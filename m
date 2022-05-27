From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 27 May 2022 09:45:23 -0700
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix dropped jumbo frames
 statistics
In-Reply-To: <20220527080750.2370502-1-jedrzej.jagielski@intel.com>
References: <20220527080750.2370502-1-jedrzej.jagielski@intel.com>
Message-ID: <2485cd45-1ac5-6e2a-9023-2887cc535069@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/27/2022 1:07 AM, Jedrzej Jagielski wrote:
> From: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
> 
> +/**
> + * i40e_stats_update_rx_discards - update rx_discards.
> + * @vsi: ptr to the VSI to be updated.
> + * @hw: ptr to the hardware info.
> + * @stat_idx: VSI's stat_counter_idx.
> + * @offset_loaded: ptr to the VSI's stat_offsets_loaded.
> + * @stat_offset: ptr to stat_offset to store first read of specific register.
> + * @stat: ptr to VSI's stat to be updated.
> + **/
> +static void i40e_stats_update_rx_discards(struct i40e_vsi *vsi,
> +			struct i40e_hw *hw, int stat_idx, bool offset_loaded,
> +			struct i40e_eth_stats *stat_offset,
> +			struct i40e_eth_stats *stat)

Checkpatch reports an alignment issue with this. I'd recommend using 
this style to help resolve this:

static void
i40e_stats_update_rx_discards(struct i40e_vsi *vsi,
			      struct i40e_hw *hw, int stat_idx, ...

Look at the ice driver for more examples.

> +{
> +	u64 rx_rdpc, rx_rxerr;
> +
> +	i40e_stat_update32(hw, I40E_GLV_RDPC(stat_idx), offset_loaded,
> +			   &stat_offset->rx_discards, &rx_rdpc);
> +	i40e_stat_update64(hw,
> +			   I40E_GL_RXERR1H(i40e_compute_pci_to_hw_id(vsi, hw)),
> +			   I40E_GL_RXERR1L(i40e_compute_pci_to_hw_id(vsi, hw)),
> +			   offset_loaded, &stat_offset->rx_discards_other,
> +			   &rx_rxerr);
> +
> +	stat->rx_discards = rx_rdpc + rx_rxerr;
> +}
> +
>   /**
>    * i40e_update_eth_stats - Update VSI-specific ethernet statistics counters.
>    * @vsi: the VSI to be updated
> @@ -679,6 +749,10 @@ void i40e_update_eth_stats(struct i40e_vsi *vsi)
>   			   I40E_GLV_BPTCL(stat_idx),
>   			   vsi->stat_offsets_loaded,
>   			   &oes->tx_broadcast, &es->tx_broadcast);
> +
> +	i40e_stats_update_rx_discards(vsi, hw, stat_idx,
> +		   vsi->stat_offsets_loaded, oes, es);

Alignment issue here as well.

> +
>   	vsi->stat_offsets_loaded = true;
>   }
