From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Thu, 3 Jan 2019 22:28:57 +0100
Subject: [Intel-wired-lan] e1000e driver stuck at 10Mbps after reconnection
Message-ID: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi

I'm seeing the same problem as Camille Bordignon in August
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20180806/013606.html

I'm on Ubuntu 18.04 (Kernel 4.15) and Ubuntu 12.04 + 14.04 HWE (Kernel 4.4).

My hardware is a Fujitsu laptop, u757 series, Skylake based.

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection I219-LM (rev 21)
        Subsystem: Fujitsu Limited. Ethernet Connection I219-LM
        Flags: bus master, fast devsel, latency 0, IRQ 128
        Memory at c1200000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] PCI Advanced Features
        Kernel driver in use: e1000e
        Kernel modules: e1000e

Almost always a reconnect brings the connection down to 10M. It seems to work correctly from an
initramfs, if no traffic is send (almost always). Starting the dhclient for the interface brings it
down on reconnect.

All the following stuff is from running the Ubuntu 4.20 vanilla kernel build and an extra patched
e1000e module. I've not yet compiled current master.

I put the following debug output into the module:

diff --git a/mac.c b/mac.c
index 4abd55d..7eae7ae 100644
--- a/mac.c
+++ b/mac.c
@@ -1308,6 +1308,7 @@ s32 e1000e_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
 	u32 status;

 	status = er32(STATUS);
+	pr_info("e1000e_get_speed_and_duplex_copper::status %x\n", status);
 	if (status & E1000_STATUS_SPEED_1000)
 		*speed = SPEED_1000;
 	else if (status & E1000_STATUS_SPEED_100)
diff --git a/netdev.c b/netdev.c
index 16a73bd..3016ac1 100644
--- a/netdev.c
+++ b/netdev.c
@@ -5070,6 +5070,7 @@ static bool e1000e_has_link(struct e1000_adapter *adapter)
 		if (hw->mac.get_link_status) {
 			ret_val = hw->mac.ops.check_for_link(hw);
 			link_active = !hw->mac.get_link_status;
+			pr_info("e1000e_has_link::check_for_link %i\n", ret_val);
 		} else {
 			link_active = true;
 		}

Some "evidence" I discovered:
* Link state is always correct when I have a link before module load (on boot or with rmmod + modprobe)
* It doesn't matter if I connect to a switch or simply cross-connect two U7x7
* Booting just the initramfs and re-connecting seems to work (very often) until data is transmitted.

From the debug info I took the following:
* The check_for_link is always 0 / ok.
* The working status is always 0x80083 and the broken most time 0x40080003. Once out of 50 I had a
0x80003 following the 0x40080003.

I also have some older Skylake HW (Fujitsu e737)

00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection I219-V (rev 21)
        Subsystem: Fujitsu Limited. Ethernet Connection I219-V
        Flags: bus master, fast devsel, latency 0, IRQ 125
        Memory at a1200000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] PCI Advanced Features
        Kernel driver in use: e1000e
        Kernel modules: e1000e

where I couldn't reproduce with the problem with Ubuntu 12.04 + 14.04 HWE (Kernel 4.4).

If I remember correctly my colleague could reproduce the problem with the u727 hardware (should be
the same then u757, just smaller) and the 12.04 based installation (kernel 4.4). I will test this
tomorrow again with my u757 hardware.

There was some discussion about putting some sleep somewhere, which was later dropped again.
Is a status matching 0x40000000 valid? At least there isn't a definition for a match.

And I noticed the "PHYAD" value from ethtool changes. The rule of thumb it 1 with link and 2
without. It instantly changes to 2 on lost link, but it takes some time after a link to change back
to 1 after the auto-negotiation.

Jan-Marek

P.S. I also tired the following patch, after I found the duplicate code. Didn't change anything for
me and I don't know if the new check in e1000e_get_speed_and_duplex_copper is always correct.

From bcd0ec30383698f0da14a9f675ae7475175f979a Mon Sep 17 00:00:00 2001
From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Thu, 3 Jan 2019 22:11:25 +0100
Subject: [PATCH] e1000e: drop duplicate speed + duplex decoding code

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
---
 80003es2lan.c |  4 ++--
 e1000.h       |  2 +-
 ethtool.c     | 21 +++++----------------
 hw.h          |  2 +-
 ich8lan.c     |  8 +++++---
 mac.c         | 11 ++++++++---
 mac.h         |  4 ++--
 7 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/80003es2lan.c b/80003es2lan.c
index 257bd59..7779346 100644
--- a/80003es2lan.c
+++ b/80003es2lan.c
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
diff --git a/e1000.h b/e1000.h
index c760dc7..190a4cd 100644
--- a/e1000.h
+++ b/e1000.h
@@ -200,7 +200,7 @@ struct e1000_adapter {
 	u32 rx_buffer_len;
 	u16 mng_vlan_id;
 	u16 link_speed;
-	u16 link_duplex;
+	u8 link_duplex;
 	u16 eeprom_vers;

 	/* track device up/down/testing state */
diff --git a/ethtool.c b/ethtool.c
index 02ebf20..dafdeed 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -105,7 +105,8 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 speed, supported, advertising;
+	u32 supported, advertising;
+	u16 speed;

 	if (hw->phy.media_type == e1000_media_type_copper) {
 		supported = (SUPPORTED_10baseT_Half |
@@ -148,21 +149,9 @@ static int e1000_get_link_ksettings(struct net_device *netdev,
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
+		if (!e1000e_get_speed_and_duplex_copper(hw, &speed,
+							&cmd->base.duplex))
+			cmd->base.speed = SPEED_UNKNOWN;
 	}

 	cmd->base.speed = speed;
diff --git a/hw.h b/hw.h
index eff75bd..d3c18ce 100644
--- a/hw.h
+++ b/hw.h
@@ -460,7 +460,7 @@ struct e1000_mac_operations {
 	void (*clear_vfta)(struct e1000_hw *);
 	s32  (*get_bus_info)(struct e1000_hw *);
 	void (*set_lan_id)(struct e1000_hw *);
-	s32  (*get_link_up_info)(struct e1000_hw *, u16 *, u16 *);
+	s32  (*get_link_up_info)(struct e1000_hw *, u16 *, u8 *);
 	s32  (*led_on)(struct e1000_hw *);
 	s32  (*led_off)(struct e1000_hw *);
 	void (*update_mc_addr_list)(struct e1000_hw *, u8 *, u32);
diff --git a/ich8lan.c b/ich8lan.c
index cdae0ef..fd59970 100644
--- a/ich8lan.c
+++ b/ich8lan.c
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

diff --git a/mac.c b/mac.c
index 4abd55d..19c816c 100644
--- a/mac.c
+++ b/mac.c
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
diff --git a/mac.h b/mac.h
index 6ab2611..c4416e8 100644
--- a/mac.h
+++ b/mac.h
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
2.17.1

