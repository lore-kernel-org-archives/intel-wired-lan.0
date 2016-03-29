From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 29 Mar 2016 16:58:12 -0700
Subject: [Intel-wired-lan] [PATCH V4 09/11] ixgbe: Add support for SGMII
	backplane interface
In-Reply-To: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
References: <20160329235544.68428.93935.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160329235812.68428.4760.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for an SGMII backplane interface.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    9 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   58 +++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1712917cd0a3..41bc816bbe87 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -131,6 +131,8 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII), board_x550em_a },
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SGMII_L), board_x550em_a },
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP), board_x550em_a },
 	/* required last entry */
 	{0, }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 40121b8b0220..eada335c03f8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -81,6 +81,8 @@
 #define IXGBE_DEV_ID_X550EM_X_10G_T	0x15AD
 #define IXGBE_DEV_ID_X550EM_X_1G_T	0x15AE
 #define IXGBE_DEV_ID_X550EM_A_SFP_N	0x15C4
+#define IXGBE_DEV_ID_X550EM_A_SGMII	0x15C6
+#define IXGBE_DEV_ID_X550EM_A_SGMII_L	0x15C7
 #define IXGBE_DEV_ID_X550EM_A_SFP	0x15CE
 
 /* VF Device IDs */
@@ -3064,6 +3066,7 @@ enum ixgbe_phy_type {
 	ixgbe_phy_qsfp_intel,
 	ixgbe_phy_qsfp_unknown,
 	ixgbe_phy_sfp_unsupported,
+	ixgbe_phy_sgmii,
 	ixgbe_phy_generic
 };
 
@@ -3581,6 +3584,7 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
 #define IXGBE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
 #define IXGBE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
+#define IXGBE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
 #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
 #define IXGBE_KRM_DSP_TXFFE_STATE_5(P)	((P) ? 0x8638 : 0x4638)
 #define IXGBE_KRM_RX_TRN_LINKUP_CTRL(P)	((P) ? 0x8B00 : 0x4B00)
@@ -3594,6 +3598,8 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_MASK	(0x7 << 8)
 #define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_1G	(2 << 8)
 #define IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_10G	(4 << 8)
+#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_SGMII_EN		(1 << 12)
+#define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CLAUSE_37_EN	(1 << 13)
 #define IXGBE_KRM_LINK_CTRL_1_TETH_AN_FEC_REQ		(1 << 14)
 #define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_FEC		(1 << 15)
 #define IXGBE_KRM_LINK_CTRL_1_TETH_AN_CAP_KX		(1 << 16)
@@ -3609,6 +3615,9 @@ struct ixgbe_info {
 #define IXGBE_KRM_AN_CNTL_8_LINEAR			BIT(0)
 #define IXGBE_KRM_AN_CNTL_8_LIMITING			BIT(1)
 
+#define IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_100_D	(1 << 12)
+#define IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_10_D		(1 << 19)
+
 #define IXGBE_KRM_DSP_TXFFE_STATE_C0_EN			(1 << 6)
 #define IXGBE_KRM_DSP_TXFFE_STATE_CP1_CN1_EN		(1 << 15)
 #define IXGBE_KRM_DSP_TXFFE_STATE_CO_ADAPT_EN		(1 << 16)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 74f76fbb56cb..bf82a30285d6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1558,6 +1558,57 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 	return 0;
 }
 
+/**
+ * ixgbe_setup_sgmii - Set up link for sgmii
+ * @hw: pointer to hardware structure
+ */
+static s32
+ixgbe_setup_sgmii(struct ixgbe_hw *hw, __always_unused ixgbe_link_speed speed,
+		  __always_unused bool autoneg_wait_to_complete)
+{
+	struct ixgbe_mac_info *mac = &hw->mac;
+	u32 lval, sval;
+	s32 rc;
+
+	rc = mac->ops.read_iosf_sb_reg(hw,
+				       IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+				       IXGBE_SB_IOSF_TARGET_KR_PHY, &lval);
+	if (rc)
+		return rc;
+
+	lval &= ~IXGBE_KRM_LINK_CTRL_1_TETH_AN_ENABLE;
+	lval &= ~IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_MASK;
+	lval |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_SGMII_EN;
+	lval |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_CLAUSE_37_EN;
+	lval |= IXGBE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_1G;
+	rc = mac->ops.write_iosf_sb_reg(hw,
+					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+					IXGBE_SB_IOSF_TARGET_KR_PHY, lval);
+	if (rc)
+		return rc;
+
+	rc = mac->ops.read_iosf_sb_reg(hw,
+				       IXGBE_KRM_SGMII_CTRL(hw->bus.lan_id),
+				       IXGBE_SB_IOSF_TARGET_KR_PHY, &sval);
+	if (rc)
+		return rc;
+
+	sval |= IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_10_D;
+	sval |= IXGBE_KRM_SGMII_CTRL_MAC_TAR_FORCE_100_D;
+	rc = mac->ops.write_iosf_sb_reg(hw,
+					IXGBE_KRM_SGMII_CTRL(hw->bus.lan_id),
+					IXGBE_SB_IOSF_TARGET_KR_PHY, sval);
+	if (rc)
+		return rc;
+
+	lval |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
+	rc = mac->ops.write_iosf_sb_reg(hw,
+					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
+					IXGBE_SB_IOSF_TARGET_KR_PHY, lval);
+
+	return rc;
+}
+
 /** ixgbe_init_mac_link_ops_X550em - init mac link function pointers
  *  @hw: pointer to hardware structure
  **/
@@ -1597,6 +1648,9 @@ static void ixgbe_init_mac_link_ops_X550em(struct ixgbe_hw *hw)
 		mac->ops.check_link = ixgbe_check_link_t_X550em;
 		return;
 	case ixgbe_media_type_backplane:
+		if (hw->device_id == IXGBE_DEV_ID_X550EM_A_SGMII ||
+		    hw->device_id == IXGBE_DEV_ID_X550EM_A_SGMII_L)
+			mac->ops.setup_link = ixgbe_setup_sgmii;
 		break;
 	default:
 		mac->ops.setup_fc = ixgbe_setup_fc_x550em;
@@ -2377,6 +2431,10 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 
 	/* Detect if there is a copper PHY attached. */
 	switch (hw->device_id) {
+	case IXGBE_DEV_ID_X550EM_A_SGMII:
+	case IXGBE_DEV_ID_X550EM_A_SGMII_L:
+		hw->phy.type = ixgbe_phy_sgmii;
+		/* Fallthrough */
 	case IXGBE_DEV_ID_X550EM_X_KR:
 	case IXGBE_DEV_ID_X550EM_X_KX4:
 		media_type = ixgbe_media_type_backplane;

