From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  7 Jun 2017 14:36:19 -0700
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: Update NW_MNG_IF_SEL support
	for X553
In-Reply-To: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
Message-ID: <20170607213621.18256-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The MAC register NW_MNG_IF_SEL fields have been redefined for
X553. These changes impact the iXFI driver code flow. Since iXFI is
only supported in X552, add MAC checks for iXFI flows.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 14 +++++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 62f0294..3b7cdbd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -386,7 +386,7 @@ u32 ixgbe_read_reg(struct ixgbe_hw *hw, u32 reg)
 	if (ixgbe_removed(reg_addr))
 		return IXGBE_FAILED_READ_REG;
 	if (unlikely(hw->phy.nw_mng_if_sel &
-		     IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M)) {
+		     IXGBE_NW_MNG_IF_SEL_SGMII_ENABLE)) {
 		struct ixgbe_adapter *adapter;
 		int i;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 805561c..4808978 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3786,8 +3786,8 @@ struct ixgbe_info {
 #define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_1G	BIT(19)
 #define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_2_5G	BIT(20)
 #define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_10G	BIT(21)
-#define IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M	BIT(23)
-#define IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE	BIT(24)
+#define IXGBE_NW_MNG_IF_SEL_SGMII_ENABLE	BIT(25)
+#define IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE	BIT(24) /* X552 only */
 #define IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT	3
 #define IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD	\
 				(0x1F << IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index a1bf67b..ba97685 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1555,9 +1555,14 @@ static s32 ixgbe_restart_an_internal_phy_x550em(struct ixgbe_hw *hw)
  **/
 static s32 ixgbe_setup_ixfi_x550em(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 {
+	struct ixgbe_mac_info *mac = &hw->mac;
 	s32 status;
 	u32 reg_val;
 
+	/* iXFI is only supported with X552 */
+	if (mac->type != ixgbe_mac_X550EM_x)
+		return IXGBE_ERR_LINK_SETUP;
+
 	/* Disable AN and force speed to 10G Serial. */
 	status = ixgbe_read_iosf_sb_reg_x550(hw,
 					IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
@@ -1874,8 +1879,10 @@ static s32 ixgbe_setup_mac_link_t_X550em(struct ixgbe_hw *hw,
 	else
 		force_speed = IXGBE_LINK_SPEED_1GB_FULL;
 
-	/* If internal link mode is XFI, then setup XFI internal link. */
-	if (!(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE)) {
+	/* If X552 and internal link mode is XFI, then setup XFI internal link.
+	 */
+	if (hw->mac.type == ixgbe_mac_X550EM_x &&
+	    !(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE)) {
 		status = ixgbe_setup_ixfi_x550em(hw, &force_speed);
 
 		if (status)
@@ -2628,7 +2635,8 @@ static s32 ixgbe_setup_internal_phy_t_x550em(struct ixgbe_hw *hw)
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
 		return IXGBE_ERR_CONFIG;
 
-	if (hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE) {
+	if (!(hw->mac.type == ixgbe_mac_X550EM_x &&
+	      !(hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE))) {
 		speed = IXGBE_LINK_SPEED_10GB_FULL |
 			IXGBE_LINK_SPEED_1GB_FULL;
 		return ixgbe_setup_kr_speed_x550em(hw, speed);
-- 
2.9.3

