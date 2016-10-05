From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  5 Oct 2016 09:30:46 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: drop is_vf and is_netdev fields in
	struct i40e_mac_filter
In-Reply-To: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475685046-16900-17-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

DO NOT SEND THIS PATCH UPSTREAM IF THIS LINE IS STILL HERE!

Originally the is_vf and is_netdev fields were added in order to
distinguish between VF and netdev filters in a single VSI. However, it
can be noted that we use separate VSI for SRIOV VFs and for netdev VSI.
Thus, since a single VSI should only ever have one type of filter, we
can simply remove the checks and remove the typing. This simplifies the
code and removes a couple of subtle bugs caused by interaction with
debugFS. It also removes some complex code in i40e_add_filter and
i40e_del_filter which was confusing.

Testing-hints:
  Should test add and remove of various filters, as well as add/remove
  via debugFS. Filters should now behave correctly when added and
  removed via debugFS regardless of ordering with other filters in
  regular netdev operation.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
Reviewed-by: Maharajan, Pandi <pandi.maharajan@intel.com>
Change-ID: Id9b637a4157999ea29e91142e82b287b183e3eac
---
 drivers/net/ethernet/intel/i40e/i40e.h             | 18 ++++--------
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 34 ++++------------------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 19 +++++-------
 3 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5a6f851..1f8fc8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -459,8 +459,6 @@ struct i40e_mac_filter {
 #define I40E_VLAN_ANY -1
 	s16 vlan;
 	u8 counter;		/* number of instances of this filter */
-	bool is_vf;		/* filter belongs to a VF */
-	bool is_netdev;		/* filter belongs to a netdev */
 	enum i40e_filter_state state;
 };
 
@@ -723,10 +721,8 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf);
 bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features);
 void i40e_set_ethtool_ops(struct net_device *netdev);
 struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
-					u8 *macaddr, s16 vlan,
-					bool is_vf, bool is_netdev);
-void i40e_del_filter(struct i40e_vsi *vsi, u8 *macaddr, s16 vlan,
-		     bool is_vf, bool is_netdev);
+					u8 *macaddr, s16 vlan);
+void i40e_del_filter(struct i40e_vsi *vsi, u8 *macaddr, s16 vlan);
 int i40e_sync_vsi_filters(struct i40e_vsi *vsi);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 				u16 uplink, u32 param1);
@@ -817,13 +813,11 @@ int i40e_vsi_open(struct i40e_vsi *vsi);
 void i40e_vlan_stripping_disable(struct i40e_vsi *vsi);
 int i40e_vsi_add_vlan(struct i40e_vsi *vsi, s16 vid);
 int i40e_vsi_kill_vlan(struct i40e_vsi *vsi, s16 vid);
-struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi, u8 *macaddr,
-					     bool is_vf, bool is_netdev);
-int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8 *macaddr,
-			  bool is_vf, bool is_netdev);
+struct i40e_mac_filter *i40e_put_mac_in_vlan(struct i40e_vsi *vsi,
+					     u8 *macaddr);
+int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, u8 *macaddr,
-				      bool is_vf, bool is_netdev);
+struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, u8 *macaddr);
 #ifdef I40E_FCOE
 int __i40e_setup_tc(struct net_device *netdev, u32 handle, __be16 proto,
 		    struct tc_to_netdev *tc);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d05c85f..a459ac8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1145,14 +1145,11 @@ void i40e_update_stats(struct i40e_vsi *vsi)
  * @vsi: the VSI to be searched
  * @macaddr: the MAC address
  * @vlan: the vlan
- * @is_vf: make sure its a VF filter, else doesn't matter
- * @is_netdev: make sure its a netdev filter, else doesn't matter
  *
  * Returns ptr to the filter object or NULL
  **/
 static struct i40e_mac_filter *i40e_find_filter(struct i40e_vsi *vsi,
-						u8 *macaddr, s16 vlan,
-						bool is_vf, bool is_netdev)
+						u8 *macaddr, s16 vlan)
 {
 	struct i40e_mac_filter *f;
 
@@ -1173,14 +1170,11 @@ static struct i40e_mac_filter *i40e_find_filter(struct i40e_vsi *vsi,
  * i40e_find_mac - Find a mac addr in the macvlan filters list
  * @vsi: the VSI to be searched
  * @macaddr: the MAC address we are searching for
- * @is_vf: make sure its a VF filter, else doesn't matter
- * @is_netdev: make sure its a netdev filter, else doesn't matter
  *
  * Returns the first filter with the provided MAC address or NULL if
  * MAC address was not found
  **/
-struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, u8 *macaddr,
-				      bool is_vf, bool is_netdev)
+struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, u8 *macaddr)
 {
 	struct i40e_mac_filter *f;
 
@@ -1291,8 +1285,6 @@ int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8 *macaddr,
  * @vsi: the VSI to be searched
  * @macaddr: the MAC address
  * @vlan: the vlan
- * @is_vf: make sure its a VF filter, else doesn't matter
- * @is_netdev: make sure its a netdev filter, else doesn't matter
  *
  * Returns ptr to the filter object or NULL when no memory available.
  *
@@ -1300,8 +1292,7 @@ int i40e_del_mac_all_vlan(struct i40e_vsi *vsi, u8 *macaddr,
  * being held.
  **/
 struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
-					u8 *macaddr, s16 vlan,
-					bool is_vf, bool is_netdev)
+					u8 *macaddr, s16 vlan)
 {
 	struct i40e_mac_filter *f;
 	int changed = false;
@@ -1316,7 +1307,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 	if (is_broadcast_ether_addr(macaddr))
 		return NULL;
 
-	f = i40e_find_filter(vsi, macaddr, vlan, is_vf, is_netdev);
+	f = i40e_find_filter(vsi, macaddr, vlan);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
@@ -1337,20 +1328,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 		list_add_tail(&f->list, &vsi->mac_filter_list);
 	}
 
