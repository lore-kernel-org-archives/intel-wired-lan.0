From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:50:15 +0000
Subject: [Intel-wired-lan] [PATCH 9/9] ixgbevf: don't bother clearing
 tx_buffer_info in ixgbevf_clean_tx_ring()
In-Reply-To: <20171211183730.21524.65151.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183730.21524.65151.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EF66@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Emil Tantilov
> Sent: Monday, December 11, 2017 10:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 9/9] ixgbevf: don't bother clearing
> tx_buffer_info in ixgbevf_clean_tx_ring()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  115 +++++++++++++-------
> -
>  1 file changed, 72 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index d3415ee..9b3d43d 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -206,28 +206,6 @@ static void ixgbevf_set_ivar(struct ixgbevf_adapter
> *adapter, s8 direction,
>  	}
>  }
> 
> -static void ixgbevf_unmap_and_free_tx_resource(struct ixgbevf_ring *tx_ring,
> -					struct ixgbevf_tx_buffer *tx_buffer)
> -{
> -	if (tx_buffer->skb) {
> -		dev_kfree_skb_any(tx_buffer->skb);
> -		if (dma_unmap_len(tx_buffer, len))
> -			dma_unmap_single(tx_ring->dev,
> -					 dma_unmap_addr(tx_buffer, dma),
> -					 dma_unmap_len(tx_buffer, len),
> -					 DMA_TO_DEVICE);
> -	} else if (dma_unmap_len(tx_buffer, len)) {
> -		dma_unmap_page(tx_ring->dev,
> -			       dma_unmap_addr(tx_buffer, dma),
> -			       dma_unmap_len(tx_buffer, len),
> -			       DMA_TO_DEVICE);
> -	}
> -	tx_buffer->next_to_watch = NULL;
> -	tx_buffer->skb = NULL;
> -	dma_unmap_len_set(tx_buffer, len, 0);
> -	/* tx_buffer must be completely set up in the transmit path */
> -}
> -
>  static u64 ixgbevf_get_tx_completed(struct ixgbevf_ring *ring)
>  {
>  	return ring->stats.packets;
> @@ -349,7 +327,6 @@ static bool ixgbevf_clean_tx_irq(struct
> ixgbevf_q_vector *q_vector,
>  				 DMA_TO_DEVICE);
> 
>  		/* clear tx_buffer data */
> -		tx_buffer->skb = NULL;
>  		dma_unmap_len_set(tx_buffer, len, 0);
> 
>  		/* unmap remaining buffers */
> @@ -1576,6 +1553,10 @@ static void ixgbevf_configure_tx_ring(struct
> ixgbevf_adapter *adapter,
>  	txdctl |= (1u << 8) |    /* HTHRESH = 1 */
>  		   32;           /* PTHRESH = 32 */
> 
> +	/* reinitialize tx_buffer_info */
> +	memset(ring->tx_buffer_info, 0,
> +	       sizeof(struct ixgbevf_tx_buffer) * ring->count);
> +
>  	clear_bit(__IXGBEVF_HANG_CHECK_ARMED, &ring->state);
> 
>  	IXGBE_WRITE_REG(hw, IXGBE_VFTXDCTL(reg_idx), txdctl);
> @@ -2184,23 +2165,57 @@ static void ixgbevf_clean_rx_ring(struct
> ixgbevf_ring *rx_ring)
>   **/
>  static void ixgbevf_clean_tx_ring(struct ixgbevf_ring *tx_ring)
>  {
> -	struct ixgbevf_tx_buffer *tx_buffer_info;
> -	unsigned long size;
> -	unsigned int i;
> +	u16 i = tx_ring->next_to_clean;
> +	struct ixgbevf_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> 
> -	if (!tx_ring->tx_buffer_info)
> -		return;
> +	while (i != tx_ring->next_to_use) {
> +		union ixgbe_adv_tx_desc *eop_desc, *tx_desc;
> +
> +		/* Free all the Tx ring sk_buffs */
> +		dev_kfree_skb_any(tx_buffer->skb);
> +
> +		/* unmap skb header data */
> +		dma_unmap_single(tx_ring->dev,
> +				 dma_unmap_addr(tx_buffer, dma),
> +				 dma_unmap_len(tx_buffer, len),
> +				 DMA_TO_DEVICE);
> +
> +		/* check for eop_desc to determine the end of the packet */
> +		eop_desc = tx_buffer->next_to_watch;
> +		tx_desc = IXGBEVF_TX_DESC(tx_ring, i);
> +
> +		/* unmap remaining buffers */
> +		while (tx_desc != eop_desc) {
> +			tx_buffer++;
> +			tx_desc++;
> +			i++;
> +			if (unlikely(i == tx_ring->count)) {
> +				i = 0;
> +				tx_buffer = tx_ring->tx_buffer_info;
> +				tx_desc = IXGBEVF_TX_DESC(tx_ring, 0);
> +			}
> +
> +			/* unmap any remaining paged data */
> +			if (dma_unmap_len(tx_buffer, len))
> +				dma_unmap_page(tx_ring->dev,
> +					       dma_unmap_addr(tx_buffer,
> dma),
> +					       dma_unmap_len(tx_buffer, len),
> +					       DMA_TO_DEVICE);
> +		}
> 
> -	/* Free all the Tx ring sk_buffs */
> -	for (i = 0; i < tx_ring->count; i++) {
> -		tx_buffer_info = &tx_ring->tx_buffer_info[i];
> -		ixgbevf_unmap_and_free_tx_resource(tx_ring, tx_buffer_info);
> +		/* move us one more past the eop_desc for start of next pkt */
> +		tx_buffer++;
> +		i++;
> +		if (unlikely(i == tx_ring->count)) {
> +			i = 0;
> +			tx_buffer = tx_ring->tx_buffer_info;
> +		}
>  	}
> 
> -	size = sizeof(struct ixgbevf_tx_buffer) * tx_ring->count;
> -	memset(tx_ring->tx_buffer_info, 0, size);
> +	/* reset next_to_use and next_to_clean */
> +	tx_ring->next_to_use = 0;
> +	tx_ring->next_to_clean = 0;
> 
> -	memset(tx_ring->desc, 0, tx_ring->size);
>  }
> 
>  /**
> @@ -3030,7 +3045,7 @@ int ixgbevf_setup_tx_resources(struct ixgbevf_ring
> *tx_ring)
>  	int size;
> 
>  	size = sizeof(struct ixgbevf_tx_buffer) * tx_ring->count;
> -	tx_ring->tx_buffer_info = vzalloc(size);
> +	tx_ring->tx_buffer_info = vmalloc(size);
>  	if (!tx_ring->tx_buffer_info)
>  		goto err;
> 
> @@ -3634,18 +3649,32 @@ static void ixgbevf_tx_map(struct ixgbevf_ring
> *tx_ring,
>  	return;
>  dma_error:
>  	dev_err(tx_ring->dev, "TX DMA map failed\n");
> +	tx_buffer = &tx_ring->tx_buffer_info[i];
> 
>  	/* clear dma mappings for failed tx_buffer_info map */
> -	for (;;) {
> +	while (tx_buffer != first) {
> +		if (dma_unmap_len(tx_buffer, len))
> +			dma_unmap_page(tx_ring->dev,
> +				       dma_unmap_addr(tx_buffer, dma),
> +				       dma_unmap_len(tx_buffer, len),
> +				       DMA_TO_DEVICE);
> +		dma_unmap_len_set(tx_buffer, len, 0);
> +
> +		if (i-- == 0)
> +			i += tx_ring->count;
>  		tx_buffer = &tx_ring->tx_buffer_info[i];
> -		ixgbevf_unmap_and_free_tx_resource(tx_ring, tx_buffer);
> -		if (tx_buffer == first)
> -			break;
> -		if (i == 0)
> -			i = tx_ring->count;
> -		i--;
>  	}
> 
> +	if (dma_unmap_len(tx_buffer, len))
> +		dma_unmap_single(tx_ring->dev,
> +				 dma_unmap_addr(tx_buffer, dma),
> +				 dma_unmap_len(tx_buffer, len),
> +				 DMA_TO_DEVICE);
> +	dma_unmap_len_set(tx_buffer, len, 0);
> +
> +	dev_kfree_skb_any(tx_buffer->skb);
> +	tx_buffer->skb = NULL;
> +
>  	tx_ring->next_to_use = i;
>  }
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

