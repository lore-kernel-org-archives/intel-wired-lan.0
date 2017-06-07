From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  7 Jun 2017 14:36:20 -0700
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: Do not support flow control
	autonegotiation for X553
In-Reply-To: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
Message-ID: <20170607213621.18256-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Flow control autonegotiation is not supported for fiber on X553.  Add
device ID checks in ixgbe_device_supports_autoneg_fc() to return the
appropriate value.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4e35e70..40ae7db 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -79,13 +79,22 @@ bool ixgbe_device_supports_autoneg_fc(struct ixgbe_hw *hw)
 
 	switch (hw->phy.media_type) {
 	case ixgbe_media_type_fiber:
-		hw->mac.ops.check_link(hw, &speed, &link_up, false);
-		/* if link is down, assume supported */
-		if (link_up)
-			supported = speed == IXGBE_LINK_SPEED_1GB_FULL ?
+		/* flow control autoneg black list */
+		switch (hw->device_id) {
+		case IXGBE_DEV_ID_X550EM_A_SFP:
+		case IXGBE_DEV_ID_X550EM_A_SFP_N:
+			supported = false;
+			break;
+		default:
+			hw->mac.ops.check_link(hw, &speed, &link_up, false);
+			/* if link is down, assume supported */
+			if (link_up)
+				supported = speed == IXGBE_LINK_SPEED_1GB_FULL ?
 				true : false;
-		else
-			supported = true;
+			else
+				supported = true;
+		}
+
 		break;
 	case ixgbe_media_type_backplane:
 		supported = true;
@@ -111,6 +120,10 @@ bool ixgbe_device_supports_autoneg_fc(struct ixgbe_hw *hw)
 		break;
 	}
 
+	if (!supported)
+		hw_dbg(hw, "Device %x does not support flow control autoneg\n",
+		       hw->device_id);
+
 	return supported;
 }
 
-- 
2.9.3

