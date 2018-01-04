From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 4 Jan 2018 15:49:34 +0000
Subject: [Intel-wired-lan] [PATCH 8/9] ixgbevf: improve performance and
 reduce size of ixgbevf_tx_map()
In-Reply-To: <20171211183725.21524.40905.stgit@localhost6.localdomain6>
References: <20171211183537.21524.10133.stgit@localhost6.localdomain6>
 <20171211183725.21524.40905.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64B3EF50@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Emil Tantilov
> Sent: Monday, December 11, 2017 10:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 8/9] ixgbevf: improve performance and
> reduce size of ixgbevf_tx_map()
> 
> Based on commit ec718254cbfe
> ("ixgbe: Improve performance and reduce size of ixgbe_tx_map")
> 
> This change is meant to both improve the performance and reduce the size of
> ixgbevf_tx_map().
> 
> Expand the work done in the main loop by pushing first into tx_buffer.
> This allows us to pull in the dma_mapping_error check, the tx_buffer value
> assignment, and the initial DMA value assignment to the Tx descriptor.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   45 +++++++++------------
>  1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index a793f9e..d3415ee 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3532,34 +3532,37 @@ static void ixgbevf_tx_map(struct ixgbevf_ring
> *tx_ring,
>  			   struct ixgbevf_tx_buffer *first,
>  			   const u8 hdr_len)
>  {
> -	dma_addr_t dma;
>  	struct sk_buff *skb = first->skb;
>  	struct ixgbevf_tx_buffer *tx_buffer;
>  	union ixgbe_adv_tx_desc *tx_desc;
> -	struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[0];
> -	unsigned int data_len = skb->data_len;
> -	unsigned int size = skb_headlen(skb);
> -	unsigned int paylen = skb->len - hdr_len;
> +	struct skb_frag_struct *frag;
> +	dma_addr_t dma;
> +	unsigned int data_len, size;
>  	u32 tx_flags = first->tx_flags;
> -	__le32 cmd_type;
> +	__le32 cmd_type = ixgbevf_tx_cmd_type(tx_flags);
>  	u16 i = tx_ring->next_to_use;
> 
>  	tx_desc = IXGBEVF_TX_DESC(tx_ring, i);
> 
> -	ixgbevf_tx_olinfo_status(tx_desc, tx_flags, paylen);
> -	cmd_type = ixgbevf_tx_cmd_type(tx_flags);
> +	ixgbevf_tx_olinfo_status(tx_desc, tx_flags, skb->len - hdr_len);
> +
> +	size = skb_headlen(skb);
> +	data_len = skb->data_len;
> 
>  	dma = dma_map_single(tx_ring->dev, skb->data, size,
> DMA_TO_DEVICE);
> -	if (dma_mapping_error(tx_ring->dev, dma))
> -		goto dma_error;
> 
> -	/* record length, and DMA address */
> -	dma_unmap_len_set(first, len, size);
> -	dma_unmap_addr_set(first, dma, dma);
> +	tx_buffer = first;
> 
> -	tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
> +		if (dma_mapping_error(tx_ring->dev, dma))
> +			goto dma_error;
> +
> +		/* record length, and DMA address */
> +		dma_unmap_len_set(tx_buffer, len, size);
> +		dma_unmap_addr_set(tx_buffer, dma, dma);
> +
> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> 
> -	for (;;) {
>  		while (unlikely(size > IXGBE_MAX_DATA_PER_TXD)) {
>  			tx_desc->read.cmd_type_len =
>  				cmd_type |
> cpu_to_le32(IXGBE_MAX_DATA_PER_TXD);
> @@ -3570,12 +3573,12 @@ static void ixgbevf_tx_map(struct ixgbevf_ring
> *tx_ring,
>  				tx_desc = IXGBEVF_TX_DESC(tx_ring, 0);
>  				i = 0;
>  			}
> +			tx_desc->read.olinfo_status = 0;
> 
>  			dma += IXGBE_MAX_DATA_PER_TXD;
>  			size -= IXGBE_MAX_DATA_PER_TXD;
> 
>  			tx_desc->read.buffer_addr = cpu_to_le64(dma);
> -			tx_desc->read.olinfo_status = 0;
>  		}
> 
>  		if (likely(!data_len))
> @@ -3589,23 +3592,15 @@ static void ixgbevf_tx_map(struct ixgbevf_ring
> *tx_ring,
>  			tx_desc = IXGBEVF_TX_DESC(tx_ring, 0);
>  			i = 0;
>  		}
> +		tx_desc->read.olinfo_status = 0;
> 
>  		size = skb_frag_size(frag);
>  		data_len -= size;
> 
>  		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, size,
>  				       DMA_TO_DEVICE);
> -		if (dma_mapping_error(tx_ring->dev, dma))
> -			goto dma_error;
> 
>  		tx_buffer = &tx_ring->tx_buffer_info[i];
> -		dma_unmap_len_set(tx_buffer, len, size);
> -		dma_unmap_addr_set(tx_buffer, dma, dma);
> -
> -		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> -		tx_desc->read.olinfo_status = 0;
> -
> -		frag++;
>  	}
> 
>  	/* write last descriptor with RS and EOP bits */
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

