From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Mar 2018 05:49:54 -0800
Subject: [Intel-wired-lan] [next PATCH S87-V3 5/8] i40e: track filter type
 statistics when deleting invalid filters
In-Reply-To: <20180307134957.61497-1-alice.michael@intel.com>
References: <20180307134957.61497-1-alice.michael@intel.com>
Message-ID: <20180307134957.61497-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When hardware has trouble with a particular filter, we delete it from
the list. Unfortunately, we did not properly update the per-filter
statistic when doing so.

Create a helper function to handle this, and properly reduce the
necessary counter so that it tracks the number of active filters
properly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 56 ++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 183c8b8..0b45650 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8137,6 +8137,51 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_delete_invalid_filter - Delete an invalid FDIR filter
+ * @pf: board private structure
+ * @filter: FDir filter to remove
+ */
+static void i40e_delete_invalid_filter(struct i40e_pf *pf,
+				       struct i40e_fdir_filter *filter)
+{
+	/* Update counters */
+	pf->fdir_pf_active_filters--;
+	pf->fd_inv = 0;
+
+	switch (filter->flow_type) {
+	case TCP_V4_FLOW:
+		pf->fd_tcp4_filter_cnt--;
+		break;
+	case UDP_V4_FLOW:
+		pf->fd_udp4_filter_cnt--;
+		break;
+	case SCTP_V4_FLOW:
+		pf->fd_sctp4_filter_cnt--;
+		break;
+	case IP_USER_FLOW:
+		switch (filter->ip4_proto) {
+		case IPPROTO_TCP:
+			pf->fd_tcp4_filter_cnt--;
+			break;
+		case IPPROTO_UDP:
+			pf->fd_udp4_filter_cnt--;
+			break;
+		case IPPROTO_SCTP:
+			pf->fd_sctp4_filter_cnt--;
+			break;
+		case IPPROTO_IP:
+			pf->fd_ip4_filter_cnt--;
+			break;
+		}
+		break;
+	}
+
+	/* Remove the filter from the list and free memory */
+	hlist_del(&filter->fdir_node);
+	kfree(filter);
+}
+
+/**
  * i40e_fdir_check_and_reenable - Function to reenabe FD ATR or SB if disabled
  * @pf: board private structure
  **/
@@ -8180,14 +8225,9 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 	/* if hw had a problem adding a filter, delete it */
 	if (pf->fd_inv > 0) {
 		hlist_for_each_entry_safe(filter, node,
-					  &pf->fdir_filter_list, fdir_node) {
-			if (filter->fd_id == pf->fd_inv) {
-				hlist_del(&filter->fdir_node);
-				kfree(filter);
-				pf->fdir_pf_active_filters--;
-				pf->fd_inv = 0;
-			}
-		}
+					  &pf->fdir_filter_list, fdir_node)
+			if (filter->fd_id == pf->fd_inv)
+				i40e_delete_invalid_filter(pf, filter);
 	}
 }
 
-- 
2.9.5

