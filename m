From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 2 Mar 2021 10:20:57 +0200
Subject: [Intel-wired-lan] [PATCH net-next v6 3/9] igc: Introduce
 igc_rx_buffer_flip() helper
In-Reply-To: <20210210215848.24514-4-vedang.patel@intel.com>
References: <20210210215848.24514-1-vedang.patel@intel.com>
 <20210210215848.24514-4-vedang.patel@intel.com>
Message-ID: <7dba7277-1e6b-1093-474b-8002c0e1b1b6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/02/2021 23:58, Vedang Patel wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> The igc driver implements the same page recycling scheme from other
> Intel drivers which reuses the page by flipping the buffer. The code
> to handle buffer flips is duplicated in many locations so introduce
> the igc_rx_buffer_flip() helper and use it where applicable.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 43 +++++++++++------------
>   1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 261672797346..1157a24f6d26 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1500,6 +1500,16 @@ static struct igc_rx_buffer *igc_get_rx_buffer(struct igc_ring *rx_ring,
>   	return rx_buffer;
>   }
>   
> +static void igc_rx_buffer_flip(struct igc_rx_buffer *buffer,
> +			       unsigned int truesize)
> +{
> +#if (PAGE_SIZE < 8192)
> +	buffer->page_offset ^= truesize;
> +#else
> +	buffer->page_offset += truesize;
> +#endif
> +}
> +
>   /**
>    * igc_add_rx_frag - Add contents of Rx buffer to sk_buff
>    * @rx_ring: rx descriptor ring to transact packets on
> @@ -1514,20 +1524,19 @@ static void igc_add_rx_frag(struct igc_ring *rx_ring,
>   			    struct sk_buff *skb,
>   			    unsigned int size)
>   {
> -#if (PAGE_SIZE < 8192)
> -	unsigned int truesize = igc_rx_pg_size(rx_ring) / 2;
> +	unsigned int truesize;
>   
> -	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> -			rx_buffer->page_offset, size, truesize);
> -	rx_buffer->page_offset ^= truesize;
> +#if (PAGE_SIZE < 8192)
> +	truesize = igc_rx_pg_size(rx_ring) / 2;
>   #else
> -	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
> -				SKB_DATA_ALIGN(IGC_SKB_PAD + size) :
> -				SKB_DATA_ALIGN(size);
> +	truesize = ring_uses_build_skb(rx_ring) ?
> +		   SKB_DATA_ALIGN(IGC_SKB_PAD + size) :
> +		   SKB_DATA_ALIGN(size);
> +#endif
>   	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
>   			rx_buffer->page_offset, size, truesize);
> -	rx_buffer->page_offset += truesize;
> -#endif
> +
> +	igc_rx_buffer_flip(rx_buffer, truesize);
>   }
>   
>   static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
> @@ -1556,13 +1565,7 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>   	skb_reserve(skb, IGC_SKB_PAD);
>   	__skb_put(skb, size);
>   
> -	/* update buffer offset */
> -#if (PAGE_SIZE < 8192)
> -	rx_buffer->page_offset ^= truesize;
> -#else
> -	rx_buffer->page_offset += truesize;
> -#endif
> -
> +	igc_rx_buffer_flip(rx_buffer, truesize);
>   	return skb;
>   }
>   
> @@ -1608,11 +1611,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
>   		skb_add_rx_frag(skb, 0, rx_buffer->page,
>   				(va + headlen) - page_address(rx_buffer->page),
>   				size, truesize);
> -#if (PAGE_SIZE < 8192)
> -		rx_buffer->page_offset ^= truesize;
> -#else
> -		rx_buffer->page_offset += truesize;
> -#endif
> +		igc_rx_buffer_flip(rx_buffer, truesize);
>   	} else {
>   		rx_buffer->pagecnt_bias++;
>   	}
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
