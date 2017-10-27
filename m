From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:50 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 3/9] i40evf: use spinlock to
	protect (mac|vlan)_filter_list
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Stop overloading the __I40EVF_IN_CRITICAL_TASK bit lock to protect the
mac_filter_list and vlan_filter_list. Instead, implement a spinlock to
protect these two lists, similar to how we protect the hash in the i40e
PF code.

Ensure that every place where we access the list uses the spinlock to
ensure consistency, and stop holding the critical section around blocks
of code which only need access to the macvlan filter lists.

This refactor helps simplify the locking behavior, and is necessary as
a future refactor to the __I40EVF_IN_CRITICAL_TASK would cause
a deadlock otherwise.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 84 +++++++++++-----------
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 42 +++++++++--
 3 files changed, 81 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index de0af52..47040ab 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -199,6 +199,9 @@ struct i40evf_adapter {
 	wait_queue_head_t down_waitqueue;
 	struct i40e_q_vector *q_vectors;
 	struct list_head vlan_filter_list;
+	struct list_head mac_filter_list;
+	/* Lock to protect accesses to MAC and VLAN lists */
+	spinlock_t mac_vlan_list_lock;
 	char misc_vector_name[IFNAMSIZ + 9];
 	int num_active_queues;
 	int num_req_queues;
@@ -206,7 +209,6 @@ struct i40evf_adapter {
 	/* TX */
 	struct i40e_ring *tx_rings;
 	u32 tx_timeout_count;
-	struct list_head mac_filter_list;
 	u32 tx_desc_count;
 
 	/* RX */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 320408f..2b135dc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -706,7 +706,8 @@ static void i40evf_configure_rx(struct i40evf_adapter *adapter)
  * @adapter: board private structure
  * @vlan: vlan tag
  *
- * Returns ptr to the filter object or NULL
+ * Returns ptr to the filter object or NULL. Must be called while holding the
+ * mac_vlan_list_lock.
  **/
 static struct
 i40evf_vlan_filter *i40evf_find_vlan(struct i40evf_adapter *adapter, u16 vlan)
@@ -731,14 +732,8 @@ static struct
 i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 {
 	struct i40evf_vlan_filter *f = NULL;
-	int count = 50;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section)) {
-		udelay(1);
-		if (--count == 0)
-			goto out;
-	}
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (!f) {
@@ -755,8 +750,7 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 	}
 
 clearout:
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
-out:
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 	return f;
 }
 
@@ -768,21 +762,16 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 static void i40evf_del_vlan(struct i40evf_adapter *adapter, u16 vlan)
 {
 	struct i40evf_vlan_filter *f;
-	int count = 50;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section)) {
-		udelay(1);
-		if (--count == 0)
-			return;
-	}
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (f) {
 		f->remove = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
 	}
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
 /**
@@ -824,7 +813,8 @@ static int i40evf_vlan_rx_kill_vid(struct net_device *netdev,
  * @adapter: board private structure
  * @macaddr: the MAC address
  *
- * Returns ptr to the filter object or NULL
+ * Returns ptr to the filter object or NULL. Must be called while holding the
+ * mac_vlan_list_lock.
  **/
 static struct
 i40evf_mac_filter *i40evf_find_filter(struct i40evf_adapter *adapter,
@@ -854,26 +844,17 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 				     u8 *macaddr)
 {
 	struct i40evf_mac_filter *f;
-	int count = 50;
 
 	if (!macaddr)
 		return NULL;
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section)) {
-		udelay(1);
-		if (--count == 0)
-			return NULL;
-	}
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	f = i40evf_find_filter(adapter, macaddr);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
-		if (!f) {
-			clear_bit(__I40EVF_IN_CRITICAL_TASK,
-				  &adapter->crit_section);
-			return NULL;
-		}
+		if (!f)
+			goto clearout;
 
 		ether_addr_copy(f->macaddr, macaddr);
 
@@ -884,7 +865,8 @@ i40evf_mac_filter *i40evf_add_filter(struct i40evf_adapter *adapter,
 		f->remove = false;
 	}
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+clearout:
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 	return f;
 }
 
@@ -911,12 +893,16 @@ static int i40evf_set_mac(struct net_device *netdev, void *p)
 	if (adapter->flags & I40EVF_FLAG_ADDR_SET_BY_PF)
 		return -EPERM;
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	f = i40evf_find_filter(adapter, hw->mac.addr);
 	if (f) {
 		f->remove = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
 
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	f = i40evf_add_filter(adapter, addr->sa_data);
 	if (f) {
 		ether_addr_copy(hw->mac.addr, addr->sa_data);
@@ -937,7 +923,6 @@ static void i40evf_set_rx_mode(struct net_device *netdev)
 	struct netdev_hw_addr *uca;
 	struct netdev_hw_addr *mca;
 	struct netdev_hw_addr *ha;
-	int count = 50;
 
 	/* add addr if not already in the filter list */
 	netdev_for_each_uc_addr(uca, netdev) {
@@ -947,16 +932,8 @@ static void i40evf_set_rx_mode(struct net_device *netdev)
 		i40evf_add_filter(adapter, mca->addr);
 	}
 
-	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
-				&adapter->crit_section)) {
-		udelay(1);
-		if (--count == 0) {
-			dev_err(&adapter->pdev->dev,
-				"Failed to get lock in %s\n", __func__);
-			return;
-		}
-	}
-	/* remove filter if not in netdev list */
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
 		netdev_for_each_mc_addr(mca, netdev)
 			if (ether_addr_equal(mca->addr, f->macaddr))
