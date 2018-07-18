From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 18 Jul 2018 11:18:09 +0300
Subject: [Intel-wired-lan] [PATCH v4 09/11] igc: Add code for PHY support
Message-ID: <20180718081809.15868-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sasha Neftin (v2):
minor cosmetic changes

Alexander Duyck (v3.5):
Made non-gpy versions of phy functions static
Move xmdio functions to avoid need for prototype function
Move reset, read_reg, and write_reg ops into e1000_phy_ops_base
Drop code implying more than one function
Fix merge conflict with v3.5 of NVM code.

Sasha Neftin (v3):
Introduce temporary workaround for PHY power down.

Sasha Neftin (v4):
address comments
remove space
fix minor grammar typo
replace e1000_ prefix with igc_ prefix

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igc/Makefile      |   2 +-
 drivers/net/ethernet/intel/igc/igc.h         |  16 +
 drivers/net/ethernet/intel/igc/igc_base.c    | 126 +++++++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  95 ++++++
 drivers/net/ethernet/intel/igc/igc_hw.h      |  62 +++-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  47 ++-
 drivers/net/ethernet/intel/igc/igc_mac.h     |  11 +
 drivers/net/ethernet/intel/igc/igc_main.c    |  11 +
 drivers/net/ethernet/intel/igc/igc_phy.c     | 458 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_phy.h     |  20 ++
 drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
 12 files changed, 844 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igc/igc_phy.c
 create mode 100644 drivers/net/ethernet/intel/igc/igc_phy.h

diff --git a/drivers/net/ethernet/intel/igc/Makefile b/drivers/net/ethernet/intel/igc/Makefile
index 2b5378d96c7b..4387f6ba8e67 100644
--- a/drivers/net/ethernet/intel/igc/Makefile
+++ b/drivers/net/ethernet/intel/igc/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_IGC) += igc.o
 
-igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o
+igc-objs := igc_main.o igc_mac.o igc_i225.o igc_base.o igc_nvm.o igc_phy.o
diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 9ef6f290209c..901048fdf478 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -365,6 +365,22 @@ static inline u16 igc_desc_unused(const struct igc_ring *ring)
 	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
 }
 
+static inline s32 igc_get_phy_info(struct igc_hw *hw)
+{
+	if (hw->phy.ops.get_phy_info)
+		return hw->phy.ops.get_phy_info(hw);
+
+	return 0;
+}
+
+static inline s32 igc_reset_phy(struct igc_hw *hw)
+{
+	if (hw->phy.ops.reset)
+		return hw->phy.ops.reset(hw);
+
+	return 0;
+}
+
 static inline struct netdev_queue *txring_txq(const struct igc_ring *tx_ring)
 {
 	return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 0c7cacb75643..7215f303278e 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -12,12 +12,31 @@
 /* forward declaration */
 static s32 igc_get_invariants_base(struct igc_hw *);
 static s32 igc_check_for_link_base(struct igc_hw *);
+static s32 igc_acquire_phy_base(struct igc_hw *);
+static void igc_release_phy_base(struct igc_hw *);
+static s32 igc_get_phy_id_base(struct igc_hw *);
 static s32 igc_init_hw_base(struct igc_hw *);
 static s32 igc_reset_hw_base(struct igc_hw *);
 static s32 igc_set_pcie_completion_timeout(struct igc_hw *hw);
 static s32 igc_read_mac_addr_base(struct igc_hw *hw);
 
 /**
+ *  igc_get_phy_id_base - Retrieve PHY addr and id
+ *  @hw: pointer to the HW structure
+ *
+ *  Retrieves the PHY address and ID for both PHY's which do and do not use
+ *  sgmi interface.
+ **/
+static s32 igc_get_phy_id_base(struct igc_hw *hw)
+{
+	s32  ret_val = 0;
+
+	ret_val = igc_get_phy_id(hw);
+
+	return ret_val;
+}
+
+/**
  *  igc_init_nvm_params_base - Init NVM func ptrs.
  *  @hw: pointer to the HW structure
  **/
@@ -81,6 +100,59 @@ static s32 igc_init_mac_params_base(struct igc_hw *hw)
 	return 0;
 }
 
