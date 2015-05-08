From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Fri, 08 May 2015 13:07:48 -0700
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Allow flow director
 to use entire queue space
In-Reply-To: <20150508184720.22470.35134.stgit@jrfastab-mobl.amr.corp.intel.com>
References: <20150508184720.22470.35134.stgit@jrfastab-mobl.amr.corp.intel.com>
Message-ID: <554D1794.9020409@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 05/08/2015 11:47 AM, John Fastabend wrote:
> Flow director is exported to user space using the ethtool ntuple
> support. However, currently it only supports steering traffic to a
> subset of the queues in use by the hardware. This change allows
> flow director to specify queues that have been assigned to virtual
> functions or VMDQ pools.
>
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>

Comments below.  The main thing I see is that this should really be 
split into two patches since you are doing two very different things here.

- Alex

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   22 ++++++++-----
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   37 +++++++++++++++++++++-
>   2 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 0f1bff3..ccd661f 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -2595,16 +2595,18 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   	struct ixgbe_fdir_filter *input;
>   	union ixgbe_atr_input mask;
>   	int err;
> +	u8 queue;
>
>   	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
>   		return -EOPNOTSUPP;
>
> -	/*
> -	 * Don't allow programming if the action is a queue greater than
> -	 * the number of online Rx queues.
> +	/* ring_cookie can not be larger than the total number of queues in use
> +	 * by the device including the queues aassigned to virtual functions and
> +	 * VMDQ pools.
>   	 */
>   	if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
> -	    (fsp->ring_cookie >= adapter->num_rx_queues))
> +	    (fsp->ring_cookie >=
> +		(adapter->num_rx_queues * (adapter->num_vfs + 1))))
>   		return -EINVAL;

I'm not sure if I am a fan of the literal interpretation of the 
ring_cookie.  The fact is you might be better of creating a logical 
mapping.  So for example just use the least significant byte to 
represent the queue, and the next one up to represent the VMDq pool with 
0 as the default pool (aka PF).  That way you can still deal with any 
funky mapping such as the DCB/VMDq combo.

>   	/* Don't allow indexes to exist outside of available space */
> @@ -2681,12 +2683,16 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
>   	/* apply mask and compute/store hash */
>   	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
>
> +	if (input->action < adapter->num_rx_queues)
> +		queue = adapter->rx_ring[input->action]->reg_idx;
> +	else if (input->action == IXGBE_FDIR_DROP_QUEUE)
> +		queue = IXGBE_FDIR_DROP_QUEUE;
> +	else
> +		queue = input->action - adapter->num_rx_queues;
> +
>   	/* program filters to filter memory */
>   	err = ixgbe_fdir_write_perfect_filter_82599(hw,
> -				&input->filter, input->sw_idx,
> -				(input->action == IXGBE_FDIR_DROP_QUEUE) ?
> -				IXGBE_FDIR_DROP_QUEUE :
> -				adapter->rx_ring[input->action]->reg_idx);
> +				&input->filter, input->sw_idx, queue);
>   	if (err)
>   		goto err_out_w_lock;
>

Really you should probably do the conversion sooner.  I would convert 
the value back up where you pull RX_CLS_FLOW_DISC out of the ring 
cookie.  Also breaking the ring cookie up into a logical queue would 
allow for the conversion to be much simpler since the lower 8 bits would 
give you which ring to pull the reg_idx from and the upper 8 would give 
you which VMDq pool you need to target.

All of the stuff below here belongs in a separate patch.
-V-V-V-V-V-V-


> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index ee600b2..23540dd 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -3166,8 +3166,20 @@ static void ixgbe_enable_rx_drop(struct ixgbe_adapter *adapter,
>   	u8 reg_idx = ring->reg_idx;
>   	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>
> +	pr_info("%s: enable_rx_drop on queue %d\n",
> +		ixgbe_driver_string, reg_idx);
>   	srrctl |= IXGBE_SRRCTL_DROP_EN;
> +	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
> +}
> +
> +static void ixgbe_enable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
> +{
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
>
> +	pr_info("%s: enable_vf_rx_drop on queue %d\n",
> +		ixgbe_driver_string, reg_idx);
> +	srrctl |= IXGBE_SRRCTL_DROP_EN;
>   	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>   }
>
> @@ -3183,13 +3195,22 @@ static void ixgbe_disable_rx_drop(struct ixgbe_adapter *adapter,
>   	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
>   }
>

The VF should be using a different register to enable Rx drop, or is 
this meant to be applied to a VMDq pool?  For the VF you should be using 
ixgbe_write_qde to force the queue drop enable.  The same probably 
applies for VMDq if you are planning to give user space access to actual 
pools at some point.

> +static void ixgbe_disable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
> +{
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
> +
> +	srrctl &= ~IXGBE_SRRCTL_DROP_EN;
> +	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
> +}
> +

The same goes for this spot as well.

>   #ifdef CONFIG_IXGBE_DCB
>   void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>   #else
>   static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>   #endif
>   {
> -	int i;
> +	int i, j;
>   	bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
>
>   	if (adapter->ixgbe_ieee_pfc)
> @@ -3208,9 +3229,23 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
>   	    !(adapter->hw.fc.current_mode & ixgbe_fc_tx_pause) && !pfc_en)) {
>   		for (i = 0; i < adapter->num_rx_queues; i++)
>   			ixgbe_enable_rx_drop(adapter, adapter->rx_ring[i]);
> +		for (i = 0; i < adapter->num_vfs; i++) {
> +			for (j = 0; j < adapter->num_rx_queues; j++) {
> +				u8 q = i * adapter->num_rx_queues + j;
> +
> +				ixgbe_enable_vf_rx_drop(adapter, q);
> +			}
> +		}
>   	} else {
>   		for (i = 0; i < adapter->num_rx_queues; i++)
>   			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
> +		for (i = 0; i < adapter->num_vfs; i++) {
> +			for (j = 0; j < adapter->num_rx_queues; j++) {
> +				u8 q = i * adapter->num_rx_queues + j;
> +
> +				ixgbe_disable_vf_rx_drop(adapter, q);
> +			}
> +		}
>   	}
>   }
>

This logic is just broken.  The fact is the number of queues can be 
controlled via the "ethtool -L" option, so you might get some of the VFs 
but not all of them since there might be something like 4 queues per 
pool, but the PF only has one allocated for use so you only cover a 
quarter of the VF queues.

If this is meant to go after VMDq pools I believe the info for those 
exist in the ring_feature[RING_F_VMDQ], not in num_vfs.  Probably your 
best bet would be to review ixgbe_cache_ring_dcb_sriov and 
ixgbe_cache_ring_sriov in order to sort out how to go about getting ring 
counts per pool, and offsets of queues.

Also for SR-IOV we normally always leave the VFs with queue drop enable 
set in order to prevent a failed VM from causing the device to hang. 
You might need to update your code to do something similar for VMDq as I 
am not sure you want to allow user space to stop cleaning a queue pair 
and hang the whole device.

