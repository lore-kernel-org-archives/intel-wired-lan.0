From: Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Date: Wed, 7 Aug 2019 16:08:53 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190807083831.GA6811@linux-6qg8>
References: <20190807024917.27682-1-firo.yang@suse.com>
 <85aaefdf-d454-1823-5840-d9e2f71ffb19@oracle.com>
 <20190807083831.GA6811@linux-6qg8>
Message-ID: <20190807160853.00001d71@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 7 Aug 2019 08:38:43 +0000
Firo Yang <firo.yang@suse.com> wrote:

> The 08/07/2019 15:56, Jacob Wen wrote:
> > I think the description is not correct. Consider using something like below.  
> Thank you for comments. 
> 
> > 
> > In Xen environment, due to memory fragmentation ixgbe may allocate a 'DMA'
> > buffer with pages that are not physically contiguous.  
> Actually, I didn't look into the reason why ixgbe got a DMA buffer which
> was mapped to Xen-swiotlb area.

I think that neither of these descriptions are telling us what was truly
broken. They lack what Alexander wrote on v1 thread of this patch.

ixgbe_dma_sync_frag is called only on case when the current descriptor has EOP
bit set, skb was already allocated and you'll be adding a current buffer as a
frag. DMA unmapping for the first frag was intentionally skipped and we will be
unmapping it here, in ixgbe_dma_sync_frag. As Alex said, we're using the
DMA_ATTR_SKIP_CPU_SYNC attribute which obliges us to perform a sync manually
and it was missing.

So IMHO the commit description should include descriptions from both xen and
ixgbe worlds, the v2 lacks info about ixgbe case.

BTW Alex, what was the initial reason for holding off with unmapping the first
buffer? Asking because IIRC the i40e and ice behave a bit different here. We
don't look there for EOP at all when building/constructing skb and not delaying
the unmap of non-eop buffers.

Thanks,
Maciej

> 
> But I don't think this issue relates to phsical memory contiguity because, in
> our case, one ixgbe_rx_buffer only associates at most one page.
> 
> If you take a look at the related code, you will find there are several reasons
> for mapping a DMA buffer to Xen-swiotlb area:
> static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>          */
>         if (dma_capable(dev, dev_addr, size) &&
>             !range_straddles_page_boundary(phys, size) &&
>                 !xen_arch_need_swiotlb(dev, phys, dev_addr) &&
>                 swiotlb_force != SWIOTLB_FORCE)
>                 goto done;
> 
> // Firo
> > 
> > A NIC doesn't support directly write such buffer. So xen-swiotlb would use
> > the pages, which are physically contiguous, from the swiotlb buffer for the
> > NIC.
> > 
> > The unmap operation is used to copy the swiotlb buffer to the pages that are
> > allocated by ixgbe.
> > 
> > On 8/7/19 10:49 AM, Firo Yang wrote:  
> > > In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
> > > could possibly allocate a page, DMA memory buffer, for the first
> > > fragment which is not suitable for Xen-swiotlb to do DMA operations.
> > > Xen-swiotlb have to internally allocate another page for doing DMA
> > > operations. It requires syncing between those two pages. However,
> > > since commit f3213d932173 ("ixgbe: Update driver to make use of DMA
> > > attributes in Rx path"), the unmap operation is performed with
> > > DMA_ATTR_SKIP_CPU_SYNC. As a result, the sync is not performed.
> > > 
> > > To fix this problem, always sync before possibly performing a page
> > > unmap operation.
> > > 
> > > Fixes: f3213d932173 ("ixgbe: Update driver to make use of DMA
> > > attributes in Rx path")
> > > Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > Signed-off-by: Firo Yang <firo.yang@suse.com>
> > > ---
> > > 
> > > Changes from v1:
> > >   * Imporved the patch description.
> > >   * Added Reviewed-by: and Fixes: as suggested by Alexander Duyck
> > > 
> > >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++-------
> > >   1 file changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > index cbaf712d6529..200de9838096 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> > > @@ -1825,13 +1825,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
> > >   static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
> > >   				struct sk_buff *skb)
> > >   {
> > > -	/* if the page was released unmap it, else just sync our portion */
> > > -	if (unlikely(IXGBE_CB(skb)->page_released)) {
> > > -		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
> > > -				     ixgbe_rx_pg_size(rx_ring),
> > > -				     DMA_FROM_DEVICE,
> > > -				     IXGBE_RX_DMA_ATTR);
> > > -	} else if (ring_uses_build_skb(rx_ring)) {
> > > +	if (ring_uses_build_skb(rx_ring)) {
> > >   		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
> > >   		dma_sync_single_range_for_cpu(rx_ring->dev,
> > > @@ -1848,6 +1842,14 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
> > >   					      skb_frag_size(frag),
> > >   					      DMA_FROM_DEVICE);
> > >   	}
> > > +
> > > +	/* If the page was released, just unmap it. */
> > > +	if (unlikely(IXGBE_CB(skb)->page_released)) {
> > > +		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
> > > +				     ixgbe_rx_pg_size(rx_ring),
> > > +				     DMA_FROM_DEVICE,
> > > +				     IXGBE_RX_DMA_ATTR);
> > > +	}
> > >   }
> > >   /**  
> >   

