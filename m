From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 11 Jan 2021 12:53:47 -0800
Subject: [Intel-wired-lan] [PATCH] igb: avoid premature Rx buffer reuse
In-Reply-To: <1609990905-29220-1-git-send-email-lirongqing@baidu.com>
References: <1609990905-29220-1-git-send-email-lirongqing@baidu.com>
Message-ID: <CAKgT0Ucar6h-V2pQK6Gx4wrwFzJqySfv-MGXtW1yEc6Jq3uNSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 6, 2021 at 7:53 PM Li RongQing <lirongqing@baidu.com> wrote:
>
> The page recycle code, incorrectly, relied on that a page fragment
> could not be freed inside xdp_do_redirect(). This assumption leads to
> that page fragments that are used by the stack/XDP redirect can be
> reused and overwritten.
>
> To avoid this, store the page count prior invoking xdp_do_redirect().
>
> Fixes: 9cbc948b5a20 ("igb: add XDP support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Cc: Bj?rn T?pel <bjorn.topel@intel.com>

I'm not sure what you are talking about here. We allow for a 0 to 1
count difference in the pagecount bias. The idea is the driver should
be holding onto at least one reference from the driver at all times.
Are you saying that is not the case?

As far as the code itself we hold onto the page as long as our
difference does not exceed 1. So specifically if the XDP call is
freeing the page the page itself should still be valid as the
reference count shouldn't drop below 1, and in that case the driver
should be holding that one reference to the page.

When we perform our check we are performing it such at output of
either 0 if the page is freed, or 1 if the page is not freed are
acceptable for us to allow reuse. The key bit is in igb_clean_rx_irq
where we will flip the buffer for the IGB_XDP_TX | IGB_XDP_REDIR case
and just increment the pagecnt_bias indicating that the page was
dropped in the non-flipped case.

Are you perhaps seeing a function that is returning an error and still
consuming the page? If so that might explain what you are seeing.
However the bug would be in the other driver not this one. The
xdp_do_redirect function is not supposed to free the page if it
returns an error. It is supposed to leave that up to the function that
called xdp_do_redirect.

> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 03f78fdb0dcd..3e0d903cf919 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8232,7 +8232,8 @@ static inline bool igb_page_is_reserved(struct page *page)
>         return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
>  }
>
> -static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer)
> +static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer,
> +                                                                int rx_buf_pgcnt)
>  {
>         unsigned int pagecnt_bias = rx_buffer->pagecnt_bias;
>         struct page *page = rx_buffer->page;
> @@ -8243,7 +8244,7 @@ static bool igb_can_reuse_rx_page(struct igb_rx_buffer *rx_buffer)
>
>  #if (PAGE_SIZE < 8192)
>         /* if we are only owner of page we can reuse it */
> -       if (unlikely((page_ref_count(page) - pagecnt_bias) > 1))
> +       if (unlikely((rx_buf_pgcnt - pagecnt_bias) > 1))
>                 return false;
>  #else
>  #define IGB_LAST_OFFSET \

So the difference between page_ref_count and pagecnt_bias should be 1
or 0. The 0 would assume the page fragment was freed. What is the
value you are seeing here in the error case? My concern here is that
the pagecnt_bias may be getting incremented because IGB_XDP_CONSUMED
is being returned from igb_run_xdp instead of IGB_XDP_REDIR and so it
thinks the buffer was dropped instead of being transmitted.

> @@ -8632,11 +8633,17 @@ static unsigned int igb_rx_offset(struct igb_ring *rx_ring)
>  }
>
>  static struct igb_rx_buffer *igb_get_rx_buffer(struct igb_ring *rx_ring,
> -                                              const unsigned int size)
> +                                              const unsigned int size, int *rx_buf_pgcnt)
>  {
>         struct igb_rx_buffer *rx_buffer;
>
>         rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
> +       *rx_buf_pgcnt =
> +#if (PAGE_SIZE < 8192)
> +               page_count(rx_buffer->page);
> +#else
> +               0;
> +#endif
>         prefetchw(rx_buffer->page);
>
>         /* we are reusing so sync this buffer for CPU use */

It should be page_ref_count used here, not page_count. Also caching
this value can be problematic since the value is supposed to be an
atomic count.

> @@ -8652,9 +8659,9 @@ static struct igb_rx_buffer *igb_get_rx_buffer(struct igb_ring *rx_ring,
>  }
>
>  static void igb_put_rx_buffer(struct igb_ring *rx_ring,
> -                             struct igb_rx_buffer *rx_buffer)
> +                             struct igb_rx_buffer *rx_buffer, int rx_buf_pgcnt)
>  {
> -       if (igb_can_reuse_rx_page(rx_buffer)) {
> +       if (igb_can_reuse_rx_page(rx_buffer, rx_buf_pgcnt)) {
>                 /* hand second half of page back to the ring */
>                 igb_reuse_rx_page(rx_ring, rx_buffer);
>         } else {
> @@ -8681,6 +8688,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>         u16 cleaned_count = igb_desc_unused(rx_ring);
>         unsigned int xdp_xmit = 0;
>         struct xdp_buff xdp;
> +       int rx_buf_pgcnt;
>
>         xdp.rxq = &rx_ring->xdp_rxq;
>
> @@ -8711,7 +8719,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>                  */
>                 dma_rmb();
>
> -               rx_buffer = igb_get_rx_buffer(rx_ring, size);
> +               rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
>
>                 /* retrieve a buffer from the ring */
>                 if (!skb) {
> @@ -8754,7 +8762,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>                         break;
>                 }
>
> -               igb_put_rx_buffer(rx_ring, rx_buffer);
> +               igb_put_rx_buffer(rx_ring, rx_buffer, rx_buf_pgcnt);
>                 cleaned_count++;
>
>                 /* fetch next buffer in frame if non-eop */

After reviewing the patch I don't see what this is solving. The
buffers should be reusable as long as the refcount is 1 or 0. We
assume with 1 that the stack/XDP is holding onto the page, and with 0
the page was freed.

I would need more info on the actual issue. If nothing else it might
be useful to have an example where you print out the page_ref_count
versus the pagecnt_bias at a few points to verify exactly what is
going on. As I said before if the issue is the xdp_do_redirect
returning an error and still consuming the page then the bug is
elsewhere and not here.
