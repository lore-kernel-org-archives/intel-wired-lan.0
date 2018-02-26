From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 26 Feb 2018 16:05:46 +0000
Subject: [Intel-wired-lan] [PATCH 9/9] ixgbevf: add build_skb support
In-Reply-To: <20180131005154.19264.9737.stgit@localhost6.localdomain6>
References: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
 <20180131005154.19264.9737.stgit@localhost6.localdomain6>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64BD832C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Emil Tantilov
> Sent: Tuesday, January 30, 2018 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 9/9] ixgbevf: add build_skb support
> 
> Add support for build_skb() similar to:
> commit 6f429223b31c ("ixgbe: Add support for build_skb")
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   41
> +++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index cd8c0a0..74fcb4c 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -910,6 +910,44 @@ static inline void ixgbevf_irq_enable_queues(struct
> ixgbevf_adapter *adapter,
>  	IXGBE_WRITE_REG(hw, IXGBE_VTEIMS, qmask);
>  }
> 
> +static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
> +					 struct ixgbevf_rx_buffer *rx_buffer,
> +					 union ixgbe_adv_rx_desc *rx_desc,
> +					 unsigned int size)
> +{
> +	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +#if (PAGE_SIZE < 8192)
> +	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
> +#else
> +	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct
> skb_shared_info)) +
> +				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size);
> +#endif
> +	struct sk_buff *skb;
> +
> +	/* prefetch first cache line of first page */
> +	prefetch(va);
> +#if L1_CACHE_BYTES < 128
> +	prefetch(va + L1_CACHE_BYTES);
> +#endif
> +
> +	/* build an skb to around the page buffer */
> +	skb = build_skb(va - IXGBEVF_SKB_PAD, truesize);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	/* update pointers within the skb to store the data */
> +	skb_reserve(skb, IXGBEVF_SKB_PAD);
> +	__skb_put(skb, size);
> +
> +	/* update buffer offset */
> +#if (PAGE_SIZE < 8192)
> +	rx_buffer->page_offset ^= truesize;
> +#else
> +	rx_buffer->page_offset += truesize;
> +#endif
> +
> +	return skb;
> +}
>  static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
>  				struct ixgbevf_ring *rx_ring,
>  				int budget)
> @@ -945,6 +983,9 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector
> *q_vector,
>  		/* retrieve a buffer from the ring */
>  		if (skb)
>  			ixgbevf_add_rx_frag(rx_ring, rx_buffer, skb, size);
> +		else if (ring_uses_build_skb(rx_ring))
> +			skb = ixgbevf_build_skb(rx_ring, rx_buffer,
> +						rx_desc, size);
>  		else
>  			skb = ixgbevf_construct_skb(rx_ring, rx_buffer,
>  						    rx_desc, size);
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

