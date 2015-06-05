From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 19:00:47 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add link check for X550
	copper
Message-ID: <20150605230047.16560.53688.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds ixgbe_check_link_t_X550em for checking copper PHY
link.  We check that both the MAC and external PHY have link. This
is to avoid a false link up between the internal and external PHY
when  the external PHY doesn't have link.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index af884f6..0736513 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -914,6 +914,48 @@ s32 ixgbe_setup_mac_link_t_X550em(struct ixgbe_hw *hw,
 	return hw->phy.ops.setup_link_speed(hw, speed, autoneg_wait);
 }
 
+/** ixgbe_check_link_t_X550em - Determine link and speed status
+  * @hw: pointer to hardware structure
+  * @speed: pointer to link speed
+  * @link_up: true when link is up
+  * @link_up_wait_to_complete: bool used to wait for link up or not
+  *
+  * Check that both the MAC and X557 external PHY have link.
+  **/
+static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
+				     ixgbe_link_speed *speed,
+				     bool *link_up,
+				     bool link_up_wait_to_complete)
+{
+	u32 status;
+	u16 autoneg_status;
+
+	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
+		return IXGBE_ERR_CONFIG;
+
+	status = ixgbe_check_mac_link_generic(hw, speed, link_up,
+					      link_up_wait_to_complete);
+
+	/* If check link fails or MAC link is not up, then return */
+	if (status || !(*link_up))
+		return status;
+
+	 /* MAC link is up, so check external PHY link.
+	  * Read this twice back to back to indicate current status.
+	  */
+	status = hw->phy.ops.read_reg(hw, IXGBE_MDIO_AUTO_NEG_STATUS,
+				      IXGBE_MDIO_AUTO_NEG_DEV_TYPE,
+				      &autoneg_status);
+	if (status)
+		return status;
+
+	/* If external PHY link is not up, then indicate link not up */
+	if (!(autoneg_status & IXGBE_MDIO_AUTO_NEG_LINK_STATUS))
+		*link_up = false;
+
+	return 0;
+}
+
 /** ixgbe_init_mac_link_ops_X550em - init mac link function pointers
  *  @hw: pointer to hardware structure
  **/
@@ -932,6 +974,7 @@ static void ixgbe_init_mac_link_ops_X550em(struct ixgbe_hw *hw)
 		break;
 	case ixgbe_media_type_copper:
 		mac->ops.setup_link = ixgbe_setup_mac_link_t_X550em;
+		mac->ops.check_link = ixgbe_check_link_t_X550em;
 		break;
 	default:
 		break;

