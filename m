From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 3 Mar 2017 16:29:29 -0800
Subject: [Intel-wired-lan] [RFC PATCH] ixgbe: use xdp_buff to simplify
	call path
In-Reply-To: <20170303210437.13969.48559.stgit@john-Precision-Tower-5810>
References: <20170303210437.13969.48559.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UepgwiJKhATn9oDzs8wAiPAZKkTpTaE3di6JZT1_aJYGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Mar 3, 2017 at 1:04 PM, John Fastabend <john.fastabend@gmail.com> wrote:
> Alex, is this what you are thinking w.r.t. pushing the xdp_buff
> through the ixgbe skb build routines. It seems to look OK but
> only lightly tested for now.
>
> I hvaen't decided if I want to push it into the first set of
> patches or as a 4th patch.

Yeah, this is more or less what I was thinking.  Basically we just end
up pulling most of the rx_buffer_info structure onto the stack and
then process it there.  If we folded it into the other patches it
might actually make them a bit smaller since this patch is having to
go through and unto a number of things those patches are doing.

> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   95 +++++++++++--------------
>  1 file changed, 41 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 49f7eb6..db89588 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2114,23 +2114,26 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>
>  static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>                                            struct ixgbe_rx_buffer *rx_buffer,
> -                                          union ixgbe_adv_rx_desc *rx_desc,
> -                                          unsigned int headroom,
> -                                          unsigned int size)
> +                                          struct xdp_buff *xdp,
> +                                          union ixgbe_adv_rx_desc *rx_desc)
>  {
> -       void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +       unsigned int size = xdp->data_end - xdp->data;
>  #if (PAGE_SIZE < 8192)
>         unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
>  #else
>         unsigned int truesize = SKB_DATA_ALIGN(size);
>  #endif
> -       unsigned int off_page;
>         struct sk_buff *skb;
> +#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
> +       __u32 page_offset;
> +#else
> +       __u16 page_offset;
> +#endif

You can just use an unsigned int here.  No point in doing anything
fancy since it is just on the stack anyway.

>         /* prefetch first cache line of first page */
> -       prefetch(va);
> +       prefetch(xdp->data);
>  #if L1_CACHE_BYTES < 128
> -       prefetch(va + L1_CACHE_BYTES);
> +       prefetch(xdp->data + L1_CACHE_BYTES);
>  #endif
>
>         /* allocate a skb to store the frags */
> @@ -2138,14 +2141,12 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>         if (unlikely(!skb))
>                 return NULL;
>
> -       off_page = IXGBE_SKB_PAD - headroom;
> -
>         if (size > IXGBE_RX_HDR_SIZE) {
>                 if (!ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP))
>                         IXGBE_CB(skb)->dma = rx_buffer->dma;
>
> -               skb_add_rx_frag(skb, 0, rx_buffer->page,
> -                               rx_buffer->page_offset - off_page,
> +               page_offset = xdp->data - page_address(rx_buffer->page);
> +               skb_add_rx_frag(skb, 0, rx_buffer->page, page_offset,
>                                 size, truesize);

Actually it looks like this is the only place you use page_offset
anyway.  You could probably just drop the subtraction in the place of
the argument in the function call.

>  #if (PAGE_SIZE < 8192)
>                 rx_buffer->page_offset ^= truesize;
> @@ -2153,7 +2154,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>                 rx_buffer->page_offset += truesize;
>  #endif
>         } else {
> -               memcpy(__skb_put(skb, size), va - off_page,
> +               memcpy(__skb_put(skb, size), xdp->data,
>                        ALIGN(size, sizeof(long)));
>                 rx_buffer->pagecnt_bias++;
>         }
> @@ -2163,11 +2164,9 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>
>  static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>                                        struct ixgbe_rx_buffer *rx_buffer,
> -                                      union ixgbe_adv_rx_desc *rx_desc,
> -                                      unsigned int headroom,
> -                                      unsigned int size)
> +                                      struct xdp_buff *xdp,
> +                                      union ixgbe_adv_rx_desc *rx_desc)
>  {
> -       void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  #if (PAGE_SIZE < 8192)
>         unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
>  #else
> @@ -2177,19 +2176,19 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>         struct sk_buff *skb;
>
>         /* prefetch first cache line of first page */
> -       prefetch(va);
> +       prefetch(xdp->data);
>  #if L1_CACHE_BYTES < 128
> -       prefetch(va + L1_CACHE_BYTES);
> +       prefetch(xdp->data + L1_CACHE_BYTES);
>  #endif
>
>         /* build an skb to around the page buffer */
> -       skb = build_skb(va - IXGBE_SKB_PAD, truesize);
> +       skb = build_skb(xdp->data_hard_start, truesize);
>         if (unlikely(!skb))
>                 return NULL;
>
>         /* update pointers within the skb to store the data */
> -       skb_reserve(skb, headroom);
> -       __skb_put(skb, size);
> +       skb_reserve(skb, xdp->data - xdp->data_hard_start);
> +       __skb_put(skb, xdp->data_end - xdp->data);
>
>         /* record DMA address if this is the start of a chain of buffers */
>         if (!ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP))
> @@ -2214,14 +2213,10 @@ static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
>
>  static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>                                      struct ixgbe_ring  *rx_ring,
> -                                    struct ixgbe_rx_buffer *rx_buffer,
> -                                    unsigned int *headroom,
> -                                    unsigned int *size)
> +                                    struct xdp_buff *xdp)
>  {
>         int result = IXGBE_XDP_PASS;
>         struct bpf_prog *xdp_prog;
> -       struct xdp_buff xdp;
> -       void *addr;
>         u32 act;
>
>         rcu_read_lock();
> @@ -2230,30 +2225,12 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>         if (!xdp_prog)
>                 goto xdp_out;
>
> -       addr = page_address(rx_buffer->page) + rx_buffer->page_offset;
> -       xdp.data_hard_start = addr - *headroom;
> -       xdp.data = addr;
> -       xdp.data_end = addr + *size;
> -
> -       act = bpf_prog_run_xdp(xdp_prog, &xdp);
> +       act = bpf_prog_run_xdp(xdp_prog, xdp);
>         switch (act) {
>         case XDP_PASS:
> -               *headroom = xdp.data - xdp.data_hard_start;
> -               *size = xdp.data_end - xdp.data;
>                 return IXGBE_XDP_PASS;
>         case XDP_TX:
> -               result = ixgbe_xmit_xdp_ring(adapter, &xdp);
> -               if (result == IXGBE_XDP_TX) {
> -#if (PAGE_SIZE < 8192)
> -                       rx_buffer->page_offset ^= ixgbe_rx_pg_size(rx_ring) / 2;
> -#else
> -                       rx_buffer->page_offset += ring_uses_build_skb(rx_ring) ?
> -                                       SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
> -                                       SKB_DATA_ALIGN(size);
> -#endif
> -               } else {
> -                       rx_buffer->pagecnt_bias++; /* give page back */
> -               }
> +               result = ixgbe_xmit_xdp_ring(adapter, xdp);
>                 break;
>         default:
>                 bpf_warn_invalid_xdp_action(act);
> @@ -2261,7 +2238,6 @@ static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>                 trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>                 /* fallthrough -- handle aborts by dropping packet */
>         case XDP_DROP:
> -               rx_buffer->pagecnt_bias++; /* give page back */
>                 result = IXGBE_XDP_CONSUMED;
>                 break;
>         }
> @@ -2296,10 +2272,10 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>         u16 cleaned_count = ixgbe_desc_unused(rx_ring);
>
>         while (likely(total_rx_packets < budget)) {
> -               unsigned int headroom = ixgbe_rx_offset(rx_ring);
>                 union ixgbe_adv_rx_desc *rx_desc;
>                 struct ixgbe_rx_buffer *rx_buffer;
>                 struct sk_buff *skb;
> +               struct xdp_buff xdp;
>                 unsigned int size;
>
>                 /* return some buffers to hardware, one at a time is too slow */
> @@ -2320,20 +2296,31 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 dma_rmb();
>
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
> +               xdp.data = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +               xdp.data_hard_start = xdp.data - ixgbe_rx_offset(rx_ring);
> +               xdp.data_end = xdp.data + size;
>
> -               skb = ixgbe_run_xdp(adapter, rx_ring, rx_buffer,
> -                                   &headroom, &size);
> +               skb = ixgbe_run_xdp(adapter, rx_ring, &xdp);
>                 if (IS_ERR(skb)) { /* XDP consumed buffer */
> +                       if (PTR_ERR(skb) == -IXGBE_XDP_TX) {
> +#if (PAGE_SIZE < 8192)
> +                               rx_buffer->page_offset ^= ixgbe_rx_pg_size(rx_ring) / 2;
> +#else
> +                               rx_buffer->page_offset += ring_uses_build_skb(rx_ring) ?
> +                                               SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) :
> +                                               SKB_DATA_ALIGN(size);
> +#endif
> +                       } else {
> +                               rx_buffer->pagecnt_bias++; /* give page back */
> +                       }
>                         total_rx_packets++;
>                         total_rx_bytes += size;
>                 } else if (skb) {
>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
>                 } else if (ring_uses_build_skb(rx_ring)) {
> -                       skb = ixgbe_build_skb(rx_ring, rx_buffer,
> -                                             rx_desc, headroom, size);
> +                       skb = ixgbe_build_skb(rx_ring, rx_buffer, &xdp, rx_desc);
>                 } else {
> -                       skb = ixgbe_construct_skb(rx_ring, rx_buffer,
> -                                                 rx_desc, headroom, size);
> +                       skb = ixgbe_construct_skb(rx_ring, rx_buffer, &xdp, rx_desc);
>                 }
>
>                 /* exit if we failed to retrieve a buffer */
>
