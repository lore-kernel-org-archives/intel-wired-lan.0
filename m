From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 20 Apr 2017 08:52:33 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove MAC X550EM_X 1Gbase-t
	led_[on|off] support
Message-ID: <1492692753-55535-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since FW configures the PHY and MAC X550EM_X has no
PHY access, led_[on|off] is not supported with the 1Gbase-t design.

Removed MAC X550EM_X 1Gbase-t led_[on|off] support by setting
function pointers to NULL and added NULL pointer checks. Also set
init_led_link_act to NULL and added NULL pointer check.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |  3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  3 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    | 27 ++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index c38d50c..3af6127 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -395,7 +395,8 @@ s32 ixgbe_init_hw_generic(struct ixgbe_hw *hw)
 	}
 
 	/* Initialize the LED link active for LED blink support */
-	hw->mac.ops.init_led_link_act(hw);
+	if (hw->mac.ops.init_led_link_act)
+		hw->mac.ops.init_led_link_act(hw);
 
 	return status;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 7e5e336..cced74d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2254,6 +2254,9 @@ static int ixgbe_set_phys_id(struct net_device *netdev,
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
 	struct ixgbe_hw *hw = &adapter->hw;
 
+	if (!hw->mac.ops.led_on || !hw->mac.ops.led_off)
+		return -EOPNOTSUPP;
+
 	switch (state) {
 	case ETHTOOL_ID_ACTIVE:
 		adapter->led_reg = IXGBE_READ_REG(hw, IXGBE_LEDCTL);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 2ba024b..75dd1a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -3206,6 +3206,7 @@ static s32 ixgbe_init_phy_ops_X550em(struct ixgbe_hw *hw)
 		phy->ops.setup_link = NULL;
 		phy->ops.read_reg = NULL;
 		phy->ops.write_reg = NULL;
+		phy->ops.reset = NULL;
 		break;
 	default:
 		break;
@@ -3819,7 +3820,29 @@ static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
 	.write_iosf_sb_reg	= ixgbe_write_iosf_sb_reg_x550,
 };
 
-static struct ixgbe_mac_operations mac_ops_x550em_a = {
+static const struct ixgbe_mac_operations mac_ops_X550EM_x_fw = {
+	X550_COMMON_MAC
+	.led_on			= NULL,
+	.led_off		= NULL,
+	.init_led_link_act	= NULL,
+	.reset_hw		= &ixgbe_reset_hw_X550em,
+	.get_media_type		= &ixgbe_get_media_type_X550em,
+	.get_san_mac_addr	= NULL,
+	.get_wwn_prefix		= NULL,
+	.setup_link		= &ixgbe_setup_mac_link_X540,
+	.get_link_capabilities	= &ixgbe_get_link_capabilities_X550em,
+	.get_bus_info		= &ixgbe_get_bus_info_X550em,
+	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,
+	.acquire_swfw_sync	= &ixgbe_acquire_swfw_sync_X550em,
+	.release_swfw_sync	= &ixgbe_release_swfw_sync_X550em,
+	.init_swfw_sync		= &ixgbe_init_swfw_sync_X540,
+	.setup_fc		= NULL,
+	.fc_autoneg		= ixgbe_fc_autoneg,
+	.read_iosf_sb_reg	= ixgbe_read_iosf_sb_reg_x550,
+	.write_iosf_sb_reg	= ixgbe_write_iosf_sb_reg_x550,
+};
+
+	static struct ixgbe_mac_operations mac_ops_x550em_a = {
 	X550_COMMON_MAC
 	.led_on			= ixgbe_led_on_t_x550em,
 	.led_off		= ixgbe_led_off_t_x550em,
@@ -3986,7 +4009,7 @@ const struct ixgbe_info ixgbe_X550EM_x_info = {
 const struct ixgbe_info ixgbe_x550em_x_fw_info = {
 	.mac			= ixgbe_mac_X550EM_x,
 	.get_invariants		= ixgbe_get_invariants_X550_x_fw,
-	.mac_ops		= &mac_ops_X550EM_x,
+	.mac_ops		= &mac_ops_X550EM_x_fw,
 	.eeprom_ops		= &eeprom_ops_X550EM_x,
 	.phy_ops		= &phy_ops_x550em_x_fw,
 	.mbx_ops		= &mbx_ops_generic,
-- 
2.7.4