@@ -995,7 +972,7 @@ static void i40evf_set_rx_mode(struct net_device *netdev)
 		 adapter->flags & I40EVF_FLAG_ALLMULTI_ON)
 		adapter->aq_required |= I40EVF_FLAG_AQ_RELEASE_ALLMULTI;
 
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 }
 
 /**
@@ -1094,6 +1071,8 @@ void i40evf_down(struct i40evf_adapter *adapter)
 	i40evf_napi_disable_all(adapter);
 	i40evf_irq_disable(adapter);
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	/* remove all MAC filters */
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		f->remove = true;
@@ -1102,6 +1081,9 @@ void i40evf_down(struct i40evf_adapter *adapter)
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 		f->remove = true;
 	}
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	if (!(adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) &&
 	    adapter->state != __I40EVF_RESETTING) {
 		/* cancel any current operation */
@@ -1812,6 +1794,8 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 		i40evf_free_all_rx_resources(adapter);
 	}
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	/* Delete all of the filters, both MAC and VLAN. */
 	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
 		list_del(&f->list);
@@ -1823,6 +1807,8 @@ static void i40evf_disable_vf(struct i40evf_adapter *adapter)
 		kfree(fv);
 	}
 
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_free_misc_irq(adapter);
 	i40evf_reset_interrupt_capability(adapter);
 	i40evf_free_queues(adapter);
@@ -1959,6 +1945,8 @@ static void i40evf_reset_task(struct work_struct *work)
 	adapter->aq_required |= I40EVF_FLAG_AQ_GET_CONFIG;
 	adapter->aq_required |= I40EVF_FLAG_AQ_MAP_VECTORS;
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	/* re-add all MAC filters */
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		f->add = true;
@@ -1967,6 +1955,9 @@ static void i40evf_reset_task(struct work_struct *work)
 	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
 		vlf->add = true;
 	}
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
@@ -2957,6 +2948,8 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mutex_init(&hw->aq.asq_mutex);
 	mutex_init(&hw->aq.arq_mutex);
 
+	spin_lock_init(&adapter->mac_vlan_list_lock);
+
 	INIT_LIST_HEAD(&adapter->mac_filter_list);
 	INIT_LIST_HEAD(&adapter->vlan_filter_list);
 
@@ -3132,6 +3125,7 @@ static void i40evf_remove(struct pci_dev *pdev)
 	i40evf_free_all_rx_resources(adapter);
 	i40evf_free_queues(adapter);
 	kfree(adapter->vf_res);
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
 	 */
@@ -3144,6 +3138,8 @@ static void i40evf_remove(struct pci_dev *pdev)
 		kfree(f);
 	}
 
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	free_netdev(netdev);
 
 	pci_disable_pcie_error_reporting(pdev);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 46c8b8a..2719a05 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -433,12 +433,16 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		if (f->add)
 			count++;
 	}
 	if (!count) {
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_ETH_ADDR;
@@ -456,8 +460,10 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 	}
 
 	veal = kzalloc(len, GFP_KERNEL);
-	if (!veal)
+	if (!veal) {
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
+	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
 	veal->num_elements = count;
@@ -472,6 +478,9 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 	}
 	if (!more)
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR,
 			   (u8 *)veal, len);
 	kfree(veal);
@@ -498,12 +507,16 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
+
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
 		if (f->remove)
 			count++;
 	}
 	if (!count) {
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_DEL_ETH_ADDR;
@@ -520,8 +533,10 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 		more = true;
 	}
 	veal = kzalloc(len, GFP_KERNEL);
-	if (!veal)
+	if (!veal) {
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
+	}
 
 	veal->vsi_id = adapter->vsi_res->vsi_id;
 	veal->num_elements = count;
@@ -537,6 +552,9 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 	}
 	if (!more)
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_MAC_FILTER;
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_ETH_ADDR,
 			   (u8 *)veal, len);
 	kfree(veal);
@@ -564,12 +582,15 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 		return;
 	}
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 		if (f->add)
 			count++;
 	}
 	if (!count) {
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_VLAN;
@@ -586,8 +607,10 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 		more = true;
 	}
 	vvfl = kzalloc(len, GFP_KERNEL);
-	if (!vvfl)
+	if (!vvfl) {
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
+	}
 
 	vvfl->vsi_id = adapter->vsi_res->vsi_id;
 	vvfl->num_elements = count;
@@ -602,6 +625,9 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 	}
 	if (!more)
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_VLAN, (u8 *)vvfl, len);
 	kfree(vvfl);
 }
@@ -628,12 +654,15 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 		return;
 	}
 
+	spin_lock_bh(&adapter->mac_vlan_list_lock);
+
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 		if (f->remove)
 			count++;
 	}
 	if (!count) {
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
 	}
 	adapter->current_op = VIRTCHNL_OP_DEL_VLAN;
@@ -650,8 +679,10 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 		more = true;
 	}
 	vvfl = kzalloc(len, GFP_KERNEL);
-	if (!vvfl)
+	if (!vvfl) {
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
 		return;
+	}
 
 	vvfl->vsi_id = adapter->vsi_res->vsi_id;
 	vvfl->num_elements = count;
@@ -667,6 +698,9 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 	}
 	if (!more)
 		adapter->aq_required &= ~I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
+
+	spin_unlock_bh(&adapter->mac_vlan_list_lock);
+
 	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DEL_VLAN, (u8 *)vvfl, len);
 	kfree(vvfl);
 }
-- 
2.9.5

