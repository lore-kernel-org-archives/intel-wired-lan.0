From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 2 Jul 2018 11:57:29 +0300
Subject: [Intel-wired-lan] [PATCH v3 02/11] igc: Add support for PF
In-Reply-To: <63d4f9f3-d9c7-64f2-9256-fca93e8383e7@oracle.com>
References: <20180624084500.10021-1-sasha.neftin@intel.com>
 <63d4f9f3-d9c7-64f2-9256-fca93e8383e7@oracle.com>
Message-ID: <70f27bbc-676f-1583-c0e5-e6d9ebc72592@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/27/2018 03:32, Shannon Nelson wrote:
> On 6/24/2018 1:45 AM, Sasha Neftin wrote:
>> This patch adds the basic defines and structures needed by the PF for
>> operation.
> 
> No need for new paragraph here
> 
good. remove in v4.
>> With this it is possible to bring up the interface, but without being
>> able to configure any of the filters on the interface itself.
>> Add skeletal for a function pointers.
> 
> s/skeletal/skeleton/
> 
good. fixed in v4
>>
>> Sasha Neftin (v2):
>> added description
>> fixed code indentation
>>
>> Sasha Neftin (v3):
>> squash patches, clean code and remove unused values
>> remove duplication
>>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/Makefile??????? |?? 2 +-
>> ? drivers/net/ethernet/intel/igc/e1000_defines.h |? 50 +++++
>> ? drivers/net/ethernet/intel/igc/e1000_hw.h????? | 116 ++++++++++++
>> ? drivers/net/ethernet/intel/igc/e1000_i225.h??? |? 10 +
>> ? drivers/net/ethernet/intel/igc/e1000_mac.c???? |? 51 +++++
>> ? drivers/net/ethernet/intel/igc/e1000_mac.h???? |? 13 ++
>> ? drivers/net/ethernet/intel/igc/e1000_regs.h??? | 253 
>> +++++++++++++++++++++++++
> 
> ugh... please use igc, not e1000
> 
I keep consistenly definition. I will consult about it.
>> ? drivers/net/ethernet/intel/igc/igc.h?????????? |? 13 ++
>> ? drivers/net/ethernet/intel/igc/igc_main.c????? | 101 ++++++++++
>> ? 9 files changed, 608 insertions(+), 1 deletion(-)
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_defines.h
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_i225.h
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_mac.c
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_mac.h
>> ? create mode 100644 drivers/net/ethernet/intel/igc/e1000_regs.h
>>
>> diff --git a/drivers/net/ethernet/intel/igc/Makefile 
>> b/drivers/net/ethernet/intel/igc/Makefile
>> index 3d13b015d401..4563b83cd4e0 100644
>> --- a/drivers/net/ethernet/intel/igc/Makefile
>> +++ b/drivers/net/ethernet/intel/igc/Makefile
>> @@ -7,4 +7,4 @@
>> ? obj-$(CONFIG_IGC) += igc.o
>> -igc-objs := igc_main.o
>> +igc-objs := igc_main.o e1000_mac.o
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_defines.h 
>> b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> new file mode 100644
>> index 000000000000..6831a0864bb4
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_defines.h
>> @@ -0,0 +1,50 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#ifndef _E1000_DEFINES_H_
>> +#define _E1000_DEFINES_H_
>> +
>> +#define E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES??? 0x00C00000
>> +/* Priority on PCI. 0=rx,1=fair */
>> +#define E1000_CTRL_PRIOR??????????? 0x00000004
>> +/* PCI Function Mask */
>> +#define E1000_STATUS_FUNC_MASK??????????? 0x0000000C
>> +#define E1000_EXTCNF_SIZE_EXT_PCIE_LENGTH_MASK??? 0x00FF0000
>> +#define E1000_EXTCNF_SIZE_EXT_PCIE_LENGTH_SHIFT??? 16
>> +
>> +/* PCI Bus Info */
>> +#define PCI_HEADER_TYPE_REGISTER??? 0x0E
> 
> If these are specific to igc, why no IGC_ prefix?
> 
>> +#define PCIE_LINK_STATUS??????? 0x12
>> +#define PCIE_DEVICE_CONTROL2??????? 0x28
>> +#define PCIE_LINK_WIDTH_MASK??????? 0x3F0
>> +#define PCIE_LINK_WIDTH_SHIFT??????? 4
>> +#define PCIE_LINK_SPEED_MASK??????? 0x0F
>> +#define PCIE_LINK_SPEED_2500??????? 0x01
>> +#define PCIE_LINK_SPEED_5000??????? 0x02
> 
> How do these relate to the PCIE_SPEED defines in include/linux/pci.h?
> 
Ah... good point. No relate. I will go over and clean this code. Applied 
to v4.
>> +#define PCIE_DEVICE_CONTROL2_16ms??? 0x0005
>> +
>> +/* Lx when no PCIe transactions */
>> +#define E1000_PCIEMISC_LX_DECISION??? 0x00000080
>> +#define E1000_PCI_PMCSR??????????? 0x44
>> +#define E1000_PCI_PMCSR_D3??????? 0x03
>> +
>> +/* Error Codes */
>> +#define E1000_SUCCESS??????????????? 0
>> +#define E1000_ERR_NVM??????????????? 1
>> +#define E1000_ERR_PHY??????????????? 2
>> +#define E1000_ERR_CONFIG??????????? 3
>> +#define E1000_ERR_PARAM??????????????? 4
>> +#define E1000_ERR_MAC_INIT??????????? 5
>> +#define E1000_ERR_RESET??????????????? 9
>> +
>> +/* Device Status */
>> +#define E1000_STATUS_FD??????? 0x00000001????? /* Full 
>> duplex.0=half,1=full */
>> +#define E1000_STATUS_LU??????? 0x00000002????? /* Link up.0=no,1=link */
>> +#define E1000_STATUS_FUNC_MASK??? 0x0000000C????? /* PCI Function 
>> Mask */
>> +#define E1000_STATUS_FUNC_SHIFT??? 2
>> +#define E1000_STATUS_FUNC_1??? 0x00000004????? /* Function 1 */
>> +#define E1000_STATUS_TXOFF??? 0x00000010????? /* transmission paused */
>> +#define E1000_STATUS_SPEED_100??? 0x00000040????? /* Speed 100Mb/s */
>> +#define E1000_STATUS_SPEED_1000??? 0x00000080????? /* Speed 1000Mb/s */
>> +
>> +#endif /* _E1000_DEFINES_H_ */
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_hw.h 
>> b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> index 677f40c2c0a4..b8f82f4ba998 100644
>> --- a/drivers/net/ethernet/intel/igc/e1000_hw.h
>> +++ b/drivers/net/ethernet/intel/igc/e1000_hw.h
>> @@ -4,7 +4,123 @@
>> ? #ifndef _E1000_HW_H_
>> ? #define _E1000_HW_H_
>> +#include <linux/types.h>
>> +#include <linux/if_ether.h>
>> +#include "e1000_regs.h"
>> +#include "e1000_defines.h"
>> +#include "e1000_mac.h"
>> +#include "e1000_i225.h"
>> +
>> ? #define E1000_DEV_ID_I225_LM??????????? 0x15F2
>> ? #define E1000_DEV_ID_I225_V??????????? 0x15F3
>> +/* Forward declaration */
>> +struct e1000_hw;
>> +
>> +/* Function pointers for the MAC. */
>> +struct e1000_mac_operations {
>> +};
> 
> Here's a handy vi command for you
> :%s/e1000/igc/g
> 
>> +
>> +enum e1000_mac_type {
>> +??? e1000_undefined = 0,
>> +??? e1000_i225,
>> +??? e1000_num_macs? /* List is 1-based, so subtract 1 for true count. */
>> +};
>> +
>> +enum e1000_phy_type {
>> +??? e1000_phy_unknown = 0,
>> +??? e1000_phy_none,
>> +??? e1000_phy_i225,
>> +};
>> +
>> +enum e1000_bus_type {
>> +??? e1000_bus_type_unknown = 0,
>> +??? e1000_bus_type_pci_express,
>> +??? e1000_bus_type_reserved
>> +};
>> +
>> +enum e1000_bus_speed {
>> +??? e1000_bus_speed_unknown = 0,
>> +??? e1000_bus_speed_2500,
>> +??? e1000_bus_speed_5000,
>> +??? e1000_bus_speed_reserved
>> +};
>> +
>> +enum e1000_bus_width {
>> +??? e1000_bus_width_unknown = 0,
>> +??? e1000_bus_width_pcie_x1,
>> +??? e1000_bus_width_pcie_x2,
> 
> You may as well stick the "= 1" and "= 2" on these if you are expecting 
> specific values.
> 
good. applied to v4.
>> +??? e1000_bus_width_pcie_x4 = 4,
>> +??? e1000_bus_width_pcie_x8 = 8,
>> +??? e1000_bus_width_reserved
>> +};
>> +
>> +struct e1000_mac_info {
>> +??? struct e1000_mac_operations ops;
>> +
>> +??? u8 addr[ETH_ALEN];
>> +??? u8 perm_addr[ETH_ALEN];
>> +
>> +??? enum e1000_mac_type type;
>> +
>> +??? u32 collision_delta;
>> +??? u32 ledctl_default;
>> +??? u32 ledctl_mode1;
>> +??? u32 ledctl_mode2;
>> +??? u32 mc_filter_type;
>> +??? u32 tx_packet_delta;
>> +??? u32 txcw;
>> +
>> +??? u16 mta_reg_count;
>> +??? u16 uta_reg_count;
>> +
>> +??? /* Maximum size of the MTA register table in all supported 
>> adapters */
>> +#define MAX_MTA_REG 128
> 
> Why is this #define not in igc_hw.h?
> 
Good point, thanks. I believe even not in use. I will clean code. 
applied to v4.
>> +??? u32 mta_shadow[MAX_MTA_REG];
>> +??? u16 rar_entry_count;
>> +
>> +??? u8? forced_speed_duplex;
>> +
>> +??? bool adaptive_ifs;
>> +??? bool has_fwsm;
>> +??? bool arc_subsystem_valid;
>> +
>> +??? bool autoneg;
>> +??? bool autoneg_failed;
>> +};
>> +
>> +struct e1000_bus_info {
>> +??? enum e1000_bus_type type;
>> +??? enum e1000_bus_speed speed;
>> +??? enum e1000_bus_width width;
>> +
>> +??? u16 func;
>> +??? u16 pci_cmd_word;
>> +};
>> +
>> +struct e1000_hw {
>> +??? void *back;
>> +
>> +??? u8 *hw_addr;
>> +??? u8 *flash_address;
>> +??? unsigned long io_base;
>> +
>> +??? struct e1000_mac_info? mac;
>> +
>> +??? struct e1000_bus_info bus;
>> +
>> +??? u16 device_id;
>> +??? u16 subsystem_vendor_id;
>> +??? u16 subsystem_device_id;
>> +??? u16 vendor_id;
>> +
>> +??? u8? revision_id;
>> +};
>> +
>> +/* These functions must be implemented by drivers */
>> +s32? igc_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
>> +s32? igc_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value);
>> +void igc_read_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value);
>> +void igc_write_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value);
>> +
>> ? #endif /* _E1000_HW_H_ */
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_i225.h 
>> b/drivers/net/ethernet/intel/igc/e1000_i225.h
>> new file mode 100644
>> index 000000000000..749a50c34534
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_i225.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#ifndef _E1000_I225_H_
>> +#define _E1000_I225_H_
>> +
>> +s32 igc_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
>> +void igc_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.c 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> new file mode 100644
>> index 000000000000..c38435bb8a8c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.c
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#include <linux/pci.h>
>> +#include "e1000_hw.h"
>> +
>> +/**
>> + *? igc_get_bus_info_pcie - Get PCIe bus information
>> + *? @hw: pointer to the HW structure
>> + *
>> + *? Determines and stores the system bus information for a particular
>> + *? network interface.? The following bus information is determined 
>> and stored:
>> + *? bus speed, bus width, type (PCIe), and PCIe function.
>> + **/
>> +s32 igc_get_bus_info_pcie(struct e1000_hw *hw)
>> +{
>> +??? struct e1000_bus_info *bus = &hw->bus;
>> +??? u16 pcie_link_status;
>> +??? s32 ret_val;
>> +??? u32 reg = 0;
>> +
>> +??? bus->type = e1000_bus_type_pci_express;
>> +
>> +??? ret_val = igc_read_pcie_cap_reg(hw, PCI_EXP_LNKSTA,
>> +??????????????????? &pcie_link_status);
>> +??? if (ret_val) {
>> +??????? bus->width = e1000_bus_width_unknown;
>> +??????? bus->speed = e1000_bus_speed_unknown;
>> +??? } else {
>> +??????? switch (pcie_link_status & PCI_EXP_LNKSTA_CLS) {
>> +??????? case PCI_EXP_LNKSTA_CLS_2_5GB:
>> +??????????? bus->speed = e1000_bus_speed_2500;
>> +??????????? break;
>> +??????? case PCI_EXP_LNKSTA_CLS_5_0GB:
>> +??????????? bus->speed = e1000_bus_speed_5000;
>> +??????????? break;
>> +??????? default:
>> +??????????? bus->speed = e1000_bus_speed_unknown;
>> +??????????? break;
>> +??????? }
>> +
>> +??????? bus->width = (enum e1000_bus_width)((pcie_link_status &
>> +???????????????????????????? PCI_EXP_LNKSTA_NLW) >>
>> +???????????????????????????? PCI_EXP_LNKSTA_NLW_SHIFT);
>> +??? }
>> +
>> +??? reg = rd32(E1000_STATUS);
>> +??? bus->func = (reg & E1000_STATUS_FUNC_MASK) >> 
>> E1000_STATUS_FUNC_SHIFT;
>> +
>> +??? return 0;
>> +}
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_mac.h 
>> b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> new file mode 100644
>> index 000000000000..afb0f7b28222
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_mac.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#ifndef _E1000_MAC_H_
>> +#define _E1000_MAC_H_
>> +
>> +#ifndef E1000_REMOVED
>> +#define E1000_REMOVED(a) (0)
>> +#endif /* E1000_REMOVED */
>> +
>> +s32 igc_get_bus_info_pcie(struct e1000_hw *hw);
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/intel/igc/e1000_regs.h 
>> b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> new file mode 100644
>> index 000000000000..4a1da691f42c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/intel/igc/e1000_regs.h
>> @@ -0,0 +1,253 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c)? 2018 Intel Corporation */
>> +
>> +#ifndef _E1000_REGS_H_
>> +#define _E1000_REGS_H_
>> +
>> +/* General Register Descriptions */
>> +#define E1000_CTRL??????? 0x00000? /* Device Control - RW */
>> +#define E1000_STATUS??????? 0x00008? /* Device Status - RO */
>> +#define E1000_CTRL_EXT??????? 0x00018? /* Extended Device Control - 
>> RW */
>> +#define E1000_MDIC??????? 0x00020? /* MDI Control - RW */
>> +#define E1000_MDICNFG??????? 0x00E04? /* MDC/MDIO Configuration - RW */
>> +#define E1000_PHYSCTRL??????? 0x00E08? /* PHY SERDES control - RW */
>> +#define E1000_CONNSW??????? 0x00034? /* Copper/Fiber switch control - 
>> RW */
>> +#define E1000_VET??????? 0x00038? /* VLAN Ether Type - RW */
>> +#define E1000_UFUSE??????? 0x05B78? /* FUSE register - RO */
>> +#define E1000_LEDCTL??????? 0x00E00? /* LED Control - RW */
>> +
>> +/* Internal Packet Buffer Size Registers */
>> +#define E1000_RXPBS??????? 0x02404? /* Rx Packet Buffer Size - RW */
>> +#define E1000_TXPBS??????? 0x03404? /* Tx Packet Buffer Size - RW */
>> +
>> +/* NVM? Register Descriptions */
>> +#define E1000_EEC??????? 0x12010? /* EEprom Mode control - RW */
>> +#define E1000_EELOADCTL??????? 0x12020? /* EEprom Mode load control - 
>> RO */
>> +#define E1000_EERD??????? 0x12014? /* EEprom mode read - RW */
>> +#define E1000_EELOADCRC??????? 0x00001? /* EEprom load CRC error - RO */
>> +#define E1000_EEWR??????? 0x12018? /* EEprom mode write - RW */
>> +#define E1000_FLA??????? 0x1201C? /* Flash access - RW */
>> +#define E1000_FL_SECU??????? 0x12114? /* Flash security - RO to host */
>> +
>> +/* Flow Control Register Descriptions */
>> +#define E1000_FCAL??????? 0x00028? /* FC Address Low - RW */
>> +#define E1000_FCAH??????? 0x0002C? /* FC Address High - RW */
>> +#define E1000_FCT??????? 0x00030? /* FC Type - RW */
>> +#define E1000_FCTTV??????? 0x00170? /* FC Transmit Timer - RW */
>> +#define E1000_FCRTL??????? 0x02160? /* FC Receive Threshold Low - RW */
>> +#define E1000_FCRTH??????? 0x02168? /* FC Receive Threshold High - RW */
>> +#define E1000_FCRTV??????? 0x02460? /* FC Refresh Timer Value - RW */
>> +#define E1000_FCSTS??????? 0x02464? /* FC Status - RO */
>> +
>> +/* PCIe Register Description */
>> +#define E1000_GCR??????? 0x05B00? /* PCIe control- RW */
>> +#define E1000_GSCL_1??????? 0x05B10? /* PCIe statistics control 1 - 
>> RW */
>> +#define E1000_GSCL_2??????? 0x05B14? /* PCIe statistics control 2 - 
>> RW */
>> +#define E1000_BARCTRL??????? 0x05BFC? /* PCIe BAR ctrl reg */
>> +#define E1000_PCIE_ANA_AD??? 0x05BF8? /* PCIe PHY analog address data 
>> - RW */
>> +#define E1000_PCIEPHYADR??? 0x05B40? /* PCIE PHY address - RW */
>> +#define E1000_PCIEPHYDAT??? 0x05B44? /* PCIE PHY data - RW */
>> +#define E1000_PPHY_CTL??????? 0x05B48? /* PCIE PHY control - RW */
>> +
>> +/* Semaphore registers */
>> +#define E1000_SW_FW_SYNC??? 0x05B5C? /* SW-FW Synchronization - RW */
>> +#define E1000_SWSM??????? 0x05B50? /* SW Semaphore */
>> +#define E1000_FWSM??????? 0x05B54? /* FW Semaphore */
>> +
>> +/* Interrupt Register Description */
>> +#define E1000_PICAUSE??????? 0x05B88? /* PCIe Interrupt Cause - RW1/C */
>> +#define E1000_PIENA??????? 0x05B8C? /* PCIe Interrupt enable - RW */
>> +#define E1000_EICR??????? 0x01580? /* PCIe Ex Interrupt Cause - 
>> RC/W1C */
>> +#define E1000_EICS??????? 0x01520? /* Ext. Interrupt Cause Set - W0 */
>> +#define E1000_EIMS??????? 0x01524? /* Ext. Interrupt Mask Set/Read - 
>> RW */
>> +#define E1000_EIMC??????? 0x01528? /* Ext. Interrupt Mask Clear - WO */
>> +#define E1000_EIAC??????? 0x0152C? /* Ext. Interrupt Auto Clear - RW */
>> +#define E1000_EIAM??????? 0x01530? /* Ext. Interrupt Auto Mask - RW */
>> +#define E1000_ICR??????? 0x01500? /* Intr Cause Read - RC/W1C */
>> +#define E1000_ICS??????? 0x01504? /* Intr Cause Set - WO */
>> +#define E1000_IMS??????? 0x01508? /* Intr Mask Set/Read - RW */
>> +#define E1000_IMC??????? 0x0150C? /* Intr Mask Clear - WO */
>> +#define E1000_IAM??????? 0x01510? /* Intr Ack Auto Mask- RW */
>> +/* Intr Throttle - RW */
>> +#define E1000_EITR(_n)??????? (0x01680 + (0x4 * (_n)))
>> +/* Interrupt Vector Allocation (array) - RW */
>> +#define E1000_IVAR(_n)??????? (0x01700 + (0x4 * (_n)))
>> +#define E1000_IVAR_MISC??????? 0x01740?? /* IVAR for "other" causes - 
>> RW */
>> +#define E1000_GPIE??????? 0x01514? /* General Purpose Intr Enable - 
>> RW */
>> +
>> +/* MSI-X Table Register Descriptions */
>> +#define E1000_PBACL??????? 0x05B68? /* MSIx PBA Clear - R/W 1 to 
>> clear */
>> +
>> +/* Receive Register Descriptions */
>> +#define E1000_RCTL??????? 0x00100? /* Rx Control - RW */
>> +#define E1000_SRRCTL(_n)??? (0x0C00C + ((_n) * 0x40))
>> +#define E1000_PSRTYPE(_i)??? (0x05480 + ((_i) * 4))
>> +#define E1000_RDBAL(_n)??????? (0x0C000 + ((_n) * 0x40))
>> +#define E1000_RDBAH(_n)??????? (0x0C004 + ((_n) * 0x40))
>> +#define E1000_RDLEN(_n)??????? (0x0C008 + ((_n) * 0x40))
>> +#define E1000_RDH(_n)??????? (0x0C010 + ((_n) * 0x40))
>> +#define E1000_RDT(_n)??????? (0x0C018 + ((_n) * 0x40))
>> +#define E1000_RXDCTL(_n)??? (0x0C028 + ((_n) * 0x40))
>> +#define E1000_RQDPC(_n)??????? (0x0C030 + ((_n) * 0x40))
>> +#define E1000_RXCSUM??????? 0x05000? /* Rx Checksum Control - RW */
>> +#define E1000_RLPML??????? 0x05004? /* Rx Long Packet Max Length */
>> +#define E1000_RFCTL??????? 0x05008? /* Receive Filter Control*/
>> +#define E1000_RAL(_n)??????? (0x05400 + ((_n) * 0x08))
>> +#define E1000_RAH(_n)??????? (0x05404 + ((_n) * 0x08))
>> +#define E1000_VLAPQF??????? 0x055B0? /* VLAN Priority Queuue - RW */
>> +#define E1000_VFTA??????? 0x05600? /* VLAN Filter Table Array - RW */
>> +#define E1000_MRQC??????? 0x05818? /* Multiple Receive Control - RW */
>> +#define E1000_RSSRK(_i)??????? (0x05C80 + ((_i) * 4)) /* RSS Rand Key 
>> - RW */
>> +#define E1000_RETA(_i)??????? (0x05C00 + ((_i) * 4)) /* Redirection - 
>> RW */
>> +#define E1000_DVMOLR(_n)??? (0x0C038 + (0x40 * (_n))) /* DMA VM 
>> offload */
>> +#define E1000_DRXMXOD??????? 0x02540? /* DMA Rx max outstanding data 
>> - RW */
>> +#define E1000_IMIR(_i)??????? (0x05A80 + ((_i) * 4))? /* Immediate 
>> Intr */
>> +#define E1000_IMIREXT(_i)??? (0x05AA0 + ((_i) * 4)) /* Immediate INTR 
>> Ext*/
>> +#define E1000_TTQF(_n)??????? (0x059E0 + (4 * (_n))) /* 2-tuple Queue 
>> Fltr */
>> +#define E1000_IMIRVP??????? 0x05AC0 /* Immediate INT Rx VLAN 
>> Priority-RW */
>> +#define E1000_SYNQF(_n)??????? (0x055FC + (4 * (_n))) /* SYN Pack 
>> Queue Ftr */
>> +#define E1000_ETQF(_n)??????? (0x05CB0 + (4 * (_n))) /* EType Queue 
>> Fltr */
>> +
>> +/* Transmit Register Descriptions */
>> +#define E1000_TCTL??????? 0x00400? /* Tx Control - RW */
>> +#define E1000_TCTL_EXT??????? 0x00404? /* Extended Tx Control - RW */
>> +#define E1000_TIPG??????? 0x00410? /* Tx Inter-packet gap - RW */
>> +#define E1000_REXT_CTL??????? 0x0041C? /* Retry buffer control -? RW */
>> +#define E1000_DTXCTL??????? 0x03590? /* DMA Tx Control - RW */
>> +#define E1000_DTXBCTL??????? 0x035A4? /* DMA Tx behaviour control - 
>> RW */
>> +#define E1000_DTXPARSE??????? 0x0350C? /* DMA parsing control - RW */
>> +#define E1000_DTXTCPFLGL??? 0x0359C? /* DMA Tx Control flag low - RW */
>> +#define E1000_DTXTCPFLGH??? 0x035A0? /* DMA Tx Control flag high - RW */
>> +#define E1000_DTXMXSZRQ??????? 0x03540? /* DMA Tx max total allow 
>> size req */
>> +#define E1000_DTXMXPKTSZ??? 0x0355C? /* DMA Tx max packet size i- RW */
>> +#define E1000_TQDPC??????? 0x0E030? /* Tx queue drop packet count - 
>> RW */
>> +#define E1000_TDBAL(_n)??????? (0x0E000 + ((_n) * 0x40))
>> +#define E1000_TDBAH(_n)??????? (0x0E004 + ((_n) * 0x40))
>> +#define E1000_TDLEN(_n)??????? (0x0E008 + ((_n) * 0x40))
>> +#define E1000_TDH(_n)??????? (0x0E010 + ((_n) * 0x40))
>> +#define E1000_TDT(_n)??????? (0x0E018 + ((_n) * 0x40))
>> +#define E1000_TXDCTL(_n)??? (0x0E028 + ((_n) * 0x40))
>> +#define E1000_TDWBAL(_n)??? (0x0E038 + ((_n) * 0x40))
>> +#define E1000_TDWBAH(_n)??? (0x0E03C + ((_n) * 0x40))
>> +
>> +/* MMD Registers Descriptions */
> 
> s/Registers/Register/
> 
good. applied to v4.
>> +#define E1000_MMDAC??????????? 13 /* MMD Access Control */
>> +#define E1000_MMDAAD??????????? 14 /* MMD Access Address/Data */
>> +
>> +/* Good transmitted packets counter registers */
>> +#define E1000_PQGPTC(_n)??????? (0x010014 + (0x100 * (_n)))
>> +
>> +/* Statistics Register Descriptions */
>> +#define E1000_CRCERRS??? 0x04000? /* CRC Error Count - R/clr */
>> +#define E1000_ALGNERRC??? 0x04004? /* Alignment Error Count - R/clr */
>> +#define E1000_SYMERRS??? 0x04008? /* Symbol Error Count - R/clr */
>> +#define E1000_RXERRC??? 0x0400C? /* Receive Error Count - R/clr */
>> +#define E1000_MPC??? 0x04010? /* Missed Packet Count - R/clr */
>> +#define E1000_SCC??? 0x04014? /* Single Collision Count - R/clr */
>> +#define E1000_ECOL??? 0x04018? /* Excessive Collision Count - R/clr */
>> +#define E1000_MCC??? 0x0401C? /* Multiple Collision Count - R/clr */
>> +#define E1000_LATECOL??? 0x04020? /* Late Collision Count - R/clr */
>> +#define E1000_COLC??? 0x04028? /* Collision Count - R/clr */
>> +#define E1000_DC??? 0x04030? /* Defer Count - R/clr */
>> +#define E1000_TNCRS??? 0x04034? /* Tx-No CRS - R/clr */
>> +#define E1000_SEC??? 0x04038? /* Sequence Error Count - R/clr */
>> +#define E1000_CEXTERR??? 0x0403C? /* Carrier Extension Error Count - 
>> R/clr */
>> +#define E1000_RLEC??? 0x04040? /* Receive Length Error Count - R/clr */
>> +#define E1000_XONRXC??? 0x04048? /* XON Rx Count - R/clr */
>> +#define E1000_XONTXC??? 0x0404C? /* XON Tx Count - R/clr */
>> +#define E1000_XOFFRXC??? 0x04050? /* XOFF Rx Count - R/clr */
>> +#define E1000_XOFFTXC??? 0x04054? /* XOFF Tx Count - R/clr */
>> +#define E1000_FCRUC??? 0x04058? /* Flow Control Rx Unsupported Count- 
>> R/clr */
>> +#define E1000_PRC64??? 0x0405C? /* Packets Rx (64 bytes) - R/clr */
>> +#define E1000_PRC127??? 0x04060? /* Packets Rx (65-127 bytes) - R/clr */
>> +#define E1000_PRC255??? 0x04064? /* Packets Rx (128-255 bytes) - 
>> R/clr */
>> +#define E1000_PRC511??? 0x04068? /* Packets Rx (255-511 bytes) - 
>> R/clr */
>> +#define E1000_PRC1023??? 0x0406C? /* Packets Rx (512-1023 bytes) - 
>> R/clr */
>> +#define E1000_PRC1522??? 0x04070? /* Packets Rx (1024-1522 bytes) - 
>> R/clr */
>> +#define E1000_GPRC??? 0x04074? /* Good Packets Rx Count - R/clr */
>> +#define E1000_BPRC??? 0x04078? /* Broadcast Packets Rx Count - R/clr */
>> +#define E1000_MPRC??? 0x0407C? /* Multicast Packets Rx Count - R/clr */
>> +#define E1000_GPTC??? 0x04080? /* Good Packets Tx Count - R/clr */
>> +#define E1000_GORCL??? 0x04088? /* Good Octets Rx Count Low - R/clr */
>> +#define E1000_GORCH??? 0x0408C? /* Good Octets Rx Count High - R/clr */
>> +#define E1000_GOTCL??? 0x04090? /* Good Octets Tx Count Low - R/clr */
>> +#define E1000_GOTCH??? 0x04094? /* Good Octets Tx Count High - R/clr */
>> +#define E1000_RNBC??? 0x040A0? /* Rx No Buffers Count - R/clr */
>> +#define E1000_RUC??? 0x040A4? /* Rx Undersize Count - R/clr */
>> +#define E1000_RFC??? 0x040A8? /* Rx Fragment Count - R/clr */
>> +#define E1000_ROC??? 0x040AC? /* Rx Oversize Count - R/clr */
>> +#define E1000_RJC??? 0x040B0? /* Rx Jabber Count - R/clr */
>> +#define E1000_MGTPRC??? 0x040B4? /* Management Packets Rx Count - 
>> R/clr */
>> +#define E1000_MGTPDC??? 0x040B8? /* Management Packets Dropped Count 
>> - R/clr */
>> +#define E1000_MGTPTC??? 0x040BC? /* Management Packets Tx Count - 
>> R/clr */
>> +#define E1000_TORL??? 0x040C0? /* Total Octets Rx Low - R/clr */
>> +#define E1000_TORH??? 0x040C4? /* Total Octets Rx High - R/clr */
>> +#define E1000_TOTL??? 0x040C8? /* Total Octets Tx Low - R/clr */
>> +#define E1000_TOTH??? 0x040CC? /* Total Octets Tx High - R/clr */
>> +#define E1000_TPR??? 0x040D0? /* Total Packets Rx - R/clr */
>> +#define E1000_TPT??? 0x040D4? /* Total Packets Tx - R/clr */
>> +#define E1000_PTC64??? 0x040D8? /* Packets Tx (64 bytes) - R/clr */
>> +#define E1000_PTC127??? 0x040DC? /* Packets Tx (65-127 bytes) - R/clr */
>> +#define E1000_PTC255??? 0x040E0? /* Packets Tx (128-255 bytes) - 
>> R/clr */
>> +#define E1000_PTC511??? 0x040E4? /* Packets Tx (256-511 bytes) - 
>> R/clr */
>> +#define E1000_PTC1023??? 0x040E8? /* Packets Tx (512-1023 bytes) - 
>> R/clr */
>> +#define E1000_PTC1522??? 0x040EC? /* Packets Tx (1024-1522 Bytes) - 
>> R/clr */
>> +#define E1000_MPTC??? 0x040F0? /* Multicast Packets Tx Count - R/clr */
>> +#define E1000_BPTC??? 0x040F4? /* Broadcast Packets Tx Count - R/clr */
>> +#define E1000_TSCTC??? 0x040F8? /* TCP Segmentation Context Tx - 
>> R/clr */
>> +#define E1000_TSCTFC??? 0x040FC? /* TCP Segmentation Context Tx Fail 
>> - R/clr */
>> +#define E1000_IAC??? 0x04100? /* Interrupt Assertion Count */
>> +#define E1000_ICTXPTC??? 0x0410C? /* Interrupt Cause Tx Pkt Timer 
>> Expire Count */
>> +#define E1000_ICTXATC??? 0x04110? /* Interrupt Cause Tx Abs Timer 
>> Expire Count */
>> +#define E1000_ICTXQEC??? 0x04118? /* Interrupt Cause Tx Queue Empty 
>> Count */
>> +#define E1000_ICTXQMTC??? 0x0411C? /* Interrupt Cause Tx Queue Min 
>> Thresh Count */
>> +#define E1000_RPTHC??? 0x04104? /* Rx Packets To Host */
>> +#define E1000_HGPTC??? 0x04118? /* Host Good Packets Tx Count */
>> +#define E1000_RXDMTC??? 0x04120? /* Rx Descriptor Minimum Threshold 
>> Count */
>> +#define E1000_HGORCL??? 0x04128? /* Host Good Octets Received Count 
>> Low */
>> +#define E1000_HGORCH??? 0x0412C? /* Host Good Octets Received Count 
>> High */
>> +#define E1000_HGOTCL??? 0x04130? /* Host Good Octets Transmit Count 
>> Low */
>> +#define E1000_HGOTCH??? 0x04134? /* Host Good Octets Transmit Count 
>> High */
>> +#define E1000_LENERRS??? 0x04138? /* Length Errors Count */
>> +#define E1000_SCVPC??? 0x04228? /* SerDes/SGMII Code Violation Pkt 
>> Count */
>> +#define E1000_HRMPC??? 0x0A018? /* Header Redirection Missed Packet 
>> Count */
>> +
>> +/* DMA Coalescing registers */
>> +#define E1000_DMACR??? 0x02508 /* Control Register */
>> +#define E1000_DMCTXTH??? 0x03550 /* Transmit Threshold */
>> +#define E1000_DMCTLX??? 0x02514 /* Time to Lx Request */
>> +#define E1000_DMCRTRH??? 0x05DD0 /* Receive Packet Rate Threshold */
>> +#define E1000_DMCCNT??? 0x05DD4 /* Current Rx Count */
>> +#define E1000_FCRTC??? 0x02170 /* Flow Control Rx high watermark */
>> +#define E1000_PCIEMISC??? 0x05BB8 /* PCIE misc config register */
>> +
>> +/* Energy Efficient Ethernet "EEE" registers */
>> +#define E1000_IPCNFG??? 0x0E38 /* Internal PHY Configuration */
>> +#define E1000_LTRC??? 0x01A0 /* Latency Tolerance Reporting Control */
>> +#define E1000_EEER??? 0x0E30 /* Energy Efficient Ethernet "EEE"*/
>> +#define E1000_EEE_SU??? 0x0E34 /* EEE Setup */
>> +#define E1000_TLPIC??? 0x4148 /* EEE Tx LPI Count - TLPIC */
>> +#define E1000_RLPIC??? 0x414C /* EEE Rx LPI Count - RLPIC */
>> +
>> +/* forward declaration */
>> +struct e1000_hw;
>> +u32 igc_rd32(struct e1000_hw *hw, u32 reg);
> 
> Can we do this without the forward decls?
> 
Can you advice another place?
>> +
>> +/* write operations, indexed using DWORDS */
>> +#define wr32(reg, val) \
>> +do { \
>> +??? u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
>> +??? if (!E1000_REMOVED(hw_addr)) \
>> +??????? writel((val), &hw_addr[(reg)]); \
>> +} while (0)
>> +
>> +#define rd32(reg) (igc_rd32(hw, reg))
>> +
>> +#define wrfl() ((void)rd32(E1000_STATUS))
>> +
>> +#define array_wr32(reg, offset, value) \
>> +??? wr32((reg) + ((offset) << 2), (value))
>> +
>> +#define array_rd32(reg, offset) (igc_rd32(hw, (reg) + ((offset) << 2)))
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h 
>> b/drivers/net/ethernet/intel/igc/igc.h
>> index afe595cfcf63..bd732390bd4b 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -22,8 +22,21 @@
>> ? #include <linux/net_tstamp.h>
>> ? #include <linux/ptp_clock_kernel.h>
>> +#include "e1000_hw.h"
>> +
>> ? /* main */
>> ? extern char igc_driver_name[];
>> ? extern char igc_driver_version[];
>> +/* Board specific private data structure */
>> +struct igc_adapter {
>> +??? u8 __iomem *io_addr;
>> +
>> +??? /* OS defined structs */
>> +??? struct pci_dev *pdev;
>> +
>> +??? /* structs defined in e1000_hw.h */
>> +??? struct e1000_hw hw;
>> +};
>> +
>> ? #endif /* _IGC_H_ */
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 3e10d27752d5..ec3451dad91e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -25,6 +25,69 @@ static const struct pci_device_id igc_pci_tbl[] = {
>> ? MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>> +/* Forward declaration */
>> +static int igc_sw_init(struct igc_adapter *);
> 
> Can we do this without the forward decls?
> 
Can you advice another place?
>> +
>> +/* PCIe configuration access */
>> +void igc_read_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value)
>> +{
>> +??? struct igc_adapter *adapter = hw->back;
>> +
>> +??? pci_read_config_word(adapter->pdev, reg, value);
>> +}
>> +
>> +void igc_write_pci_cfg(struct e1000_hw *hw, u32 reg, u16 *value)
>> +{
>> +??? struct igc_adapter *adapter = hw->back;
>> +
>> +??? pci_write_config_word(adapter->pdev, reg, *value);
>> +}
>> +
>> +s32 igc_read_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
>> +{
>> +??? struct igc_adapter *adapter = hw->back;
>> +??? u16 cap_offset;
>> +
>> +??? cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
>> +??? if (!cap_offset)
>> +??????? return -E1000_ERR_CONFIG;
>> +
>> +??? pci_read_config_word(adapter->pdev, cap_offset + reg, value);
>> +
>> +??? return E1000_SUCCESS;
>> +}
>> +
>> +s32 igc_write_pcie_cap_reg(struct e1000_hw *hw, u32 reg, u16 *value)
>> +{
>> +??? struct igc_adapter *adapter = hw->back;
>> +??? u16 cap_offset;
>> +
>> +??? cap_offset = pci_find_capability(adapter->pdev, PCI_CAP_ID_EXP);
>> +??? if (!cap_offset)
>> +??????? return -E1000_ERR_CONFIG;
>> +
>> +??? pci_write_config_word(adapter->pdev, cap_offset + reg, *value);
>> +
>> +??? return E1000_SUCCESS;
>> +}
>> +
>> +u32 igc_rd32(struct e1000_hw *hw, u32 reg)
>> +{
>> +??? u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
>> +??? u32 value = 0;
>> +
>> +??? if (E1000_REMOVED(hw_addr))
>> +??????? return ~value;
>> +
>> +??? value = readl(&hw_addr[reg]);
>> +
>> +??? /* reads should not return all F's */
>> +??? if (!(~value) && (!reg || !(~readl(hw_addr))))
>> +??????? hw->hw_addr = NULL;
>> +
>> +??? return value;
>> +}
>> +
>> ? /**
>> ?? *? igc_probe - Device Initialization Routine
>> ?? *? @pdev: PCI device information struct
>> @@ -39,6 +102,8 @@ MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>> ? static int igc_probe(struct pci_dev *pdev,
>> ?????????????? const struct pci_device_id *ent)
>> ? {
>> +??? struct igc_adapter *adapter;
>> +??? struct e1000_hw *hw;
>> ????? int err, pci_using_dac;
> 
> Someone's gonna ding you for the reverse xmas tree layout, it might as 
> well be me.? Especially since I just recently got beat with it :-).
> 
>> ????? err = pci_enable_device_mem(pdev);
>> @@ -73,8 +138,17 @@ static int igc_probe(struct pci_dev *pdev,
>> ????? pci_set_master(pdev);
>> ????? pci_save_state(pdev);
>> +
>> +??? /* setup the private structure */
>> +??? err = igc_sw_init(adapter);
>> +??? if (err)
>> +??????? goto err_sw_init;
>> +
>> +??? igc_get_bus_info_pcie(hw);
>> +
>> ????? return 0;
>> +err_sw_init:
>> ? err_pci_reg:
>> ? err_dma:
>> ????? pci_disable_device(pdev);
>> @@ -106,6 +180,33 @@ static struct pci_driver igc_driver = {
>> ? };
>> ? /**
>> + *? igc_sw_init - Initialize general software structures (struct 
>> igc_adapter)
>> + *? @adapter: board private structure to initialize
>> + *
>> + *? igc_sw_init initializes the Adapter private data structure.
>> + *? Fields are initialized based on PCI device information and
>> + *? OS network device settings (MTU size).
>> + **/
>> +static int igc_sw_init(struct igc_adapter *adapter)
>> +{
>> +??? struct e1000_hw *hw = &adapter->hw;
>> +??? struct pci_dev *pdev = adapter->pdev;
>> +
>> +??? /* PCI config space info */
>> +
>> +??? hw->vendor_id = pdev->vendor;
>> +??? hw->device_id = pdev->device;
>> +??? hw->subsystem_vendor_id = pdev->subsystem_vendor;
>> +??? hw->subsystem_device_id = pdev->subsystem_device;
>> +
>> +??? pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id);
>> +
>> +??? pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
>> +
>> +??? return 0;
>> +}
>> +
>> +/**
>> ?? *? igc_init_module - Driver Registration Routine
>> ?? *
>> ?? *? igc_init_module is the first routine called when the driver is
>>

