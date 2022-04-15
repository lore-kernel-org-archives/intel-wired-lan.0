From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 Apr 2022 13:55:06 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: Protect vf_state check by
 cfg_lock in ice_vc_process_vf_msg()
In-Reply-To: <YlldsfrRJURXpp5d@boxer>
References: <20220413072259.3189386-1-ivecera@redhat.com>
 <YlldFriBVkKEgbBs@boxer> <YlldsfrRJURXpp5d@boxer>
Message-ID: <248da3d7-cb00-14b6-12f0-6bb9fda6d532@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/15/2022 4:57 AM, Maciej Fijalkowski wrote:

<snip>

>>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>> index 5612c032f15a..553287a75b50 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>>> @@ -3625,44 +3625,39 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
>>>   		return;
>>>   	}
>>>   
>>> +	mutex_lock(&vf->cfg_lock);
>>> +
>>>   	/* Check if VF is disabled. */
>>>   	if (test_bit(ICE_VF_STATE_DIS, vf->vf_states)) {
>>>   		err = -EPERM;
>>> -		goto error_handler;
>>> -	}
>>> -
>>> -	ops = vf->virtchnl_ops;
>>> -
>>> -	/* Perform basic checks on the msg */
>>> -	err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg, msglen);
>>> -	if (err) {
>>> -		if (err == VIRTCHNL_STATUS_ERR_PARAM)
>>> -			err = -EPERM;
>>> -		else
>>> -			err = -EINVAL;
>>> +	} else {
>>> +		/* Perform basic checks on the msg */
>>> +		err = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg,
>>> +						  msglen);
>>> +		if (err) {
>>> +			if (err == VIRTCHNL_STATUS_ERR_PARAM)
>>> +				err = -EPERM;
>>> +			else
>>> +				err = -EINVAL;
>>> +		}
>> The chunk above feels a bit like unnecessary churn, no?
>> Couldn't this patch be simply focused only on extending critical section?

Agree, this doesn't seem related to the fix.

Thanks,

Tony


>>>   	}
>>> -
>>> -error_handler:
>>>   	if (err) {
>>>   		ice_vc_send_msg_to_vf(vf, v_opcode, VIRTCHNL_STATUS_ERR_PARAM,
>>>   				      NULL, 0);
>>>   		dev_err(dev, "Invalid message from VF %d, opcode %d, len %d, error %d\n",
>>>   			vf_id, v_opcode, msglen, err);
>>> -		ice_put_vf(vf);
>>> -		return;
>>> +		goto finish;
>>>   	}
>>>   
>>> -	mutex_lock(&vf->cfg_lock);
>>> -
>>>   	if (!ice_vc_is_opcode_allowed(vf, v_opcode)) {
>>>   		ice_vc_send_msg_to_vf(vf, v_opcode,
>>>   				      VIRTCHNL_STATUS_ERR_NOT_SUPPORTED, NULL,
>>>   				      0);
>>> -		mutex_unlock(&vf->cfg_lock);
>>> -		ice_put_vf(vf);
>>> -		return;
>>> +		goto finish;
>>>   	}
>>>   
>>> +	ops = vf->virtchnl_ops;
>>> +
>>>   	switch (v_opcode) {
>>>   	case VIRTCHNL_OP_VERSION:
>>>   		err = ops->get_ver_msg(vf, msg);
>>> @@ -3773,6 +3768,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
>>>   			 vf_id, v_opcode, err);
>>>   	}
>>>   
>>> +finish:
>>>   	mutex_unlock(&vf->cfg_lock);
>>>   	ice_put_vf(vf);
>>>   }
>>> -- 
>>> 2.35.1
>>>
>>> _______________________________________________
>>> Intel-wired-lan mailing list
>>> Intel-wired-lan at osuosl.org
>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
