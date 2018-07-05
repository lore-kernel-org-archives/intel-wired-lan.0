From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 5 Jul 2018 14:24:33 +0300
Subject: [Intel-wired-lan] [PATCH v3 09/11] igc: Add code for PHY support
In-Reply-To: <cac0f505-b4be-89f4-f32b-7c12175769d3@oracle.com>
References: <20180624084521.10330-1-sasha.neftin@intel.com>
 <cac0f505-b4be-89f4-f32b-7c12175769d3@oracle.com>
Message-ID: <528cfc58-1ffd-afb4-b529-26782009f228@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2018 17:37, Shannon Nelson wrote:
> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>> Sasha Neftin (v2):
>> minor cosmetic changes
>>
>> Alexander Duyck (v3.5):
>> Made non-gpy versions of phy functions static
>> Moved xmdio functions to avoid need for prototype function
>> Moved reset, read_reg, and write_reg ops into e1000_phy_ops_base
>> Dropped code implying more than one function
>> Fixed merge conflict with v3.5 of NVM code.
>>
>> Sasha Neftin (v3):
>> Introduced temporary workaround for PHY power down.
>>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/Makefile??????? |?? 3 +-
>> ? drivers/net/ethernet/intel/igc/e1000_base.c??? | 126 ++++++-
>> ? drivers/net/ethernet/intel/igc/e1000_base.h??? |?? 1 +
>> ? drivers/net/ethernet/intel/igc/e1000_defines.h |? 81 ++++-
>> ? drivers/net/ethernet/intel/igc/e1000_hw.h????? |? 54 +++
>> ? drivers/net/ethernet/intel/igc/e1000_mac.c???? |? 48 ++-
>> ? drivers/net/ethernet/intel/igc/e1000_mac.h???? |? 11 +
>> ? drivers/net/ethernet/intel/igc/e1000_phy.c???? | 457 
>> +++++++++++++++++++++++++
>> ? drivers/net/ethernet/intel/igc/e1000_phy.h???? |? 21 ++
>> ? drivers/net/ethernet/intel/igc/e1000_regs.h??? |?? 3 +
>> ? drivers/net/ethernet/intel/igc/igc.h?????????? |? 16 +
>> ? drivers/net/ethernet/intel/igc/igc_main.c????? |? 11 +
>> ? 12 files changed, 827 insertions(+), 5 deletions(-)
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_phy.c
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_phy.h
>>
>> diff --git a/drivers/net/ethernet/intel/igc/Makefile 
>> b/drivers/net/ethernet/intel/igc/Makefile
>> index 5147bca1a900..cd5cb1630b1d 100644
>> --- a/drivers/net/ethernet/intel/igc/Makefile
>> +++ b/drivers/net/ethernet/intel/igc/Makefile
>> @@ -7,4 +7,5 @@
>> ? obj-$(CONFIG_IGC) += igc.o
>> -igc-objs := igc_main.o e1000_mac.o e1000_i225.o e1000_base.o e1000_nvm.o
>> +igc-objs := igc_main.o e1000_mac.o e1000_i225.o e1000_base.o 
>> e1000_nvm.o \
>> +e1000_phy.o
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_base.c 
>> b/drivers/net/ethernet/intel/igc/e1000_base.c
>> index 6db31349daa4..8b35e1d6c32e 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_base.c
>> +++ b/drivers/net/ethernet/intel/igc/e1000_base.c
>> @@ -12,12 +12,31 @@
>> ? /* forward declaration */
>> ? static s32 igc_get_invariants_base(struct e1000_hw *);
>> ? static s32 igc_check_for_link_base(struct e1000_hw *);
>> +static s32 igc_acquire_phy_base(struct e1000_hw *);
>> +static void igc_release_phy_base(struct e1000_hw *);
>> +static s32 igc_get_phy_id_base(struct e1000_hw *);
>> ? static s32 igc_init_hw_base(struct e1000_hw *);
>> ? static s32 igc_reset_hw_base(struct e1000_hw *);
>> ? static s32 igc_set_pcie_completion_timeout(struct e1000_hw *hw);
>> ? static s32 igc_read_mac_addr_base(struct e1000_hw *hw);
>> ? /**
>> + *? igc_get_phy_id_base - Retrieve PHY addr and id
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Retrieves the PHY address and ID for both PHY's which do and do 
>> not use
>> + *? sgmi interface.
>> + **/
>> +static s32 igc_get_phy_id_base(struct e1000_hw *hw)
>> +{
>> +??? s32? ret_val = 0;
>> +
>> +??? ret_val = igc_get_phy_id(hw);
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> ?? *? igc_init_nvm_params_base - Init NVM func ptrs.
>> ?? *? @hw: pointer to the HW structure
>> ?? **/
>> @@ -81,6 +100,59 @@ static s32 igc_init_mac_params_base(struct 
>> e1000_hw *hw)
>> ????? return 0;
>> ? }
>> +/**
>> + *? igc_init_phy_params_base - Init PHY func ptrs.
>> + *? @hw: pointer to the HW structure
>> + **/
>> +static s32 igc_init_phy_params_base(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? s32 ret_val = 0;
>> +??? u32 ctrl_ext;
>> +
>> +??? if (hw->phy.media_type != e1000_media_type_copper) {
>> +??????? phy->type = e1000_phy_none;
>> +??????? goto out;
>> +??? }
>> +
>> +??? phy->autoneg_mask?????? = AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
>> +??? phy->reset_delay_us???? = 100;
>> +
>> +??? ctrl_ext = rd32(E1000_CTRL_EXT);
>> +
>> +??? /* set lan id */
>> +??? hw->bus.func = (rd32(E1000_STATUS) & E1000_STATUS_FUNC_MASK) >>
>> +??????????? E1000_STATUS_FUNC_SHIFT;
>> +
>> +??? /* Make sure the PHY is in a good state. Several people have 
>> reported
>> +???? * firmware leaving the PHY's page select register set to something
>> +???? * other than the default of zero, which causes the PHY ID read to
>> +???? * access something other than the intended register.
>> +???? */
>> +??? ret_val = hw->phy.ops.reset(hw);
>> +??? if (ret_val) {
>> +??????? hw_dbg("Error resetting the PHY.\n");
>> +??????? goto out;
>> +??? }
>> +
>> +??? ret_val = igc_get_phy_id_base(hw);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? /* Verify phy id and set remaining function pointers */
>> +??? switch (phy->id) {
>> +??? case I225_I_PHY_ID:
>> +??????? phy->type??? = e1000_phy_i225;
>> +??????? break;
>> +??? default:
>> +??????? ret_val = -E1000_ERR_PHY;
>> +??????? goto out;
>> +??? }
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> ? static s32 igc_get_invariants_base(struct e1000_hw *hw)
>> ? {
>> ????? s32 ret_val = 0;
>> @@ -105,6 +177,8 @@ static s32 igc_get_invariants_base(struct e1000_hw 
>> *hw)
>> ????????? break;
>> ????? }
>> +??? /* setup PHY parameters */
>> +??? ret_val = igc_init_phy_params_base(hw);
>> ????? if (ret_val)
>> ????????? goto out;
>> @@ -113,6 +187,34 @@ static s32 igc_get_invariants_base(struct 
>> e1000_hw *hw)
>> ? }
>> ? /**
>> + *? igc_acquire_phy_base - Acquire rights to access PHY
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Acquire access rights to the correct PHY.? This is a
>> + *? function pointer entry point called by the api module.
>> + **/
>> +static s32 igc_acquire_phy_base(struct e1000_hw *hw)
>> +{
>> +??? u16 mask = E1000_SWFW_PHY0_SM;
>> +
>> +??? return hw->mac.ops.acquire_swfw_sync(hw, mask);
>> +}
>> +
>> +/**
>> + *? igc_release_phy_base - Release rights to access PHY
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? A wrapper to release access rights to the correct PHY.? This is a
>> + *? function pointer entry point called by the api module.
>> + **/
>> +static void igc_release_phy_base(struct e1000_hw *hw)
>> +{
>> +??? u16 mask = E1000_SWFW_PHY0_SM;
>> +
>> +??? hw->mac.ops.release_swfw_sync(hw, mask);
>> +}
>> +
>> +/**
>> ?? *? igc_get_link_up_info_base - Get link speed/duplex info
>> ?? *? @hw: pointer to the HW structure
>> ?? *? @speed: stores the current speed
>> @@ -200,6 +302,20 @@ static s32 igc_read_mac_addr_base(struct e1000_hw 
>> *hw)
>> ? }
>> ? /**
>> + *? igc_power_down_phy_copper_base - Remove link during PHY power down
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? In the case of a PHY power down to save power, or to turn off 
>> link during a
>> + *? driver unload, or wake on lan is not enabled, remove the link.
>> + **/
>> +void igc_power_down_phy_copper_base(struct e1000_hw *hw)
>> +{
>> +??? /* If the management interface is not enabled, then power down */
>> +??? if (!(igc_enable_mng_pass_thru(hw) || igc_check_reset_block(hw)))
>> +??????? igc_power_down_phy_copper(hw);
>> +}
>> +
>> +/**
>> ?? *? igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
>> ?? *? @hw: pointer to the HW structure
>> ?? *
>> @@ -283,10 +399,18 @@ static struct e1000_mac_operations 
>> e1000_mac_ops_base = {
>> ????? .get_speed_and_duplex??? = igc_get_link_up_info_base,
>> ? };
>> +static const struct e1000_phy_operations e1000_phy_ops_base = {
>> +??? .acquire??????? = igc_acquire_phy_base,
>> +??? .release??????? = igc_release_phy_base,
>> +??? .reset??????????? = igc_phy_hw_reset,
>> +??? .read_reg??????? = igc_read_phy_reg_gpy,
>> +??? .write_reg??????? = igc_write_phy_reg_gpy,
>> +};
>> +
>> ? const struct e1000_info e1000_base_info = {
>> ????? .get_invariants??? = igc_get_invariants_base,
>> ????? .mac_ops??? = &e1000_mac_ops_base,
>> -??? /* TODO phy_ops */
>> +??? .phy_ops??? = &e1000_phy_ops_base,
>> ? };
>> ? /**
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_base.h 
>> b/drivers/net/ethernet/intel/igc/e1000_base.h
>> index 210f1b5f6012..37e61e033966 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_base.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_base.h
>> @@ -6,6 +6,7 @@
>> ? /* forward declaration */
>> ? void igc_rx_fifo_flush_base(struct e1000_hw *hw);
>> +void igc_power_down_phy_copper_base(struct e1000_hw *hw);
>> ? /* Transmit Descriptor - Advanced */
>> ? union e1000_adv_tx_desc {
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h 
>> b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> index 31bc85cfa149..40276ae76c9f 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> @@ -67,11 +67,14 @@
>> ? #define E1000_ERR_MAC_INIT??????????? 5
>> ? #define E1000_ERR_RESET??????????????? 9
>> ? #define E1000_ERR_MASTER_REQUESTS_PENDING??? 10
>> +#define E1000_BLK_PHY_RESET??????????? 12
> 
> This should have the _ERR_ in it like the rest
> 
Good. fix will be applied in v4.
>> ? #define E1000_ERR_SWFW_SYNC??????????? 13
>> ? /* Device Control */
>> ? #define E1000_CTRL_RST??????? 0x04000000? /* Global reset */
>> +#define E1000_CTRL_PHY_RST??? 0x80000000? /* PHY Reset */
>> +
>> ? /* PBA constants */
>> ? #define E1000_PBA_34K??????????? 0x0022
>> @@ -175,6 +178,22 @@
>> ? #define HALF_DUPLEX??????? 1
>> ? #define FULL_DUPLEX??????? 2
>> +/* 1Gbps and 2.5Gbps half duplex is not supported, nor 
>> spec-compliant. */
>> +#define ADVERTISE_10_HALF??????? 0x0001
>> +#define ADVERTISE_10_FULL??????? 0x0002
>> +#define ADVERTISE_100_HALF??????? 0x0004
>> +#define ADVERTISE_100_FULL??????? 0x0008
>> +#define ADVERTISE_1000_HALF??????? 0x0010 /* Not used, just FYI */
>> +#define ADVERTISE_1000_FULL??????? 0x0020
>> +#define ADVERTISE_2500_HALF??????? 0x0040 /* NOT used, just FYI */
>> +#define ADVERTISE_2500_FULL??????? 0x0080
>> +
>> +#define E1000_ALL_SPEED_DUPLEX_2500 ( \
>> +??? ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
>> +??? ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
>> +
>> +#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500    
>> E1000_ALL_SPEED_DUPLEX_2500
>> +
>> ? /* Interrupt Cause Read */
>> ? #define E1000_ICR_TXDW??????? 0x00000001 /* Transmit desc written 
>> back */
>> ? #define E1000_ICR_TXQE??????? 0x00000002 /* Transmit Queue empty */
>> @@ -256,7 +275,8 @@
>> ? #define E1000_FCRTL_XONE??????? 0x80000000
>> ? /* Management Control */
>> -#define E1000_MANC_RCV_TCO_EN??? 0x00020000 /* Receive TCO Packets 
>> Enabled */
>> +#define E1000_MANC_RCV_TCO_EN??????? 0x00020000 /* Receive TCO 
>> Enabled */
>> +#define E1000_MANC_BLK_PHY_RST_ON_IDE??? 0x00040000 /* Block phy 
>> resets */
>> ? /* Receive Control */
>> ? #define E1000_RCTL_RST??????? 0x00000001 /* Software reset */
>> @@ -322,4 +342,63 @@
>> ? #define E1000_RCTL_PMCF??????? 0x00800000 /* pass MAC control frames */
>> ? #define E1000_RCTL_SECRC??? 0x04000000 /* Strip Ethernet CRC */
>> +/* GPY211 - I225 defines */
>> +#define GPY_MMD_MASK??????????? 0xFFFF0000
>> +#define GPY_MMD_SHIFT??????????? 16
>> +#define GPY_REG_MASK??????????? 0x0000FFFF
>> +
>> +#define E1000_MMDAC_FUNC_DATA??? 0x4000 /* Data, no post increment */
>> +
>> +/* MAC definitions */
>> +#define E1000_FACTPS_MNGCG??????? 0x20000000
>> +#define E1000_FWSM_MODE_MASK??????? 0xE
>> +#define E1000_FWSM_MODE_SHIFT??????? 1
>> +
>> +/* Management Control */
>> +#define E1000_MANC_SMBUS_EN??? 0x00000001 /* SMBus Enabled - RO */
>> +#define E1000_MANC_ASF_EN??? 0x00000002 /* ASF Enabled - RO */
>> +
>> +/* PHY */
>> +#define PHY_REVISION_MASK??? 0xFFFFFFF0
>> +#define MAX_PHY_REG_ADDRESS??? 0x1F? /* 5 bit address bus (0-0x1F) */
>> +#define E1000_GEN_POLL_TIMEOUT??? 640
>> +
>> +/* PHY Control Register */
>> +#define MII_CR_FULL_DUPLEX??? 0x0100? /* FDX =1, half duplex =0 */
>> +#define MII_CR_RESTART_AUTO_NEG??? 0x0200? /* Restart auto 
>> negotiation */
>> +#define MII_CR_POWER_DOWN??? 0x0800? /* Power down */
>> +#define MII_CR_AUTO_NEG_EN??? 0x1000? /* Auto Neg Enable */
>> +#define MII_CR_LOOPBACK??????? 0x4000? /* 0 = normal, 1 = loopback */
>> +#define MII_CR_RESET??????? 0x8000? /* 0 = normal, 1 = PHY reset */
>> +#define MII_CR_SPEED_1000??? 0x0040
>> +#define MII_CR_SPEED_100??? 0x2000
>> +#define MII_CR_SPEED_10??????? 0x0000
>> +
>> +/* PHY Status Register */
>> +#define MII_SR_LINK_STATUS??? 0x0004 /* Link Status 1 = link */
>> +#define MII_SR_AUTONEG_COMPLETE??? 0x0020 /* Auto Neg Complete */
>> +
>> +/* PHY 1000 MII Register/Bit Definitions */
>> +/* PHY Registers defined by IEEE */
>> +#define PHY_CONTROL??? 0x00 /* Control Register */
>> +#define PHY_STATUS??? 0x01 /* Status Register */
>> +#define PHY_ID1??????? 0x02 /* Phy Id Reg (word 1) */
>> +#define PHY_ID2??????? 0x03 /* Phy Id Reg (word 2) */
>> +
>> +/* Bit definitions for valid PHY IDs. I = Integrated E = External */
>> +#define I225_I_PHY_ID??????? 0x67C9DC00
> 
> To be consistent, these PHY_ and MII_ and the rest should have the same 
> prefix as the rest of the driver specific #defines, which I still think 
> should be IGC_, not E1000_.
> 
As I answer previously. In regard e1000_ or igc_ prefix, we will discuss 
with my colleagues and I will reply.
>> +
>> +/* MDI Control */
>> +#define E1000_MDIC_DATA_MASK??? 0x0000FFFF
>> +#define E1000_MDIC_REG_MASK??? 0x001F0000
>> +#define E1000_MDIC_REG_SHIFT??? 16
>> +#define E1000_MDIC_PHY_MASK??? 0x03E00000
>> +#define E1000_MDIC_PHY_SHIFT??? 21
>> +#define E1000_MDIC_OP_WRITE??? 0x04000000
>> +#define E1000_MDIC_OP_READ??? 0x08000000
>> +#define E1000_MDIC_READY??? 0x10000000
>> +#define E1000_MDIC_INT_EN??? 0x20000000
>> +#define E1000_MDIC_ERROR??? 0x40000000
>> +#define E1000_MDIC_DEST??????? 0x80000000
>> +
>> ? #endif /* _E1000_DEFINES_H_ */
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h 
>> b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> index ab630e5b3d97..d8fc6fa9eda2 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> @@ -11,6 +11,7 @@
>> ? #include "e1000_regs.h"
>> ? #include "e1000_defines.h"
>> ? #include "e1000_mac.h"
>> +#include "e1000_phy.h"
>> ? #include "e1000_nvm.h"
>> ? #include "e1000_i225.h"
>> ? #include "e1000_base.h"
>> @@ -18,6 +19,8 @@
>> ? #define E1000_DEV_ID_I225_LM??????????? 0x15F2
>> ? #define E1000_DEV_ID_I225_V??????????? 0x15F3
>> +#define E1000_FUNC_0??????????????? 0
>> +
>> ? /* Forward declaration */
>> ? struct e1000_hw;
>> @@ -47,6 +50,12 @@ enum e1000_phy_type {
>> ????? e1000_phy_i225,
>> ? };
>> +enum e1000_media_type {
>> +??? e1000_media_type_unknown = 0,
>> +??? e1000_media_type_copper = 1,
>> +??? e1000_num_media_types
>> +};
>> +
>> ? enum e1000_nvm_type {
>> ????? e1000_nvm_unknown = 0,
>> ????? e1000_nvm_flash_hw,
>> @@ -112,6 +121,7 @@ struct e1000_mac_info {
>> ????? bool adaptive_ifs;
>> ????? bool has_fwsm;
>> +??? bool asf_firmware_present;
>> ????? bool arc_subsystem_valid;
>> ????? bool autoneg;
>> @@ -129,6 +139,20 @@ struct e1000_nvm_operations {
>> ????? s32 (*valid_led_default)(struct e1000_hw *hw, u16 *data);
>> ? };
>> +struct e1000_phy_operations {
>> +??? s32 (*acquire)(struct e1000_hw *hw);
>> +??? s32 (*check_polarity)(struct e1000_hw *hw);
>> +??? s32 (*check_reset_block)(struct e1000_hw *hw);
>> +??? s32 (*force_speed_duplex)(struct e1000_hw *hw);
>> +??? s32 (*get_cfg_done)(struct e1000_hw *hw);
>> +??? s32 (*get_cable_length)(struct e1000_hw *hw);
>> +??? s32 (*get_phy_info)(struct e1000_hw *hw);
>> +??? s32 (*read_reg)(struct e1000_hw *hw, u32 address, u16 *data);
>> +??? void (*release)(struct e1000_hw *hw);
>> +??? s32 (*reset)(struct e1000_hw *hw);
>> +??? s32 (*write_reg)(struct e1000_hw *hw, u32 address, u16 data);
>> +};
>> +
>> ? struct e1000_nvm_info {
>> ????? struct e1000_nvm_operations ops;
>> ????? enum e1000_nvm_type type;
>> @@ -143,6 +167,35 @@ struct e1000_nvm_info {
>> ????? u16 page_size;
>> ? };
>> +struct e1000_phy_info {
>> +??? struct e1000_phy_operations ops;
>> +
>> +??? enum e1000_phy_type type;
>> +
>> +??? u32 addr;
>> +??? u32 id;
>> +??? u32 reset_delay_us; /* in usec */
>> +??? u32 revision;
>> +
>> +??? enum e1000_media_type media_type;
>> +
>> +??? u16 autoneg_advertised;
>> +??? u16 autoneg_mask;
>> +??? u16 cable_length;
>> +??? u16 max_cable_length;
>> +??? u16 min_cable_length;
>> +??? u16 pair_length[4];
>> +
>> +??? u8 mdix;
>> +
>> +??? bool disable_polarity_correction;
>> +??? bool is_mdix;
>> +??? bool polarity_correction;
>> +??? bool reset_disable;
>> +??? bool speed_downgraded;
>> +??? bool autoneg_wait_to_complete;
>> +};
>> +
>> ? struct e1000_bus_info {
>> ????? enum e1000_bus_type type;
>> ????? enum e1000_bus_speed speed;
>> @@ -188,6 +241,7 @@ struct e1000_hw {
>> ????? struct e1000_mac_info? mac;
>> ????? struct e1000_fc_info?? fc;
>> ????? struct e1000_nvm_info? nvm;
>> +??? struct e1000_phy_info? phy;
>> ????? struct e1000_bus_info bus;
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.c 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> index 5681c0e3f0c8..fe483211f66f 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_mac.c
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> @@ -389,7 +389,8 @@ s32 igc_check_for_copper_link(struct e1000_hw *hw)
>> ?????? * link.? If so, then we want to get the current speed/duplex
>> ?????? * of the PHY.
>> ?????? */
>> -??? /* TODO ret_val = igc_phy_has_link(hw, 1, 0, &link); */
>> +??? ret_val = igc_phy_has_link(hw, 1, 0, &link);
>> +
> 
> no blank line needed here
> 
Thanks. fix will be applied in v4.
>> ????? if (ret_val)
>> ????????? goto out;
>> @@ -401,7 +402,7 @@ s32 igc_check_for_copper_link(struct e1000_hw *hw)
>> ????? /* Check if there was DownShift, must be checked
>> ?????? * immediately after link-up
>> ?????? */
>> -??? /* TODO igc_check_downshift(hw); */
>> +??? igc_check_downshift(hw);
>> ????? /* If we are forcing speed/duplex, then we simply return since
>> ?????? * we have already determined whether we have link or not.
>> @@ -542,3 +543,46 @@ void igc_put_hw_semaphore(struct e1000_hw *hw)
>> ????? wr32(E1000_SWSM, swsm);
>> ? }
>> +
>> +/**
>> + *? igc_enable_mng_pass_thru - Enable processing of ARP's
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Verifies the hardware needs to leave interface enabled so that 
>> frames can
>> + *? be directed to and from the management interface.
>> + **/
>> +bool igc_enable_mng_pass_thru(struct e1000_hw *hw)
>> +{
>> +??? u32 manc;
>> +??? u32 fwsm, factps;
>> +??? bool ret_val = false;
>> +
>> +??? if (!hw->mac.asf_firmware_present)
>> +??????? goto out;
>> +
>> +??? manc = rd32(E1000_MANC);
>> +
>> +??? if (!(manc & E1000_MANC_RCV_TCO_EN))
>> +??????? goto out;
>> +
>> +??? if (hw->mac.arc_subsystem_valid) {
>> +??????? fwsm = rd32(E1000_FWSM);
>> +??????? factps = rd32(E1000_FACTPS);
>> +
>> +??????? if (!(factps & E1000_FACTPS_MNGCG) &&
>> +??????????? ((fwsm & E1000_FWSM_MODE_MASK) ==
>> +??????????? (e1000_mng_mode_pt << E1000_FWSM_MODE_SHIFT))) {
>> +??????????? ret_val = true;
>> +??????????? goto out;
>> +??????? }
>> +??? } else {
>> +??????? if ((manc & E1000_MANC_SMBUS_EN) &&
>> +??????????? !(manc & E1000_MANC_ASF_EN)) {
>> +??????????? ret_val = true;
>> +??????????? goto out;
>> +??????? }
>> +??? }
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.h 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> index f18f5221199f..0f17a8443125 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_mac.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> @@ -5,6 +5,7 @@
>> ? #define _E1000_MAC_H_
>> ? #include "e1000_hw.h"
>> +#include "e1000_phy.h"
>> ? #include "e1000_defines.h"
>> ? #ifndef E1000_REMOVED
>> @@ -28,4 +29,14 @@ s32 igc_get_bus_info_pcie(struct e1000_hw *hw);
>> ? s32 igc_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
>> ????????????????????? u16 *duplex);
>> +bool igc_enable_mng_pass_thru(struct e1000_hw *hw);
>> +
>> +enum e1000_mng_mode {
>> +??? e1000_mng_mode_none = 0,
>> +??? e1000_mng_mode_asf,
>> +??? e1000_mng_mode_pt,
>> +??? e1000_mng_mode_ipmi,
>> +??? e1000_mng_mode_host_if_only
>> +};
>> +
>> ? #endif
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_phy.c 
>> b/drivers/net/ethernet/intel/igc/e1000_phy.c
>> new file mode 100644
>> index 000000000000..c95efc4145e8
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_phy.c
>> @@ -0,0 +1,457 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#include "e1000_phy.h"
>> +
>> +/**
>> + *? igc_check_reset_block - Check if PHY reset is blocked
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Read the PHY management control register and check whether a PHY 
>> reset
>> + *? is blocked.? If a reset is not blocked return 0, otherwise
>> + *? return E1000_BLK_PHY_RESET (12).
>> + **/
>> +s32 igc_check_reset_block(struct e1000_hw *hw)
>> +{
>> +??? u32 manc;
>> +
>> +??? manc = rd32(E1000_MANC);
>> +
>> +??? return (manc & E1000_MANC_BLK_PHY_RST_ON_IDE) ? 
>> E1000_BLK_PHY_RESET : 0;
>> +}
>> +
>> +/**
>> + *? igc_get_phy_id - Retrieve the PHY ID and revision
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Reads the PHY registers and stores the PHY ID and possibly the PHY
>> + *? revision in the hardware structure.
>> + **/
>> +s32 igc_get_phy_id(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? s32 ret_val = 0;
>> +??? u16 phy_id;
>> +
>> +??? ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +??? phy->id = (u32)(phy_id << 16);
>> +??? usleep_range(200, 500);
>> +??? ret_val = phy->ops.read_reg(hw, PHY_ID2, &phy_id);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +??? phy->id |= (u32)(phy_id & PHY_REVISION_MASK);
>> +??? phy->revision = (u32)(phy_id & ~PHY_REVISION_MASK);
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_phy_has_link - Polls PHY for link
>> + *? @hw: pointer to the HW structure
>> + *? @iterations: number of times to poll for link
>> + *? @usec_interval: delay between polling attempts
>> + *? @success: pointer to whether polling was successful or not
>> + *
>> + *? Polls the PHY status register for link, 'iterations' number of 
>> times.
>> + **/
>> +s32 igc_phy_has_link(struct e1000_hw *hw, u32 iterations,
>> +???????????? u32 usec_interval, bool *success)
>> +{
>> +??? s32 ret_val = 0;
>> +??? u16 i, phy_status;
>> +
>> +??? for (i = 0; i < iterations; i++) {
>> +??????? /* Some PHYs require the PHY_STATUS register to be read
>> +???????? * twice due to the link bit being sticky.? No harm doing
>> +???????? * it across the board.
>> +???????? */
>> +??????? ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
>> +??????? if (ret_val && usec_interval > 0) {
>> +??????????? /* If the first read fails, another entity may have
>> +???????????? * ownership of the resources, wait and try again to
>> +???????????? * see if they have relinquished the resources yet.
>> +???????????? */
>> +??????????? if (usec_interval >= 1000)
>> +??????????????? mdelay(usec_interval / 1000);
>> +??????????? else
>> +??????????????? udelay(usec_interval);
>> +??????? }
>> +??????? ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
>> +??????? if (ret_val)
>> +??????????? break;
>> +??????? if (phy_status & MII_SR_LINK_STATUS)
>> +??????????? break;
>> +??????? if (usec_interval >= 1000)
>> +??????????? mdelay(usec_interval / 1000);
>> +??????? else
>> +??????????? udelay(usec_interval);
>> +??? }
>> +
>> +??? *success = (i < iterations) ? true : false;
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_power_up_phy_copper - Restore copper link in case of PHY 
>> power down
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? In the case of a PHY power down to save power, or to turn off 
>> link during a
>> + *? driver unload, restore the link to previous settings.
>> + **/
>> +void igc_power_up_phy_copper(struct e1000_hw *hw)
>> +{
>> +??? u16 mii_reg = 0;
>> +
>> +??? /* The PHY will retain its settings across a power down/up cycle */
>> +??? hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
>> +??? mii_reg &= ~MII_CR_POWER_DOWN;
>> +??? hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
>> +}
>> +
>> +/**
>> + *? igc_power_down_phy_copper - Power down copper PHY
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Power down PHY to save power when interface is down and wake on lan
>> + *? is not enabled.
>> + **/
>> +void igc_power_down_phy_copper(struct e1000_hw *hw)
>> +{
>> +??? u16 mii_reg = 0;
>> +
>> +??? /* The PHY will retain its settings across a power down/up cycle */
>> +??? hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
>> +??? mii_reg |= MII_CR_POWER_DOWN;
>> +
>> +??? /* Temporary workaround - should be removed when PHY will implement
>> +???? * IEEE registers as properly
>> +???? */
> 
> Maybe this should be marked with a TODO: as that is a more standard way 
> of tagging future work.
> 
Ah... we just decided kee without /* TODO... */ so I marked this as 
comment. In next step of silicon this issue should be resolved and I 
will send another patch.
>> +??? /* hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);*/
>> +??? usleep_range(1000, 2000);
>> +}
>> +
>> +/**
>> + *? igc_check_downshift - Checks whether a downshift in speed occurred
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Success returns 0, Failure returns 1
>> + *
>> + *? A downshift is detected by querying the PHY link health.
>> + **/
>> +s32 igc_check_downshift(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? s32 ret_val;
>> +??? u16 phy_data, offset, mask;
>> +
>> +??? switch (phy->type) {
>> +??? case e1000_phy_i225:
>> +??? default:
>> +??????? /* speed downshift not supported */
>> +??????? phy->speed_downgraded = false;
>> +??????? ret_val = 0;
>> +??????? goto out;
>> +??? }
> 
> This filter looks wrong, I don't think both i225 and default should end 
> up with "not supported".? Either you're filtering specific devices for 
> not supported and the default should go on to check for downgrade, or 
> only specific devices should go on to check for downgrade and the rest 
> should default to not supported.
> 
Ok. I need to check more depth with design and run HW experiment.
>> +
>> +??? ret_val = phy->ops.read_reg(hw, offset, &phy_data);
>> +
>> +??? if (!ret_val)
>> +??????? phy->speed_downgraded = (phy_data & mask) ? true : false;
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_phy_hw_reset - PHY hardware reset
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Verify the reset block is not blocking us from resetting.? Acquire
>> + *? semaphore (if necessary) and read/set/write the device control reset
>> + *? bit in the PHY.? Wait the appropriate delay time for the device to
>> + *? reset and release the semaphore (if necessary).
>> + **/
>> +s32 igc_phy_hw_reset(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? s32? ret_val;
>> +??? u32 ctrl;
>> +
>> +??? ret_val = igc_check_reset_block(hw);
>> +??? if (ret_val) {
>> +??????? ret_val = 0;
>> +??????? goto out;
>> +??? }
>> +
>> +??? ret_val = phy->ops.acquire(hw);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +??? ctrl = rd32(E1000_CTRL);
>> +??? wr32(E1000_CTRL, ctrl | E1000_CTRL_PHY_RST);
>> +??? wrfl();
>> +
>> +??? udelay(phy->reset_delay_us); > +
>> +??? wr32(E1000_CTRL, ctrl);
>> +??? wrfl();
> 
> You have to specifically clear the PHY_RST bit?? Doesn't the reset clear 
> the bit?
> 
I keep align with other drivers. Our PHY's FW not completely done yet - 
so, please wait when I will check this.
>> +
>> +??? usleep_range(1500, 2000);
>> +
>> +??? phy->ops.release(hw);
>> +
>> +??? ret_val = phy->ops.get_cfg_done(hw);
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_read_phy_reg_mdic - Read MDI control register
>> + *? @hw: pointer to the HW structure
>> + *? @offset: register offset to be read
>> + *? @data: pointer to the read data
>> + *
>> + *? Reads the MDI control register in the PHY at offset and stores the
>> + *? information read to data.
>> + **/
>> +static s32 igc_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 
>> *data)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? u32 i, mdic = 0;
>> +??? s32 ret_val = 0;
>> +
>> +??? if (offset > MAX_PHY_REG_ADDRESS) {
>> +??????? hw_dbg("PHY Address %d is out of range\n", offset);
>> +??????? ret_val = -E1000_ERR_PARAM;
>> +??????? goto out;
>> +??? }
>> +
>> +??? /* Set up Op-code, Phy Address, and register offset in the MDI
>> +???? * Control register.? The MAC will take care of interfacing with the
>> +???? * PHY to retrieve the desired data.
>> +???? */
>> +??? mdic = ((offset << E1000_MDIC_REG_SHIFT) |
>> +??????? (phy->addr << E1000_MDIC_PHY_SHIFT) |
>> +??????? (E1000_MDIC_OP_READ));
>> +
>> +??? wr32(E1000_MDIC, mdic);
>> +
>> +??? /* Poll the ready bit to see if the MDI read completed
>> +???? * Increasing the time out as testing showed failures with
>> +???? * the lower time out
> 
> Why not just make the #define a larger number?
> 
Possible, but why do not keep same approach as another drivers.
>> +???? */
>> +??? for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
>> +??????? usleep_range(500, 1000);
>> +??????? mdic = rd32(E1000_MDIC);
>> +??????? if (mdic & E1000_MDIC_READY)
>> +??????????? break;
>> +??? }
>> +??? if (!(mdic & E1000_MDIC_READY)) {
>> +??????? hw_dbg("MDI Read did not complete\n");
>> +??????? ret_val = -E1000_ERR_PHY;
>> +??????? goto out;
>> +??? }
>> +??? if (mdic & E1000_MDIC_ERROR) {
>> +??????? hw_dbg("MDI Error\n");
>> +??????? ret_val = -E1000_ERR_PHY;
>> +??????? goto out;
>> +??? }
>> +??? *data = (u16)mdic;
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_write_phy_reg_mdic - Write MDI control register
>> + *? @hw: pointer to the HW structure
>> + *? @offset: register offset to write to
>> + *? @data: data to write to register at offset
>> + *
>> + *? Writes data to MDI control register in the PHY at offset.
>> + **/
>> +static s32 igc_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, 
>> u16 data)
>> +{
>> +??? struct e1000_phy_info *phy = &hw->phy;
>> +??? u32 i, mdic = 0;
>> +??? s32 ret_val = 0;
>> +
>> +??? if (offset > MAX_PHY_REG_ADDRESS) {
>> +??????? hw_dbg("PHY Address %d is out of range\n", offset);
>> +??????? ret_val = -E1000_ERR_PARAM;
>> +??????? goto out;
>> +??? }
>> +
>> +??? /* Set up Op-code, Phy Address, and register offset in the MDI
>> +???? * Control register.? The MAC will take care of interfacing with the
>> +???? * PHY to retrieve the desired data.
> 
> s/retrieve/write/
> 
fix will be applied in v4.
>> +???? */
>> +??? mdic = (((u32)data) |
>> +??????? (offset << E1000_MDIC_REG_SHIFT) |
>> +??????? (phy->addr << E1000_MDIC_PHY_SHIFT) |
>> +??????? (E1000_MDIC_OP_WRITE));
>> +
>> +??? wr32(E1000_MDIC, mdic);
>> +
>> +??? /* Poll the ready bit to see if the MDI read completed
>> +???? * Increasing the time out as testing showed failures with
>> +???? * the lower time out
> 
> Yeah, just fix the #define
> 
Same as above.
>> +???? */
>> +??? for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
>> +??????? usleep_range(500, 1000);
>> +??????? mdic = rd32(E1000_MDIC);
>> +??????? if (mdic & E1000_MDIC_READY)
>> +??????????? break;
>> +??? }
>> +??? if (!(mdic & E1000_MDIC_READY)) {
>> +??????? hw_dbg("MDI Write did not complete\n");
>> +??????? ret_val = -E1000_ERR_PHY;
>> +??????? goto out;
>> +??? }
>> +??? if (mdic & E1000_MDIC_ERROR) {
>> +??????? hw_dbg("MDI Error\n");
>> +??????? ret_val = -E1000_ERR_PHY;
>> +??????? goto out;
>> +??? }
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? __igc_access_xmdio_reg - Read/write XMDIO register
>> + *? @hw: pointer to the HW structure
>> + *? @address: XMDIO address to program
>> + *? @dev_addr: device address to program
>> + *? @data: pointer to value to read/write from/to the XMDIO address
>> + *? @read: boolean flag to indicate read or write
>> + **/
>> +static s32 __igc_access_xmdio_reg(struct e1000_hw *hw, u16 address,
>> +????????????????? u8 dev_addr, u16 *data, bool read)
>> +{
>> +??? s32 ret_val;
>> +
>> +??? ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, dev_addr);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAAD, address);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 
>> E1000_MMDAC_FUNC_DATA |
>> +??????????????????? dev_addr);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? if (read)
>> +??????? ret_val = hw->phy.ops.read_reg(hw, E1000_MMDAAD, data);
> 
> Is there no wait needed before the read?
> 
ok. I can say that this piece of code work as properly on our HW without 
delay. I don't saw any problem.
>> +??? else
>> +??????? ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAAD, *data);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? /* Recalibrate the device back to 0 */
>> +??? ret_val = hw->phy.ops.write_reg(hw, E1000_MMDAC, 0);
>> +??? if (ret_val)
>> +??????? return ret_val;
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_read_xmdio_reg - Read XMDIO register
>> + *? @hw: pointer to the HW structure
>> + *? @addr: XMDIO address to program
>> + *? @dev_addr: device address to program
>> + *? @data: value to be read from the EMI address
>> + **/
>> +static s32 igc_read_xmdio_reg(struct e1000_hw *hw, u16 addr,
>> +????????????????? u8 dev_addr, u16 *data)
>> +{
>> +??? return __igc_access_xmdio_reg(hw, addr, dev_addr, data, true);
>> +}
>> +
>> +/**
>> + *? igc_write_xmdio_reg - Write XMDIO register
>> + *? @hw: pointer to the HW structure
>> + *? @addr: XMDIO address to program
>> + *? @dev_addr: device address to program
>> + *? @data: value to be written to the XMDIO address
>> + **/
>> +static s32 igc_write_xmdio_reg(struct e1000_hw *hw, u16 addr,
>> +?????????????????? u8 dev_addr, u16 data)
>> +{
>> +??? return __igc_access_xmdio_reg(hw, addr, dev_addr, &data, false);
>> +}
>> +
>> +/**
>> + *? igc_write_phy_reg_gpy - Write GPY PHY register
>> + *? @hw: pointer to the HW structure
>> + *? @offset: register offset to write to
>> + *? @data: data to write at register offset
>> + *
>> + *? Acquires semaphore, if necessary, then writes the data to PHY 
>> register
>> + *? at the offset.? Release any acquired semaphores before exiting.
>> + **/
>> +s32 igc_write_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 data)
>> +{
>> +??? s32 ret_val;
>> +??? u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
>> +
>> +??? offset = offset & GPY_REG_MASK;
>> +
>> +??? if (!dev_addr) {
>> +??????? ret_val = hw->phy.ops.acquire(hw);
>> +??????? if (ret_val)
>> +??????????? return ret_val;
>> +??????? ret_val = igc_write_phy_reg_mdic(hw, offset, data);
>> +??????? if (ret_val)
>> +??????????? return ret_val;
>> +??????? hw->phy.ops.release(hw);
>> +??? } else {
>> +??????? ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
>> +????????????????????????? data);
>> +??? }
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_read_phy_reg_gpy - Read GPY PHY register
>> + *? @hw: pointer to the HW structure
>> + *? @offset: lower half is register offset to read to
>> + *???? upper half is MMD to use.
>> + *? @data: data to read at register offset
>> + *
>> + *? Acquires semaphore, if necessary, then reads the data in the PHY 
>> register
>> + *? at the offset.? Release any acquired semaphores before exiting.
>> + **/
>> +s32 igc_read_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 *data)
>> +{
>> +??? s32 ret_val;
>> +??? u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
>> +
>> +??? offset = offset & GPY_REG_MASK;
>> +
>> +??? if (!dev_addr) {
>> +??????? ret_val = hw->phy.ops.acquire(hw);
>> +??????? if (ret_val)
>> +??????????? return ret_val;
>> +??????? ret_val = igc_read_phy_reg_mdic(hw, offset, data);
>> +??????? if (ret_val)
>> +??????????? return ret_val;
>> +??????? hw->phy.ops.release(hw);
>> +??? } else {
>> +??????? ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
>> +???????????????????????? data);
>> +??? }
>> +??? return ret_val;
>> +}
>> +
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_phy.h 
>> b/drivers/net/ethernet/intel/igc/e1000_phy.h
>> new file mode 100644
>> index 000000000000..d04dfd0be7fd
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_phy.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#ifndef _E1000_PHY_H_
>> +#define _E1000_PHY_H_
>> +
>> +#include "e1000_mac.h"
>> +
>> +s32? igc_check_reset_block(struct e1000_hw *hw);
>> +s32? igc_phy_hw_reset(struct e1000_hw *hw);
>> +s32? igc_get_phy_id(struct e1000_hw *hw);
>> +s32? igc_phy_has_link(struct e1000_hw *hw, u32 iterations,
>> +????????????? u32 usec_interval, bool *success);
>> +s32 igc_check_downshift(struct e1000_hw *hw);
>> +void igc_power_up_phy_copper(struct e1000_hw *hw);
>> +void igc_power_down_phy_copper(struct e1000_hw *hw);
>> +
>> +s32? igc_write_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 data);
>> +s32? igc_read_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 *data);
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_regs.h 
>> b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> index 698ce0cac757..3fcaf606ce20 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_regs.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> @@ -55,6 +55,9 @@
>> ? #define E1000_SWSM??????? 0x05B50? /* SW Semaphore */
>> ? #define E1000_FWSM??????? 0x05B54? /* FW Semaphore */
>> +/* Function Active and Power State to MNG */
>> +#define E1000_FACTPS??????? 0x05B30
>> +
>> ? /* Interrupt Register Description */
>> ? #define E1000_PICAUSE??????? 0x05B88? /* PCIe Interrupt Cause - 
>> RW1/C */
>> ? #define E1000_PIENA??????? 0x05B8C? /* PCIe Interrupt enable - RW */
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h 
>> b/drivers/net/ethernet/intel/igc/igc.h
>> index 735a5e3d0717..91df0a14c3a5 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -365,6 +365,22 @@ static inline u16 igc_desc_unused(const struct 
>> igc_ring *ring)
>> ????? return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
>> ? }
>> +static inline s32 igc_get_phy_info(struct e1000_hw *hw)
>> +{
>> +??? if (hw->phy.ops.get_phy_info)
>> +??????? return hw->phy.ops.get_phy_info(hw);
>> +
>> +??? return 0;
>> +}
>> +
>> +static inline s32 igc_reset_phy(struct e1000_hw *hw)
>> +{
>> +??? if (hw->phy.ops.reset)
>> +??????? return hw->phy.ops.reset(hw);
>> +
>> +??? return 0;
>> +}
>> +
>> ? static inline struct netdev_queue *txring_txq(const struct igc_ring 
>> *tx_ring)
>> ? {
>> ????? return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index dcc7e700074f..21aed91454d4 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -100,6 +100,8 @@ void igc_reset(struct igc_adapter *adapter)
>> ????? if (!netif_running(adapter->netdev))
>> ????????? igc_power_down_link(adapter);
>> +
>> +??? igc_get_phy_info(hw);
>> ? }
>> ? /**
>> @@ -108,6 +110,12 @@ void igc_reset(struct igc_adapter *adapter)
>> ?? **/
>> ? void igc_power_up_link(struct igc_adapter *adapter)
>> ? {
>> +??? igc_reset_phy(&adapter->hw);
>> +
>> +??? if (adapter->hw.phy.media_type == e1000_media_type_copper)
>> +??????? igc_power_up_phy_copper(&adapter->hw);
>> +
>> +??? igc_setup_link(&adapter->hw);
>> ? }
>> ? /**
>> @@ -116,6 +124,8 @@ void igc_power_up_link(struct igc_adapter *adapter)
>> ?? **/
>> ? static void igc_power_down_link(struct igc_adapter *adapter)
>> ? {
>> +??? if (adapter->hw.phy.media_type == e1000_media_type_copper)
>> +??????? igc_power_down_phy_copper_base(&adapter->hw);
>> ? }
>> ? /**
>> @@ -3424,6 +3434,7 @@ static int igc_probe(struct pci_dev *pdev,
>> ????? /* Copy the default MAC and PHY function pointers */
>> ????? memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
>> +??? memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
>> ????? /* Initialize skew-specific constants */
>> ????? err = ei->get_invariants(hw);
>>
Thanks for your comments.

