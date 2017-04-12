From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 12 Apr 2017 13:35:22 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Allow setting zero MAC address for
	VF
Message-ID: <20170412203522.57743-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, there is no logic that allows a VF's MAC address to be removed
from the RAR table.

Allow the user to specify a zero MAC address in order to clear the VF's
MAC address from the RAR table.  This functionality is also utilized by
libvirt when removing VFs.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 28 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index c45de53..58897d9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -1347,18 +1347,26 @@ void ixgbe_ping_all_vfs(struct ixgbe_adapter *adapter)
 int ixgbe_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
-	if (!is_valid_ether_addr(mac) || (vf >= adapter->num_vfs))
+
+	if (vf >= adapter->num_vfs)
+		return -EINVAL;
+
+	if (is_zero_ether_addr(mac)) {
+		adapter->vfinfo[vf].pf_set_mac = false;
+		dev_info(&adapter->pdev->dev, "removing MAC on VF %d\n", vf);
+	} else if (is_valid_ether_addr(mac)) {
+		adapter->vfinfo[vf].pf_set_mac = true;
+		dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n",
+			 mac, vf);
+		dev_info(&adapter->pdev->dev, "Reload the VF driver to make this change effective.");
+		if (test_bit(__IXGBE_DOWN, &adapter->state)) {
+			dev_warn(&adapter->pdev->dev, "The VF MAC address has been set, but the PF device is not up.\n");
+			dev_warn(&adapter->pdev->dev, "Bring the PF device up before attempting to use the VF device.\n");
+		}
+	} else {
 		return -EINVAL;
-	adapter->vfinfo[vf].pf_set_mac = true;
-	dev_info(&adapter->pdev->dev, "setting MAC %pM on VF %d\n", mac, vf);
-	dev_info(&adapter->pdev->dev, "Reload the VF driver to make this"
-				      " change effective.");
-	if (test_bit(__IXGBE_DOWN, &adapter->state)) {
-		dev_warn(&adapter->pdev->dev, "The VF MAC address has been set,"
-			 " but the PF device is not up.\n");
-		dev_warn(&adapter->pdev->dev, "Bring the PF device up before"
-			 " attempting to use the VF device.\n");
 	}
+
 	return ixgbe_set_vf_mac(adapter, vf, mac);
 }
 
-- 
2.9.3

