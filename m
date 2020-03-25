From: Aaron Ma <aaron.ma@canonical.com>
Date: Wed, 25 Mar 2020 22:07:36 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <750ad0ad-816a-5896-de2f-7e034d2a2508@intel.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
 <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
 <899895bc-fb88-a97d-a629-b514ceda296d@canonical.com>
 <750ad0ad-816a-5896-de2f-7e034d2a2508@intel.com>
Message-ID: <2b817a13-9fd8-4181-fed5-e55f7b4365ca@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/25/20 9:58 PM, Neftin, Sasha wrote:
> On 3/25/2020 08:43, Aaron Ma wrote:
>>
>>
>> On 3/25/20 2:36 PM, Neftin, Sasha wrote:
>>> On 3/25/2020 06:17, Kai-Heng Feng wrote:
>>>> Hi Aaron,
>>>>
>>>>> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
>>>>>
>>>>> ME takes 2+ seconds to un-configure ULP mode done after resume
>>>>> from s2idle on some ThinkPad laptops.
>>>>> Without enough wait, reset and re-init will fail with error.
>>>>
>>>> Thanks, this patch solves the issue. We can drop the DMI quirk in
>>>> favor of this patch.
>>>>
>>>>>
>>>>> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
>>>>> BugLink: https://bugs.launchpad.net/bugs/1865570
>>>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>>>> ---
>>>>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>> index b4135c50e905..147b15a2f8b3 100644
>>>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct
>>>>> e1000_hw *hw, bool force)
>>>>> ???????????? ew32(H2ME, mac_reg);
>>>>> ???????? }
>>>>>
>>>>> -??????? /* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
>>>>> +??????? /* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>>>>> ???????? while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
>>>>> -??????????? if (i++ == 30) {
>>>>> +??????????? if (i++ == 250) {
>>>>> ???????????????? ret_val = -E1000_ERR_PHY;
>>>>> ???????????????? goto out;
>>>>> ???????????? }
>>>>
>>>> The return value was not caught by the caller, so the error ends up
>>>> unnoticed.
>>>> Maybe let the caller check the return value of
>>>> e1000_disable_ulp_lpt_lp()?
>>>>
>>>> Kai-Heng
>>> Hello Kai-Heng and Aaron,
>>> I a bit confused. In our previous conversation you told ME not running.
>>> let me shimming in. Increasing delay won't be solve the problem and just
>>> mask it. We need to understand why ME take too much time. What is
>>> problem with this specific system?
>>> So, basically no ME system should works for you.
>>
>> Some laptops ME work that's why only reproduce issue on some laptops.
>> In this issue i219 is controlled by ME.
>>
> Who can explain - why ME required too much time on this system?
> Probably need work with ME/BIOS vendor and understand it.
> Delay will just mask the real problem - we need to find root cause.

IMHO, it should be ME check the link status when link disconnected,
that's why Poll up to 5 seconds for Cable Disconnected indication when
enable ULP.

The reason is same for both disable/enable ULP mode.

I agree to ask ME to check it too.

Regards,
Aaron

>> Quirk is only for 1 model type. But issue is reproduced by more models.
>> So it won't work.
>>
>> Regard,
>> Aaron
>>
>>>
>>> Meanwhile I prefer keep DMI quirk.
>>> Thanks,
>>> Sasha
>>>>
>>>>> --?
>>>>> 2.17.1
>>>>>
>>>>
>>>
> 
