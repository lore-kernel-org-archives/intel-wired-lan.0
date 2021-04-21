From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 21 Apr 2021 09:54:07 +0200
Subject: [Intel-wired-lan] [PATCH V2 net] ice: Re-organizes reqstd/avail
 {R, T}XQ check/code for efficiency+readability
In-Reply-To: <418702bdb5244eb4811a2a1a536c55c0@huawei.com>
References: <20210413224446.16612-1-salil.mehta@huawei.com>
 <7974e665-73bd-401c-f023-9da568e1dffc@molgen.mpg.de>
 <418702bdb5244eb4811a2a1a536c55c0@huawei.com>
Message-ID: <9335975a-ef19-863c-005a-d460eac83e03@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[CC: Remove Jeff, as email is rejected]

Dear Salil,


Am 21.04.21 um 09:41 schrieb Salil Mehta:
>> From: Paul Menzel [mailto:pmenzel at molgen.mpg.de]
>> Sent: Wednesday, April 21, 2021 6:36 AM

[?]

>> In the git commit message summary, could you please use imperative mood [1]?
> 
> No issues. There is always a scope of improvement.
> 
>>> Re-organize reqstd/avail {R, T}XQ check/code for efficiency+readability
>>
>> It?s a bit long though. Maybe:
>>
>> Avoid unnecessary assignment with user specified {R,T}XQs
> 
> Umm..above conveys the wrong meaning as this is not what patch is doing.
> 
> If you see the code, in the presence of the user specified {R,T}XQs it
> avoids fetching available {R,T}XQ count.
> 
> What about below?
> 
> "Avoid unnecessary avail_{r,t}xq assignments if user has specified Qs"

Sounds good, still a little long. Maybe:

> Avoid unnecessary avail_{r,t}xq assignments with user specified Qs

>> Am 14.04.21 um 00:44 schrieb Salil Mehta:
>>> If user has explicitly requested the number of {R,T}XQs, then it is
>>> unnecessary to get the count of already available {R,T}XQs from the
>>> PF avail_{r,t}xqs bitmap. This value will get overridden by user specified
>>> value in any case.
>>>
>>> This patch does minor re-organization of the code for improving the flow
>>> and readabiltiy. This scope of improvement was found during the review of
>>
>> readabil*it*y
> 
> Thanks. Missed that earlier. My shaky fingers :(
> 
>>> the ICE driver code.
>>>
>>> FYI, I could not test this change due to unavailability of the hardware.
>>> It would be helpful if somebody can test this patch and provide Tested-by
>>> Tag. Many thanks!
>>
>> This should go outside the commit message (below the --- for example).
> 
> Agreed.
> 
>>> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
>>
>> Did you check the behavior before is actually a bug? Or is it just for
>> the detection heuristic for commits to be applied to the stable series?
> 
> Right, later was the idea.
>   
>>> Cc: intel-wired-lan at lists.osuosl.org
>>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> --
>>> Change V1->V2
>>>    (*) Fixed the comments from Anthony Nguyen(Intel)
>>>        Link: https://lkml.org/lkml/2021/4/12/1997
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> index d13c7fc8fb0a..d77133d6baa7 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>>> @@ -161,12 +161,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
>>>
>>>    	switch (vsi->type) {
>>>    	case ICE_VSI_PF:
>>> -		vsi->alloc_txq = min3(pf->num_lan_msix,
>>> -				      ice_get_avail_txq_count(pf),
>>> -				      (u16)num_online_cpus());
>>>    		if (vsi->req_txq) {
>>>    			vsi->alloc_txq = vsi->req_txq;
>>>    			vsi->num_txq = vsi->req_txq;
>>> +		} else {
>>> +			vsi->alloc_txq = min3(pf->num_lan_msix,
>>> +					      ice_get_avail_txq_count(pf),
>>> +					      (u16)num_online_cpus());
>>>    		}
>>
>> I am curious, did you check the compiler actually creates different
>> code, or did it notice the inefficiency by itself and optimized it already?
> 
> I have not looked into that detail but irrespective of what compiler generates
> I would like to keep the code in a shape which is more efficient and more readable.
> 
> I do understand in certain cases we have to do tradeoff between efficiency
> and readability but I do not see that here.

I agree, as *efficiency* is mentioned several times, I assume it was 
tested. Thank you for the clarification.

>>>    		pf->num_lan_tx = vsi->alloc_txq;
>>> @@ -175,12 +176,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
>>>    		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
>>>    			vsi->alloc_rxq = 1;
>>>    		} else {
>>> -			vsi->alloc_rxq = min3(pf->num_lan_msix,
>>> -					      ice_get_avail_rxq_count(pf),
>>> -					      (u16)num_online_cpus());
>>>    			if (vsi->req_rxq) {
>>>    				vsi->alloc_rxq = vsi->req_rxq;
>>>    				vsi->num_rxq = vsi->req_rxq;
>>> +			} else {
>>> +				vsi->alloc_rxq = min3(pf->num_lan_msix,
>>> +						      ice_get_avail_rxq_count(pf),
>>> +						      (u16)num_online_cpus());
>>>    			}
>>>    		}
>>>


Kind regards,

Paul
