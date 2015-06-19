From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 19 Jun 2015 16:37:35 -0700
Subject: [Intel-wired-lan] [net-next 06/10] fm10k: send traffic on default
	vid to vlan device if we have one
In-Reply-To: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434757059-3384-6-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch ensures that vlan traffic on the default vid will go to the
corresponding vlan device if it exists. To do this, mask the rx_ring vid
if we have an active vlan on that vid.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 12 ++++++++++++
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index e1ceb3a2e2cd..c173c79373fe 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -758,6 +758,7 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	struct fm10k_intfc *interface = netdev_priv(netdev);
 	struct fm10k_hw *hw = &interface->hw;
 	s32 err;
+	int i;
 
 	/* updates do not apply to VLAN 0 */
 	if (!vid)
@@ -775,6 +776,17 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (!set)
 		clear_bit(vid, interface->active_vlans);
 
+	/* disable the default vid on ring if we have an active vlan */
+	for (i = 0; i < interface->num_rx_queues; i++) {
+		struct fm10k_ring *rx_ring = interface->rx_ring[i];
+		u16 rx_vid = rx_ring->vid & (VLAN_N_VID - 1);
+
+		if (test_bit(rx_vid, interface->active_vlans))
+			rx_ring->vid |= FM10K_VLAN_CLEAR;
+		else
+			rx_ring->vid &= ~FM10K_VLAN_CLEAR;
+	}
+
 	/* Do not remove default VID related entries from VLAN and MAC tables */
 	if (!set && vid == hw->mac.default_vid)
 		return 0;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 6d1364393a8b..989981ea3c64 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -694,6 +694,10 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	/* assign default VLAN to queue */
 	ring->vid = hw->mac.default_vid;
 
+	/* if we have an active VLAN, disable default vid */
+	if (test_bit(hw->mac.default_vid, interface->active_vlans))
+		ring->vid |= FM10K_VLAN_CLEAR;
+
 	/* Map interrupt */
 	if (ring->q_vector) {
 		rxint = ring->q_vector->v_idx + NON_Q_VECTORS(hw);
-- 
2.4.3

