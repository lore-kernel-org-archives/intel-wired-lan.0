From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  5 Feb 2018 13:03:32 -0800
Subject: [Intel-wired-lan] [S86 v3 3/8] i40evf: Use an iterator of the same
 type as the list
In-Reply-To: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
References: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180205210337.22102-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

When iterating through the linked list of vlan filters, make the
iterator the same type as that of the linked list.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 69d7e457e593..fcc49e1177d7 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1027,6 +1027,7 @@ static void i40evf_up_complete(struct i40evf_adapter *adapter)
 void i40evf_down(struct i40evf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct i40evf_vlan_filter *vlf;
 	struct i40evf_mac_filter *f;
 	struct i40evf_cloud_filter *cf;
 
@@ -1046,8 +1047,8 @@ void i40evf_down(struct i40evf_adapter *adapter)
 		f->remove = true;
 	}
 	/* remove all VLAN filters */
-	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-		f->remove = true;
+	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
+		vlf->remove = true;
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
@@ -3857,6 +3858,7 @@ static void i40evf_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct i40evf_vlan_filter *vlf, *vlftmp;
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40evf_cloud_filter *cf, *cftmp;
 	struct i40e_hw *hw = &adapter->hw;
@@ -3921,9 +3923,10 @@ static void i40evf_remove(struct pci_dev *pdev)
 		list_del(&f->list);
 		kfree(f);
 	}
-	list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-		list_del(&f->list);
-		kfree(f);
+	list_for_each_entry_safe(vlf, vlftmp, &adapter->vlan_filter_list,
+				 list) {
+		list_del(&vlf->list);
+		kfree(vlf);
 	}
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
-- 
2.14.3

