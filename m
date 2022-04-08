From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 8 Apr 2022 09:01:05 -0700
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix incorrect locking in
 ice_vc_process_vf_msg()
In-Reply-To: <20220408134714.1834349-1-alexandr.lobakin@intel.com>
References: <20220401104052.1711721-1-ivecera@redhat.com>
 <20220408134714.1834349-1-alexandr.lobakin@intel.com>
Message-ID: <97c58b06-11b5-182b-eed2-e5a74824241c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/8/2022 6:47 AM, Alexander Lobakin wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> Date: Fri,  1 Apr 2022 12:40:52 +0200
>
>> Usage of mutex_trylock() in ice_vc_process_vf_msg() is incorrect
>> because message sent from VF is ignored and never processed.
>>
>> Use mutex_lock() instead to fix the issue. It is safe because this
>> mutex is used to prevent races between VF related NDOs and
>> handlers processing request messages from VF and these handlers
>> are running in ice_service_task() context. Additionally move this
>> mutex lock prior ice_vc_is_opcode_allowed() call to avoid potential
>> races during allowlist acccess.
>>
>> Fixes: e6ba5273d4ed ("ice: Fix race conditions between virtchnl handling and VF ndo ops")
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Hey Tony,
>
> I guess you missed this one due to being on a vacation previously.
> It's been previously reviewed IIRC, could you take it into
> net-queue?

I remember applying this but I don't see it on the tree so I must be 
mistaken. :( I'll get it applied, thanks for catching.

-Tony

>> ---
>>   drivers/net/ethernet/intel/ice/ice_virtchnl.c | 21 +++++++------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> index 3f1a63815bac..a465f3743ffc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
>> @@ -3642,14 +3642,6 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
>>   			err = -EINVAL;
>>   	}
>>   
>> -	if (!ice_vc_is_opcode_allowed(vf, v_opcode)) {
>> -		ice_vc_send_msg_to_vf(vf, v_opcode,
>> -				      VIRTCHNL_STATUS_ERR_NOT_SUPPORTED, NULL,
>> -				      0);
>> -		ice_put_vf(vf);
>> -		return;
>> -	}
>> -
>>   error_handler:
>>   	if (err) {
>>   		ice_vc_send_msg_to_vf(vf, v_opcode, VIRTCHNL_STATUS_ERR_PARAM,
>> @@ -3660,12 +3652,13 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
>>   		return;
>>   	}
>>   
>> -	/* VF is being configured in another context that triggers a VFR, so no
>> -	 * need to process this message
>> -	 */
>> -	if (!mutex_trylock(&vf->cfg_lock)) {
>> -		dev_info(dev, "VF %u is being configured in another context that will trigger a VFR, so there is no need to handle this message\n",
>> -			 vf->vf_id);
>> +	mutex_lock(&vf->cfg_lock);
>> +
>> +	if (!ice_vc_is_opcode_allowed(vf, v_opcode)) {
>> +		ice_vc_send_msg_to_vf(vf, v_opcode,
>> +				      VIRTCHNL_STATUS_ERR_NOT_SUPPORTED, NULL,
>> +				      0);
>> +		mutex_unlock(&vf->cfg_lock);
>>   		ice_put_vf(vf);
>>   		return;
>>   	}
>> -- 
>> 2.35.1
> Thanks,
> Al
