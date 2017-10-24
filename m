From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Tue, 24 Oct 2017 08:31:07 -0400
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: advertise highest capable link
	speed
Message-ID: <1508848267-35221-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On module insert advertise highest capable link speed. If module is
capable of 10G, then advertise 10G, else advertise modules capable
link speeds.

v2 - Simplify logic based on feedback.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1e1aee1..a33bb7e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7648,6 +7648,7 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 static void ixgbe_sfp_link_config_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 cap_speed;
 	u32 speed;
 	bool autoneg = false;
 
@@ -7660,16 +7661,14 @@ static void ixgbe_sfp_link_config_subtask(struct ixgbe_adapter *adapter)
 
 	adapter->flags &= ~IXGBE_FLAG_NEED_LINK_CONFIG;
 
-	speed = hw->phy.autoneg_advertised;
-	if ((!speed) && (hw->mac.ops.get_link_capabilities)) {
-		hw->mac.ops.get_link_capabilities(hw, &speed, &autoneg);
+	hw->mac.ops.get_link_capabilities(hw, &cap_speed, &autoneg);
 
-		/* setup the highest link when no autoneg */
-		if (!autoneg) {
-			if (speed & IXGBE_LINK_SPEED_10GB_FULL)
-				speed = IXGBE_LINK_SPEED_10GB_FULL;
-		}
-	}
+	/* advertise highest capable link speed */
+	if (!autoneg && (cap_speed & IXGBE_LINK_SPEED_10GB_FULL))
+		speed = IXGBE_LINK_SPEED_10GB_FULL;
+	else
+		speed = cap_speed & (IXGBE_LINK_SPEED_10GB_FULL |
+			IXGBE_LINK_SPEED_1GB_FULL);
 
 	if (hw->mac.ops.setup_link)
 		hw->mac.ops.setup_link(hw, speed, true);
-- 
2.7.4

