From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu, 29 Sep 2016 10:11:30 -0700
Subject: [Intel-wired-lan] [next PATCH S49 10/15] i40e: avoid looping to
	check whether we're in vlan mode
In-Reply-To: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
References: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475169095-20873-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We determine that a vsi is in vlan_mode whenever it has any filters
with a vlan other than -1 (I40E_VLAN_ALL). The previous method of doing
so was to perform a loop whenever we needed the check. However, we can
notice that only place where filters are added (i40e_add_filter) can
change the condition from false to true, and the only place we can
return to false is in i40e_vsi_sync_filters_subtask. Thus, we can remove
the loop and use a boolean directly.

Doing this avoids looping over filters repeatedly especially while we're
already inside a loop over all the filters. This should reduce the
latency of filter operations throughout the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Iafde08df588da2a2ea666997d05e11fad8edc338
---
 drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 48 ++++++++++++++++++++++-------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c5d7a04..1d9a6b9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -517,6 +517,7 @@ struct i40e_vsi {
 	spinlock_t mac_filter_hash_lock;
 	/* Fixed size hash table with 2^8 buckets for MAC filters */
 	DECLARE_HASHTABLE(mac_filter_hash, 8);
+	bool has_vlan_filter;
 
 	/* VSI stats */
 	struct rtnl_link_stats64 net_stats;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5ea761c..be46109 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1198,19 +1198,31 @@ struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr)
  **/
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi)
 {
-	struct i40e_mac_filter *f;
-	struct hlist_node *h;
-	int bkt;
+	/* If we have a PVID, always operate in VLAN mode */
+	if (vsi->info.pvid)
+		return true;
 
-	/* Only -1 for all the filters denotes not in vlan mode
-	 * so we have to go through all the list in order to make sure
+	/* We need to operate in VLAN mode whenever we have any filters with
+	 * a VLAN other than I40E_VLAN_ALL. We could check the table each
+	 * time, incurring search cost repeatedly. However, we can notice two
+	 * things:
+	 *
+	 * 1) the only place where we can gain a VLAN filter is in
+	 *    i40e_add_filter.
+	 *
+	 * 2) the only place where filters are actually removed is in
+	 *    i40e_vsi_sync_filters_subtask.
+	 *
+	 * Thus, we can simply use a boolean value, has_vlan_filters which we
+	 * will set to true when we add a vlan filter in i40e_add_filter. Then
+	 * we have to perform the full search after deleting filters in
+	 * i40e_vsi_sync_filters_subtask, but we already have to search
+	 * filters here and can perform the check at the same time. This
+	 * results in avoiding embedding a loop for vlan mode inside another
+	 * loop over all the filters, and should maintain correctness as noted
+	 * above.
 	 */
-	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
-		if (f->vlan >= 0 || vsi->info.pvid)
-			return true;
-	}
-
-	return false;
+	return vsi->has_vlan_filter;
 }
 
 /**
@@ -1246,6 +1258,12 @@ struct i40e_mac_filter *i40e_add_filter(struct i40e_vsi *vsi,
 		if (!f)
 			return NULL;
 
+		/* Update the boolean indicating if we need to function in
+		 * vlan mode.
+		 */
+		if (vlan >= 0)
+			vsi->has_vlan_filter = true;
+
 		ether_addr_copy(f->macaddr, macaddr);
 		f->vlan = vlan;
 		/* If we're in overflow promisc mode, set the state directly
@@ -1979,6 +1997,14 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 		del_list = NULL;
 	}
 
+	/* After finishing notifying firmware of the deleted filters, update
+	 * the cached value of vsi->has_vlan_filter. Note that we are safe to
+	 * use just !!vlan_filters here because if we only have VLAN=0 (that
+	 * is, non_vlan_filters) these will all be converted to VLAN=-1 in the
+	 * logic above already so this value would still be correct.
+	 */
+	vsi->has_vlan_filter = !!vlan_filters;
+
 	if (!hlist_empty(&tmp_add_list)) {
 		/* Do all the adds now. */
 		filter_list_len = hw->aq.asq_buf_size /
-- 
2.4.11