-	/* increment counter and add a new flag if needed */
-	if (is_vf) {
-		if (!f->is_vf) {
-			f->is_vf = true;
-			f->counter++;
-		}
-	} else if (is_netdev) {
-		if (!f->is_netdev) {
-			f->is_netdev = true;
-			f->counter++;
-		}
-	} else {
-		f->counter++;
-	}
+	f->counter++;
 
 	if (changed) {
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
@@ -1366,8 +1344,6 @@ add_filter_out:
  * @vsi: the VSI to be searched
  * @macaddr: the MAC address
  * @vlan: the vlan
- * @is_vf: make sure it's a VF filter, else doesn't matter
- * @is_netdev: make sure it's a netdev filter, else doesn't matter
  *
  * NOTE: This function is expected to be called with mac_filter_list_lock
  * being held.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 54b8ee2..dccc9f8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -689,8 +689,8 @@ static int i40e_alloc_vsi_res(struct i40e_vf *vf, enum i40e_vsi_type type)
 		spin_lock_bh(&vsi->mac_filter_list_lock);
 		if (is_valid_ether_addr(vf->default_lan_addr.addr)) {
 			f = i40e_add_filter(vsi, vf->default_lan_addr.addr,
-				       vf->port_vlan_id ? vf->port_vlan_id : -1,
-				       true, false);
+				       vf->port_vlan_id ?
+				       vf->port_vlan_id : -1);
 			if (!f)
 				dev_info(&pf->pdev->dev,
 					 "Could not add MAC filter %pM for VF %d\n",
@@ -1933,14 +1933,12 @@ static int i40e_vc_add_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
 
-		f = i40e_find_mac(vsi, al->list[i].addr, true, false);
+		f = i40e_find_mac(vsi, al->list[i].addr);
 		if (!f) {
 			if (i40e_is_vsi_in_vlan(vsi))
-				f = i40e_put_mac_in_vlan(vsi, al->list[i].addr,
-							 true, false);
+				f = i40e_put_mac_in_vlan(vsi, al->list[i].addr);
 			else
-				f = i40e_add_filter(vsi, al->list[i].addr, -1,
-						    true, false);
+				f = i40e_add_filter(vsi, al->list[i].addr, -1);
 		}
 
 		if (!f) {
@@ -2006,7 +2004,7 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 	spin_lock_bh(&vsi->mac_filter_list_lock);
 	/* delete addresses from the list */
 	for (i = 0; i < al->num_elements; i++)
-		if (i40e_del_mac_all_vlan(vsi, al->list[i].addr, true, false)) {
+		if (i40e_del_mac_all_vlan(vsi, al->list[i].addr)) {
 			ret = I40E_ERR_INVALID_MAC_ADDR;
 			spin_unlock_bh(&vsi->mac_filter_list_lock);
 			goto error_param;
@@ -2722,14 +2720,13 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* delete the temporary mac address */
 	if (!is_zero_ether_addr(vf->default_lan_addr.addr))
 		i40e_del_filter(vsi, vf->default_lan_addr.addr,
-				vf->port_vlan_id ? vf->port_vlan_id : -1,
-				true, false);
+				vf->port_vlan_id ? vf->port_vlan_id : -1);
 
 	/* Delete all the filters for this VSI - we're going to kill it
 	 * anyway.
 	 */
 	list_for_each_entry(f, &vsi->mac_filter_list, list)
-		i40e_del_filter(vsi, f->macaddr, f->vlan, true, false);
+		i40e_del_filter(vsi, f->macaddr, f->vlan);
 
 	spin_unlock_bh(&vsi->mac_filter_list_lock);
 
-- 
2.4.11

