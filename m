From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  6 Dec 2017 09:25:13 -0800
Subject: [Intel-wired-lan] [PATCH 4/6] fm10k: don't assume VLAN 1 is enabled
In-Reply-To: <20171206172515.37577-1-jeffrey.t.kirsher@intel.com>
References: <20171206172515.37577-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20171206172515.37577-4-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Since commit 856dfd69e84f ("fm10k: Fix multicast mode synch issues",
2016-03-03) we've incorrectly assumed that VLAN 1 is enabled when the
default VID is not set.

This occurs because we check the default_vid and if it's zero, start
several loops over the active_vlans bitmask at 1, instead of checking to
ensure that that bit is active.

This happened because of commit d9ff3ee8efe9 ("fm10k: Add support for
VLAN 0 w/o default VLAN", 2014-08-07) which mistakenly assumed that we
should send requests for MAC and VLAN filters with VLAN 0 when the
default_vid isn't set.

However, the switch generally considers this an invalid configuration,
so the only time we'd have a default_vid of 0 is when the switch is
down.

Instead, lets just not request any filters for the default_vid if it's
not yet been assigned.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index d79bff7c23f7..ec91eabbb723 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1050,14 +1050,13 @@ static int __fm10k_uc_sync(struct net_device *dev,
 			   const unsigned char *addr, bool sync)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_hw *hw = &interface->hw;
 	u16 vid, glort = interface->glort;
 	s32 err;
 
 	if (!is_valid_ether_addr(addr))
 		return -EADDRNOTAVAIL;
 
-	for (vid = hw->mac.default_vid ? fm10k_find_next_vlan(interface, 0) : 1;
+	for (vid = fm10k_find_next_vlan(interface, 0);
 	     vid < VLAN_N_VID;
 	     vid = fm10k_find_next_vlan(interface, vid)) {
 		err = fm10k_queue_mac_request(interface, glort,
@@ -1116,14 +1115,13 @@ static int __fm10k_mc_sync(struct net_device *dev,
 			   const unsigned char *addr, bool sync)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_hw *hw = &interface->hw;
 	u16 vid, glort = interface->glort;
 	s32 err;
 
 	if (!is_multicast_ether_addr(addr))
 		return -EADDRNOTAVAIL;
 
-	for (vid = hw->mac.default_vid ? fm10k_find_next_vlan(interface, 0) : 1;
+	for (vid = fm10k_find_next_vlan(interface, 0);
 	     vid < VLAN_N_VID;
 	     vid = fm10k_find_next_vlan(interface, vid)) {
 		err = fm10k_queue_mac_request(interface, glort,
@@ -1222,7 +1220,7 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 				 xcast_mode == FM10K_XCAST_MODE_PROMISC);
 
 	/* update table with current entries */
-	for (vid = hw->mac.default_vid ? fm10k_find_next_vlan(interface, 0) : 1;
+	for (vid = fm10k_find_next_vlan(interface, 0);
 	     vid < VLAN_N_VID;
 	     vid = fm10k_find_next_vlan(interface, vid)) {
 		fm10k_queue_vlan_request(interface, vid, 0, true);
-- 
2.15.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

