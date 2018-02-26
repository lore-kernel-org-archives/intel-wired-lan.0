From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 26 Feb 2018 15:54:19 +0000
Subject: [Intel-wired-lan] [PATCH 4/9] ixgbevf: add support for
 DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
In-Reply-To: <20171211183704.21524.88419.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183704.21524.88419.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64BD81F0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/9] ixgbevf: add support for
> DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING
> 
> Based on commit 5be5955425c2
> ("igb: update driver to make use of DMA_ATTR_SKIP_CPU_SYNC")
> 
> and
> 
> commit 7bd175928280 ("igb: Add support for DMA_ATTR_WEAK_ORDERING")
> 
> Convert the calls to dma_map/unmap_page() to the attributes version
> and add DMA_ATTR_SKIP_CPU_SYNC/WEAK_ORDERING which should help
> improve performance on some platforms.
> 
> Move sync_for_cpu call before we perform a prefetch to avoid
> invalidating the first 128 bytes of the packet on architectures where
> that call may invalidate the cache.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    3 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   57 +++++++++++++-------
> -
>  2 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index 581f44b..b1da9f4 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -260,6 +260,9 @@ static inline void ixgbevf_write_tail(struct ixgbevf_ring
> *ring, u32 value)
>  #define MIN_MSIX_Q_VECTORS	1
>  #define MIN_MSIX_COUNT		(MIN_MSIX_Q_VECTORS +
> NON_Q_VECTORS)
> 
> +#define IXGBEVF_RX_DMA_ATTR \
> +	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
> +
>  /* board specific private data structure */
>  struct ixgbevf_adapter {
>  	/* this field must be first, see ixgbevf_process_skb_fields */
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 725fe2d..fbd493e 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -595,8 +595,8 @@ static bool ixgbevf_alloc_mapped_page(struct
> ixgbevf_ring *rx_ring,
>  	}
> 
>  	/* map page for use */
> -	dma = dma_map_page(rx_ring->dev, page, 0,
> -			   PAGE_SIZE, DMA_FROM_DEVICE);
> +	dma = dma_map_page_attrs(rx_ring->dev, page, 0, PAGE_SIZE,
> +				 DMA_FROM_DEVICE,
> IXGBEVF_RX_DMA_ATTR);
> 
>  	/* if mapping failed free memory back to system since
>  	 * there isn't much point in holding memory we can't use
> @@ -639,6 +639,12 @@ static void ixgbevf_alloc_rx_buffers(struct
> ixgbevf_ring *rx_ring,
>  		if (!ixgbevf_alloc_mapped_page(rx_ring, bi))
>  			break;
> 
> +		/* sync the buffer for use by the device */
> +		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
> +						 bi->page_offset,
> +						 IXGBEVF_RX_BUFSZ,
> +						 DMA_FROM_DEVICE);
> +
>  		/* Refresh the desc even if pkt_addr didn't change
>  		 * because each write-back erases this info.
>  		 */
> @@ -741,12 +747,6 @@ static void ixgbevf_reuse_rx_page(struct ixgbevf_ring
> *rx_ring,
>  	new_buff->page = old_buff->page;
>  	new_buff->dma = old_buff->dma;
>  	new_buff->page_offset = old_buff->page_offset;
> -
> -	/* sync the buffer for use by the device */
> -	dma_sync_single_range_for_device(rx_ring->dev, new_buff->dma,
> -					 new_buff->page_offset,
> -					 IXGBEVF_RX_BUFSZ,
> -					 DMA_FROM_DEVICE);
>  }
> 
>  static inline bool ixgbevf_page_is_reserved(struct page *page)
> @@ -862,6 +862,13 @@ static struct sk_buff *ixgbevf_fetch_rx_buffer(struct
> ixgbevf_ring *rx_ring,
>  	page = rx_buffer->page;
>  	prefetchw(page);
> 
> +	/* we are reusing so sync this buffer for CPU use */
> +	dma_sync_single_range_for_cpu(rx_ring->dev,
> +				      rx_buffer->dma,
> +				      rx_buffer->page_offset,
> +				      size,
> +				      DMA_FROM_DEVICE);
> +
>  	if (likely(!skb)) {
>  		void *page_addr = page_address(page) +
>  				  rx_buffer->page_offset;
> @@ -887,21 +894,15 @@ static struct sk_buff *ixgbevf_fetch_rx_buffer(struct
> ixgbevf_ring *rx_ring,
>  		prefetchw(skb->data);
>  	}
> 
> -	/* we are reusing so sync this buffer for CPU use */
> -	dma_sync_single_range_for_cpu(rx_ring->dev,
> -				      rx_buffer->dma,
> -				      rx_buffer->page_offset,
> -				      size,
> -				      DMA_FROM_DEVICE);
> -
>  	/* pull page into skb */
>  	if (ixgbevf_add_rx_frag(rx_ring, rx_buffer, size, rx_desc, skb)) {
>  		/* hand second half of page back to the ring */
>  		ixgbevf_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
>  		/* we are not reusing the buffer so unmap it */
> -		dma_unmap_page(rx_ring->dev, rx_buffer->dma,
> -			       PAGE_SIZE, DMA_FROM_DEVICE);
> +		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
> +				     PAGE_SIZE, DMA_FROM_DEVICE,
> +				     IXGBEVF_RX_DMA_ATTR);
>  	}
> 
>  	/* clear contents of buffer_info */
> @@ -2116,7 +2117,6 @@ void ixgbevf_up(struct ixgbevf_adapter *adapter)
>   **/
>  static void ixgbevf_clean_rx_ring(struct ixgbevf_ring *rx_ring)
>  {
> -	struct device *dev = rx_ring->dev;
>  	unsigned long size;
>  	unsigned int i;
> 
> @@ -2135,10 +2135,23 @@ static void ixgbevf_clean_rx_ring(struct
> ixgbevf_ring *rx_ring)
>  		struct ixgbevf_rx_buffer *rx_buffer;
> 
>  		rx_buffer = &rx_ring->rx_buffer_info[i];
> -		if (rx_buffer->dma)
> -			dma_unmap_page(dev, rx_buffer->dma,
> -				       PAGE_SIZE, DMA_FROM_DEVICE);
> -		rx_buffer->dma = 0;
> +
> +		/* Invalidate cache lines that may have been written to by
> +		 * device so that we avoid corrupting memory.
> +		 */
> +		dma_sync_single_range_for_cpu(rx_ring->dev,
> +					      rx_buffer->dma,
> +					      rx_buffer->page_offset,
> +					      IXGBEVF_RX_BUFSZ,
> +					      DMA_FROM_DEVICE);
> +
> +		/* free resources associated with mapping */
> +		dma_unmap_page_attrs(rx_ring->dev,
> +				     rx_buffer->dma,
> +				     PAGE_SIZE,
> +				     DMA_FROM_DEVICE,
> +				     IXGBEVF_RX_DMA_ATTR);
> +
>  		if (rx_buffer->page)
>  			__free_page(rx_buffer->page);
>  		rx_buffer->page = NULL;
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

