From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Apr 2018 11:15:54 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: setup VLANs for l2 accelerated
 macvlan interfaces
Message-ID: <20180412181559.4343-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We have support for accelerating macvlan devices via the
.ndo_dfwd_add_station() netdev op. These accelerated macvlan MAC
addresses are stored in the l2_accel structure, separate from the
unicast or multicast address lists.

If a VLAN is added on top of the macvlan device by the stack, traffic
will not properly flow to the macvlan. This occurs because we fail to
setup the VLANs for l2_accel MAC addresses.

In the non-offloaded case the MAC address is added to the unicast
address list, and thus the normal setup for enabling VLANs works as
expected.

We also need to add VLANs marked from .ndo_vlan_rx_add_vid() into the
l2_accel MAC addresses. Otherwise, VLAN traffic will not properly be
received by the VLAN devices attached to the offloaded macvlan devices.

Fix this by adding necessary logic to setup VLANs not only for the
unicast and multicast addresses, but also the l2_accel list. We need
similar logic in dfwd_add_station, dfwd_del_station, fm10k_update_vid,
and fm10k_restore_rx_state.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 50 ++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 26e749766337..36200dec941d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -925,7 +925,9 @@ static int fm10k_mc_vlan_unsync(struct net_device *netdev,
 static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 {
 	struct fm10k_intfc *interface = netdev_priv(netdev);
+	struct fm10k_l2_accel *l2_accel = interface->l2_accel;
 	struct fm10k_hw *hw = &interface->hw;
+	u16 glort;
 	s32 err;
 	int i;
 
@@ -993,6 +995,22 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (err)
 		goto err_out;
 
+	/* Update L2 accelerated macvlan addresses */
+	if (l2_accel) {
+		for (i = 0; i < l2_accel->size; i++) {
+			struct net_device *sdev = l2_accel->macvlan[i];
+
+			if (!sdev)
+				continue;
+
+			glort = l2_accel->dglort + 1 + i;
+
+			fm10k_queue_mac_request(interface, glort,
+						sdev->dev_addr,
+						vid, set);
+		}
+	}
+
 	/* set VLAN ID prior to syncing/unsyncing the VLAN */
 	interface->vid = vid + (set ? VLAN_N_VID : 0);
 
@@ -1232,6 +1250,22 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 
 		fm10k_queue_mac_request(interface, glort,
 					hw->mac.addr, vid, true);
+
+		/* synchronize macvlan addresses */
+		if (l2_accel) {
+			for (i = 0; i < l2_accel->size; i++) {
+				struct net_device *sdev = l2_accel->macvlan[i];
+
+				if (!sdev)
+					continue;
+
+				glort = l2_accel->dglort + 1 + i;
+
+				fm10k_queue_mac_request(interface, glort,
+							sdev->dev_addr,
+							vid, true);
+			}
+		}
 	}
 
 	/* update xcast mode before synchronizing addresses if host's mailbox
@@ -1448,7 +1482,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 	struct fm10k_dglort_cfg dglort = { 0 };
 	struct fm10k_hw *hw = &interface->hw;
 	int size = 0, i;
-	u16 glort;
+	u16 vid, glort;
 
 	/* The hardware supported by fm10k only filters on the destination MAC
 	 * address. In order to avoid issues we only support offloading modes
@@ -1528,6 +1562,12 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 					hw->mac.default_vid, true);
 	}
 
+	for (vid = fm10k_find_next_vlan(interface, 0);
+	     vid < VLAN_N_VID;
+	     vid = fm10k_find_next_vlan(interface, vid))
+		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
+					vid, true);
+
 	fm10k_mbx_unlock(interface);
 
 	return sdev;
@@ -1540,8 +1580,8 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 	struct fm10k_dglort_cfg dglort = { 0 };
 	struct fm10k_hw *hw = &interface->hw;
 	struct net_device *sdev = priv;
+	u16 vid, glort;
 	int i;
-	u16 glort;
 
 	if (!l2_accel)
 		return;
@@ -1568,6 +1608,12 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 					hw->mac.default_vid, false);
 	}
 
+	for (vid = fm10k_find_next_vlan(interface, 0);
+	     vid < VLAN_N_VID;
+	     vid = fm10k_find_next_vlan(interface, vid))
+		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
+					vid, false);
+
 	fm10k_mbx_unlock(interface);
 
 	/* record removal */
-- 
2.15.1.478.ga1e07cd25f8b

