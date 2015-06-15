From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Jun 2015 15:00:56 -0700
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: update netdev perm_addr during
	reinit, instead of at up
In-Reply-To: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434405656-10465-6-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Update the netdev permanent address during fm10k_reinit enables the user
to immediately see the new MAC address on the VF even if the device
isn't up. The previous code required that the device by opened before
changes would appear.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 15 ---------------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 818bc8b1fa58..b2065cb44edc 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -996,21 +996,6 @@ void fm10k_restore_rx_state(struct fm10k_intfc *interface)
 	int xcast_mode;
 	u16 vid, glort;
 
-	/* restore our address if perm_addr is set */
-	if (hw->mac.type == fm10k_mac_vf) {
-		if (is_valid_ether_addr(hw->mac.perm_addr)) {
-			ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
-			ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
-			ether_addr_copy(netdev->dev_addr, hw->mac.perm_addr);
-			netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
-		}
-
-		if (hw->mac.vlan_override)
-			netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX;
-		else
-			netdev->features |= NETIF_F_HW_VLAN_CTAG_RX;
-	}
-
 	/* record glort for this interface */
 	glort = interface->glort;
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index d8ab6cdca456..dc354c74fd58 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -170,6 +170,21 @@ static void fm10k_reinit(struct fm10k_intfc *interface)
 	/* reassociate interrupts */
 	fm10k_mbx_request_irq(interface);
 
+	/* update hardware address for VFs if perm_addr has changed */
+	if (hw->mac.type == fm10k_mac_vf) {
+		if (is_valid_ether_addr(hw->mac.perm_addr)) {
+			ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
+			ether_addr_copy(netdev->perm_addr, hw->mac.perm_addr);
+			ether_addr_copy(netdev->dev_addr, hw->mac.perm_addr);
+			netdev->addr_assign_type &= ~NET_ADDR_RANDOM;
+		}
+
+		if (hw->mac.vlan_override)
+			netdev->features &= ~NETIF_F_HW_VLAN_CTAG_RX;
+		else
+			netdev->features |= NETIF_F_HW_VLAN_CTAG_RX;
+	}
+
 	/* reset clock */
 	fm10k_ts_reset(interface);
 
-- 
2.4.2

