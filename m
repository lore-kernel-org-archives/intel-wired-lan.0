From: Ivan Vecera <ivecera@redhat.com>
Date: Sat, 16 Apr 2022 13:30:43 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <248da3d7-cb00-14b6-12f0-6bb9fda6d532@intel.com>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <YlldsfrRJURXpp5d@boxer>
 <248da3d7-cb00-14b6-12f0-6bb9fda6d532@intel.com>
Message-ID: <20220416133043.08b4ee74@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 15 Apr 2022 13:55:06 -0700
Tony Nguyen <anthony.l.nguyen@intel.com> wrote:

> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >>> index 5612c032f15a..553287a75b50 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> >>> @@ -3625,44 +3625,39 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
> >>>   		return;
> >>>   	}
> >>>   
> >>> +	mutex_lock(&vf->cfg_lock);
> >>> +
> >>>   	/* Check if VF is disabled. */
> >>>   	if (test_bit(ICE_VF_STATE_DIS, vf->vf_states)) {
> >>>   		err = -EPERM;
> >>> -		goto error_handler;
> >>> -	}
> >>> -
> >>> -	ops = vf->virtchnl_ops;
> >>> -
> >>> -	/* Perform basic checks on the msg */
> >>> -	err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg, msglen);
> >>> -	if (err) {
> >>> -		if (err == VIRTCHNL_STATUS_ERR_PARAM)
> >>> -			err = -EPERM;
> >>> -		else
> >>> -			err = -EINVAL;
> >>> +	} else {
> >>> +		/* Perform basic checks on the msg */
> >>> +		err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg,
> >>> +						  msglen);
> >>> +		if (err) {
> >>> +			if (err == VIRTCHNL_STATUS_ERR_PARAM)
> >>> +				err = -EPERM;
> >>> +			else
> >>> +				err = -EINVAL;
> >>> +		}  
> >> The chunk above feels a bit like unnecessary churn, no?
> >> Couldn't this patch be simply focused only on extending critical section?  
> 
> Agree, this doesn't seem related to the fix.
> 
> Thanks,
> 
> Tony
Yes, it is not directly related but it's just a conversion of following snippet
to avoid ugly and unnecessary 'goto':

if (A) {
	err = ...
	goto error_handler;
}
if (B) {
	err = ...
	...
}
if (err) {
	...
}

to

if (A) {
	err = ...
} else {
	if (B) {
		...
	}
}
if (err) {
	...
}

If you want to leave the code as is and remove this from the patch
let me know and I will send v2.

Thanks,
Ivan

