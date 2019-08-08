From: Jacob Wen <jian.w.wen@oracle.com>
Date: Wed, 7 Aug 2019 18:56:00 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190807083831.GA6811@linux-6qg8>
References: <20190807024917.27682-1-firo.yang@suse.com>
 <85aaefdf-d454-1823-5840-d9e2f71ffb19@oracle.com>
 <20190807083831.GA6811@linux-6qg8>
Message-ID: <901704f1-163d-9dd8-4d20-93fa19f4435d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 8/7/19 4:38 PM, Firo Yang wrote:
> The 08/07/2019 15:56, Jacob Wen wrote:
>> I think the description is not correct. Consider using something like below.
> Thank you for comments.
>
>> In Xen environment, due to memory fragmentation ixgbe may allocate a 'DMA'
>> buffer with pages that are not physically contiguous.
> Actually, I didn't look into the reason why ixgbe got a DMA buffer which
> was mapped to Xen-swiotlb area.
Yes. I was wrong. You don't need to tell the exact reason.
>
> But I don't think this issue relates to phsical memory contiguity because, in
> our case, one ixgbe_rx_buffer only associates at most one page.

This is interesting.

I guess the performance of the NIC in your environment is not good due 
to the extra cost of bounce buffer.

>
> If you take a look at the related code, you will find there are several reasons
> for mapping a DMA buffer to Xen-swiotlb area:
> static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>           */
>          if (dma_capable(dev, dev_addr, size) &&
>              !range_straddles_page_boundary(phys, size) &&
>                  !xen_arch_need_swiotlb(dev, phys, dev_addr) &&
>                  swiotlb_force != SWIOTLB_FORCE)
>                  goto done;
>
> // Firo
>> A NIC doesn't support directly write such buffer. So xen-swiotlb would use
>> the pages, which are physically contiguous, from the swiotlb buffer for the
>> NIC.
>>
>> The unmap operation is used to copy the swiotlb buffer to the pages that are
>> allocated by ixgbe.
>>
>> On 8/7/19 10:49 AM, Firo Yang wrote:
>>> In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
>>> could possibly allocate a page, DMA memory buffer, for the first
>>> fragment which is not suitable for Xen-swiotlb to do DMA operations.
>>> Xen-swiotlb have to internally allocate another page for doing DMA
>>> operations. It requires syncing between those two pages. However,
>>> since commit f3213d932173 ("ixgbe: Update driver to make use of DMA
>>> attributes in Rx path"), the unmap operation is performed with
>>> DMA_ATTR_SKIP_CPU_SYNC. As a result, the sync is not performed.
>>>
>>> To fix this problem, always sync before possibly performing a page
>>> unmap operation.
>>>
>>> Fixes: f3213d932173 ("ixgbe: Update driver to make use of DMA
>>> attributes in Rx path")
>>> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> Signed-off-by: Firo Yang <firo.yang@suse.com>
>>> ---
>>>
>>> Changes from v1:
>>>    * Imporved the patch description.
>>>    * Added Reviewed-by: and Fixes: as suggested by Alexander Duyck
>>>
>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++-------
>>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> index cbaf712d6529..200de9838096 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> @@ -1825,13 +1825,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
>>>    static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
>>>    				struct sk_buff *skb)
>>>    {
>>> -	/* if the page was released unmap it, else just sync our portion */
>>> -	if (unlikely(IXGBE_CB(skb)->page_released)) {
>>> -		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
>>> -				     ixgbe_rx_pg_size(rx_ring),
>>> -				     DMA_FROM_DEVICE,
>>> -				     IXGBE_RX_DMA_ATTR);
>>> -	} else if (ring_uses_build_skb(rx_ring)) {
>>> +	if (ring_uses_build_skb(rx_ring)) {
>>>    		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
>>>    		dma_sync_single_range_for_cpu(rx_ring->dev,
>>> @@ -1848,6 +1842,14 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
>>>    					      skb_frag_size(frag),
>>>    					      DMA_FROM_DEVICE);
>>>    	}
>>> +
>>> +	/* If the page was released, just unmap it. */
>>> +	if (unlikely(IXGBE_CB(skb)->page_released)) {
>>> +		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
>>> +				     ixgbe_rx_pg_size(rx_ring),
>>> +				     DMA_FROM_DEVICE,
>>> +				     IXGBE_RX_DMA_ATTR);
>>> +	}
>>>    }
>>>    /**
