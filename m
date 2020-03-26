From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 26 Mar 2020 16:34:18 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <3895cb4d-cc9d-238a-0776-a1fd3a490664@molgen.mpg.de>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
 <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
 <899895bc-fb88-a97d-a629-b514ceda296d@canonical.com>
 <750ad0ad-816a-5896-de2f-7e034d2a2508@intel.com>
 <f9dc1980-fa8b-7df9-6460-b0944c7ebc43@molgen.mpg.de>
 <60A8493D-811B-4AD5-A8D3-82054B562A8C@canonical.com>
 <3895cb4d-cc9d-238a-0776-a1fd3a490664@molgen.mpg.de>
Message-ID: <065e5e61-0342-3882-d6af-21618b44033c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/26/2020 13:41, Paul Menzel wrote:
> Dear Kai-Heng,
> 
> 
> Am 26.03.20 um 12:29 schrieb Kai-Heng Feng:
> 
>>> On Mar 25, 2020, at 23:49, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
>>> Am 25.03.20 um 14:58 schrieb Neftin, Sasha:
>>>> On 3/25/2020 08:43, Aaron Ma wrote:
>>>
>>>>> On 3/25/20 2:36 PM, Neftin, Sasha wrote:
>>>>>> On 3/25/2020 06:17, Kai-Heng Feng wrote:
>>>
>>>>>>>> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
>>>>>>>>
>>>>>>>> ME takes 2+ seconds to un-configure ULP mode done after resume
>>>>>>>> from s2idle on some ThinkPad laptops.
>>>>>>>> Without enough wait, reset and re-init will fail with error.
>>>>>>>
>>>>>>> Thanks, this patch solves the issue. We can drop the DMI quirk in
>>>>>>> favor of this patch.
>>>>>>>
>>>>>>>> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
>>>>>>>> BugLink: https://bugs.launchpad.net/bugs/1865570
>>>>>>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>>>>>>> ---
>>>>>>>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>>>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> index b4135c50e905..147b15a2f8b3 100644
>>>>>>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>>>> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct
>>>>>>>> e1000_hw *hw, bool force)
>>>>>>>> ????????????? ew32(H2ME, mac_reg);
>>>>>>>> ????????? }
>>>>>>>>
>>>>>>>> -??????? /* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
>>>>>>>> +??????? /* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>>>>>>>> ????????? while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
>>>>>>>> -??????????? if (i++ == 30) {
>>>>>>>> +??????????? if (i++ == 250) {
>>>>>>>> ????????????????? ret_val = -E1000_ERR_PHY;
>>>>>>>> ????????????????? goto out;
>>>>>>>> ????????????? }
>>>>>>>
>>>>>>> The return value was not caught by the caller, so the error ends up
>>>>>>> unnoticed.
>>>>>>> Maybe let the caller check the return value of
>>>>>>> e1000_disable_ulp_lpt_lp()?
>>>
>>>>>> I a bit confused. In our previous conversation you told ME not 
>>>>>> running.
>>>>>> let me shimming in. Increasing delay won't be solve the problem 
>>>>>> and just
>>>>>> mask it. We need to understand why ME take too much time. What is
>>>>>> problem with this specific system?
>>>>>> So, basically no ME system should works for you.
>>>>>
>>>>> Some laptops ME work that's why only reproduce issue on some laptops.
>>>>> In this issue i219 is controlled by ME.
>>>>
>>>> Who can explain - why ME required too much time on this system?
>>>> Probably need work with ME/BIOS vendor and understand it.
>>>> Delay will just mask the real problem - we need to find root cause.
>>>>> Quirk is only for 1 model type. But issue is reproduced by more 
>>>>> models.
>>>>> So it won't work.
>>>
>>> (Where is Aaron?s reply? It wasn?t delivered to me yet.)
>>>
>>> As this is clearly a regression, please revert the commit for now,
>>> and then find a way to correctly implement S0ix support. Linux?
>>> regression policy demands that as no fix has been found since
>>> v5.5-rc1. Changing Intel ME settings, even if it would work around
>>> the issue, is not an acceptable solution. Delaying the resume time
>>> is also not a solution.
>>
>> The s0ix patch can reduce power consumption, finally makes S2idle an
>> acceptable sleep method. So I'd say it's a fix, albeit a regression
>> was introduced.
>>
>>> Regarding Intel Management Engine, only Intel knows what it does
>>> and what the error is, as the ME firmware is proprietary and
>>> closed.
>>>
>>> Lastly, there is no way to fully disable the Intel Management
>>> Engine. The HAP stuff claims to stop the Intel ME execution, but
>>> nobody knows, if it?s successful.
>>>
>>> Aaron, Kai-Hang, can you send the revert?
>>
>> I consider that as an important fix for s2idle, I don't think
>> reverting is appropriate.
> 
> If there is a fix with no other regression, I agree. But there has not 
> been one, so please revert. It doesn?t matter if the commit introducing 
> the regression fixes something else. It gets too complicated to decide, 
> which regression is worth it or not. The Linux kernel guarantees its 
> users, they can update any time without breaking user space (in this 
> case suspend/resume).? Please read Linus? several messages about that. 
> His message [1] exactly addresses your arguments.
> 
Revert is no option. S0ix supported on none ME system, approved by Intel 
design team and power management domain owner.
Vendor should provide none ME BIOS I thought. Our PAE will work toward 
meet this.
>> Yeah, HELL NO!
>>
>> Guess what? You're wrong. YOU ARE MISSING THE #1 KERNEL RULE.
>>
>> We do not regress, and we do not regress exactly because your are 100% 
>> wrong.
>>
>> And the reason you state for your opinion is in fact exactly *WHY* you
>> are wrong.
>>
>> Your "good reasons" are pure and utter garbage.
>>
>> The whole point of "we do not regress" is so that people can upgrade
>> the kernel and never have to worry about it.
>>
>>> Kernel had a bug which has been fixed
>>
>> That is *ENTIRELY* immaterial.
>>
>> Guys, whether something was buggy or not DOES NOT MATTER.
> 
> So, please (also Intel developers), please adhere to this rule, and 
> revert the commit.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://lkml.org/lkml/2018/8/3/621
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

