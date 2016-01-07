From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:11:34 -0800
Subject: [Intel-wired-lan] [next PATCH 10/11] igb: Enable use of "bridge fdb
 add" to set unicast table entries
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071133.13648.51584.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change makes it so that we can use the bridge utility to add a FDB
entry for the PF to an igb port.  By doing this we can enable the VFs to
talk to virtual ports residing on top of the PF.

In addition this should also address issues with MACVLANs trying to reside
on top of the PF as well as they would have had similar issues when added
to the PF with SR-IOV enabled.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   39 ++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 49daac3bb051..06b8b1e0362b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2126,6 +2126,25 @@ static u16 igb_select_queue(struct net_device *netdev,
 		return fallback(netdev, skb);
 }
 
+static int igb_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
+			   struct net_device *dev,
+			   const unsigned char *addr, u16 vid,
+			   u16 flags)
+{
+	/* guarantee we can provide a unique filter for the unicast address */
+	if (is_unicast_ether_addr(addr) || is_link_local_ether_addr(addr)) {
+		struct igb_adapter *adapter = netdev_priv(dev);
+		struct e1000_hw *hw = &adapter->hw;
+		int vfn = adapter->vfs_allocated_count;
+		int rar_entries = hw->mac.rar_entry_count - (vfn + 1);
+
+		if (netdev_uc_count(dev) >= rar_entries)
+			return -ENOMEM;
+	}
+
+	return ndo_dflt_fdb_add(ndm, tb, dev, addr, vid, flags);
+}
+
 static const struct net_device_ops igb_netdev_ops = {
 	.ndo_open		= igb_open,
 	.ndo_stop		= igb_close,
@@ -2150,6 +2169,7 @@ static const struct net_device_ops igb_netdev_ops = {
 #endif
 	.ndo_fix_features	= igb_fix_features,
 	.ndo_set_features	= igb_set_features,
+	.ndo_fdb_add		= igb_ndo_fdb_add,
 	.ndo_features_check	= passthru_features_check,
 };
 
@@ -4256,15 +4276,16 @@ static void igb_set_rx_mode(struct net_device *netdev)
 				vmolr |= E1000_VMOLR_ROMPE;
 			}
 		}
-		/* Write addresses to available RAR registers, if there is not
-		 * sufficient space to store all the addresses then enable
-		 * unicast promiscuous mode
-		 */
-		count = igb_write_uc_addr_list(netdev);
-		if (count < 0) {
-			rctl |= E1000_RCTL_UPE;
-			vmolr |= E1000_VMOLR_ROPE;
-		}
+	}
+
+	/* Write addresses to available RAR registers, if there is not
+	 * sufficient space to store all the addresses then enable
+	 * unicast promiscuous mode
+	 */
+	count = igb_write_uc_addr_list(netdev);
+	if (count < 0) {
+		rctl |= E1000_RCTL_UPE;
+		vmolr |= E1000_VMOLR_ROPE;
 	}
 
 	/* enable VLAN filtering by default */

