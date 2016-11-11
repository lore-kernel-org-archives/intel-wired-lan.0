From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 11 Nov 2016 12:39:36 -0800
Subject: [Intel-wired-lan] [next PATCH S54 12/15] i40e: avoid O(n^2) loop
	when deleting all filters
In-Reply-To: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478896779-13697-13-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Use __i40e_del_filter instead of using i40e_del_filter() which will
avoid doing an additional search to delete a filter we already have the
pointer for.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Iea5a7e3cafbf8c682ed9d3b6c69cf5ff53f44daf
---
 drivers/net/ethernet/intel/i40e/i40e.h             | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1fdb082..e5dcdd3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -763,6 +763,7 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features);
 void i40e_set_ethtool_ops(struct net_device *netdev);
 struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 					const u8 *macaddr, s16 vlan);
+void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f);
 void i40e_del_filter(struct i40e_vsi *vsi, const u8 *macaddr, s16 vlan);
 int i40e_sync_vsi_filters(struct i40e_vsi *vsi);
 struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6a6c293..535a70a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1439,7 +1439,7 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
  * the "safe" variants of any list iterators, e.g. list_for_each_entry_safe()
  * instead of list_for_each_entry().
  **/
-static void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
+void __i40e_del_filter(struct i40e_vsi *vsi, struct i40e_mac_filter *f)
 {
 	if (!f)
 		return;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1859911..49941dd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2725,7 +2725,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	 * anyway.
 	 */
 	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist)
-		i40e_del_filter(vsi, f->macaddr, f->vlan);
+		__i40e_del_filter(vsi, f);
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-- 
2.4.11

