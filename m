From: Alice Michael <alice.michael@intel.com>
Date: Mon,  5 Feb 2018 06:11:16 -0500
Subject: [Intel-wired-lan] [next PATCH S86 V3 3/8] i40evf: Use an iterator
 of the same type as the list
In-Reply-To: <20180205111121.59468-1-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
Message-ID: <20180205111121.59468-3-alice.michael@intel.com>
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
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 6fd0992..4f07469 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1027,6 +1027,7 @@ static void i40evf_up_complete(struct i40evf_adapter *adapter)
 void i40evf_down(struct i40evf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct i40evf_vlan_filter *vlf;
 	struct i40evf_mac_filter *f;
 
 	if (adapter->state <= __I40EVF_DOWN_PENDING)
@@ -1045,7 +1046,7 @@ void i40evf_down(struct i40evf_adapter *adapter)
 		f->remove = true;
 	}
 	/* remove all VLAN filters */
-	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
+	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
 		f->remove = true;
 	}
 
@@ -3067,6 +3068,7 @@ static void i40evf_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	struct i40evf_vlan_filter *vlf, *vlftmp;
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40e_hw *hw = &adapter->hw;
 	int err;
@@ -3129,9 +3131,10 @@ static void i40evf_remove(struct pci_dev *pdev)
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
2.9.5

