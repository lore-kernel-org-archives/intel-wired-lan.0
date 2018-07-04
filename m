From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 4 Jul 2018 16:39:38 +0300
Subject: [Intel-wired-lan] [PATCH v3 07/11] igc: Add HW initialization
 code
In-Reply-To: <cf82084e-aa48-8d00-5ae7-ae53b95f6bb2@oracle.com>
References: <20180624084515.10242-1-sasha.neftin@intel.com>
 <cf82084e-aa48-8d00-5ae7-ae53b95f6bb2@oracle.com>
Message-ID: <257e0cae-6edd-4c0a-2af3-2bb8bc56827f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2018 01:25, Shannon Nelson wrote:
> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>> Add code for hw initialization and reset.
>> Add code for semaphore handling.
>>
>> Sasha Neftin (v2):
>> fixed code indentation
>> refactor of igc_desc_unused method
>>
>> Sasha Neftin (v3):
>> clean code and remove unused methods
>>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/Makefile??????? |?? 3 +-
>> ? drivers/net/ethernet/intel/igc/e1000_base.c??? | 198 +++++++++++++++
>> ? drivers/net/ethernet/intel/igc/e1000_base.h??? |?? 2 +
>> ? drivers/net/ethernet/intel/igc/e1000_defines.h |? 39 +++
>> ? drivers/net/ethernet/intel/igc/e1000_hw.h????? |? 85 +++++++
>> ? drivers/net/ethernet/intel/igc/e1000_i225.c??? | 141 +++++++++++
>> ? drivers/net/ethernet/intel/igc/e1000_mac.c???? | 320 
>> +++++++++++++++++++++++++
>> ? drivers/net/ethernet/intel/igc/e1000_mac.h???? |? 13 +-
>> ? drivers/net/ethernet/intel/igc/e1000_regs.h??? |? 27 +++
>> ? drivers/net/ethernet/intel/igc/igc_main.c????? |? 21 ++
>> ? 10 files changed, 846 insertions(+), 3 deletions(-)
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_i225.c
>>
>> diff --git a/drivers/net/ethernet/intel/igc/Makefile 
>> b/drivers/net/ethernet/intel/igc/Makefile
>> index 6a757ac8492d..cb260bedfa37 100644
>> --- a/drivers/net/ethernet/intel/igc/Makefile
>> +++ b/drivers/net/ethernet/intel/igc/Makefile
>> @@ -7,5 +7,4 @@
>> ? obj-$(CONFIG_IGC) += igc.o
>> -igc-objs := igc_main.o e1000_mac.o \
>> -e1000_base.o
>> +igc-objs := igc_main.o e1000_mac.o e1000_i225.o e1000_base.o
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_base.c 
>> b/drivers/net/ethernet/intel/igc/e1000_base.c
>> index 265ec98000e7..395d7ce70bb4 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_base.c
>> +++ b/drivers/net/ethernet/intel/igc/e1000_base.c
>> @@ -5,6 +5,92 @@
>> ? #include "e1000_hw.h"
>> ? #include "e1000_i225.h"
>> +#include "e1000_mac.h"
>> +#include "e1000_base.h"
>> +#include "igc.h"
>> +
>> +/* forward declaration */
>> +static s32 igc_get_invariants_base(struct e1000_hw *);
>> +static s32 igc_init_hw_base(struct e1000_hw *);
>> +static s32 igc_reset_hw_base(struct e1000_hw *);
>> +static s32 igc_set_pcie_completion_timeout(struct e1000_hw *hw);
>> +
>> +/**
>> + *? igc_init_mac_params_base - Init MAC func ptrs.
>> + *? @hw: pointer to the HW structure
>> + **/
>> +static s32 igc_init_mac_params_base(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_mac_info *mac = &hw->mac;
>> +
>> +??? /* Set mta register count */
>> +??? mac->mta_reg_count = 128;
>> +??? mac->rar_entry_count = E1000_RAR_ENTRIES;
>> +
>> +??? /* reset */
>> +??? mac->ops.reset_hw = igc_reset_hw_base;
>> +
>> +??? mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
>> +??? mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
>> +
>> +??? return 0;
>> +}
>> +
>> +static s32 igc_get_invariants_base(struct e1000_hw *hw)
>> +{
>> +??? s32 ret_val = 0;
>> +??? u32 ctrl_ext = 0;
>> +??? u32 link_mode = 0;
>> +
>> +??? ctrl_ext = rd32(E1000_CTRL_EXT);
>> +??? link_mode = ctrl_ext & E1000_CTRL_EXT_LINK_MODE_MASK;
>> +
>> +??? /* mac initialization and operations */
>> +??? ret_val = igc_init_mac_params_base(hw);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_init_hw_base - Initialize hardware
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? This inits the hardware readying it for operation.
>> + **/
>> +static s32 igc_init_hw_base(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_mac_info *mac = &hw->mac;
>> +??? s32 ret_val = 0;
>> +??? u16 i, rar_count = mac->rar_entry_count;
>> +
>> +??? /* Setup the receive address */
>> +??? igc_init_rx_addrs(hw, rar_count);
>> +
>> +??? /* Zero out the Multicast HASH table */
>> +??? hw_dbg("Zeroing the MTA\n");
>> +??? for (i = 0; i < mac->mta_reg_count; i++)
>> +??????? array_wr32(E1000_MTA, i, 0);
>> +
>> +??? /* Zero out the Unicast HASH table */
>> +??? hw_dbg("Zeroing the UTA\n");
>> +??? for (i = 0; i < mac->uta_reg_count; i++)
>> +??????? array_wr32(E1000_UTA, i, 0);
>> +
>> +??? /* Setup link and flow control */
>> +??? ret_val = igc_setup_link(hw);
>> +
>> +??? /* Clear all of the statistics registers (clear on read).? It is
>> +???? * important that we do this after we have tried to establish link
>> +???? * because the symbol error count will increment wildly if there
>> +???? * is no link.
>> +???? */
>> +??? igc_clear_hw_cntrs_base(hw);
>> +
>> +??? return ret_val;
>> +}
>> ? /**
>> ?? *? igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
>> @@ -81,3 +167,115 @@ void igc_rx_fifo_flush_base(struct e1000_hw *hw)
>> ????? rd32(E1000_RNBC);
>> ????? rd32(E1000_MPC);
>> ? }
>> +
>> +static struct e1000_mac_operations e1000_mac_ops_base = {
>> +??? .init_hw??? = igc_init_hw_base,
>> +};
>> +
>> +const struct e1000_info e1000_base_info = {
>> +??? .get_invariants = igc_get_invariants_base,
>> +??? .mac_ops = &e1000_mac_ops_base,
>> +};
>> +
>> +/**
>> + *? igc_reset_hw_base - Reset hardware
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? This resets the hardware into a known state.? This is a
>> + *? function pointer entry point called by the api module.
>> + **/
>> +static s32 igc_reset_hw_base(struct e1000_hw *hw)
>> +{
>> +??? u32 ctrl;
>> +??? s32 ret_val;
>> +
>> +??? /* Prevent the PCI-E bus from sticking if there is no TLP connection
>> +???? * on the last TLP read/write transaction when MAC is reset.
>> +???? */
>> +??? ret_val = igc_disable_pcie_master(hw);
>> +??? if (ret_val)
>> +??????? hw_dbg("PCI-E Master disable polling has failed.\n");
>> +
>> +??? /* set the completion timeout for interface */
>> +??? ret_val = igc_set_pcie_completion_timeout(hw);
>> +??? if (ret_val)
>> +??????? hw_dbg("PCI-E Set completion timeout has failed.\n");
>> +
>> +??? hw_dbg("Masking off all interrupts\n");
>> +??? wr32(E1000_IMC, 0xffffffff);
>> +
>> +??? wr32(E1000_RCTL, 0);
>> +??? wr32(E1000_TCTL, E1000_TCTL_PSP);
>> +??? wrfl();
>> +
>> +??? usleep_range(10000, 20000);
>> +
>> +??? ctrl = rd32(E1000_CTRL);
>> +
>> +??? hw_dbg("Issuing a global reset to MAC\n");
>> +??? wr32(E1000_CTRL, ctrl | E1000_CTRL_RST);
>> +
>> +??? ret_val = igc_get_auto_rd_done(hw);
>> +??? if (ret_val) {
>> +??????? /* When auto config read does not complete, do not
>> +???????? * return with an error. This can happen in situations
>> +???????? * where there is no eeprom and prevents getting link.
>> +???????? */
>> +??????? hw_dbg("Auto Read Done did not complete\n");
>> +??? }
>> +
>> +??? /* Clear any pending interrupt events. */
>> +??? wr32(E1000_IMC, 0xffffffff);
>> +??? rd32(E1000_ICR);
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_set_pcie_completion_timeout - set pci-e completion timeout
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? The defaults for 82575 and 82576 should be in the range of 50us 
>> to 50ms,
> 
> Wrong devices
> 
> Since this is copy-n-paste from the previous driver, is this even correct?
> 
Right. Should be gone. fix will be applied in v4.
>> + *? however the hardware default for these parts is 500us to 1ms 
>> which is less
>> + *? than the 10ms recommended by the pci-e spec.? To address this we 
>> need to
>> + *? increase the value to either 10ms to 200ms for capability version 
>> 1 config,
>> + *? or 16ms to 55ms for version 2.
>> + **/
>> +static s32 igc_set_pcie_completion_timeout(struct e1000_hw *hw)
>> +{
>> +??? u32 gcr = rd32(E1000_GCR);
>> +??? s32 ret_val = 0;
>> +??? u16 pcie_devctl2;
>> +
>> +??? /* only take action if timeout value is defaulted to 0 */
>> +??? if (gcr & E1000_GCR_CMPL_TMOUT_MASK)
>> +??????? goto out;
>> +
>> +??? /* if capabilities version is type 1 we can write the
>> +???? * timeout of 10ms to 200ms through the GCR register
>> +???? */
>> +??? if (!(gcr & E1000_GCR_CAP_VER2)) {
>> +??????? gcr |= E1000_GCR_CMPL_TMOUT_10ms;
>> +??????? goto out;
>> +??? }
>> +
>> +??? /* for version 2 capabilities we need to write the config space
>> +???? * directly in order to set the completion timeout value for
>> +???? * 16ms to 55ms
>> +???? */
>> +??? ret_val = igc_read_pcie_cap_reg(hw, PCIE_DEVICE_CONTROL2,
>> +??????????????????? &pcie_devctl2);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +??? pcie_devctl2 |= PCIE_DEVICE_CONTROL2_16ms;
>> +
>> +??? ret_val = igc_write_pcie_cap_reg(hw, PCIE_DEVICE_CONTROL2,
>> +???????????????????? &pcie_devctl2);
>> +out:
>> +??? /* disable completion timeout resend */
>> +??? gcr &= ~E1000_GCR_CMPL_TMOUT_RESEND;
>> +
>> +??? wr32(E1000_GCR, gcr);
>> +??? return ret_val;
>> +}
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_base.h 
>> b/drivers/net/ethernet/intel/igc/e1000_base.h
>> index 5c766fb7514b..210f1b5f6012 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_base.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_base.h
>> @@ -33,6 +33,8 @@ union e1000_adv_tx_desc {
>> ? #define E1000_ADVTXD_DCMD_TSE??? 0x80000000 /* TCP Seg enable */
>> ? #define E1000_ADVTXD_PAYLEN_SHIFT??? 14 /* Adv desc PAYLEN shift */
>> +#define E1000_RAR_ENTRIES??????? 16
>> +
>> ? struct e1000_adv_data_desc {
>> ????? __le64 buffer_addr;??? /* Address of the descriptor's data 
>> buffer */
>> ????? union {
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h 
>> b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> index f39d93d17ba6..5613806742b1 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> @@ -30,6 +30,22 @@
>> ? #define E1000_PCI_PMCSR??????????? 0x44
>> ? #define E1000_PCI_PMCSR_D3??????? 0x03
>> +/* Physical Func Reset Done Indication */
>> +#define E1000_CTRL_EXT_LINK_MODE_MASK??? 0x00C00000
>> +
>> +/* Number of 100 microseconds we wait for PCI Express master disable */
>> +#define MASTER_DISABLE_TIMEOUT??????? 800
>> +/*Blocks new Master requests */
>> +#define E1000_CTRL_GIO_MASTER_DISABLE??? 0x00000004
>> +/* Status of Master requests. */
>> +#define E1000_STATUS_GIO_MASTER_ENABLE??? 0x00080000
>> +
>> +/* PCI Express Control */
>> +#define E1000_GCR_CMPL_TMOUT_MASK??? 0x0000F000
>> +#define E1000_GCR_CMPL_TMOUT_10ms??? 0x00001000
>> +#define E1000_GCR_CMPL_TMOUT_RESEND??? 0x00010000
>> +#define E1000_GCR_CAP_VER2??????? 0x00040000
>> +
>> ? /* Receive Address
>> ?? * Number of high/low register pairs in the RAR. The RAR (Receive 
>> Address
>> ?? * Registers) holds the directed and multicast addresses that we 
>> monitor.
>> @@ -48,10 +64,26 @@
>> ? #define E1000_ERR_PARAM??????????????? 4
>> ? #define E1000_ERR_MAC_INIT??????????? 5
>> ? #define E1000_ERR_RESET??????????????? 9
>> +#define E1000_ERR_MASTER_REQUESTS_PENDING??? 10
>> +#define E1000_ERR_SWFW_SYNC??????????? 13
>> +
>> +/* Device Control */
>> +#define E1000_CTRL_RST??????? 0x04000000? /* Global reset */
>> ? /* PBA constants */
>> ? #define E1000_PBA_34K??????????? 0x0022
>> +/* SW Semaphore Register */
>> +#define E1000_SWSM_SMBI??????? 0x00000001 /* Driver Semaphore bit */
>> +#define E1000_SWSM_SWESMBI??? 0x00000002 /* FW Semaphore bit */
>> +
>> +/* NVM Control */
>> +#define E1000_EECD_PRES??????? 0x00000100 /* NVM Present */
>> +
>> +/* Number of milliseconds for NVM auto read done after MAC reset. */
>> +#define AUTO_READ_DONE_TIMEOUT??????? 10
>> +#define E1000_EECD_AUTO_RD??? 0x00000200? /* NVM Auto Read done */
>> +
>> ? /* Device Status */
>> ? #define E1000_STATUS_FD??????? 0x00000001????? /* Full 
>> duplex.0=half,1=full */
>> ? #define E1000_STATUS_LU??????? 0x00000002????? /* Link 
>> up.0=no,1=link */
>> @@ -135,6 +167,13 @@
>> ? #define E1000_CT_SHIFT??????????? 4
>> ? #define E1000_COLLISION_THRESHOLD??? 15
>> +/* Flow Control Constants */
>> +#define FLOW_CONTROL_ADDRESS_LOW??? 0x00C28001
>> +#define FLOW_CONTROL_ADDRESS_HIGH??? 0x00000100
>> +#define FLOW_CONTROL_TYPE??????? 0x8808
>> +/* Enable XON frame transmission */
>> +#define E1000_FCRTL_XONE??????? 0x80000000
>> +
>> ? /* Management Control */
>> ? #define E1000_MANC_RCV_TCO_EN??? 0x00020000 /* Receive TCO Packets 
>> Enabled */
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h 
>> b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> index 67fa4f696b98..debeadd61b45 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> @@ -6,6 +6,8 @@
>> ? #include <linux/types.h>
>> ? #include <linux/if_ether.h>
>> +#include <linux/netdevice.h>
>> +
>> ? #include "e1000_regs.h"
>> ? #include "e1000_defines.h"
>> ? #include "e1000_mac.h"
>> @@ -20,6 +22,16 @@ struct e1000_hw;
>> ? /* Function pointers for the MAC. */
>> ? struct e1000_mac_operations {
>> +??? s32 (*check_for_link)(struct e1000_hw *hw);
>> +??? s32 (*reset_hw)(struct e1000_hw *hw);
>> +??? s32 (*init_hw)(struct e1000_hw *hw);
>> +??? s32 (*setup_physical_interface)(struct e1000_hw *hw);
>> +??? void (*rar_set)(struct e1000_hw *hw, u8 *address, u32 index);
>> +??? s32 (*read_mac_addr)(struct e1000_hw *hw);
>> +??? s32 (*get_speed_and_duplex)(struct e1000_hw *hw, u16 *speed,
>> +??????????????????? u16 *duplex);
>> +??? s32 (*acquire_swfw_sync)(struct e1000_hw *hw, u16 mask);
>> +??? void (*release_swfw_sync)(struct e1000_hw *hw, u16 mask);
>> ? };
>> ? enum e1000_mac_type {
>> @@ -34,6 +46,12 @@ enum e1000_phy_type {
>> ????? e1000_phy_i225,
>> ? };
>> +enum e1000_nvm_type {
>> +??? e1000_nvm_unknown = 0,
>> +??? e1000_nvm_flash_hw,
>> +??? e1000_nvm_invm,
>> +};
>> +
>> ? enum e1000_bus_type {
>> ????? e1000_bus_type_unknown = 0,
>> ????? e1000_bus_type_pci_express,
>> @@ -56,6 +74,13 @@ enum e1000_bus_width {
>> ????? e1000_bus_width_reserved
>> ? };
>> +struct e1000_info {
>> +??? s32 (*get_invariants)(struct e1000_hw *hw);
>> +??? struct e1000_mac_operations *mac_ops;
>> +??? const struct e1000_phy_operations *phy_ops;
>> +??? struct e1000_nvm_operations *nvm_ops;
>> +};
>> +
>> ? struct e1000_mac_info {
>> ????? struct e1000_mac_operations ops;
>> @@ -91,6 +116,30 @@ struct e1000_mac_info {
>> ????? bool get_link_status;
>> ? };
>> +struct e1000_nvm_operations {
>> +??? s32 (*acquire)(struct e1000_hw *hw);
>> +??? s32 (*read)(struct e1000_hw *hw, u16 offset, u16 i, u16 *data);
>> +??? void (*release)(struct e1000_hw *hw);
>> +??? s32 (*write)(struct e1000_hw *hw, u16 offset, u16 i, u16 *data);
>> +??? s32 (*update)(struct e1000_hw *hw);
>> +??? s32 (*validate)(struct e1000_hw *hw);
>> +??? s32 (*valid_led_default)(struct e1000_hw *hw, u16 *data);
>> +};
>> +
>> +struct e1000_nvm_info {
>> +??? struct e1000_nvm_operations ops;
>> +??? enum e1000_nvm_type type;
>> +
>> +??? u32 flash_bank_size;
>> +??? u32 flash_base_addr;
>> +
>> +??? u16 word_size;
>> +??? u16 delay_usec;
>> +??? u16 address_bits;
>> +??? u16 opcode_bits;
>> +??? u16 page_size;
>> +};
>> +
>> ? struct e1000_bus_info {
>> ????? enum e1000_bus_type type;
>> ????? enum e1000_bus_speed speed;
>> @@ -100,6 +149,32 @@ struct e1000_bus_info {
>> ????? u16 pci_cmd_word;
>> ? };
>> +enum e1000_fc_mode {
>> +??? e1000_fc_none = 0,
>> +??? e1000_fc_rx_pause,
>> +??? e1000_fc_tx_pause,
>> +??? e1000_fc_full,
>> +??? e1000_fc_default = 0xFF
>> +};
>> +
>> +struct e1000_fc_info {
>> +??? u32 high_water;???? /* Flow control high-water mark */
>> +??? u32 low_water;????? /* Flow control low-water mark */
>> +??? u16 pause_time;???? /* Flow control pause timer */
>> +??? bool send_xon;????? /* Flow control send XON */
>> +??? bool strict_ieee;?? /* Strict IEEE mode */
>> +??? enum e1000_fc_mode current_mode; /* Type of flow control */
>> +??? enum e1000_fc_mode requested_mode;
>> +};
>> +
>> +struct e1000_dev_spec_base {
>> +??? bool global_device_reset;
>> +??? bool eee_disable;
>> +??? bool clear_semaphore_once;
>> +??? bool module_plugged;
>> +??? u8 media_port;
>> +};
>> +
>> ? struct e1000_hw {
>> ????? void *back;
>> @@ -108,9 +183,15 @@ struct e1000_hw {
>> ????? unsigned long io_base;
>> ????? struct e1000_mac_info? mac;
>> +??? struct e1000_fc_info?? fc;
>> +??? struct e1000_nvm_info? nvm;
>> ????? struct e1000_bus_info bus;
>> +??? union {
>> +??????? struct e1000_dev_spec_base??? _base;
>> +??? } dev_spec;
>> +
>> ????? u16 device_id;
>> ????? u16 subsystem_vendor_id;
>> ????? u16 subsystem_device_id;
>> @@ -203,6 +284,10 @@ struct e1000_hw_stats {
>> ????? u64 b2ogprc;
>> ? };
>> +struct net_device *igc_get_hw_dev(struct e1000_hw *hw);
>> +#define hw_dbg(format, arg...) \
>> +??? netdev_dbg(igc_get_hw_dev(hw), format, ##arg)
>> +
>> ? /* These functions must be implemented by drivers */
>> ? s32? igc_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
>> ? s32? igc_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_i225.c 
>> b/drivers/net/ethernet/intel/igc/e1000_i225.c
>> new file mode 100644
>> index 000000000000..11d797c77619
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_i225.c
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#include <linux/delay.h>
>> +
>> +#include "e1000_hw.h"
>> +
>> +/**
>> + *? igc_get_hw_semaphore_i225 - Acquire hardware semaphore
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Acquire the HW semaphore to access the PHY or NVM
>> + */
>> +static s32 igc_get_hw_semaphore_i225(struct e1000_hw *hw)
>> +{
>> +??? u32 swsm;
>> +??? s32 timeout = hw->nvm.word_size + 1;
>> +??? s32 i = 0;
> 
> reverse xmas tree
> 
fix will be applied in v4.
>> +
>> +??? /* Get the SW semaphore */
>> +??? while (i < timeout) {
>> +??????? swsm = rd32(E1000_SWSM);
>> +??????? if (!(swsm & E1000_SWSM_SMBI))
>> +??????????? break;
>> +
>> +??????? usleep_range(500, 600);
>> +??????? i++;
>> +??? }
>> +
>> +??? if (i == timeout) {
>> +??????? /* In rare circumstances, the SW semaphore may already be held
>> +???????? * unintentionally. Clear the semaphore once before giving up.
>> +???????? */
>> +??????? if (hw->dev_spec._base.clear_semaphore_once) {
>> +??????????? hw->dev_spec._base.clear_semaphore_once = false;
>> +??????????? igc_put_hw_semaphore(hw);
>> +??????????? for (i = 0; i < timeout; i++) {
>> +??????????????? swsm = rd32(E1000_SWSM);
>> +??????????????? if (!(swsm & E1000_SWSM_SMBI))
>> +??????????????????? break;
>> +
>> +??????????????? usleep_range(500, 600);
>> +??????????? }
>> +??????? }
>> +
>> +??????? /* If we do not have the semaphore here, we have to give up. */
>> +??????? if (i == timeout) {
>> +??????????? hw_dbg("Driver can't access device - SMBI bit is set.\n");
>> +??????????? return -E1000_ERR_NVM;
>> +??????? }
>> +??? }
>> +
>> +??? /* Get the FW semaphore. */
>> +??? for (i = 0; i < timeout; i++) {
>> +??????? swsm = rd32(E1000_SWSM);
>> +??????? wr32(E1000_SWSM, swsm | E1000_SWSM_SWESMBI);
>> +
>> +??????? /* Semaphore acquired if bit latched */
>> +??????? if (rd32(E1000_SWSM) & E1000_SWSM_SWESMBI)
>> +??????????? break;
>> +
>> +??????? usleep_range(500, 600);
>> +??? }
>> +
>> +??? if (i == timeout) {
>> +??????? /* Release semaphores */
>> +??????? igc_put_hw_semaphore(hw);
>> +??????? hw_dbg("Driver can't access the NVM\n");
>> +??????? return -E1000_ERR_NVM;
>> +??? }
>> +
>> +??? return 0;
>> +}
>> +
>> +/**
>> + *? igc_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
>> + *? @hw: pointer to the HW structure
>> + *? @mask: specifies which semaphore to acquire
>> + *
>> + *? Acquire the SW/FW semaphore to access the PHY or NVM.? The mask
>> + *? will also specify which port we're acquiring the lock for.
>> + **/
>> +s32 igc_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
>> +{
>> +??? u32 swfw_sync;
>> +??? u32 swmask = mask;
>> +??? u32 fwmask = mask << 16;
>> +??? s32 ret_val = 0;
>> +??? s32 i = 0, timeout = 200; /* FIXME: find real value to use here */
>> +
>> +??? while (i < timeout) {
>> +??????? if (igc_get_hw_semaphore_i225(hw)) {
>> +??????????? ret_val = -E1000_ERR_SWFW_SYNC;
>> +??????????? goto out;
>> +??????? }
>> +
>> +??????? swfw_sync = rd32(E1000_SW_FW_SYNC);
>> +??????? if (!(swfw_sync & (fwmask | swmask)))
>> +??????????? break;
>> +
>> +??????? /* Firmware currently using resource (fwmask) */
>> +??????? igc_put_hw_semaphore(hw);
>> +??????? mdelay(5);
>> +??????? i++;
>> +??? }
>> +
>> +??? if (i == timeout) {
>> +??????? hw_dbg("Driver can't access resource, SW_FW_SYNC timeout.\n");
>> +??????? ret_val = -E1000_ERR_SWFW_SYNC;
>> +??????? goto out;
>> +??? }
>> +
>> +??? swfw_sync |= swmask;
>> +??? wr32(E1000_SW_FW_SYNC, swfw_sync);
>> +
>> +??? igc_put_hw_semaphore(hw);
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_release_swfw_sync_i225 - Release SW/FW semaphore
>> + *? @hw: pointer to the HW structure
>> + *? @mask: specifies which semaphore to acquire
>> + *
>> + *? Release the SW/FW semaphore used to access the PHY or NVM.? The mask
>> + *? will also specify which port we're releasing the lock for.
>> + **/
>> +void igc_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
>> +{
>> +??? u32 swfw_sync;
>> +
>> +??? while (igc_get_hw_semaphore_i225(hw))
>> +??????? ; /* Empty */
> 
> This loop needs a bounding condition
> 
I prefer keep and be alight with another drivers. Any benefit if we will 
change?
>> +
>> +??? swfw_sync = rd32(E1000_SW_FW_SYNC);
>> +??? swfw_sync &= ~mask;
>> +??? wr32(E1000_SW_FW_SYNC, swfw_sync);
>> +
>> +??? igc_put_hw_semaphore(hw);
>> +}
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.c 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> index c38435bb8a8c..27e478a9854c 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_mac.c
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> @@ -2,8 +2,15 @@
>> ? /* Copyright (c)? 2018 Intel Corporation */
>> ? #include <linux/pci.h>
>> +#include <linux/delay.h>
>> +
>> +#include "e1000_mac.h"
>> ? #include "e1000_hw.h"
>> +/* forward declaration */
>> +static s32 igc_set_default_fc(struct e1000_hw *hw);
>> +static s32 igc_set_fc_watermarks(struct e1000_hw *hw);
>> +
>> ? /**
>> ?? *? igc_get_bus_info_pcie - Get PCIe bus information
>> ?? *? @hw: pointer to the HW structure
>> @@ -49,3 +56,316 @@ s32 igc_get_bus_info_pcie(struct e1000_hw *hw)
>> ????? return 0;
>> ? }
>> +
>> +/**
>> + *? igc_disable_pcie_master - Disables PCI-express master access
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Returns 0 (0) if successful, else returns -10
>> + *? (-E1000_ERR_MASTER_REQUESTS_PENDING) if master disable bit has 
>> not caused
>> + *? the master requests to be disabled.
>> + *
>> + *? Disables PCI-Express master access and verifies there are no pending
>> + *? requests.
>> + **/
>> +s32 igc_disable_pcie_master(struct e1000_hw *hw)
>> +{
>> +??? u32 ctrl;
>> +??? s32 timeout = MASTER_DISABLE_TIMEOUT;
>> +??? s32 ret_val = 0;
>> +
>> +??? if (hw->bus.type != e1000_bus_type_pci_express)
>> +??????? goto out;
>> +
>> +??? ctrl = rd32(E1000_CTRL);
>> +??? ctrl |= E1000_CTRL_GIO_MASTER_DISABLE;
>> +??? wr32(E1000_CTRL, ctrl);
>> +
>> +??? while (timeout) {
>> +??????? if (!(rd32(E1000_STATUS) &
>> +??????????? E1000_STATUS_GIO_MASTER_ENABLE))
>> +??????????? break;
>> +??????? usleep_range(2000, 3000);
>> +??????? timeout--;
>> +??? }
>> +
>> +??? if (!timeout) {
>> +??????? hw_dbg("Master requests are pending.\n");
>> +??????? ret_val = -E1000_ERR_MASTER_REQUESTS_PENDING;
>> +??????? goto out;
>> +??? }
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_init_rx_addrs - Initialize receive address's
> 
> s/address's/addresses/
> 
fix will be applied in v4.
>> + *? @hw: pointer to the HW structure
>> + *? @rar_count: receive address registers
>> + *
>> + *? Setups the receive address registers by setting the base receive 
>> address
> 
> s/Setups/Setup/
> 
fix will be applied in v4.
>> + *? register to the devices MAC address and clearing all the other 
>> receive
>> + *? address registers to 0.
>> + **/
>> +void igc_init_rx_addrs(struct e1000_hw *hw, u16 rar_count)
>> +{
>> +??? u32 i;
>> +??? u8 mac_addr[ETH_ALEN] = {0};
>> +
>> +??? /* Setup the receive address */
>> +??? hw_dbg("Programming MAC Address into RAR[0]\n");
>> +
>> +??? hw->mac.ops.rar_set(hw, hw->mac.addr, 0);
>> +
>> +??? /* Zero out the other (rar_entry_count - 1) receive addresses */
>> +??? hw_dbg("Clearing RAR[1-%u]\n", rar_count - 1);
>> +??? for (i = 1; i < rar_count; i++)
>> +??????? hw->mac.ops.rar_set(hw, mac_addr, i);
>> +}
>> +
>> +/**
>> + *? igc_setup_link - Setup flow control and link settings
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Determines which flow control settings to use, then configures flow
>> + *? control.? Calls the appropriate media-specific link configuration
>> + *? function.? Assuming the adapter has a valid link partner, a valid 
>> link
>> + *? should be established.? Assumes the hardware has previously been 
>> reset
>> + *? and the transmitter and receiver are not enabled.
>> + **/
>> +s32 igc_setup_link(struct e1000_hw *hw)
>> +{
>> +??? s32 ret_val = 0;
>> +
>> +??? /* In the case of the phy reset being blocked, we already have a 
>> link.
>> +???? * We do not need to set it up again.
>> +???? */
>> +
>> +??? /* If requested flow control is set to default, set flow control
>> +???? * based on the EEPROM flow control settings.
>> +???? */
>> +??? if (hw->fc.requested_mode == e1000_fc_default) {
>> +??????? ret_val = igc_set_default_fc(hw);
>> +??????? if (ret_val)
>> +??????????? goto out;
>> +??? }
>> +
>> +??? /* We want to save off the original Flow Control configuration just
>> +???? * in case we get disconnected and then reconnected into a different
>> +???? * hub or switch with different Flow Control capabilities.
>> +???? */
>> +??? hw->fc.current_mode = hw->fc.requested_mode;
>> +
>> +??? hw_dbg("After fix-ups FlowControl is now = %x\n", 
>> hw->fc.current_mode);
>> +
>> +??? /* Call the necessary media_type subroutine to configure the 
>> link. */
>> +??? ret_val = hw->mac.ops.setup_physical_interface(hw);
>> +??? if (ret_val)
>> +??????? goto out;
>> +
>> +??? /* Initialize the flow control address, type, and PAUSE timer
>> +???? * registers to their default values.? This is done even if flow
>> +???? * control is disabled, because it does not hurt anything to
>> +???? * initialize these registers.
>> +???? */
>> +??? hw_dbg("Initializing the Flow Control address, type and timer 
>> regs\n");
>> +??? wr32(E1000_FCT, FLOW_CONTROL_TYPE);
>> +??? wr32(E1000_FCAH, FLOW_CONTROL_ADDRESS_HIGH);
>> +??? wr32(E1000_FCAL, FLOW_CONTROL_ADDRESS_LOW);
>> +
>> +??? wr32(E1000_FCTTV, hw->fc.pause_time);
>> +
>> +??? ret_val = igc_set_fc_watermarks(hw);
>> +
>> +out:
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_set_default_fc - Set flow control default values
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Read the EEPROM for the default values for flow control and store 
>> the
>> + *? values.
>> + **/
>> +static s32 igc_set_default_fc(struct e1000_hw *hw)
>> +{
>> +??? return 0;
>> +}
>> +
>> +/**
>> + *? igc_set_fc_watermarks - Set flow control high/low watermarks
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Sets the flow control high/low threshold (watermark) registers.? If
>> + *? flow control XON frame transmission is enabled, then set XON frame
>> + *? tansmission as well.
> 
> s/tansmission/transmission/
> 
fix will be applied in v4.
>> + **/
>> +static s32 igc_set_fc_watermarks(struct e1000_hw *hw)
>> +{
>> +??? s32 ret_val = 0;
>> +??? u32 fcrtl = 0, fcrth = 0;
>> +
>> +??? /* Set the flow control receive threshold registers.? Normally,
>> +???? * these registers will be set to a default threshold that may be
>> +???? * adjusted later by the driver's runtime code.? However, if the
>> +???? * ability to transmit pause frames is not enabled, then these
>> +???? * registers will be set to 0.
>> +???? */
>> +??? if (hw->fc.current_mode & e1000_fc_tx_pause) {
>> +??????? /* We need to set up the Receive Threshold high and low water
>> +???????? * marks as well as (optionally) enabling the transmission of
>> +???????? * XON frames.
>> +???????? */
>> +??????? fcrtl = hw->fc.low_water;
>> +??????? if (hw->fc.send_xon)
>> +??????????? fcrtl |= E1000_FCRTL_XONE;
>> +
>> +??????? fcrth = hw->fc.high_water;
>> +??? }
>> +??? wr32(E1000_FCRTL, fcrtl);
>> +??? wr32(E1000_FCRTH, fcrth);
>> +
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_clear_hw_cntrs_base - Clear base hardware counters
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Clears the base hardware counters by reading the counter registers.
>> + **/
>> +void igc_clear_hw_cntrs_base(struct e1000_hw *hw)
>> +{
>> +??? rd32(E1000_CRCERRS);
>> +??? rd32(E1000_SYMERRS);
>> +??? rd32(E1000_MPC);
>> +??? rd32(E1000_SCC);
>> +??? rd32(E1000_ECOL);
>> +??? rd32(E1000_MCC);
>> +??? rd32(E1000_LATECOL);
>> +??? rd32(E1000_COLC);
>> +??? rd32(E1000_DC);
>> +??? rd32(E1000_SEC);
>> +??? rd32(E1000_RLEC);
>> +??? rd32(E1000_XONRXC);
>> +??? rd32(E1000_XONTXC);
>> +??? rd32(E1000_XOFFRXC);
>> +??? rd32(E1000_XOFFTXC);
>> +??? rd32(E1000_FCRUC);
>> +??? rd32(E1000_GPRC);
>> +??? rd32(E1000_BPRC);
>> +??? rd32(E1000_MPRC);
>> +??? rd32(E1000_GPTC);
>> +??? rd32(E1000_GORCL);
>> +??? rd32(E1000_GORCH);
>> +??? rd32(E1000_GOTCL);
>> +??? rd32(E1000_GOTCH);
>> +??? rd32(E1000_RNBC);
>> +??? rd32(E1000_RUC);
>> +??? rd32(E1000_RFC);
>> +??? rd32(E1000_ROC);
>> +??? rd32(E1000_RJC);
>> +??? rd32(E1000_TORL);
>> +??? rd32(E1000_TORH);
>> +??? rd32(E1000_TOTL);
>> +??? rd32(E1000_TOTH);
>> +??? rd32(E1000_TPR);
>> +??? rd32(E1000_TPT);
>> +??? rd32(E1000_MPTC);
>> +??? rd32(E1000_BPTC);
>> +
>> +??? rd32(E1000_PRC64);
>> +??? rd32(E1000_PRC127);
>> +??? rd32(E1000_PRC255);
>> +??? rd32(E1000_PRC511);
>> +??? rd32(E1000_PRC1023);
>> +??? rd32(E1000_PRC1522);
>> +??? rd32(E1000_PTC64);
>> +??? rd32(E1000_PTC127);
>> +??? rd32(E1000_PTC255);
>> +??? rd32(E1000_PTC511);
>> +??? rd32(E1000_PTC1023);
>> +??? rd32(E1000_PTC1522);
>> +
>> +??? rd32(E1000_ALGNERRC);
>> +??? rd32(E1000_RXERRC);
>> +??? rd32(E1000_TNCRS);
>> +??? rd32(E1000_CEXTERR);
>> +??? rd32(E1000_TSCTC);
>> +??? rd32(E1000_TSCTFC);
>> +
>> +??? rd32(E1000_MGTPRC);
>> +??? rd32(E1000_MGTPDC);
>> +??? rd32(E1000_MGTPTC);
>> +
>> +??? rd32(E1000_IAC);
>> +??? rd32(E1000_ICRXOC);
>> +
>> +??? rd32(E1000_ICRXPTC);
>> +??? rd32(E1000_ICRXATC);
>> +??? rd32(E1000_ICTXPTC);
>> +??? rd32(E1000_ICTXATC);
>> +??? rd32(E1000_ICTXQEC);
>> +??? rd32(E1000_ICTXQMTC);
>> +??? rd32(E1000_ICRXDMTC);
>> +
>> +??? rd32(E1000_CBTMPC);
>> +??? rd32(E1000_HTDPMC);
>> +??? rd32(E1000_CBRMPC);
>> +??? rd32(E1000_RPTHC);
>> +??? rd32(E1000_HGPTC);
>> +??? rd32(E1000_HTCBDPC);
>> +??? rd32(E1000_HGORCL);
>> +??? rd32(E1000_HGORCH);
>> +??? rd32(E1000_HGOTCL);
>> +??? rd32(E1000_HGOTCH);
>> +??? rd32(E1000_LENERRS);
>> +}
>> +
>> +/**
>> + *? igc_get_auto_rd_done - Check for auto read completion
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Check EEPROM for Auto Read done bit.
>> + **/
>> +s32 igc_get_auto_rd_done(struct e1000_hw *hw)
>> +{
>> +??? s32 i = 0;
>> +??? s32 ret_val = 0;
>> +
>> +??? while (i < AUTO_READ_DONE_TIMEOUT) {
>> +??????? if (rd32(E1000_EECD) & E1000_EECD_AUTO_RD)
>> +??????????? break;
>> +??????? usleep_range(1000, 2000);
>> +??????? i++;
>> +??? }
>> +
>> +??? if (i == AUTO_READ_DONE_TIMEOUT) {
>> +??????? hw_dbg("Auto read by HW from NVM has not completed.\n");
>> +??????? ret_val = -E1000_ERR_RESET;
>> +??????? goto out;
>> +??? }
>> +
>> +out:
>> +??? return ret_val;
>> +}
>> +
>> +/**
>> + *? igc_put_hw_semaphore - Release hardware semaphore
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Release hardware semaphore used to access the PHY or NVM
>> + **/
>> +void igc_put_hw_semaphore(struct e1000_hw *hw)
>> +{
>> +??? u32 swsm;
>> +
>> +??? swsm = rd32(E1000_SWSM);
>> +
>> +??? swsm &= ~(E1000_SWSM_SMBI | E1000_SWSM_SWESMBI);
>> +
>> +??? wr32(E1000_SWSM, swsm);
>> +}
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.h 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> index afb0f7b28222..2f8dbf17800a 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_mac.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> @@ -4,10 +4,21 @@
>> ? #ifndef _E1000_MAC_H_
>> ? #define _E1000_MAC_H_
>> +#include "e1000_hw.h"
>> +#include "e1000_defines.h"
>> +
>> ? #ifndef E1000_REMOVED
>> ? #define E1000_REMOVED(a) (0)
>> ? #endif /* E1000_REMOVED */
>> -s32 igc_get_bus_info_pcie(struct e1000_hw *hw);
>> +/* forward declaration */
>> +s32? igc_disable_pcie_master(struct e1000_hw *hw);
>> +void igc_init_rx_addrs(struct e1000_hw *hw, u16 rar_count);
>> +s32? igc_setup_link(struct e1000_hw *hw);
>> +void igc_clear_hw_cntrs_base(struct e1000_hw *hw);
>> +s32 igc_get_auto_rd_done(struct e1000_hw *hw);
>> +void igc_put_hw_semaphore(struct e1000_hw *hw);
>> +
>> +s32? igc_get_bus_info_pcie(struct e1000_hw *hw);
>> ? #endif
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_regs.h 
>> b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> index dcc4d89c9933..66d5c757dae8 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_regs.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> @@ -7,6 +7,7 @@
>> ? /* General Register Descriptions */
>> ? #define E1000_CTRL??????? 0x00000? /* Device Control - RW */
>> ? #define E1000_STATUS??????? 0x00008? /* Device Status - RO */
>> +#define E1000_EECD??????? 0x00010? /* EEPROM/Flash Control - RW */
>> ? #define E1000_CTRL_EXT??????? 0x00018? /* Extended Device Control - 
>> RW */
>> ? #define E1000_MDIC??????? 0x00020? /* MDI Control - RW */
>> ? #define E1000_MDICNFG??????? 0x00E04? /* MDC/MDIO Configuration - RW */
>> @@ -75,6 +76,30 @@
>> ? #define E1000_IVAR_MISC??????? 0x01740?? /* IVAR for "other" causes 
>> - RW */
>> ? #define E1000_GPIE??????? 0x01514? /* General Purpose Intr Enable - 
>> RW */
>> +/* Interrupt Cause Rx Packet Timer Expire Count */
>> +#define E1000_ICRXPTC??????? 0x04104
>> +/* Interrupt Cause Rx Absolute Timer Expire Count */
>> +#define E1000_ICRXATC??????? 0x04108
>> +/* Interrupt Cause Tx Packet Timer Expire Count */
>> +#define E1000_ICTXPTC??????? 0x0410C
>> +/* Interrupt Cause Tx Absolute Timer Expire Count */
>> +#define E1000_ICTXATC??????? 0x04110
>> +/* Interrupt Cause Tx Queue Empty Count */
>> +#define E1000_ICTXQEC??????? 0x04118
>> +/* Interrupt Cause Tx Queue Minimum Threshold Count */
>> +#define E1000_ICTXQMTC??????? 0x0411C
>> +/* Interrupt Cause Rx Descriptor Minimum Threshold Count */
>> +#define E1000_ICRXDMTC??????? 0x04120
>> +/* Interrupt Cause Receiver Overrun Count */
>> +#define E1000_ICRXOC??????? 0x04124
> 
> These comments intersperced make the #defines hard to read - putting 
> them off to the side would help a lot.
> 
Good. fix will be applied in v4.
>> +
>> +#define E1000_CBTMPC??????? 0x0402C? /* Circuit Breaker TX Packet 
>> Count */
>> +#define E1000_HTDPMC??????? 0x0403C? /* Host Transmit Discarded 
>> Packets */
>> +#define E1000_CBRMPC??????? 0x040FC? /* Circuit Breaker RX Packet 
>> Count */
>> +#define E1000_RPTHC??????? 0x04104? /* Rx Packets To Host */
>> +#define E1000_HGPTC??????? 0x04118? /* Host Good Packets TX Count */
>> +#define E1000_HTCBDPC??????? 0x04124? /* Host TX Circ.Breaker Drop 
>> Count */
>> +
>> ? /* MSI-X Table Register Descriptions */
>> ? #define E1000_PBACL??????? 0x05B68? /* MSIx PBA Clear - R/W 1 to 
>> clear */
>> @@ -92,6 +117,8 @@
>> ? #define E1000_RXCSUM??????? 0x05000? /* Rx Checksum Control - RW */
>> ? #define E1000_RLPML??????? 0x05004? /* Rx Long Packet Max Length */
>> ? #define E1000_RFCTL??????? 0x05008? /* Receive Filter Control*/
>> +#define E1000_MTA??????? 0x05200? /* Multicast Table Array - RW Array */
>> +#define E1000_UTA??????? 0x0A000 /* Unicast Table Array - RW */
>> ? #define E1000_RAL(_n)??????? (0x05400 + ((_n) * 0x08))
>> ? #define E1000_RAH(_n)??????? (0x05404 + ((_n) * 0x08))
>> ? #define E1000_VLAPQF??????? 0x055B0? /* VLAN Priority Queuue - RW */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 67826041eb3c..9a99c7d68796 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -86,6 +86,14 @@ enum latency_range {
>> ? void igc_reset(struct igc_adapter *adapter)
>> ? {
>> +??? struct pci_dev *pdev = adapter->pdev;
>> +??? struct e1000_hw *hw = &adapter->hw;
>> +
>> +??? hw->mac.ops.reset_hw(hw);
>> +
>> +??? if (hw->mac.ops.init_hw(hw))
>> +??????? dev_err(&pdev->dev, "Hardware Error\n");
> 
> Is there something more specific that can be said here, including 
> something about it being the init that failed?
> 
No. Let's keep it as default. I consider extend this message when I will 
more logic to the driver.
>> +
>> ????? if (!netif_running(adapter->netdev))
>> ????????? igc_power_down_link(adapter);
>> ? }
>> @@ -3621,6 +3629,19 @@ static void igc_nfc_filter_exit(struct 
>> igc_adapter *adapter)
>> ? }
>> ? /**
>> + *? igc_get_hw_dev - return device
>> + *? @hw: pointer to hardware structure
>> + *
>> + *? used by hardware layer to print debugging information
>> + **/
>> +struct net_device *igc_get_hw_dev(struct e1000_hw *hw)
>> +{
>> +??? struct igc_adapter *adapter = hw->back;
>> +
>> +??? return adapter->netdev;
> 
> I think this can either become a #define or an inline in a .h file
> 
Declared in .h Move it will cause to mess. What is benefit move it?
>> +}
>> +
>> +/**
>> ?? *? igc_init_module - Driver Registration Routine
>> ?? *
>> ?? *? igc_init_module is the first routine called when the driver is
>>
Thanks for your comments.
