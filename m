From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 18 Apr 2022 11:10:30 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <20220416133043.08b4ee74@ceranb>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <YlldsfrRJURXpp5d@boxer>
 <248da3d7-cb00-14b6-12f0-6bb9fda6d532@intel.com>
 <20220416133043.08b4ee74@ceranb>
Message-ID: <607248b2-bfb2-08a2-3d17-67c5c28840fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/16/2022 4:30 AM, Ivan Vecera wrote:
> On Fri, 15 Apr 2022 13:55:06 -0700
> Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>
>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>>>> index 5612c032f15a..553287a75b50 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>>>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>>>> @@ -3625,44 +3625,39 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
>>>>>    		return;
>>>>>    	}
>>>>>    
>>>>> +	mutex_lock(&vf->cfg_lock);
>>>>> +
>>>>>    	/* Check if VF is disabled. */
>>>>>    	if (test_bit(ICE_VF_STATE_DIS, vf->vf_states)) {
>>>>>    		err = -EPERM;
>>>>> -		goto error_handler;
>>>>> -	}
>>>>> -
>>>>> -	ops = vf->virtchnl_ops;
>>>>> -
>>>>> -	/* Perform basic checks on the msg */
>>>>> -	err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg, msglen);
>>>>> -	if (err) {
>>>>> -		if (err == VIRTCHNL_STATUS_ERR_PARAM)
>>>>> -			err = -EPERM;
>>>>> -		else
>>>>> -			err = -EINVAL;
>>>>> +	} else {
>>>>> +		/* Perform basic checks on the msg */
>>>>> +		err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg,
>>>>> +						  msglen);
>>>>> +		if (err) {
>>>>> +			if (err == VIRTCHNL_STATUS_ERR_PARAM)
>>>>> +				err = -EPERM;
>>>>> +			else
>>>>> +				err = -EINVAL;
>>>>> +		}
>>>> The chunk above feels a bit like unnecessary churn, no?
>>>> Couldn't this patch be simply focused only on extending critical section?
>> Agree, this doesn't seem related to the fix.
>>
>> Thanks,
>>
>> Tony
> Yes, it is not directly related but it's just a conversion of following snippet
> to avoid ugly and unnecessary 'goto':
>
> if (A) {
> 	err = ...
> 	goto error_handler;
> }
> if (B) {
> 	err = ...
> 	...
> }
> if (err) {
> 	...
> }
>
> to
>
> if (A) {
> 	err = ...
> } else {
> 	if (B) {
> 		...
> 	}
> }
> if (err) {
> 	...
> }
>
> If you want to leave the code as is and remove this from the patch
> let me know and I will send v2.

The change itself looks ok to me, but for net patches, we should fix the 
issue without introducing other changes. A v2 without this change would 
be great; feel free to submit this change to -next after I've applied 
the v2 for this patch.

Thanks,

Tony

> Thanks,
> Ivan
>
