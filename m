From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 16 Jun 2020 18:31:27 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: continue to init phy even
 when failed to disable ULP
In-Reply-To: <74391e62-7226-b0f8-d129-768b88f13160@molgen.mpg.de>
References: <20200616100512.22512-1-aaron.ma@canonical.com>
 <74391e62-7226-b0f8-d129-768b88f13160@molgen.mpg.de>
Message-ID: <b42b344b-9bdc-edf5-a940-9e4db3a73928@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/16/20 6:20 PM, Paul Menzel wrote:
> Dear Aaron,
> 
> 
> Thank you for your patch.
> 
> (Rant: Some more fallout from the other patch, which nobody reverted.)
> 

Would you like a revert?

Thanks,
Aaron

> Am 16.06.20 um 12:05 schrieb Aaron Ma:
>> After commit "e1000e: disable s0ix entry and exit flows for ME systems",
>> some ThinkPads always failed to disable ulp by ME.
> 
> Please add the (short) commit hash from the master branch.
> 
> s/ulp/ULP/
> 
> Please list one ThinkPad as example.
> 
>> commit "e1000e: Warn if disabling ULP failed" break out of init phy:
> 
> 1.? Please add the closing quote ".
> 2.? Please add the commit hash.
> 
>> error log:
>> [?? 42.364753] e1000e 0000:00:1f.6 enp0s31f6: Failed to disable ULP
>> [?? 42.524626] e1000e 0000:00:1f.6 enp0s31f6: PHY Wakeup cause - Unicast Packet
>> [?? 42.822476] e1000e 0000:00:1f.6 enp0s31f6: Hardware Error
>>
>> When disable s0ix, E1000_FWSM_ULP_CFG_DONE will never be 1.
>> If continue to init phy like before, it can work as before.
>> iperf test result good too.
>>
>> Chnage e_warn to e_dbg, in case it confuses.
> 
> s/Chnage/Change/
> 
> Please leave the level warning, and improve the warning message instead, so a user knows what is going on.
> 
> Could you please add a `Fixes:` tag and the URL to the bug report?
> 
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>> ? drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +--
>> ? 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> index f999cca37a8a..63405819eb83 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> @@ -302,8 +302,7 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
>> ????? hw->dev_spec.ich8lan.ulp_state = e1000_ulp_state_unknown;
>> ????? ret_val = e1000_disable_ulp_lpt_lp(hw, true);
>> ????? if (ret_val) {
>> -??????? e_warn("Failed to disable ULP\n");
>> -??????? goto out;
>> +??????? e_dbg("Failed to disable ULP\n");
>> ????? }
>> ? ????? ret_val = hw->phy.ops.acquire(hw);
>>
> 
> Kind regards,
> 
> Paul
