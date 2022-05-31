From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 31 May 2022 13:40:37 -0700
Subject: [Intel-wired-lan] [PATCH net v1 1/2] ice: Add error handling
 for queue config fail
In-Reply-To: <20220531131835.3614-1-mateusz.palczewski@intel.com>
References: <20220531131835.3614-1-mateusz.palczewski@intel.com>
Message-ID: <2cceb264-8998-2f81-354b-b1331f71102d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/31/2022 6:18 AM, Mateusz Palczewski wrote:
> From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> 
> Disable VF's RX/TX queues, when VIRTCHNL_OP_CONFIG_VSI_QUEUES fail.
> Not disabling them might lead to scenario, where PF driver leaves VF
> queues enabled, when VF's VSI failed queue config.
> In this scenario VF should not have RX/TX queues enabled. If PF failed
> to setup VF's queues, VF will reset due to TX timeouts in VF driver.
> 

Patches for net need a Fixes tag.

> Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Suggested-by: Slawomir Laba <slawomirx.laba@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 53 +++++++++----------
>   1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index 1d9b84c..4547bc1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -1569,35 +1569,27 @@ static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
>    */
>   static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>   {
> -	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;

This removal seems like a refactor and unrelated to the bug. Please send 
this change via net-next.

Thanks,
Tony

>   	struct virtchnl_vsi_queue_config_info *qci =
>   	    (struct virtchnl_vsi_queue_config_info *)msg;
>   	struct virtchnl_queue_pair_info *qpi;
>   	struct ice_pf *pf = vf->pf;
>   	struct ice_vsi *vsi;
> -	int i, q_idx;
> +	int i = -1, q_idx;
>   
> -	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
> -		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
>   		goto error_param;
> -	}
>   
> -	if (!ice_vc_isvalid_vsi_id(vf, qci->vsi_id)) {
> -		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
> +	if (!ice_vc_isvalid_vsi_id(vf, qci->vsi_id))
>   		goto error_param;
> -	}

