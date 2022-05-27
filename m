From: Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 27 May 2022 18:17:15 +0200
Subject: [Intel-wired-lan] [PATCH net] ice: disable stripping in default
 VSI ctx
In-Reply-To: <c808f098-2d17-db32-6106-8c75d5116508@molgen.mpg.de>
References: <20220527115131.7413-1-marcin.szycik@linux.intel.com>
 <6b4a6f01-dfde-e047-066f-15098633113c@molgen.mpg.de>
 <3fab057b-ef21-3bda-6535-a19e5c4c96ec@linux.intel.com>
 <c808f098-2d17-db32-6106-8c75d5116508@molgen.mpg.de>
Message-ID: <4f8d2b55-ed19-206e-3171-efff363dc8d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 27-May-22 15:11, Paul Menzel wrote:
> Dear Marcin.
> 
> 
> Am 27.05.22 um 15:01 schrieb Marcin Szycik:
> 
>> On 27-May-22 14:15, Paul Menzel wrote:
> 
>>> Am 27.05.22 um 13:51 schrieb Marcin Szycik:
>>>> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>>
>>>> In case when driver is in eswitch mode, having VLAN stripping enabled
>>>> causes failure in communication. All VLAN configuration commands are
>>>> blocked, because of that VF driver can't disable VLAN stripping at
>>>
>>> s/blocked, because/blocked. Because/
>>
>> Sorry, but I don't understand what to change here. Could you explain more clearly?
> 
> I am sorry for being unclear. I think it should be two sentences.

Ah, now I see it's a sed-style string replace. I will remember this for future discussions :)

>>>> initialization. It leads to the situation when VLAN stripping on VF VSI
>>>> is on, but in kernel it is off.
>>>>
>>>> To prevent this, set VLAN stripping to disabled in VSI initialization.
>>>
>>> Maybe: ?, disable VLAN stripping in VSI initialization.
>>
>> Sounds good.
>>
>>>> It doesn't break other usecases, because it is set according to kernel
>>>> settings.
>>>
>>> Please document your test setup.
>>
>> Will reproduction steps be enough?
> 
> Yes, that?d be great.

I'll send v2 probably on Monday. I'm sorry for delay, but I have a bit of a problem reproducing this issue, and I don't want to include a repro that doesn't actually work (Micha? originally worked on the fix, but he will be unavailable for some time).

Regards,
Marcin

>>>> Fixes: f09901aa554a ("ice: remove VLAN representor specific ops")
>>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>>>> ---
>>>> ?? drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>>>> ?? 1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> index 70961c0343e7..b28fb8eacffb 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>>>> @@ -887,6 +887,9 @@ static void ice_set_dflt_vsi_ctx(struct ice_hw *hw, struct ice_vsi_ctx *ctxt)
>>>> ?????????????? (ICE_AQ_VSI_OUTER_TAG_VLAN_8100 <<
>>>> ??????????????? ICE_AQ_VSI_OUTER_TAG_TYPE_S) &
>>>> ?????????????? ICE_AQ_VSI_OUTER_TAG_TYPE_M;
>>>> +??????? ctxt->info.outer_vlan_flags |=
>>>> +??????????? FIELD_PREP(ICE_AQ_VSI_OUTER_VLAN_EMODE_M,
>>>> +?????????????????? ICE_AQ_VSI_OUTER_VLAN_EMODE_NOTHING);
>>>> ?????? }
>>>> ?????? /* Have 1:1 UP mapping for both ingress/egress tables */
>>>> ?????? table |= ICE_UP_TABLE_TRANSLATE(0, 0)
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
