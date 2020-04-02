From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 2 Apr 2020 09:19:25 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: remove IGC_REMOVED function
In-Reply-To: <08d29d85-9f5b-f97b-d6dc-9346b5844beb@intel.com>
References: <20200401091644.5863-1-vitaly.lifshits@intel.com>
 <08d29d85-9f5b-f97b-d6dc-9346b5844beb@intel.com>
Message-ID: <1c5fb458-dd3e-e488-b63d-71268a878e35@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/2/2020 09:16, Neftin, Sasha wrote:
> On 4/1/2020 12:16, Vitaly Lifshits wrote:
>> igc driver has leftovers from the previous device that supported
>> virtualization. This can be found in the function IGC_REMOVED which
>> became obsolete, and can be removed.
>>
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/igc_mac.h? | 4 ----
>> ? drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
>> ? drivers/net/ethernet/intel/igc/igc_regs.h | 3 +--
>> ? 3 files changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.h 
>> b/drivers/net/ethernet/intel/igc/igc_mac.h
>> index 832cccec87cd..b5963f86defb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_mac.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.h
>> @@ -8,10 +8,6 @@
>> ? #include "igc_phy.h"
>> ? #include "igc_defines.h"
>> -#ifndef IGC_REMOVED
>> -#define IGC_REMOVED(a) (0)
>> -#endif /* IGC_REMOVED */
>> -
>> ? /* forward declaration */
>> ? s32 igc_disable_pcie_master(struct igc_hw *hw);
>> ? s32 igc_check_for_copper_link(struct igc_hw *hw);
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index c3555148ca0e..cb0d523ffc19 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -4662,9 +4662,6 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
>> ????? u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
>> ????? u32 value = 0;
>> -??? if (IGC_REMOVED(hw_addr))
>> -??????? return ~value;
>> -
>> ????? value = readl(&hw_addr[reg]);
>> ????? /* reads should not return all F's */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h 
>> b/drivers/net/ethernet/intel/igc/igc_regs.h
>> index 82158176634c..21b6fc42edbb 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_regs.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_regs.h
>> @@ -277,8 +277,7 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg);
>> ? #define wr32(reg, val) \
>> ? do { \
>> ????? u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
>> -??? if (!IGC_REMOVED(hw_addr)) \
>> -??????? writel((val), &hw_addr[(reg)]); \
>> +??? writel((val), &hw_addr[(reg)]); \
>> ? } while (0)
>> ? #define rd32(reg) (igc_rd32(hw, reg))
>>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

