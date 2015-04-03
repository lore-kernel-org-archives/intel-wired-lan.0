From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:11 -0700
Subject: [Intel-wired-lan] [net-next 21/25] fm10k: update xcast mode before
	synchronizing multicast addresses
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-21-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the PF receives a request to update a multicast address for the VF,
it checks the enabled multicast mode first. Fix a bug where the VF tried
to set a multicast address before requesting the required xcast mode.
This ensures the multicast addresses are honored as long as the xcast
mode was allowed.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index c9f87bb..7f5c36a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -966,14 +966,7 @@ static void fm10k_set_rx_mode(struct net_device *dev)
 
 	fm10k_mbx_lock(interface);
 
-	/* synchronize all of the addresses */
-	if (xcast_mode != FM10K_XCAST_MODE_PROMISC) {
-		__dev_uc_sync(dev, fm10k_uc_sync, fm10k_uc_unsync);
-		if (xcast_mode != FM10K_XCAST_MODE_ALLMULTI)
-			__dev_mc_sync(dev, fm10k_mc_sync, fm10k_mc_unsync);
-	}
-
-	/* if we aren't changing modes there is nothing to do */
+	/* update xcast mode first, but only if it changed */
 	if (interface->xcast_mode != xcast_mode) {
 		/* update VLAN table */
 		if (xcast_mode == FM10K_XCAST_MODE_PROMISC)
@@ -988,6 +981,13 @@ static void fm10k_set_rx_mode(struct net_device *dev)
 		interface->xcast_mode = xcast_mode;
 	}
 
+	/* synchronize all of the addresses */
+	if (xcast_mode != FM10K_XCAST_MODE_PROMISC) {
+		__dev_uc_sync(dev, fm10k_uc_sync, fm10k_uc_unsync);
+		if (xcast_mode != FM10K_XCAST_MODE_ALLMULTI)
+			__dev_mc_sync(dev, fm10k_mc_sync, fm10k_mc_unsync);
+	}
+
 	fm10k_mbx_unlock(interface);
 }
 
@@ -1047,6 +1047,9 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 					   vid, true, 0);
 	}
 
+	/* update xcast mode before syncronizing addresses */
+	hw->mac.ops.update_xcast_mode(hw, glort, xcast_mode);
+
 	/* synchronize all of the addresses */
 	if (xcast_mode != FM10K_XCAST_MODE_PROMISC) {
 		__dev_uc_sync(netdev, fm10k_uc_sync, fm10k_uc_unsync);
@@ -1054,9 +1057,6 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 			__dev_mc_sync(netdev, fm10k_mc_sync, fm10k_mc_unsync);
 	}
 
-	/* update xcast mode */
-	hw->mac.ops.update_xcast_mode(hw, glort, xcast_mode);
-
 	fm10k_mbx_unlock(interface);
 
 	/* record updated xcast mode state */
-- 
1.9.3

