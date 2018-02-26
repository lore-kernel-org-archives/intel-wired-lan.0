From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 26 Feb 2018 15:56:12 +0000
Subject: [Intel-wired-lan] [PATCH 5/9] ixgbevf: update code to better
 handle incrementing page count
In-Reply-To: <20171211183709.21524.19432.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183709.21524.19432.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64BD825D@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 5/9] ixgbevf: update code to better handle
> incrementing page count
> 
> Based on commit bd4171a5d4c2
> ("igb: update code to better handle incrementing page count")
> 
> Update the driver code so that we do bulk updates of the page reference
> count instead of just incrementing it by one reference at a time.  The
> advantage to doing this is that we cut down on atomic operations and
> this in turn should give us a slight improvement in cycles per packet.
> In addition if we eventually move this over to using build_skb the gains
> will be more noticeable.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    7 ++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   30 +++++++++++++++----
> --
>  2 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index b1da9f4..c70a789 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -62,7 +62,12 @@ struct ixgbevf_tx_buffer {
>  struct ixgbevf_rx_buffer {
>  	dma_addr_t dma;
>  	struct page *page;
> -	unsigned int page_offset;
> +#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
> +	__u32 page_offset;
> +#else
> +	__u16 page_offset;
> +#endif
> +	__u16 pagecnt_bias;
>  };
> 
>  struct ixgbevf_stats {
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index fbd493e..ae2402d 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -611,6 +611,7 @@ static bool ixgbevf_alloc_mapped_page(struct
> ixgbevf_ring *rx_ring,
>  	bi->dma = dma;
>  	bi->page = page;
>  	bi->page_offset = 0;
> +	bi->pagecnt_bias = 1;
> 
>  	return true;
>  }
> @@ -747,6 +748,7 @@ static void ixgbevf_reuse_rx_page(struct ixgbevf_ring
> *rx_ring,
>  	new_buff->page = old_buff->page;
>  	new_buff->dma = old_buff->dma;
>  	new_buff->page_offset = old_buff->page_offset;
> +	new_buff->pagecnt_bias = old_buff->pagecnt_bias;
>  }
> 
>  static inline bool ixgbevf_page_is_reserved(struct page *page)
> @@ -758,13 +760,15 @@ static bool ixgbevf_can_reuse_rx_page(struct
> ixgbevf_rx_buffer *rx_buffer,
>  				      struct page *page,
>  				      const unsigned int truesize)
>  {
> +	unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
> +
>  	/* avoid re-using remote pages */
>  	if (unlikely(ixgbevf_page_is_reserved(page)))
>  		return false;
> 
>  #if (PAGE_SIZE < 8192)
>  	/* if we are only owner of page we can reuse it */
> -	if (unlikely(page_count(page) != 1))
> +	if (unlikely(page_ref_count(page) != pagecnt_bias))
>  		return false;
> 
>  	/* flip page offset to other buffer */
> @@ -778,10 +782,15 @@ static bool ixgbevf_can_reuse_rx_page(struct
> ixgbevf_rx_buffer *rx_buffer,
>  		return false;
> 
>  #endif
> -	/* Even if we own the page, we are not allowed to use atomic_set()
> -	 * This would break get_page_unless_zero() users.
> +
> +	/* If we have drained the page fragment pool we need to update
> +	 * the pagecnt_bias and page count so that we fully restock the
> +	 * number of references the driver holds.
>  	 */
> -	page_ref_inc(page);
> +	if (unlikely(pagecnt_bias == 1)) {
> +		page_ref_add(page, USHRT_MAX);
> +		rx_buffer->pagecnt_bias = USHRT_MAX;
> +	}
> 
>  	return true;
>  }
> @@ -827,7 +836,6 @@ static bool ixgbevf_add_rx_frag(struct ixgbevf_ring
> *rx_ring,
>  			return true;
> 
>  		/* this page cannot be reused so discard it */
> -		put_page(page);
>  		return false;
>  	}
> 
> @@ -899,10 +907,13 @@ static struct sk_buff *ixgbevf_fetch_rx_buffer(struct
> ixgbevf_ring *rx_ring,
>  		/* hand second half of page back to the ring */
>  		ixgbevf_reuse_rx_page(rx_ring, rx_buffer);
>  	} else {
> -		/* we are not reusing the buffer so unmap it */
> +		/* We are not reusing the buffer so unmap it and free
> +		 * any references we are holding to it
> +		 */
>  		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
>  				     PAGE_SIZE, DMA_FROM_DEVICE,
>  				     IXGBEVF_RX_DMA_ATTR);
> +		__page_frag_cache_drain(page, rx_buffer->pagecnt_bias);
>  	}
> 
>  	/* clear contents of buffer_info */
> @@ -2135,6 +2146,8 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring
> *rx_ring)
>  		struct ixgbevf_rx_buffer *rx_buffer;
> 
>  		rx_buffer = &rx_ring->rx_buffer_info[i];
> +		if (!rx_buffer->page)
> +			continue;
> 
>  		/* Invalidate cache lines that may have been written to by
>  		 * device so that we avoid corrupting memory.
> @@ -2152,8 +2165,9 @@ static void ixgbevf_clean_rx_ring(struct ixgbevf_ring
> *rx_ring)
>  				     DMA_FROM_DEVICE,
>  				     IXGBEVF_RX_DMA_ATTR);
> 
> -		if (rx_buffer->page)
> -			__free_page(rx_buffer->page);
> +		__page_frag_cache_drain(rx_buffer->page,
> +					rx_buffer->pagecnt_bias);
> +
>  		rx_buffer->page = NULL;
>  	}
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

