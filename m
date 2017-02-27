From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 27 Feb 2017 08:32:31 -0800
Subject: [Intel-wired-lan] [net-next PATCH 3/3] ixgbe: xdp support for
	adjust head
In-Reply-To: <20170225173320.32741.88705.stgit@john-Precision-Tower-5810>
References: <20170225172422.32741.67877.stgit@john-Precision-Tower-5810>
 <20170225173320.32741.88705.stgit@john-Precision-Tower-5810>
Message-ID: <CAKgT0UcD640X1GuNj62uT+CAVqE4r2-PoRaX9frbqJX1V1fj8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Feb 25, 2017 at 9:33 AM, John Fastabend
<john.fastabend@gmail.com> wrote:
> Add adjust_head support for XDP however at the moment we are only
> adding IXGBE_SKB_PAD bytes of headroom to align with driver paths.
>
> The infrastructure is is such that a follow on patch can extend
> headroom up to 196B without changing RX path.

So I am really not a fan of the way this is implemented.  I think we
can probably just get away with passing size as a pointer, and
adjusting page_offset in the rx_buffer_info structure.

Then the only extra bit of work that is needed is that we have to add
some code to sanitize the page_offset in ixgbe_build_skb and
ixgbe_construct_skb in the 4K case since we can't just use an xor
anymore and instead will probably have to do a combination of xor,
and, or to clear and reset the page offset back to what it is supposed
to be.

> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   45 +++++++++++++++++--------
>  1 file changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 227caf8..040e469 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2031,6 +2031,7 @@ static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer)
>  static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
>                               struct ixgbe_rx_buffer *rx_buffer,
>                               struct sk_buff *skb,
> +                             unsigned int headroom,
>                               unsigned int size)
>  {
>  #if (PAGE_SIZE < 8192)
> @@ -2041,7 +2042,8 @@ static void ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
>                                 SKB_DATA_ALIGN(size);
>  #endif
>         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> -                       rx_buffer->page_offset, size, truesize);
> +                       rx_buffer->page_offset - (IXGBE_SKB_PAD - headroom),
> +                       size, truesize);
>  #if (PAGE_SIZE < 8192)
>         rx_buffer->page_offset ^= truesize;
>  #else
> @@ -2114,6 +2116,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>  static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>                                            struct ixgbe_rx_buffer *rx_buffer,
>                                            union ixgbe_adv_rx_desc *rx_desc,
> +                                          unsigned int headroom,
>                                            unsigned int size)
>  {
>         void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> @@ -2122,6 +2125,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>  #else
>         unsigned int truesize = SKB_DATA_ALIGN(size);
>  #endif
> +       unsigned int off_page;
>         struct sk_buff *skb;
>
>         /* prefetch first cache line of first page */
> @@ -2135,12 +2139,14 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>         if (unlikely(!skb))
>                 return NULL;
>
> +       off_page = IXGBE_SKB_PAD - headroom;
> +
>         if (size > IXGBE_RX_HDR_SIZE) {
>                 if (!ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP))
>                         IXGBE_CB(skb)->dma = rx_buffer->dma;
>
>                 skb_add_rx_frag(skb, 0, rx_buffer->page,
> -                               rx_buffer->page_offset,
> +                               rx_buffer->page_offset - off_page,
>                                 size, truesize);
>  #if (PAGE_SIZE < 8192)
>                 rx_buffer->page_offset ^= truesize;
> @@ -2148,7 +2154,8 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>                 rx_buffer->page_offset += truesize;
>  #endif
>         } else {
> -               memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
> +               memcpy(__skb_put(skb, size), va - off_page,
> +                      ALIGN(size, sizeof(long)));
>                 rx_buffer->pagecnt_bias++;
>         }
>
> @@ -2158,6 +2165,7 @@ static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
>  static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>                                        struct ixgbe_rx_buffer *rx_buffer,
>                                        union ixgbe_adv_rx_desc *rx_desc,
> +                                      unsigned int headroom,
>                                        unsigned int size)
>  {
>         void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> @@ -2181,7 +2189,7 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
>                 return NULL;
>
>         /* update pointers within the skb to store the data */
> -       skb_reserve(skb, IXGBE_SKB_PAD);
> +       skb_reserve(skb, headroom);
>         __skb_put(skb, size);
>
>         /* record DMA address if this is the start of a chain of buffers */
> @@ -2202,10 +2210,14 @@ static int ixgbe_xmit_xdp_ring(struct xdp_buff *xdp,
>                                struct ixgbe_adapter *adapter,
>                                struct ixgbe_ring *tx_ring);
>
> +#define IXGBE_XDP_PASS 0
> +#define IXGBE_XDP_CONSUMED 1
> +

Going back to my original suggestions for patch one you would have 3
possible return values.  You would return NULL if it is meant to pass,
one value wrapped in PTR_ERR if it is meant to be an XMIT, and another
value wrapped in PTR_ERR if it is meant to be dropped.  The only real
difference between the 3 is that for NULL you do nothing, for XMIT you
are going to need to call your xdp_xmit function and update the
page_offset, and for drop you add one back to the pagecnt_bias.

I just realized I think my example that I provided for patch one was
missing that bit.  We need to add one back to the pagecnt_bias if we
are just dropping the buffer.

>  static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>                          struct ixgbe_ring  *rx_ring,
>                          struct ixgbe_rx_buffer *rx_buffer,
> -                        unsigned int size)
> +                        unsigned int *headroom,
> +                        unsigned int *size)
>  {
>         struct ixgbe_ring *xdp_ring;
>         struct bpf_prog *xdp_prog;
> @@ -2216,17 +2228,19 @@ static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>         xdp_prog = READ_ONCE(rx_ring->xdp_prog);
>
>         if (!xdp_prog)
> -               return 0;
> +               return IXGBE_XDP_PASS;
>
>         addr = page_address(rx_buffer->page) + rx_buffer->page_offset;
> -       xdp.data_hard_start = addr;
> +       xdp.data_hard_start = addr - *headroom;
>         xdp.data = addr;
> -       xdp.data_end = addr + size;
> +       xdp.data_end = addr + *size;
>
>         act = bpf_prog_run_xdp(xdp_prog, &xdp);
>         switch (act) {
>         case XDP_PASS:
> -               return 0;
> +               *headroom = xdp.data - xdp.data_hard_start;
> +               *size = xdp.data_end - xdp.data;
> +               return IXGBE_XDP_PASS;
>         case XDP_TX:
>                 xdp_ring = adapter->xdp_ring[smp_processor_id()];
>
> @@ -2246,7 +2260,7 @@ static int ixgbe_run_xdp(struct ixgbe_adapter *adapter,
>                 rx_buffer->pagecnt_bias++; /* give page back */
>                 break;
>         }
> -       return size;
> +       return IXGBE_XDP_CONSUMED;
>  }
>
>  /**
> @@ -2275,6 +2289,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>         u16 cleaned_count = ixgbe_desc_unused(rx_ring);
>
>         while (likely(total_rx_packets < budget)) {
> +               unsigned int headroom = ixgbe_rx_offset(rx_ring);
>                 union ixgbe_adv_rx_desc *rx_desc;
>                 struct ixgbe_rx_buffer *rx_buffer;
>                 struct sk_buff *skb;
> @@ -2301,7 +2316,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>
>                 rcu_read_lock();
> -               consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer, size);
> +               consumed = ixgbe_run_xdp(adapter, rx_ring, rx_buffer,
> +                                        &headroom, &size);
>                 rcu_read_unlock();
>
>                 if (consumed) {
> @@ -2315,13 +2331,14 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>
>                 /* retrieve a buffer from the ring */
>                 if (skb)
> -                       ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
> +                       ixgbe_add_rx_frag(rx_ring, rx_buffer, skb,
> +                                         headroom, size);
>                 else if (ring_uses_build_skb(rx_ring))
>                         skb = ixgbe_build_skb(rx_ring, rx_buffer,
> -                                             rx_desc, size);
> +                                             rx_desc, headroom, size);
>                 else
>                         skb = ixgbe_construct_skb(rx_ring, rx_buffer,
> -                                                 rx_desc, size);
> +                                                 rx_desc, headroom, size);
>
>                 /* exit if we failed to retrieve a buffer */
>                 if (!skb) {
>
