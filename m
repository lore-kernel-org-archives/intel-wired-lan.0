From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 10:35:11 -0700
Subject: [Intel-wired-lan] [PATCH 4/7] ixgbe: Use method pointer to access
	IOSF devices
In-Reply-To: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
References: <20160318173358.28259.83547.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318173511.28259.30047.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Provide method pointers and use them to access IOSF-attached
devices. A new MAC will introduce a new access method.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   32 ++++++++++++++-----------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 818e0a10d1bd..ae4b86fff9c3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3348,6 +3348,8 @@ struct ixgbe_mac_operations {
 	s32 (*dmac_config)(struct ixgbe_hw *hw);
 	s32 (*dmac_update_tcs)(struct ixgbe_hw *hw);
 	s32 (*dmac_config_tcs)(struct ixgbe_hw *hw);
+	s32 (*read_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32 *);
+	s32 (*write_iosf_sb_reg)(struct ixgbe_hw *, u32, u32, u32);
 };
 
 struct ixgbe_phy_operations {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 615aaea069b6..b8c10e40bc9e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1670,7 +1670,7 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 	s32 status;
 	u32 reg_val;
 
-	status = ixgbe_read_iosf_sb_reg_x550(hw,
+	status = hw->mac.ops.read_iosf_sb_reg(hw,
 					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
 					IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
 	if (status)
@@ -1692,7 +1692,7 @@ static s32 ixgbe_setup_kr_speed_x550em(struct ixgbe_hw *hw,
 
 	/* Restart auto-negotiation. */
 	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
-	status = ixgbe_write_iosf_sb_reg_x550(hw,
+	status = hw->mac.ops.write_iosf_sb_reg(hw,
 					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
 					IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 
@@ -1709,9 +1709,9 @@ static s32 ixgbe_setup_kx4_x550em(struct ixgbe_hw *hw)
 	s32 status;
 	u32 reg_val;
 
-	status = ixgbe_read_iosf_sb_reg_x550(hw, IXGBE_KX4_LINK_CNTL_1,
-					     IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
-					     hw->bus.lan_id, &reg_val);
+	status = hw->mac.ops.read_iosf_sb_reg(hw, IXGBE_KX4_LINK_CNTL_1,
+					      IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
+					      hw->bus.lan_id, &reg_val);
 	if (status)
 		return status;
 
@@ -1730,9 +1730,9 @@ static s32 ixgbe_setup_kx4_x550em(struct ixgbe_hw *hw)
 
 	/* Restart auto-negotiation. */
 	reg_val |= IXGBE_KX4_LINK_CNTL_1_TETH_AN_RESTART;
-	status = ixgbe_write_iosf_sb_reg_x550(hw, IXGBE_KX4_LINK_CNTL_1,
-					      IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
-					      hw->bus.lan_id, reg_val);
+	status = hw->mac.ops.write_iosf_sb_reg(hw, IXGBE_KX4_LINK_CNTL_1,
+					       IXGBE_SB_IOSF_TARGET_KX4_PCS0 +
+					       hw->bus.lan_id, reg_val);
 
 	return status;
 }
@@ -1952,9 +1952,10 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 	if (hw->device_id != IXGBE_DEV_ID_X550EM_X_KR)
 		return 0;
 
-	rc = ixgbe_read_iosf_sb_reg_x550(hw,
-					 IXGBE_KRM_AN_CNTL_1(hw->bus.lan_id),
-					 IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
+	rc = hw->mac.ops.read_iosf_sb_reg(hw,
+					  IXGBE_KRM_AN_CNTL_1(hw->bus.lan_id),
+					  IXGBE_SB_IOSF_TARGET_KR_PHY,
+					  &reg_val);
 	if (rc)
 		return rc;
 
@@ -1964,9 +1965,10 @@ static s32 ixgbe_setup_fc_x550em(struct ixgbe_hw *hw)
 		reg_val |= IXGBE_KRM_AN_CNTL_1_SYM_PAUSE;
 	if (asm_dir)
 		reg_val |= IXGBE_KRM_AN_CNTL_1_ASM_PAUSE;
-	rc = ixgbe_write_iosf_sb_reg_x550(hw,
-					  IXGBE_KRM_AN_CNTL_1(hw->bus.lan_id),
-					  IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	rc = hw->mac.ops.write_iosf_sb_reg(hw,
+					   IXGBE_KRM_AN_CNTL_1(hw->bus.lan_id),
+					   IXGBE_SB_IOSF_TARGET_KR_PHY,
+					   reg_val);
 
 	/* This device does not fully support AN. */
 	hw->fc.disable_fc_autoneg = true;
@@ -2557,6 +2559,8 @@ static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
 	.release_swfw_sync	= &ixgbe_release_swfw_sync_X550em,
 	.init_swfw_sync		= &ixgbe_init_swfw_sync_X540,
 	.setup_fc		= NULL, /* defined later */
+	.read_iosf_sb_reg	= ixgbe_read_iosf_sb_reg_x550,
+	.write_iosf_sb_reg	= ixgbe_write_iosf_sb_reg_x550,
 };
 
 #define X550_COMMON_EEP \

