From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 21 Apr 2021 18:47:10 +0000
Subject: [Intel-wired-lan] [PATCH S56 08/13] ice: Refactor
 VIRTCHNL_OP_CONFIG_VSI_QUEUES handling
In-Reply-To: <20210302181545.51822-8-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
 <20210302181545.51822-8-anthony.l.nguyen@intel.com>
Message-ID: <CY4PR11MB15769EF82C7B193E6779A172AB479@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: wtorek, 2 marca 2021 19:16
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S56 08/13] ice: Refactor
> VIRTCHNL_OP_CONFIG_VSI_QUEUES handling
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently, when a VF requests queue configuration via
> VIRTCHNL_OP_CONFIG_VSI_QUEUES the PF driver expects that this
> message will only be called once and we always assume the queues being
> configured start from 0. This is incorrect and is causing issues when a VF tries
> to send this message for multiple queue blocks. Fix this by using the
> queue_id specified in the virtchnl message and allowing for individual Rx
> and/or Tx queues to be configured.
> 
> Also, reduce the duplicated for loops for configuring the queues by moving
> all the logic into a single for loop.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 27 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  4 ++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 51 ++++++++++---------
>  3 files changed, 59 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 01371b377fbc..ddcbd5bfd058 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -1668,6 +1668,33 @@ ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16
> pf_q, u32 rxdid, u32 prio)
>  	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);  }
> 
> +int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx) {
> +	if (q_idx >= vsi->num_rxq)
> +		return -EINVAL;
> +
> +	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
> +}
> +
> +int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_ring
> +**tx_rings, u16 q_idx) {
> +	struct ice_aqc_add_tx_qgrp *qg_buf;
> +	int err;
> +
> +	if (q_idx >= vsi->alloc_txq || !tx_rings || !tx_rings[q_idx])
> +		return -EINVAL;
> +
> +	qg_buf = kzalloc(struct_size(qg_buf, txqs, 1), GFP_KERNEL);
> +	if (!qg_buf)
> +		return -ENOMEM;
> +
> +	qg_buf->num_txqs = 1;
> +
> +	err = ice_vsi_cfg_txq(vsi, tx_rings[q_idx], qg_buf);
> +	kfree(qg_buf);
> +	return err;
> +}
> +
>  /**
>   * ice_vsi_cfg_rxqs - Configure the VSI for Rx
>   * @vsi: the VSI being configured
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h
> b/drivers/net/ethernet/intel/ice/ice_lib.h
> index 3da17895a2b1..4b16394da354 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.h
> @@ -12,6 +12,10 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf);
> 
>  void ice_update_eth_stats(struct ice_vsi *vsi);
> 
> +int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
> +
> +int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_ring
> +**tx_rings, u16 q_idx);
> +
>  int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
> 
>  int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi); diff --git
> a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index 7ffad4c8a64e..420fcb58e0d3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -3053,10 +3053,9 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8
> *msg)
>  	struct virtchnl_vsi_queue_config_info *qci =
>  	    (struct virtchnl_vsi_queue_config_info *)msg;
>  	struct virtchnl_queue_pair_info *qpi;
> -	u16 num_rxq = 0, num_txq = 0;
>  	struct ice_pf *pf = vf->pf;
>  	struct ice_vsi *vsi;
> -	int i;
> +	int i, q_idx;
> 
>  	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
>  		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> @@ -3094,18 +3093,31 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8
> *msg)
>  			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>  			goto error_param;
>  		}
> +
> +		q_idx = qpi->rxq.queue_id;
> +
> +		/* make sure selected "q_idx" is in valid range of queues
> +		 * for selected "vsi"
> +		 */
> +		if (q_idx >= vsi->alloc_txq || q_idx >= vsi->alloc_rxq) {
> +			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +			goto error_param;
> +		}
> +
>  		/* copy Tx queue info from VF into VSI */
>  		if (qpi->txq.ring_len > 0) {
> -			num_txq++;
>  			vsi->tx_rings[i]->dma = qpi->txq.dma_ring_addr;
>  			vsi->tx_rings[i]->count = qpi->txq.ring_len;
> +			if (ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx)) {
> +				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +				goto error_param;
> +			}
>  		}
> 
>  		/* copy Rx queue info from VF into VSI */
>  		if (qpi->rxq.ring_len > 0) {
>  			u16 max_frame_size =
> ice_vc_get_max_frame_size(vf);
> 
> -			num_rxq++;
>  			vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
>  			vsi->rx_rings[i]->count = qpi->rxq.ring_len;
> 
> @@ -3122,27 +3134,20 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8
> *msg)
>  				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
>  				goto error_param;
>  			}
> -		}
> 
> -		vsi->max_frame = qpi->rxq.max_pkt_size;
> -		/* add space for the port VLAN since the VF driver is not
> -		 * expected to account for it in the MTU calculation
> -		 */
> -		if (vf->port_vlan_info)
> -			vsi->max_frame += VLAN_HLEN;
> -	}
> -
> -	/* VF can request to configure less than allocated queues or default
> -	 * allocated queues. So update the VSI with new number
> -	 */
> -	vsi->num_txq = num_txq;
> -	vsi->num_rxq = num_rxq;
> -	/* All queues of VF VSI are in TC 0 */
> -	vsi->tc_cfg.tc_info[0].qcount_tx = num_txq;
> -	vsi->tc_cfg.tc_info[0].qcount_rx = num_rxq;
> +			vsi->max_frame = qpi->rxq.max_pkt_size;
> +			/* add space for the port VLAN since the VF driver is
> not
> +			 * expected to account for it in the MTU calculation
> +			 */
> +			if (vf->port_vlan_info)
> +				vsi->max_frame += VLAN_HLEN;
> 
> -	if (ice_vsi_cfg_lan_txqs(vsi) || ice_vsi_cfg_rxqs(vsi))
> -		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
> +			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
> +				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +				goto error_param;
> +			}
> +		}
> +	}
> 
>  error_param:
>  	/* send the response to the VF */

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
