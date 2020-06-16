From: Aaron Ma <aaron.ma@canonical.com>
Date: Tue, 16 Jun 2020 19:26:23 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: continue to init phy even
 when failed to disable ULP
In-Reply-To: <4CC928F1-02CC-4675-908E-42B26C151FA1@canonical.com>
References: <20200616100512.22512-1-aaron.ma@canonical.com>
 <4CC928F1-02CC-4675-908E-42B26C151FA1@canonical.com>
Message-ID: <dc46e68f-8af7-327e-3763-ebcb24df3a83@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/16/20 7:23 PM, Kai-Heng Feng wrote:
> 
> 
>> On Jun 16, 2020, at 18:05, Aaron Ma <aaron.ma@canonical.com> wrote:
>>
>> After commit "e1000e: disable s0ix entry and exit flows for ME systems",
>> some ThinkPads always failed to disable ulp by ME.
>> commit "e1000e: Warn if disabling ULP failed" break out of init phy:
>>
>> error log:
>> [   42.364753] e1000e 0000:00:1f.6 enp0s31f6: Failed to disable ULP
>> [   42.524626] e1000e 0000:00:1f.6 enp0s31f6: PHY Wakeup cause - Unicast Packet
>> [   42.822476] e1000e 0000:00:1f.6 enp0s31f6: Hardware Error
>>
>> When disable s0ix, E1000_FWSM_ULP_CFG_DONE will never be 1.
>> If continue to init phy like before, it can work as before.
>> iperf test result good too.
>>
>> Chnage e_warn to e_dbg, in case it confuses.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> index f999cca37a8a..63405819eb83 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> @@ -302,8 +302,7 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
>> 	hw->dev_spec.ich8lan.ulp_state = e1000_ulp_state_unknown;
>> 	ret_val = e1000_disable_ulp_lpt_lp(hw, true);
> 
> If si0x entry isn't enabled, maybe skip calling e1000_disable_ulp_lpt_lp() altogether?
> We can use e1000e_check_me() to check that.
> 

No, s0ix is different feature with ULP mode.

Aaron

>> 	if (ret_val) {
>> -		e_warn("Failed to disable ULP\n");
>> -		goto out;
>> +		e_dbg("Failed to disable ULP\n");
>> 	}
> 
> The change of "e1000e: Warn if disabling ULP failed" is intentional to catch bugs like this.
> 
> Kai-Heng
> 
>>
>> 	ret_val = hw->phy.ops.acquire(hw);
>> -- 
>> 2.26.2
>>
> 
