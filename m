From: John W. Linville <linville@tuxdriver.com>
Date: Fri, 21 Jul 2017 14:12:24 -0400
Subject: [Intel-wired-lan] [PATCH] igb: support BCM54616 PHY
Message-ID: <b5d586566a1b523b9be65567b52898e33058a1cf.1500660210.git.>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The management port on an Edgecore AS7712-32 switch uses an igb MAC, but
it uses a BCM54616 PHY. Without a patch like this, loading the igb
module produces dmesg output like this:

[    3.439125] igb: Copyright (c) 2007-2014 Intel Corporation.
[    3.439866] igb: probe of 0000:00:14.0 failed with error -2

Signed-off-by: John W. Linville <linville@tuxdriver.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c   | 6 ++++++
 drivers/net/ethernet/intel/igb/e1000_defines.h | 1 +
 drivers/net/ethernet/intel/igb/e1000_hw.h      | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index ee443985581f..a87bc7dcea80 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -339,6 +339,9 @@ static s32 igb_init_phy_params_82575(struct e1000_hw *hw)
 		phy->ops.set_d3_lplu_state = igb_set_d3_lplu_state_82580;
 		phy->ops.force_speed_duplex = igb_phy_force_speed_duplex_m88;
 		break;
+	case BCM54616_E_PHY_ID:
+		phy->type = e1000_phy_bcm54616;
+		break;
 	default:
 		ret_val = -E1000_ERR_PHY;
 		goto out;
@@ -1658,6 +1661,9 @@ static s32 igb_setup_copper_link_82575(struct e1000_hw *hw)
 	case e1000_phy_82580:
 		ret_val = igb_copper_link_setup_82580(hw);
 		break;
+	case e1000_phy_bcm54616:
+		ret_val = 0;
+		break;
 	default:
 		ret_val = -E1000_ERR_PHY;
 		break;
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 2688180a7acd..ce95b7ec1bc7 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -867,6 +867,7 @@
 #define I210_I_PHY_ID        0x01410C00
 #define M88E1543_E_PHY_ID    0x01410EA0
 #define M88E1512_E_PHY_ID    0x01410DD0
+#define BCM54616_E_PHY_ID    0x03625D10
 
 /* M88E1000 Specific Registers */
 #define M88E1000_PHY_SPEC_CTRL     0x10  /* PHY Specific Control Register */
diff --git a/drivers/net/ethernet/intel/igb/e1000_hw.h b/drivers/net/ethernet/intel/igb/e1000_hw.h
index 2fb2213cd562..644d8f59debe 100644
--- a/drivers/net/ethernet/intel/igb/e1000_hw.h
+++ b/drivers/net/ethernet/intel/igb/e1000_hw.h
@@ -128,6 +128,7 @@ enum e1000_phy_type {
 	e1000_phy_ife,
 	e1000_phy_82580,
 	e1000_phy_i210,
+	e1000_phy_bcm54616,
 };
 
 enum e1000_bus_type {
-- 
2.13.3

