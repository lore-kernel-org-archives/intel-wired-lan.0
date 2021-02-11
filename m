From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 11 Feb 2021 02:46:53 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix not showing opcode
 msg on unsuccessful VF MAC change
In-Reply-To: <20210209121745.8840-1-mateusz.palczewski@intel.com>
References: <20210209121745.8840-1-mateusz.palczewski@intel.com>
Message-ID: <af49217051d461d29142a7de7c1232eda735db3b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-02-09 at 12:17 +0000, Mateusz Palczewski wrote:
> Hide i40e opcode information sent during response to VF in case when
> untrusted VF tried to change MAC on the VF interface.

The title and description seem to contradict.
"Fix not showing opcode" and "Hide i40e opcode information"

> This is implemented by adding an additional parameter 'hide' to the
> response sent to VF function that hides the display of error
> information, but forwards the error code to VF.
> 
> Previously it was not possible to send response with some error code
> to VF without displaying opcode information.
> 
> Fixes: 5c3c48ac6bf5("i40e:implement virtual device interface")

nit: There's a missing space
Fixes: 5c3c48ac6bf5("i40e: implement virtual device interface")

It's not clear to me what the bug is.

> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Reviewed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 44 +++++++++++++++
> ----
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index b40ce62..b47159a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -1792,17 +1792,18 @@ sriov_configure_out:
>  /***********************virtual channel routines******************/
>  
>  /**
> - * i40e_vc_send_msg_to_vf
> + * i40e_vc_send_msg_to_vf_ex
>   * @vf: pointer to the VF info
>   * @v_opcode: virtual channel opcode
>   * @v_retval: virtual channel return value
>   * @msg: pointer to the msg buffer
>   * @msglen: msg length
> - *
> + * @is_quiet: true for not printing unsuccessful return values,
> false otherwise
>   * send msg to VF
>   **/
> -static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
> -				  u32 v_retval, u8 *msg, u16 msglen)
> +static int i40e_vc_send_msg_to_vf_ex(struct i40e_vf *vf, u32
> v_opcode,
> +				     u32 v_retval, u8 *msg, u16 msglen,
> +				     bool is_quiet)
>  {
>  	struct i40e_pf *pf;
>  	struct i40e_hw *hw;
> @@ -1818,7 +1819,7 @@ static int i40e_vc_send_msg_to_vf(struct
> i40e_vf *vf, u32 v_opcode,
>  	abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
>  
>  	/* single place to detect unsuccessful return values */
> -	if (v_retval) {
> +	if (v_retval && !is_quiet) {
>  		vf->num_invalid_msgs++;
>  		dev_info(&pf->pdev->dev, "VF %d failed opcode %d,
> retval: %d\n",
>  			 vf->vf_id, v_opcode, v_retval);
> @@ -1848,6 +1849,23 @@ static int i40e_vc_send_msg_to_vf(struct
> i40e_vf *vf, u32 v_opcode,
>  	return 0;
>  }
>  
> +/**
> + * i40e_vc_send_msg_to_vf
> + * @vf: pointer to the VF info
> + * @v_opcode: virtual channel opcode
> + * @v_retval: virtual channel return value
> + * @msg: pointer to the msg buffer
> + * @msglen: msg length
> + *
> + * send msg to VF
> + **/
> +static int i40e_vc_send_msg_to_vf(struct i40e_vf *vf, u32 v_opcode,
> +				  u32 v_retval, u8 *msg, u16 msglen)
> +{
> +	return i40e_vc_send_msg_to_vf_ex(vf, v_opcode, v_retval,
> +					 msg, msglen, false);
> +}
> +
>  /**
>   * i40e_vc_send_resp_to_vf
>   * @vf: pointer to the VF info
> @@ -2591,6 +2609,7 @@ error_param:
>   * i40e_check_vf_permission
>   * @vf: pointer to the VF info
>   * @al: MAC address list from virtchnl
> + * @is_quiet: set true for printing msg without opcode info, false
> otherwise
>   *
>   * Check that the given list of MAC addresses is allowed. Will
> return -EPERM
>   * if any address in the list is not valid. Checks the following
> conditions:
> @@ -2605,13 +2624,18 @@ error_param:
>   * addresses might not be accurate.
>   **/
>  static inline int i40e_check_vf_permission(struct i40e_vf *vf,
> -					   struct
> virtchnl_ether_addr_list *al)
> +					   struct
> virtchnl_ether_addr_list *al,
> +					   bool *is_quiet)
>  {
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
>  	int mac2add_cnt = 0;
>  	int i;
>  
> +	if (!is_quiet)
> +		return -EINVAL;
> +
> +	*is_quiet = false;
>  	for (i = 0; i < al->num_elements; i++) {
>  		struct i40e_mac_filter *f;
>  		u8 *addr = al->list[i].addr;
> @@ -2635,6 +2659,7 @@ static inline int
> i40e_check_vf_permission(struct i40e_vf *vf,
>  		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) 
> {
>  			dev_err(&pf->pdev->dev,
>  				"VF attempting to override
> administratively set MAC address, bring down and up the VF interface
> to resume normal operation\n");
> +			*is_quiet = true;
>  			return -EPERM;
>  		}
>  
> @@ -2671,6 +2696,7 @@ static int i40e_vc_add_mac_addr_msg(struct
> i40e_vf *vf, u8 *msg)
>  	    (struct virtchnl_ether_addr_list *)msg;
>  	struct i40e_pf *pf = vf->pf;
>  	struct i40e_vsi *vsi = NULL;
> +	bool is_quiet = false;
>  	i40e_status ret = 0;
>  	int i;
>  
> @@ -2687,7 +2713,7 @@ static int i40e_vc_add_mac_addr_msg(struct
> i40e_vf *vf, u8 *msg)
>  	 */
>  	spin_lock_bh(&vsi->mac_filter_hash_lock);
>  
> -	ret = i40e_check_vf_permission(vf, al);
> +	ret = i40e_check_vf_permission(vf, al, &is_quiet);
>  	if (ret) {
>  		spin_unlock_bh(&vsi->mac_filter_hash_lock);
>  		goto error_param;
> @@ -2725,8 +2751,8 @@ static int i40e_vc_add_mac_addr_msg(struct
> i40e_vf *vf, u8 *msg)
>  
>  error_param:
>  	/* send the response to the VF */
> -	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ADD_ETH_ADDR,
> -				       ret);
> +	return i40e_vc_send_msg_to_vf_ex(vf, VIRTCHNL_OP_ADD_ETH_ADDR,
> +				       ret, NULL, 0, is_quiet);
>  }
>  
>  /**
