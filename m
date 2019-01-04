From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Fri,  4 Jan 2019 14:31:05 +0100
Subject: [Intel-wired-lan] [PATCH 1/3] e1000e: drop duplicate speed + duplex
 decoding code
In-Reply-To: <1546608667-25498-1-git-send-email-glogow@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
Message-ID: <1546608667-25498-2-git-send-email-glogow@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This also moves the link-up status checks into the common speed
and duplex status extraction code. I expect the speed and duplex
status to be invalid, if there is no link-up.

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c |  4 ++--
 drivers/net/ethernet/intel/e1000e/e1000.h       |  2 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c     | 20 ++++----------------
 drivers/net/ethernet/intel/e1000e/hw.h          |  2 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c     |  8 +++++---
 drivers/net/ethernet/intel/e1000e/mac.c         | 11 ++++++++---
 drivers/net/ethernet/intel/e1000e/mac.h         |  4 ++--
 7 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59..7779346 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -638,7 +638,7 @@ static s32 e1000_get_cable_length_80003es2lan(struct e1000_hw *hw)
  *  Retrieve the current speed and duplex configuration.
  **/
 static s32 e1000_get_link_up_info_80003es2lan(struct e1000_hw *hw, u16 *speed,
-					      u16 *duplex)
+					      u8 *duplex)
 {
 	s32 ret_val;
 
@@ -1068,7 +1068,7 @@ static s32 e1000_cfg_on_link_up_80003es2lan(struct e1000_hw *hw)
 {
 	s32 ret_val = 0;
 	u16 speed;
-	u16 duplex;
+	u8 duplex;
 
 	if (hw->phy.media_type == e1000_media_type_copper) {
 		ret_val = e1000e_get_speed_and_duplex_copper(hw, &speed,
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index be13227..7fd8d26 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -200,7 +200,7 @@ struct e1000_adapter {
 	u32 rx_buffer_len;
 	u16 mng_vlan_id;
 	u16 link_speed;
-	u16 link_duplex;
+	u8 link_duplex;
 	u16 eeprom_vers;
 
 	/* track device up/down/testing state */
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 02ebf20..d6ad54b 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -105,7 +105,8 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 speed, supported, advertising;
+	u32 supported, advertising;
+	u16 speed;
 
 	if (hw->phy.media_type == e1000_media_type_copper) {
 		supported = (SUPPORTED_10baseT_Half |
@@ -148,21 +149,8 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 			cmd->base.duplex = adapter->link_duplex - 1;
 		}
 	} else if (!pm_runtime_suspended(netdev->dev.parent)) {
-		u32 status = er32(STATUS);
-
-		if (status & E1000_STATUS_LU) {
-			if (status & E1000_STATUS_SPEED_1000)
-				speed = SPEED_1000;
-			else if (status & E1000_STATUS_SPEED_100)
-				speed = SPEED_100;
-			else
-				speed = SPEED_10;
-
-			if (status & E1000_STATUS_FD)
-				cmd->base.duplex = DUPLEX_FULL;
-			else
-				cmd->base.duplex = DUPLEX_HALF;
-		}
+		e1000e_get_speed_and_duplex_copper(hw, &speed,
+						   &cmd->base.duplex);
 	}
 
 	cmd->base.speed = speed;
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index eff75bd..d3c18ce 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -460,7 +460,7 @@ struct e1000_mac_operations {
 	void (*clear_vfta)(struct e1000_hw *);
 	s32  (*get_bus_info)(struct e1000_hw *);
 	void (*set_lan_id)(struct e1000_hw *);
-	s32  (*get_link_up_info)(struct e1000_hw *, u16 *, u16 *);
+	s32  (*get_link_up_info)(struct e1000_hw *, u16 *, u8 *);
 	s32  (*led_on)(struct e1000_hw *);
 	s32  (*led_off)(struct e1000_hw *);
 	void (*update_mc_addr_list)(struct e1000_hw *, u8 *, u32);
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index cdae0ef..fd59970 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -998,7 +998,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 	u16 lat_enc = 0;	/* latency encoded */
 
 	if (link) {
-		u16 speed, duplex, scale = 0;
+		u16 speed, scale = 0;
+		u8 duplex;
 		u16 max_snoop, max_nosnoop;
 		u16 max_ltr_enc;	/* max LTR latency encoded */
 		u64 value;
@@ -1386,7 +1387,8 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	 * the IPG and reduce Rx latency in the PHY.
 	 */
 	if ((hw->mac.type >= e1000_pch2lan) && link) {
-		u16 speed, duplex;
+		u16 speed;
+		u8 duplex;
 
 		e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex);
 		tipg_reg = er32(TIPG);
@@ -5074,7 +5076,7 @@ static s32 e1000_setup_copper_link_pch_lpt(struct e1000_hw *hw)
  *  gigabit speeds.
  **/
 static s32 e1000_get_link_up_info_ich8lan(struct e1000_hw *hw, u16 *speed,
-					  u16 *duplex)
+					  u8 *duplex)
 {
 	s32 ret_val;
 
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 4abd55d..19c816c 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1004,7 +1004,8 @@ s32 e1000e_config_fc_after_link_up(struct e1000_hw *hw)
 	s32 ret_val = 0;
 	u32 pcs_status_reg, pcs_adv_reg, pcs_lp_ability_reg, pcs_ctrl_reg;
 	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
-	u16 speed, duplex;
+	u16 speed;
+	u8 duplex;
 
 	/* Check for the case where we have fiber media and auto-neg failed
 	 * so we had to force link.  In this case, we need to force the
@@ -1303,11 +1304,15 @@ s32 e1000e_config_fc_after_link_up(struct e1000_hw *hw)
  *  speed and duplex for copper connections.
  **/
 s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
-				       u16 *duplex)
+				       u8 *duplex)
 {
 	u32 status;
 
 	status = er32(STATUS);
+
+	if (!(status & E1000_STATUS_LU))
+		return 1;
+
 	if (status & E1000_STATUS_SPEED_1000)
 		*speed = SPEED_1000;
 	else if (status & E1000_STATUS_SPEED_100)
@@ -1337,7 +1342,7 @@ s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
  *  for fiber/serdes links.
  **/
 s32 e1000e_get_speed_and_duplex_fiber_serdes(struct e1000_hw __always_unused
-					     *hw, u16 *speed, u16 *duplex)
+					     *hw, u16 *speed, u8 *duplex)
 {
 	*speed = SPEED_1000;
 	*duplex = FULL_DUPLEX;
diff --git a/drivers/net/ethernet/intel/e1000e/mac.h b/drivers/net/ethernet/intel/e1000e/mac.h
index 6ab2611..c4416e8 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.h
+++ b/drivers/net/ethernet/intel/e1000e/mac.h
@@ -17,9 +17,9 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw);
 void e1000_set_lan_id_single_port(struct e1000_hw *hw);
 s32 e1000e_get_hw_semaphore(struct e1000_hw *hw);
 s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
-				       u16 *duplex);
+				       u8 *duplex);
 s32 e1000e_get_speed_and_duplex_fiber_serdes(struct e1000_hw *hw,
-					     u16 *speed, u16 *duplex);
+					     u16 *speed, u8 *duplex);
 s32 e1000e_id_led_init_generic(struct e1000_hw *hw);
 s32 e1000e_led_on_generic(struct e1000_hw *hw);
 s32 e1000e_led_off_generic(struct e1000_hw *hw);
-- 
2.1.4

