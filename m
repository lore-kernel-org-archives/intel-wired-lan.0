From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:47 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 16/16] fm10k: Fix
 configuration for macvlan offload
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185747.29785.20248.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The fm10k driver didn't work correctly when macvlan offload was enabled.
Specifically what would occur is that we would see no unicast packets being
received. This was traced down to us not correctly configuring the default
VLAN ID for the port and defaulting to 0.

To correct this we either use the default ID provided by the switch or
simply use 1. With that we are able to pass and receive traffic without any
issues.

In addition we were not repopulating the filter table following a reset. To
correct that I have added a bit of code to fm10k_restore_rx_state that will
repopulate the Rx filter configuration for the macvlan interfaces.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   25 ++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index adc62fb38c49..6d9088956407 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1182,9 +1182,10 @@ static void fm10k_set_rx_mode(struct net_device *dev)
 
 void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 {
+	struct fm10k_l2_accel *l2_accel = interface->l2_accel;
 	struct net_device *netdev = interface->netdev;
 	struct fm10k_hw *hw = &interface->hw;
-	int xcast_mode;
+	int xcast_mode, i;
 	u16 vid, glort;
 
 	/* record glort for this interface */
@@ -1234,6 +1235,24 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 	__dev_uc_sync(netdev, fm10k_uc_sync, fm10k_uc_unsync);
 	__dev_mc_sync(netdev, fm10k_mc_sync, fm10k_mc_unsync);
 
+	/* synchronize macvlan addresses */
+	if (l2_accel) {
+		for (i = 0; i < l2_accel->size; i++) {
+			struct net_device *sdev = l2_accel->macvlan[i];
+
+			if (!sdev)
+				continue;
+
+			glort = l2_accel->dglort + 1 + i;
+
+			hw->mac.ops.update_xcast_mode(hw, glort,
+						      FM10K_XCAST_MODE_MULTI);
+			fm10k_queue_mac_request(interface, glort,
+						sdev->dev_addr,
+						hw->mac.default_vid, true);
+		}
+	}
+
 	fm10k_mbx_unlock(interface);
 
 	/* record updated xcast mode state */
@@ -1490,7 +1509,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_MULTI);
 		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					0, true);
+					hw->mac.default_vid, true);
 	}
 
 	fm10k_mbx_unlock(interface);
@@ -1530,7 +1549,7 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_NONE);
 		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					0, false);
+					hw->mac.default_vid, false);
 	}
 
 	fm10k_mbx_unlock(interface);

