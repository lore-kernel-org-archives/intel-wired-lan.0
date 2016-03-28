From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Mon, 28 Mar 2016 14:18:00 -0700
Subject: [Intel-wired-lan] [PATCH V3 06/11] ixgbe: Read and parse
	NW_MNG_IF_SEL register
In-Reply-To: <20160328211623.68937.52252.stgit@mdrustad-wks.jf.intel.com>
References: <20160328211623.68937.52252.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160328211800.68937.93319.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Read the IXGBE_NW_MNG_IF_SEL register and use it to set interface
attributes.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   37 ++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 3fc447a7c15d..3e0dd5584d4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3648,5 +3648,10 @@ struct ixgbe_info {
 #define IXGBE_SB_IOSF_TARGET_KX4_PCS1	3
 
 #define IXGBE_NW_MNG_IF_SEL		0x00011178
+#define IXGBE_NW_MNG_IF_SEL_MDIO_ACT		BIT(1)
+#define IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M	BIT(23)
 #define IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE	BIT(24)
+#define IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT	3
+#define IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD	\
+				(0x1F << IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT)
 #endif /* _IXGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index ee925854c999..846cfcd53d5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2137,6 +2137,36 @@ static s32 ixgbe_enter_lplu_t_x550em(struct ixgbe_hw *hw)
 	return status;
 }
 
+/**
+ * ixgbe_read_mng_if_sel_x550em - Read NW_MNG_IF_SEL register
+ * @hw: pointer to hardware structure
+ *
+ * Read NW_MNG_IF_SEL register and save field values.
+ */
+static void ixgbe_read_mng_if_sel_x550em(struct ixgbe_hw *hw)
+{
+	/* Save NW management interface connected on board. This is used
+	 * to determine internal PHY mode.
+	 */
+	hw->phy.nw_mng_if_sel = IXGBE_READ_REG(hw, IXGBE_NW_MNG_IF_SEL);
+
+	/* If X552 (X550EM_a) and MDIO is connected to external PHY, then set
+	 * PHY address. This register field was has only been used for X552.
+	 */
+	if (!hw->phy.nw_mng_if_sel) {
+		if (hw->mac.type == ixgbe_mac_x550em_a) {
+			struct ixgbe_adapter *adapter = hw->back;
+
+			e_warn(drv, "nw_mng_if_sel not set\n");
+		}
+		return;
+	}
+
+	hw->phy.mdio.prtad = (hw->phy.nw_mng_if_sel &
+			      IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD) >>
+			     IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT;
+}
+
 /** ixgbe_init_phy_ops_X550em - PHY/SFP specific init
  *  @hw: pointer to hardware structure
  *
@@ -2151,14 +2181,11 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 
 	hw->mac.ops.set_lan_id(hw);
 
+	ixgbe_read_mng_if_sel_x550em(hw);
+
 	if (hw->mac.ops.get_media_type(hw) == ixgbe_media_type_fiber) {
 		phy->phy_semaphore_mask = IXGBE_GSSR_SHARED_I2C_SM;
 		ixgbe_setup_mux_ctl(hw);
-
-		/* Save NW management interface connected on board. This is used
-		 * to determine internal PHY mode.
-		 */
-		phy->nw_mng_if_sel = IXGBE_READ_REG(hw, IXGBE_NW_MNG_IF_SEL);
 	}
 
 	/* Identify the PHY or SFP module */

