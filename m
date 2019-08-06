From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Aug 2019 13:00:45 -0700
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190806092919.13211-1-firo.yang@suse.com>
References: <20190806092919.13211-1-firo.yang@suse.com>
Message-ID: <CAKgT0UdFky-tnyhn_oXGefex=9FN5ckAJ0YYd2Z7STZg1V48Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 6, 2019 at 2:38 AM Firo Yang <firo.yang@suse.com> wrote:
>
> In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
> could possibly allocate a page, DMA memory buffer, for the first
> fragment which is not suitable for Xen-swiotlb to do DMA operations.
> Xen-swiotlb will internally allocate another page for doing DMA
> operations. It requires syncing between those two pages. Otherwise,
> we may get an incomplete skb. To fix this problem, sync the first
> fragment no matter the first fargment is makred as "page_released"
> or not.
>
> Signed-off-by: Firo Yang <firo.yang@suse.com>

From what I can tell the code below is fine. However the patch
description isn't very clear about the issue.

Specifically since we are mapping the frame with
DMA_ATTR_SKIP_CPU_SYNC we have to unmap with that as well. As a result
a sync is not performed on an unmap and must be done manually as we
skipped it for the first frag. As such we need to always sync before
possibly performing a page unmap operation.

Also you can probably add the following to your patch description"
Fixes: f3213d932173 ("ixgbe: Update driver to make use of DMA
attributes in Rx path")
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index cbaf712d6529..200de9838096 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -1825,13 +1825,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
>  static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
>                                 struct sk_buff *skb)
>  {
> -       /* if the page was released unmap it, else just sync our portion */
> -       if (unlikely(IXGBE_CB(skb)->page_released)) {
> -               dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
> -                                    ixgbe_rx_pg_size(rx_ring),
> -                                    DMA_FROM_DEVICE,
> -                                    IXGBE_RX_DMA_ATTR);
> -       } else if (ring_uses_build_skb(rx_ring)) {
> +       if (ring_uses_build_skb(rx_ring)) {
>                 unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
>
>                 dma_sync_single_range_for_cpu(rx_ring->dev,
> @@ -1848,6 +1842,14 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
>                                               skb_frag_size(frag),
>                                               DMA_FROM_DEVICE);
>         }
> +
> +       /* If the page was released, just unmap it. */
> +       if (unlikely(IXGBE_CB(skb)->page_released)) {
> +               dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
> +                                    ixgbe_rx_pg_size(rx_ring),
> +                                    DMA_FROM_DEVICE,
> +                                    IXGBE_RX_DMA_ATTR);
> +       }
>  }
>
>  /**
> --
> 2.16.4
>