+/**
+ *  igc_init_phy_params_base - Init PHY func ptrs.
+ *  @hw: pointer to the HW structure
+ **/
+static s32 igc_init_phy_params_base(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32 ret_val = 0;
+	u32 ctrl_ext;
+
+	if (hw->phy.media_type != igc_media_type_copper) {
+		phy->type = igc_phy_none;
+		goto out;
+	}
+
+	phy->autoneg_mask       = AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
+	phy->reset_delay_us     = 100;
+
+	ctrl_ext = rd32(IGC_CTRL_EXT);
+
+	/* set lan id */
+	hw->bus.func = (rd32(IGC_STATUS) & IGC_STATUS_FUNC_MASK) >>
+			IGC_STATUS_FUNC_SHIFT;
+
+	/* Make sure the PHY is in a good state. Several people have reported
+	 * firmware leaving the PHY's page select register set to something
+	 * other than the default of zero, which causes the PHY ID read to
+	 * access something other than the intended register.
+	 */
+	ret_val = hw->phy.ops.reset(hw);
+	if (ret_val) {
+		hw_dbg("Error resetting the PHY.\n");
+		goto out;
+	}
+
+	ret_val = igc_get_phy_id_base(hw);
+	if (ret_val)
+		return ret_val;
+
+	/* Verify phy id and set remaining function pointers */
+	switch (phy->id) {
+	case I225_I_PHY_ID:
+		phy->type	= igc_phy_i225;
+		break;
+	default:
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
 static s32 igc_get_invariants_base(struct igc_hw *hw)
 {
 	u32 link_mode = 0;
@@ -105,6 +177,8 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 		break;
 	}
 
+	/* setup PHY parameters */
+	ret_val = igc_init_phy_params_base(hw);
 	if (ret_val)
 		goto out;
 
@@ -113,6 +187,34 @@ static s32 igc_get_invariants_base(struct igc_hw *hw)
 }
 
 /**
+ *  igc_acquire_phy_base - Acquire rights to access PHY
+ *  @hw: pointer to the HW structure
+ *
+ *  Acquire access rights to the correct PHY.  This is a
+ *  function pointer entry point called by the api module.
+ **/
+static s32 igc_acquire_phy_base(struct igc_hw *hw)
+{
+	u16 mask = IGC_SWFW_PHY0_SM;
+
+	return hw->mac.ops.acquire_swfw_sync(hw, mask);
+}
+
+/**
+ *  igc_release_phy_base - Release rights to access PHY
+ *  @hw: pointer to the HW structure
+ *
+ *  A wrapper to release access rights to the correct PHY.  This is a
+ *  function pointer entry point called by the api module.
+ **/
+static void igc_release_phy_base(struct igc_hw *hw)
+{
+	u16 mask = IGC_SWFW_PHY0_SM;
+
+	hw->mac.ops.release_swfw_sync(hw, mask);
+}
+
+/**
  *  igc_get_link_up_info_base - Get link speed/duplex info
  *  @hw: pointer to the HW structure
  *  @speed: stores the current speed
@@ -200,6 +302,20 @@ static s32 igc_read_mac_addr_base(struct igc_hw *hw)
 }
 
 /**
+ *  igc_power_down_phy_copper_base - Remove link during PHY power down
+ *  @hw: pointer to the HW structure
+ *
+ *  In the case of a PHY power down to save power, or to turn off link during a
+ *  driver unload, or wake on lan is not enabled, remove the link.
+ **/
+void igc_power_down_phy_copper_base(struct igc_hw *hw)
+{
+	/* If the management interface is not enabled, then power down */
+	if (!(igc_enable_mng_pass_thru(hw) || igc_check_reset_block(hw)))
+		igc_power_down_phy_copper(hw);
+}
+
+/**
  *  igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
  *  @hw: pointer to the HW structure
  *
@@ -283,10 +399,18 @@ static struct igc_mac_operations igc_mac_ops_base = {
 	.get_speed_and_duplex	= igc_get_link_up_info_base,
 };
 
+static const struct igc_phy_operations igc_phy_ops_base = {
+	.acquire		= igc_acquire_phy_base,
+	.release		= igc_release_phy_base,
+	.reset			= igc_phy_hw_reset,
+	.read_reg		= igc_read_phy_reg_gpy,
+	.write_reg		= igc_write_phy_reg_gpy,
+};
+
 const struct igc_info igc_base_info = {
 	.get_invariants		= igc_get_invariants_base,
 	.mac_ops		= &igc_mac_ops_base,
-	/* TODO phy_ops */
+	.phy_ops		= &igc_phy_ops_base,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 802a0cbd3123..35588fa7b8c5 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -6,6 +6,7 @@
 
 /* forward declaration */
 void igc_rx_fifo_flush_base(struct igc_hw *hw);
+void igc_power_down_phy_copper_base(struct igc_hw *hw);
 
 /* Transmit Descriptor - Advanced */
 union igc_adv_tx_desc {
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index a94970289a74..6b0c5058d897 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -54,11 +54,14 @@
 #define IGC_ERR_MAC_INIT		5
 #define IGC_ERR_RESET			9
 #define IGC_ERR_MASTER_REQUESTS_PENDING	10
+#define IGC_ERR_BLK_PHY_RESET			12
 #define IGC_ERR_SWFW_SYNC			13
 
 /* Device Control */
 #define IGC_CTRL_RST		0x04000000  /* Global reset */
 
+#define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
+
 /* PBA constants */
 #define IGC_PBA_34K		0x0022
 
@@ -131,6 +134,22 @@
 #define HALF_DUPLEX		1
 #define FULL_DUPLEX		2
 
+/* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
+#define ADVERTISE_10_HALF		0x0001
+#define ADVERTISE_10_FULL		0x0002
+#define ADVERTISE_100_HALF		0x0004
+#define ADVERTISE_100_FULL		0x0008
+#define ADVERTISE_1000_HALF		0x0010 /* Not used, just FYI */
+#define ADVERTISE_1000_FULL		0x0020
+#define ADVERTISE_2500_HALF		0x0040 /* NOT used, just FYI */
+#define ADVERTISE_2500_FULL		0x0080
+
+#define IGC_ALL_SPEED_DUPLEX_2500 ( \
+	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
+	ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
+
+#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500	IGC_ALL_SPEED_DUPLEX_2500
+
 /* Interrupt Cause Read */
 #define IGC_ICR_TXDW		BIT(0)	/* Transmit desc written back */
 #define IGC_ICR_TXQE		BIT(1)	/* Transmit Queue empty */
@@ -216,6 +235,7 @@
 
 /* Management Control */
 #define IGC_MANC_RCV_TCO_EN	0x00020000 /* Receive TCO Packets Enabled */
+#define IGC_MANC_BLK_PHY_RST_ON_IDE	0x00040000 /* Block phy resets */
 
 /* Receive Control */
 #define IGC_RCTL_RST		0x00000001 /* Software reset */
@@ -280,6 +300,81 @@
 #define I225_RXPBSIZE_DEFAULT	0x000000A2 /* RXPBSIZE default */
 #define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
 
+/* these buffer sizes are valid if IGC_RCTL_BSEX is 0 */
+#define IGC_RCTL_SZ_2048	0x00000000 /* Rx buffer size 2048 */
+#define IGC_RCTL_SZ_1024	0x00010000 /* Rx buffer size 1024 */
+#define IGC_RCTL_SZ_512		0x00020000 /* Rx buffer size 512 */
+#define IGC_RCTL_SZ_256		0x00030000 /* Rx buffer size 256 */
+/* these buffer sizes are valid if IGC_RCTL_BSEX is 1 */
+#define IGC_RCTL_SZ_16384	0x00010000 /* Rx buffer size 16384 */
+#define IGC_RCTL_SZ_8192	0x00020000 /* Rx buffer size 8192 */
+#define IGC_RCTL_SZ_4096	0x00030000 /* Rx buffer size 4096 */
+
+#define IGC_RCTL_MO_SHIFT	12 /* multicast offset shift */
+#define IGC_RCTL_CFIEN		0x00080000 /* canonical form enable */
+#define IGC_RCTL_DPF		0x00400000 /* discard pause frames */
+#define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
+#define IGC_RCTL_SECRC		0x04000000 /* Strip Ethernet CRC */
+
+/* GPY211 - I225 defines */
+#define GPY_MMD_MASK		0xFFFF0000
+#define GPY_MMD_SHIFT		16
+#define GPY_REG_MASK		0x0000FFFF
+
+#define IGC_MMDAC_FUNC_DATA	0x4000 /* Data, no post increment */
+
+/* MAC definitions */
+#define IGC_FACTPS_MNGCG	0x20000000
+#define IGC_FWSM_MODE_MASK	0xE
+#define IGC_FWSM_MODE_SHIFT	1
+
+/* Management Control */
+#define IGC_MANC_SMBUS_EN	0x00000001 /* SMBus Enabled - RO */
+#define IGC_MANC_ASF_EN		0x00000002 /* ASF Enabled - RO */
+
+/* PHY */
+#define PHY_REVISION_MASK	0xFFFFFFF0
+#define MAX_PHY_REG_ADDRESS	0x1F  /* 5 bit address bus (0-0x1F) */
+#define IGC_GEN_POLL_TIMEOUT	640
+
+/* PHY Control Register */
+#define MII_CR_FULL_DUPLEX	0x0100  /* FDX =1, half duplex =0 */
+#define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
+#define MII_CR_POWER_DOWN	0x0800  /* Power down */
+#define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
+#define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
+#define MII_CR_RESET		0x8000  /* 0 = normal, 1 = PHY reset */
+#define MII_CR_SPEED_1000	0x0040
+#define MII_CR_SPEED_100	0x2000
+#define MII_CR_SPEED_10		0x0000
+
+/* PHY Status Register */
+#define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
+#define MII_SR_AUTONEG_COMPLETE	0x0020 /* Auto Neg Complete */
+
+/* PHY 1000 MII Register/Bit Definitions */
+/* PHY Registers defined by IEEE */
+#define PHY_CONTROL		0x00 /* Control Register */
+#define PHY_STATUS		0x01 /* Status Register */
+#define PHY_ID1			0x02 /* Phy Id Reg (word 1) */
+#define PHY_ID2			0x03 /* Phy Id Reg (word 2) */
+
+/* Bit definitions for valid PHY IDs. I = Integrated E = External */
+#define I225_I_PHY_ID		0x67C9DC00
+
+/* MDI Control */
+#define IGC_MDIC_DATA_MASK	0x0000FFFF
+#define IGC_MDIC_REG_MASK	0x001F0000
+#define IGC_MDIC_REG_SHIFT	16
+#define IGC_MDIC_PHY_MASK	0x03E00000
+#define IGC_MDIC_PHY_SHIFT	21
+#define IGC_MDIC_OP_WRITE	0x04000000
+#define IGC_MDIC_OP_READ	0x08000000
+#define IGC_MDIC_READY		0x10000000
+#define IGC_MDIC_INT_EN		0x20000000
+#define IGC_MDIC_ERROR		0x40000000
+#define IGC_MDIC_DEST		0x80000000
+
 #define IGC_N0_QUEUE -1
 
 #endif /* _IGC_DEFINES_H_ */
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index bf4fcbe396e6..a84cf0ba78d4 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -11,6 +11,7 @@
 #include "igc_regs.h"
 #include "igc_defines.h"
 #include "igc_mac.h"
+#include "igc_phy.h"
 #include "igc_nvm.h"
 #include "igc_i225.h"
 #include "igc_base.h"
@@ -18,6 +19,8 @@
 #define IGC_DEV_ID_I225_LM			0x15F2
 #define IGC_DEV_ID_I225_V			0x15F3
 
+#define IGC_FUNC_0				0
+
 /* Forward declaration */
 struct igc_hw;
 
@@ -47,10 +50,10 @@ enum igc_phy_type {
 	igc_phy_i225,
 };
 
-enum igc_bus_type {
-	igc_bus_type_unknown = 0,
-	igc_bus_type_pci_express,
-	igc_bus_type_reserved
+enum igc_media_type {
+	igc_media_type_unknown = 0,
+	igc_media_type_copper = 1,
+	igc_num_media_types
 };
 
 enum igc_nvm_type {
@@ -59,6 +62,12 @@ enum igc_nvm_type {
 	igc_nvm_invm,
 };
 
+enum igc_bus_type {
+	igc_bus_type_unknown = 0,
+	igc_bus_type_pci_express,
+	igc_bus_type_reserved
+};
+
 enum igc_bus_speed {
 	igc_bus_speed_unknown = 0,
 	igc_bus_speed_2500,
@@ -109,6 +118,7 @@ struct igc_mac_info {
 
 	bool adaptive_ifs;
 	bool has_fwsm;
+	bool asf_firmware_present;
 	bool arc_subsystem_valid;
 
 	bool autoneg;
@@ -126,6 +136,20 @@ struct igc_nvm_operations {
 	s32 (*valid_led_default)(struct igc_hw *hw, u16 *data);
 };
 
+struct igc_phy_operations {
+	s32 (*acquire)(struct igc_hw *hw);
+	s32 (*check_polarity)(struct igc_hw *hw);
+	s32 (*check_reset_block)(struct igc_hw *hw);
+	s32 (*force_speed_duplex)(struct igc_hw *hw);
+	s32 (*get_cfg_done)(struct igc_hw *hw);
+	s32 (*get_cable_length)(struct igc_hw *hw);
+	s32 (*get_phy_info)(struct igc_hw *hw);
+	s32 (*read_reg)(struct igc_hw *hw, u32 address, u16 *data);
+	void (*release)(struct igc_hw *hw);
+	s32 (*reset)(struct igc_hw *hw);
+	s32 (*write_reg)(struct igc_hw *hw, u32 address, u16 data);
+};
+
 struct igc_nvm_info {
 	struct igc_nvm_operations ops;
 	enum igc_nvm_type type;
@@ -140,6 +164,35 @@ struct igc_nvm_info {
 	u16 page_size;
 };
 
+struct igc_phy_info {
+	struct igc_phy_operations ops;
+
+	enum igc_phy_type type;
+
+	u32 addr;
+	u32 id;
+	u32 reset_delay_us; /* in usec */
+	u32 revision;
+
+	enum igc_media_type media_type;
+
+	u16 autoneg_advertised;
+	u16 autoneg_mask;
+	u16 cable_length;
+	u16 max_cable_length;
+	u16 min_cable_length;
+	u16 pair_length[4];
+
+	u8 mdix;
+
+	bool disable_polarity_correction;
+	bool is_mdix;
+	bool polarity_correction;
+	bool reset_disable;
+	bool speed_downgraded;
+	bool autoneg_wait_to_complete;
+};
+
 struct igc_bus_info {
 	enum igc_bus_type type;
 	enum igc_bus_speed speed;
@@ -185,6 +238,7 @@ struct igc_hw {
 	struct igc_mac_info  mac;
 	struct igc_fc_info   fc;
 	struct igc_nvm_info  nvm;
+	struct igc_phy_info  phy;
 
 	struct igc_bus_info bus;
 
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index d08d2c6a6647..78941e2a26f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -389,7 +389,7 @@ s32 igc_check_for_copper_link(struct igc_hw *hw)
 	 * link.  If so, then we want to get the current speed/duplex
 	 * of the PHY.
 	 */
-	/* TODO ret_val = igc_phy_has_link(hw, 1, 0, &link); */
+	ret_val = igc_phy_has_link(hw, 1, 0, &link);
 	if (ret_val)
 		goto out;
 
@@ -401,7 +401,7 @@ s32 igc_check_for_copper_link(struct igc_hw *hw)
 	/* Check if there was DownShift, must be checked
 	 * immediately after link-up
 	 */
-	/* TODO igc_check_downshift(hw); */
+	igc_check_downshift(hw);
 
 	/* If we are forcing speed/duplex, then we simply return since
 	 * we have already determined whether we have link or not.
@@ -542,3 +542,46 @@ void igc_put_hw_semaphore(struct igc_hw *hw)
 
 	wr32(IGC_SWSM, swsm);
 }
+
+/**
+ *  igc_enable_mng_pass_thru - Enable processing of ARP's
+ *  @hw: pointer to the HW structure
+ *
+ *  Verifies the hardware needs to leave interface enabled so that frames can
+ *  be directed to and from the management interface.
+ **/
+bool igc_enable_mng_pass_thru(struct igc_hw *hw)
+{
+	bool ret_val = false;
+	u32 fwsm, factps;
+	u32 manc;
+
+	if (!hw->mac.asf_firmware_present)
+		goto out;
+
+	manc = rd32(IGC_MANC);
+
+	if (!(manc & IGC_MANC_RCV_TCO_EN))
+		goto out;
+
+	if (hw->mac.arc_subsystem_valid) {
+		fwsm = rd32(IGC_FWSM);
+		factps = rd32(IGC_FACTPS);
+
+		if (!(factps & IGC_FACTPS_MNGCG) &&
+		    ((fwsm & IGC_FWSM_MODE_MASK) ==
+		    (igc_mng_mode_pt << IGC_FWSM_MODE_SHIFT))) {
+			ret_val = true;
+			goto out;
+		}
+	} else {
+		if ((manc & IGC_MANC_SMBUS_EN) &&
+		    !(manc & IGC_MANC_ASF_EN)) {
+			ret_val = true;
+			goto out;
+		}
+	}
+
+out:
+	return ret_val;
+}
diff --git a/drivers/net/ethernet/intel/igc/igc_mac.h b/drivers/net/ethernet/intel/igc/igc_mac.h
index 7d935d581fc7..e61b9c5faa32 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.h
+++ b/drivers/net/ethernet/intel/igc/igc_mac.h
@@ -5,6 +5,7 @@
 #define _IGC_MAC_H_
 
 #include "igc_hw.h"
+#include "igc_phy.h"
 #include "igc_defines.h"
 
 #ifndef IGC_REMOVED
@@ -26,4 +27,14 @@ s32 igc_get_bus_info_pcie(struct igc_hw *hw);
 s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
 				    u16 *duplex);
 
+bool igc_enable_mng_pass_thru(struct igc_hw *hw);
+
+enum igc_mng_mode {
+	igc_mng_mode_none = 0,
+	igc_mng_mode_asf,
+	igc_mng_mode_pt,
+	igc_mng_mode_ipmi,
+	igc_mng_mode_host_if_only
+};
+
 #endif
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2514bb5e5651..24689854a0a2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -100,6 +100,8 @@ static void igc_reset(struct igc_adapter *adapter)
 
 	if (!netif_running(adapter->netdev))
 		igc_power_down_link(adapter);
+
+	igc_get_phy_info(hw);
 }
 
 /**
@@ -108,6 +110,12 @@ static void igc_reset(struct igc_adapter *adapter)
  **/
 static void igc_power_up_link(struct igc_adapter *adapter)
 {
+	igc_reset_phy(&adapter->hw);
+
+	if (adapter->hw.phy.media_type == igc_media_type_copper)
+		igc_power_up_phy_copper(&adapter->hw);
+
+	igc_setup_link(&adapter->hw);
 }
 
 /**
@@ -116,6 +124,8 @@ static void igc_power_up_link(struct igc_adapter *adapter)
  **/
 static void igc_power_down_link(struct igc_adapter *adapter)
 {
+	if (adapter->hw.phy.media_type == igc_media_type_copper)
+		igc_power_down_phy_copper_base(&adapter->hw);
 }
 
 /**
@@ -3401,6 +3411,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 	/* Copy the default MAC and PHY function pointers */
 	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
+	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
 
 	/* Initialize skew-specific constants */
 	err = ei->get_invariants(hw);
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
new file mode 100644
index 000000000000..95c9a30b96a2
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -0,0 +1,458 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include "igc_phy.h"
+
+/**
+ *  igc_check_reset_block - Check if PHY reset is blocked
+ *  @hw: pointer to the HW structure
+ *
+ *  Read the PHY management control register and check whether a PHY reset
+ *  is blocked.  If a reset is not blocked return 0, otherwise
+ *  return IGC_ERR_BLK_PHY_RESET (12).
+ **/
+s32 igc_check_reset_block(struct igc_hw *hw)
+{
+	u32 manc;
+
+	manc = rd32(IGC_MANC);
+
+	return (manc & IGC_MANC_BLK_PHY_RST_ON_IDE) ?
+		IGC_ERR_BLK_PHY_RESET : 0;
+}
+
+/**
+ *  igc_get_phy_id - Retrieve the PHY ID and revision
+ *  @hw: pointer to the HW structure
+ *
+ *  Reads the PHY registers and stores the PHY ID and possibly the PHY
+ *  revision in the hardware structure.
+ **/
+s32 igc_get_phy_id(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32 ret_val = 0;
+	u16 phy_id;
+
+	ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
+	if (ret_val)
+		goto out;
+
+	phy->id = (u32)(phy_id << 16);
+	usleep_range(200, 500);
+	ret_val = phy->ops.read_reg(hw, PHY_ID2, &phy_id);
+	if (ret_val)
+		goto out;
+
+	phy->id |= (u32)(phy_id & PHY_REVISION_MASK);
+	phy->revision = (u32)(phy_id & ~PHY_REVISION_MASK);
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_phy_has_link - Polls PHY for link
+ *  @hw: pointer to the HW structure
+ *  @iterations: number of times to poll for link
+ *  @usec_interval: delay between polling attempts
+ *  @success: pointer to whether polling was successful or not
+ *
+ *  Polls the PHY status register for link, 'iterations' number of times.
+ **/
+s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
+		     u32 usec_interval, bool *success)
+{
+	u16 i, phy_status;
+	s32 ret_val = 0;
+
+	for (i = 0; i < iterations; i++) {
+		/* Some PHYs require the PHY_STATUS register to be read
+		 * twice due to the link bit being sticky.  No harm doing
+		 * it across the board.
+		 */
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val && usec_interval > 0) {
+			/* If the first read fails, another entity may have
+			 * ownership of the resources, wait and try again to
+			 * see if they have relinquished the resources yet.
+			 */
+			if (usec_interval >= 1000)
+				mdelay(usec_interval / 1000);
+			else
+				udelay(usec_interval);
+		}
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val)
+			break;
+		if (phy_status & MII_SR_LINK_STATUS)
+			break;
+		if (usec_interval >= 1000)
+			mdelay(usec_interval / 1000);
+		else
+			udelay(usec_interval);
+	}
+
+	*success = (i < iterations) ? true : false;
+
+	return ret_val;
+}
+
+/**
+ *  igc_power_up_phy_copper - Restore copper link in case of PHY power down
+ *  @hw: pointer to the HW structure
+ *
+ *  In the case of a PHY power down to save power, or to turn off link during a
+ *  driver unload, restore the link to previous settings.
+ **/
+void igc_power_up_phy_copper(struct igc_hw *hw)
+{
+	u16 mii_reg = 0;
+
+	/* The PHY will retain its settings across a power down/up cycle */
+	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
+	mii_reg &= ~MII_CR_POWER_DOWN;
+	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
+}
+
+/**
+ *  igc_power_down_phy_copper - Power down copper PHY
+ *  @hw: pointer to the HW structure
+ *
+ *  Power down PHY to save power when interface is down and wake on lan
+ *  is not enabled.
+ **/
+void igc_power_down_phy_copper(struct igc_hw *hw)
+{
+	u16 mii_reg = 0;
+
+	/* The PHY will retain its settings across a power down/up cycle */
+	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
+	mii_reg |= MII_CR_POWER_DOWN;
+
+	/* Temporary workaround - should be removed when PHY will implement
+	 * IEEE registers as properly
+	 */
+	/* hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);*/
+	usleep_range(1000, 2000);
+}
+
+/**
+ *  igc_check_downshift - Checks whether a downshift in speed occurred
+ *  @hw: pointer to the HW structure
+ *
+ *  Success returns 0, Failure returns 1
+ *
+ *  A downshift is detected by querying the PHY link health.
+ **/
+s32 igc_check_downshift(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u16 phy_data, offset, mask;
+	s32 ret_val;
+
+	switch (phy->type) {
+	case igc_phy_i225:
+	default:
+		/* speed downshift not supported */
+		phy->speed_downgraded = false;
+		ret_val = 0;
+		goto out;
+	}
+
+	ret_val = phy->ops.read_reg(hw, offset, &phy_data);
+
+	if (!ret_val)
+		phy->speed_downgraded = (phy_data & mask) ? true : false;
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_phy_hw_reset - PHY hardware reset
+ *  @hw: pointer to the HW structure
+ *
+ *  Verify the reset block is not blocking us from resetting.  Acquire
+ *  semaphore (if necessary) and read/set/write the device control reset
+ *  bit in the PHY.  Wait the appropriate delay time for the device to
+ *  reset and release the semaphore (if necessary).
+ **/
+s32 igc_phy_hw_reset(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32  ret_val;
+	u32 ctrl;
+
+	ret_val = igc_check_reset_block(hw);
+	if (ret_val) {
+		ret_val = 0;
+		goto out;
+	}
+
+	ret_val = phy->ops.acquire(hw);
+	if (ret_val)
+		goto out;
+
+	ctrl = rd32(IGC_CTRL);
+	wr32(IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
+	wrfl();
+
+	udelay(phy->reset_delay_us);
+
+	wr32(IGC_CTRL, ctrl);
+	wrfl();
+
+	usleep_range(1500, 2000);
+
+	phy->ops.release(hw);
+
+	ret_val = phy->ops.get_cfg_done(hw);
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_read_phy_reg_mdic - Read MDI control register
+ *  @hw: pointer to the HW structure
+ *  @offset: register offset to be read
+ *  @data: pointer to the read data
+ *
+ *  Reads the MDI control register in the PHY at offset and stores the
+ *  information read to data.
+ **/
+static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u32 i, mdic = 0;
+	s32 ret_val = 0;
+
+	if (offset > MAX_PHY_REG_ADDRESS) {
+		hw_dbg("PHY Address %d is out of range\n", offset);
+		ret_val = -IGC_ERR_PARAM;
+		goto out;
+	}
+
+	/* Set up Op-code, Phy Address, and register offset in the MDI
+	 * Control register.  The MAC will take care of interfacing with the
+	 * PHY to retrieve the desired data.
+	 */
+	mdic = ((offset << IGC_MDIC_REG_SHIFT) |
+		(phy->addr << IGC_MDIC_PHY_SHIFT) |
+		(IGC_MDIC_OP_READ));
+
+	wr32(IGC_MDIC, mdic);
+
+	/* Poll the ready bit to see if the MDI read completed
+	 * Increasing the time out as testing showed failures with
+	 * the lower time out
+	 */
+	for (i = 0; i < (IGC_GEN_POLL_TIMEOUT * 3); i++) {
+		usleep_range(500, 1000);
+		mdic = rd32(IGC_MDIC);
+		if (mdic & IGC_MDIC_READY)
+			break;
+	}
+	if (!(mdic & IGC_MDIC_READY)) {
+		hw_dbg("MDI Read did not complete\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	if (mdic & IGC_MDIC_ERROR) {
+		hw_dbg("MDI Error\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	*data = (u16)mdic;
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_write_phy_reg_mdic - Write MDI control register
+ *  @hw: pointer to the HW structure
+ *  @offset: register offset to write to
+ *  @data: data to write to register at offset
+ *
+ *  Writes data to MDI control register in the PHY@offset.
+ **/
+static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u32 i, mdic = 0;
+	s32 ret_val = 0;
+
+	if (offset > MAX_PHY_REG_ADDRESS) {
+		hw_dbg("PHY Address %d is out of range\n", offset);
+		ret_val = -IGC_ERR_PARAM;
+		goto out;
+	}
+
+	/* Set up Op-code, Phy Address, and register offset in the MDI
+	 * Control register.  The MAC will take care of interfacing with the
+	 * PHY to write the desired data.
+	 */
+	mdic = (((u32)data) |
+		(offset << IGC_MDIC_REG_SHIFT) |
+		(phy->addr << IGC_MDIC_PHY_SHIFT) |
+		(IGC_MDIC_OP_WRITE));
+
+	wr32(IGC_MDIC, mdic);
+
+	/* Poll the ready bit to see if the MDI read completed
+	 * Increasing the time out as testing showed failures with
+	 * the lower time out
+	 */
+	for (i = 0; i < (IGC_GEN_POLL_TIMEOUT * 3); i++) {
+		usleep_range(500, 1000);
+		mdic = rd32(IGC_MDIC);
+		if (mdic & IGC_MDIC_READY)
+			break;
+	}
+	if (!(mdic & IGC_MDIC_READY)) {
+		hw_dbg("MDI Write did not complete\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	if (mdic & IGC_MDIC_ERROR) {
+		hw_dbg("MDI Error\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ *  __igc_access_xmdio_reg - Read/write XMDIO register
+ *  @hw: pointer to the HW structure
+ *  @address: XMDIO address to program
+ *  @dev_addr: device address to program
+ *  @data: pointer to value to read/write from/to the XMDIO address
+ *  @read: boolean flag to indicate read or write
+ **/
+static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
+				  u8 dev_addr, u16 *data, bool read)
+{
+	s32 ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, dev_addr);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, address);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, IGC_MMDAC_FUNC_DATA |
+					dev_addr);
+	if (ret_val)
+		return ret_val;
+
+	if (read)
+		ret_val = hw->phy.ops.read_reg(hw, IGC_MMDAAD, data);
+	else
+		ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, *data);
+	if (ret_val)
+		return ret_val;
+
+	/* Recalibrate the device back to 0 */
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
+	if (ret_val)
+		return ret_val;
+
+	return ret_val;
+}
+
+/**
+ *  igc_read_xmdio_reg - Read XMDIO register
+ *  @hw: pointer to the HW structure
+ *  @addr: XMDIO address to program
+ *  @dev_addr: device address to program
+ *  @data: value to be read from the EMI address
+ **/
+static s32 igc_read_xmdio_reg(struct igc_hw *hw, u16 addr,
+			      u8 dev_addr, u16 *data)
+{
+	return __igc_access_xmdio_reg(hw, addr, dev_addr, data, true);
+}
+
+/**
+ *  igc_write_xmdio_reg - Write XMDIO register
+ *  @hw: pointer to the HW structure
+ *  @addr: XMDIO address to program
+ *  @dev_addr: device address to program
+ *  @data: value to be written to the XMDIO address
+ **/
+static s32 igc_write_xmdio_reg(struct igc_hw *hw, u16 addr,
+			       u8 dev_addr, u16 data)
+{
+	return __igc_access_xmdio_reg(hw, addr, dev_addr, &data, false);
+}
+
+/**
+ *  igc_write_phy_reg_gpy - Write GPY PHY register
+ *  @hw: pointer to the HW structure
+ *  @offset: register offset to write to
+ *  @data: data to write at register offset
+ *
+ *  Acquires semaphore, if necessary, then writes the data to PHY register
+ *  at the offset.  Release any acquired semaphores before exiting.
+ **/
+s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
+{
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+	s32 ret_val;
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
+					      data);
+	}
+	return ret_val;
+}
+
+/**
+ *  igc_read_phy_reg_gpy - Read GPY PHY register
+ *  @hw: pointer to the HW structure
+ *  @offset: lower half is register offset to read to
+ *  upper half is MMD to use.
+ *  @data: data to read at register offset
+ *
+ *  Acquires semaphore, if necessary, then reads the data in the PHY register
+ *  at the offset.  Release any acquired semaphores before exiting.
+ **/
+s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
+{
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+	s32 ret_val;
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
+					     data);
+	}
+	return ret_val;
+}
+
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
new file mode 100644
index 000000000000..deac52297052
--- /dev/null
+++ b/drivers/net/ethernet/intel/igc/igc_phy.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_PHY_H_
+#define _IGC_PHY_H_
+
+#include "igc_mac.h"
+
+s32  igc_check_reset_block(struct igc_hw *hw);
+s32  igc_phy_hw_reset(struct igc_hw *hw);
+s32  igc_get_phy_id(struct igc_hw *hw);
+s32  igc_phy_has_link(struct igc_hw *hw, u32 iterations,
+		      u32 usec_interval, bool *success);
+s32 igc_check_downshift(struct igc_hw *hw);
+void igc_power_up_phy_copper(struct igc_hw *hw);
+void igc_power_down_phy_copper(struct igc_hw *hw);
+s32  igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
+s32  igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
+
+#endif
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index aaeaf61b730a..68a1aa17b329 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -39,6 +39,9 @@
 #define IGC_SWSM		0x05B50  /* SW Semaphore */
 #define IGC_FWSM		0x05B54  /* FW Semaphore */
 
+/* Function Active and Power State to MNG */
+#define IGC_FACTPS		0x05B30
+
 /* Interrupt Register Description */
 #define IGC_EICS		0x01520  /* Ext. Interrupt Cause Set - W0 */
 #define IGC_EIMS		0x01524  /* Ext. Interrupt Mask Set/Read - RW */
-- 
2.11.0

