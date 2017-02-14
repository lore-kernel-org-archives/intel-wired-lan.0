From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Feb 2017 10:55:06 -0800
Subject: [Intel-wired-lan] [PATCH v2] i40e: allow i40e_update_filter_state
	to skip broadcast filters
Message-ID: <20170214185506.14099-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix a bug where we modified the mac_filter_hash while outside a lock,
when handling addition of broadcast filters.

Normally, we add filters to firmware by batching the additions into
lists and issuing 1 update for every few filters. Broadcast filters are
handled differently, by instead setting the broadcast promiscuous mode
flags. In order to make sure the 1<->1 mapping of filters in our
addition array lined up with filters in the hlist tmp_add_list, we had
to remove the filter and move it back to the main hash. However, we
didn't do this under lock, which could cause consistency problems for
the list.

Fix this by updating i40e_update_filter_state logic so that it knows to
avoid broadcast filters. This ensures that we don't have to remove the
filter separately, and can put it back using the normal flow.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: Id288fade80b3e3a9a54b68cc249188cb95147518
---
This addresses Sergei's comments on the netdev mailing list. It should
be able to replace the patch in Jeff's queue directly, but it may cause
some conflicts with one of the other patches.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 36 ++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fa4a04da47b7..000bf4f78909 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1842,6 +1842,30 @@ static void i40e_undo_filter_entries(struct i40e_vsi *vsi,
 	}
 }
 
+/**
+ * i40e_next_entry - Get the next non-broadcast filter from a list
+ * @f: pointer to filter in list
+ *
+ * Returns the next non-broadcast filter in the list. Required so that we
+ * ignore broadcast filters within the list, since these are not handled via
+ * the normal firmware update path.
+ */
+static struct i40e_mac_filter *i40e_next_filter(struct i40e_mac_filter *f)
+{
+	while (f) {
+		f = hlist_entry(f->hlist.next,
+				typeof(struct i40e_mac_filter),
+				hlist);
+
+		/* If we have a non-broadcast filter, return it */
+		if (f && !is_broadcast_ether_addr(f->macaddr))
+			return f;
+	}
+
+	/* Otherwise, return NULL */
+	return NULL;
+}
+
 /**
  * i40e_update_filter_state - Update filter state based on return data
  * from firmware
@@ -1874,9 +1898,9 @@ i40e_update_filter_state(int count,
 			retval++;
 		}
 
-		add_head = hlist_entry(add_head->hlist.next,
-				       typeof(struct i40e_mac_filter),
-				       hlist);
+		add_head = i40e_next_filter(add_head);
+		if (!add_head)
+			break;
 	}
 
 	return retval;
@@ -2095,7 +2119,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			cmd_flags = 0;
 
 			/* handle broadcast filters by updating the broadcast
-			 * promiscuous flag instead of deleting a MAC filter.
+			 * promiscuous flag and release filter list.
 			 */
 			if (is_broadcast_ether_addr(f->macaddr)) {
 				i40e_aqc_broadcast_filter(vsi, vsi_name, f);
@@ -2164,11 +2188,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 			 * promiscuous flag instead of adding a MAC filter.
 			 */
 			if (is_broadcast_ether_addr(f->macaddr)) {
-				u64 key = i40e_addr_to_hkey(f->macaddr);
 				i40e_aqc_broadcast_filter(vsi, vsi_name, f);
-
-				hlist_del(&f->hlist);
-				hash_add(vsi->mac_filter_hash, &f->hlist, key);
 				continue;
 			}
 
-- 
2.12.0.rc0.177.g63172abf21d0

