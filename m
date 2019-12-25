From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 25 Dec 2019 16:17:52 +0200
Subject: [Intel-wired-lan] [PATCH v2] igc: Add PHY power management
 control
In-Reply-To: <f46101da-8d48-84a3-3229-653a36e6e1ae@intel.com>
References: <20191212173650.14210-1-sasha.neftin@intel.com>
 <87imml5t8z.fsf@linux.intel.com>
 <f46101da-8d48-84a3-3229-653a36e6e1ae@intel.com>
Message-ID: <2a042920-d948-9b08-826d-492e4f81ec83@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/12/2019 20:00, Neftin, Sasha wrote:
> On 12/12/2019 19:49, Vinicius Costa Gomes wrote:
>>
>> Sasha Neftin <sasha.neftin@intel.com> writes:
>>
>>> PHY power management control should provide a reliable and accurate
>>> indication of PHY reset completion and decrease the delay time
>>> after a PHY reset
>>>
>>> v1 -> v2: add hw_dbg print for a timeout
>>>
>>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>>> ---
>>> ? drivers/net/ethernet/intel/igc/igc_defines.h |? 1 +
>>> ? drivers/net/ethernet/intel/igc/igc_phy.c???? | 12 ++++++++++++
>>> ? drivers/net/ethernet/intel/igc/igc_regs.h??? |? 1 +
>>> ? 3 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h 
>>> b/drivers/net/ethernet/intel/igc/igc_defines.h
>>> index 2121fc34e300..71a4b0281c03 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>>> @@ -460,6 +460,7 @@
>>> ? /* PHY Status Register */
>>> ? #define MII_SR_LINK_STATUS??? 0x0004 /* Link Status 1 = link */
>>> ? #define MII_SR_AUTONEG_COMPLETE??? 0x0020 /* Auto Neg Complete */
>>> +#define IGC_PHY_RST_COMP??? 0x0100 /* Internal PHY reset completion */
>>> ? /* PHY 1000 MII Register/Bit Definitions */
>>> ? /* PHY Registers defined by IEEE */
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c 
>>> b/drivers/net/ethernet/intel/igc/igc_phy.c
>>> index f4b05af0dd2f..a5483368690a 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
>>> @@ -173,6 +173,7 @@ s32 igc_check_downshift(struct igc_hw *hw)
>>> ? s32 igc_phy_hw_reset(struct igc_hw *hw)
>>> ? {
>>> ????? struct igc_phy_info *phy = &hw->phy;
>>> +??? u32 phpm = 0, timeout = 10000;
>>> ????? s32? ret_val;
>>> ????? u32 ctrl;
>>> @@ -186,6 +187,8 @@ s32 igc_phy_hw_reset(struct igc_hw *hw)
>>> ????? if (ret_val)
>>> ????????? goto out;
>>> +??? phpm = rd32(IGC_I225_PHPM);
>>> +
>>> ????? ctrl = rd32(IGC_CTRL);
>>> ????? wr32(IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
>>> ????? wrfl();
>>> @@ -195,6 +198,15 @@ s32 igc_phy_hw_reset(struct igc_hw *hw)
>>> ????? wr32(IGC_CTRL, ctrl);
>>> ????? wrfl();
>>> +??? do {
>>> +??????? phpm = rd32(IGC_I225_PHPM);
>>> +??????? timeout--;
>>> +??????? udelay(1);
>>> +??? } while (!(phpm & IGC_PHY_RST_COMP) && timeout);
>>> +
>>> +??? if (!timeout)
>>> +??????? hw_dbg("Timeoui is expired after a phy reset\n");
>>
>> nitpick: Timeoui -> Timeout
>>
> thanks - I will send v3 and fix the typo
Unfortunately, RST_COMPL signal in a PHY power management registers 
still not work as properly. Please, disregard this patch. The RST_COMPL 
indication should be fixed. I will release another patch so.
> ________________________________________
_______
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

