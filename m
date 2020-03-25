From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 25 Mar 2020 08:36:36 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
Message-ID: <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/25/2020 06:17, Kai-Heng Feng wrote:
> Hi Aaron,
> 
>> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
>>
>> ME takes 2+ seconds to un-configure ULP mode done after resume
>> from s2idle on some ThinkPad laptops.
>> Without enough wait, reset and re-init will fail with error.
> 
> Thanks, this patch solves the issue. We can drop the DMI quirk in favor of this patch.
> 
>>
>> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
>> BugLink: https://bugs.launchpad.net/bugs/1865570
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> index b4135c50e905..147b15a2f8b3 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>> 			ew32(H2ME, mac_reg);
>> 		}
>>
>> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
>> +		/* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>> 		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
>> -			if (i++ == 30) {
>> +			if (i++ == 250) {
>> 				ret_val = -E1000_ERR_PHY;
>> 				goto out;
>> 			}
> 
> The return value was not caught by the caller, so the error ends up unnoticed.
> Maybe let the caller check the return value of e1000_disable_ulp_lpt_lp()?
> 
> Kai-Heng
Hello Kai-Heng and Aaron,
I a bit confused. In our previous conversation you told ME not running. 
let me shimming in. Increasing delay won't be solve the problem and just 
mask it. We need to understand why ME take too much time. What is 
problem with this specific system?
So, basically no ME system should works for you.

Meanwhile I prefer keep DMI quirk.
Thanks,
Sasha
> 
>> -- 
>> 2.17.1
>>
> 

