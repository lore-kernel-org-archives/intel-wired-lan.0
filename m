From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  4 Aug 2016 18:49:46 +0200
Subject: [Intel-wired-lan] [next PATCH 4/5] i40e: Refactor flow director
	filter management to make it per VSI.
In-Reply-To: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
References: <1470329387-25138-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <1470329387-25138-4-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Three fields in struct i40e_pf - fd_filter_list, fdir_pf_active_filters and
fd_inv are moved to struct i40e_vsi.

This enables the later patch to support ntuple filters on a VF using
VF representor netdev.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  31 +++---
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 147 +++++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |   5 +-
 4 files changed, 138 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 2d35c0d..a0344e9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -296,8 +296,6 @@ struct i40e_pf {
 	u8 atr_sample_rate;
 	bool wol_en;
 
-	struct hlist_head fdir_filter_list;
-	u16 fdir_pf_active_filters;
 	unsigned long fd_flush_timestamp;
 	u32 fd_flush_cnt;
 	u32 fd_add_err;
@@ -446,7 +444,6 @@ struct i40e_pf {
 	u32 npar_min_bw;
 
 	u32 ioremap_len;
-	u32 fd_inv;
 	u16 phy_led_val;
 	enum devlink_eswitch_mode eswitch_mode;
 };
@@ -529,6 +526,10 @@ struct i40e_vsi {
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 
+	struct hlist_head fdir_filter_list;
+	u16 fdir_active_filters;
+	u32 fd_inv;
+
 	/* These are containers of ring pointers, allocated at run-time */
 	struct i40e_ring **rx_rings;
 	struct i40e_ring **tx_rings;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0c3bffa..9a5c807 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2181,7 +2181,7 @@ static int i40e_get_rss_hash_opts(struct i40e_pf *pf, struct ethtool_rxnfc *cmd)
 
 /**
  * i40e_get_ethtool_fdir_all - Populates the rule count of a command
- * @pf: Pointer to the physical function struct
+ * @vsi: Pointer to the VSI struct
  * @cmd: The command to get or set Rx flow classification rules
  * @rule_locs: Array of used rule locations
  *
@@ -2190,19 +2190,20 @@ static int i40e_get_rss_hash_opts(struct i40e_pf *pf, struct ethtool_rxnfc *cmd)
  *
  * Returns 0 on success or -EMSGSIZE if entry not found
  **/
-static int i40e_get_ethtool_fdir_all(struct i40e_pf *pf,
+static int i40e_get_ethtool_fdir_all(struct i40e_vsi *vsi,
 				     struct ethtool_rxnfc *cmd,
 				     u32 *rule_locs)
 {
 	struct i40e_fdir_filter *rule;
 	struct hlist_node *node2;
+	struct i40e_pf *pf = vsi->back;
 	int cnt = 0;
 
 	/* report total rule count */
 	cmd->data = i40e_get_fd_cnt_all(pf);
 
 	hlist_for_each_entry_safe(rule, node2,
-				  &pf->fdir_filter_list, fdir_node) {
+				  &vsi->fdir_filter_list, fdir_node) {
 		if (cnt == cmd->rule_cnt)
 			return -EMSGSIZE;
 
@@ -2217,7 +2218,7 @@ static int i40e_get_ethtool_fdir_all(struct i40e_pf *pf,
 
 /**
  * i40e_get_ethtool_fdir_entry - Look up a filter based on Rx flow
- * @pf: Pointer to the physical function struct
+ * @vsi: Pointer to the VSI struct
  * @cmd: The command to get or set Rx flow classification rules
  *
  * This function looks up a filter based on the Rx flow classification
@@ -2225,16 +2226,17 @@ static int i40e_get_ethtool_fdir_all(struct i40e_pf *pf,
  *
  * Returns 0 on success or -EINVAL if filter not found
  **/
-static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
+static int i40e_get_ethtool_fdir_entry(struct i40e_vsi *vsi,
 				       struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp =
 			(struct ethtool_rx_flow_spec *)&cmd->fs;
 	struct i40e_fdir_filter *rule = NULL;
 	struct hlist_node *node2;
+	struct i40e_pf *pf = vsi->back;
 
 	hlist_for_each_entry_safe(rule, node2,
-				  &pf->fdir_filter_list, fdir_node) {
+				  &vsi->fdir_filter_list, fdir_node) {
 		if (fsp->location <= rule->fd_id)
 			break;
 	}
@@ -2262,7 +2264,7 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	else
 		fsp->ring_cookie = rule->q_index;
 
-	if (rule->dest_vsi != pf->vsi[pf->lan_vsi]->id) {
+	if (rule->dest_vsi != vsi->id) {
 		struct i40e_vsi *vsi;
 
 		vsi = i40e_find_vsi_from_id(pf, rule->dest_vsi);
@@ -2299,16 +2301,16 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		ret = i40e_get_rss_hash_opts(pf, cmd);
 		break;
 	case ETHTOOL_GRXCLSRLCNT:
-		cmd->rule_cnt = pf->fdir_pf_active_filters;
+		cmd->rule_cnt = vsi->fdir_active_filters;
 		/* report total rule count */
 		cmd->data = i40e_get_fd_cnt_all(pf);
 		ret = 0;
 		break;
 	case ETHTOOL_GRXCLSRULE:
-		ret = i40e_get_ethtool_fdir_entry(pf, cmd);
+		ret = i40e_get_ethtool_fdir_entry(vsi, cmd);
 		break;
 	case ETHTOOL_GRXCLSRLALL:
-		ret = i40e_get_ethtool_fdir_all(pf, cmd, rule_locs);
+		ret = i40e_get_ethtool_fdir_all(vsi, cmd, rule_locs);
 		break;
 	default:
 		break;
@@ -2483,7 +2485,6 @@ static int i40e_update_ethtool_fdir_entry(struct i40e_vsi *vsi,
 					  struct ethtool_rxnfc *cmd)
 {
 	struct i40e_fdir_filter *rule, *parent;
-	struct i40e_pf *pf = vsi->back;
 	struct hlist_node *node2;
 	int err = -EINVAL;
 
@@ -2491,7 +2492,7 @@ static int i40e_update_ethtool_fdir_entry(struct i40e_vsi *vsi,
 	rule = NULL;
 
 	hlist_for_each_entry_safe(rule, node2,
-				  &pf->fdir_filter_list, fdir_node) {
+				  &vsi->fdir_filter_list, fdir_node) {
 		/* hash found, or no matching entry */
 		if (rule->fd_id >= sw_idx)
 			break;
@@ -2506,7 +2507,7 @@ static int i40e_update_ethtool_fdir_entry(struct i40e_vsi *vsi,
 			err = i40e_add_del_fdir(vsi, rule, false);
 		hlist_del(&rule->fdir_node);
 		kfree(rule);
-		pf->fdir_pf_active_filters--;
+		vsi->fdir_active_filters--;
 	}
 
 	/* If no input this was a delete, err should be 0 if a rule was
@@ -2523,10 +2524,10 @@ static int i40e_update_ethtool_fdir_entry(struct i40e_vsi *vsi,
 		hlist_add_behind(&input->fdir_node, &parent->fdir_node);
 	else
 		hlist_add_head(&input->fdir_node,
-			       &pf->fdir_filter_list);
+			       &vsi->fdir_filter_list);
 
 	/* update counts */
-	pf->fdir_pf_active_filters++;
+	vsi->fdir_active_filters++;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 208da9f..579ea8a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3091,25 +3091,46 @@ static void i40e_set_vsi_rx_mode(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_fdir_filter_restore - Restore the Sideband Flow Director filters
- * @vsi: Pointer to the targeted VSI
+ * i40e_vsi_fdir_filter_restore - Restore the Sideband Flow Director filters
+ * @vsi: Pointer to VSI
  *
  * This function replays the hlist on the hw where all the SB Flow Director
- * filters were saved.
+ * filters were saved for a VSI.
  **/
-static void i40e_fdir_filter_restore(struct i40e_vsi *vsi)
+
+static void i40e_vsi_fdir_filter_restore(struct i40e_vsi *vsi)
 {
 	struct i40e_fdir_filter *filter;
-	struct i40e_pf *pf = vsi->back;
 	struct hlist_node *node;
 
+	hlist_for_each_entry_safe(filter, node,
+				  &vsi->fdir_filter_list, fdir_node) {
+		i40e_add_del_fdir(vsi, filter, true);
+	}
+}
+
+
+/**
+ * i40e_fdir_filter_restore - Restore the Sideband Flow Director filters
+ * @pf: Pointer to PF
+ *
+ * This function calls i40_vsi_fdi_filter_restore() for all the VSIs
+ * associated with the PF that have flow director filters.
+ **/
+static void i40e_fdir_filter_restore(struct i40e_pf *pf)
+{
+	struct i40e_vf *vf;
+	int i;
+
 	if (!(pf->flags & I40E_FLAG_FD_SB_ENABLED))
 		return;
 
-	hlist_for_each_entry_safe(filter, node,
-				  &pf->fdir_filter_list, fdir_node) {
-		i40e_add_del_fdir(vsi, filter, true);
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		vf = &(pf->vf[i]);
+		i40e_vsi_fdir_filter_restore(pf->vsi[vf->lan_vsi_idx]);
 	}
+
+	i40e_vsi_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
 }
 
 /**
@@ -5232,7 +5253,7 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 				dev_info(&pf->pdev->dev, "Forcing ATR off, sideband rules for TCP/IPv4 exist\n");
 			pf->fd_tcp_rule = 0;
 		}
-		i40e_fdir_filter_restore(vsi);
+		i40e_fdir_filter_restore(pf);
 	}
 
 	/* On the next run of the service_task, notify any clients of the new
@@ -5498,23 +5519,43 @@ err_setup_tx:
 }
 
 /**
- * i40e_fdir_filter_exit - Cleans up the Flow Director accounting
- * @pf: Pointer to PF
+ * i40e_vsi_fdir_filter_exit - Cleans up the Flow Director accounting
+ * @vsi: Pointer to VSI
  *
  * This function destroys the hlist where all the Flow Director
- * filters were saved.
+ * filters were saved for a VSI.
  **/
-static void i40e_fdir_filter_exit(struct i40e_pf *pf)
+static void i40e_vsi_fdir_filter_exit(struct i40e_vsi *vsi)
 {
 	struct i40e_fdir_filter *filter;
-	struct hlist_node *node2;
+	struct hlist_node *node;
 
-	hlist_for_each_entry_safe(filter, node2,
-				  &pf->fdir_filter_list, fdir_node) {
+	hlist_for_each_entry_safe(filter, node, &vsi->fdir_filter_list,
+				  fdir_node) {
 		hlist_del(&filter->fdir_node);
 		kfree(filter);
 	}
-	pf->fdir_pf_active_filters = 0;
+	vsi->fdir_active_filters = 0;
+}
+
+/**
+ * i40e_fdir_filter_exit - Cleans up the Flow Director accounting
+ * @pf: Pointer to PF
+ *
+ * This function destroys the hlist's where all the Flow Director
+ * filters were saved.
+ **/
+static void i40e_fdir_filter_exit(struct i40e_pf *pf)
+{
+	struct i40e_vf *vf;
+	int i;
+
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		vf = &(pf->vf[i]);
+		i40e_vsi_fdir_filter_exit(pf->vsi[vf->lan_vsi_idx]);
+	}
+
+	i40e_vsi_fdir_filter_exit(pf->vsi[pf->lan_vsi]);
 }
 
 /**
@@ -5898,14 +5939,37 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_vsi_fd_inv_clean - Function to reenabe FD ATR or SB if disabled
+ * @vsi: Pointer to VSI
+ **/
+static void i40e_vsi_fd_inv_clean(struct i40e_vsi *vsi)
+{
+	struct i40e_fdir_filter *filter;
+	struct hlist_node *node;
+
+	if (!vsi->fd_inv)
+		return;
+
+	hlist_for_each_entry_safe(filter, node, &vsi->fdir_filter_list,
+				  fdir_node) {
+		if (filter->fd_id == vsi->fd_inv) {
+			hlist_del(&filter->fdir_node);
+			kfree(filter);
+			vsi->fdir_active_filters--;
+		}
+	}
+}
+
+
+/**
  * i40e_fdir_check_and_reenable - Function to reenabe FD ATR or SB if disabled
  * @pf: board private structure
  **/
 void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 {
-	struct i40e_fdir_filter *filter;
+	struct i40e_vf *vf;
 	u32 fcnt_prog, fcnt_avail;
-	struct hlist_node *node;
+	int i;
 
 	if (test_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state))
 		return;
@@ -5936,16 +6000,35 @@ void i40e_fdir_check_and_reenable(struct i40e_pf *pf)
 	}
 
 	/* if hw had a problem adding a filter, delete it */
-	if (pf->fd_inv > 0) {
-		hlist_for_each_entry_safe(filter, node,
-					  &pf->fdir_filter_list, fdir_node) {
-			if (filter->fd_id == pf->fd_inv) {
-				hlist_del(&filter->fdir_node);
-				kfree(filter);
-				pf->fdir_pf_active_filters--;
-			}
-		}
+
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		vf = &(pf->vf[i]);
+		i40e_vsi_fd_inv_clean(pf->vsi[vf->lan_vsi_idx]);
+	}
+	i40e_vsi_fd_inv_clean(pf->vsi[pf->lan_vsi]);
+}
+
+/**
+ * i40e_pf_get_fdir_active_filters - Returns the numbe of active filters
+ * associated with a PF
+ *
+ * @pf: Pointer to PF
+ *
+ **/
+static u16 i40e_pf_get_fdir_active_filters(struct i40e_pf *pf)
+{
+	struct i40e_vf *vf;
+	u16 cnt = 0;
+	int i;
+
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		vf = &(pf->vf[i]);
+		cnt += pf->vsi[vf->lan_vsi_idx]->fdir_active_filters;
 	}
+
+	cnt += pf->vsi[pf->lan_vsi]->fdir_active_filters;
+
+	return cnt;
 }
 
 #define I40E_MIN_FD_FLUSH_INTERVAL 10
@@ -5974,7 +6057,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 	 */
 	min_flush_time = pf->fd_flush_timestamp +
 			 (I40E_MIN_FD_FLUSH_SB_ATR_UNSTABLE * HZ);
-	fd_room = pf->fdir_pf_filter_count - pf->fdir_pf_active_filters;
+	fd_room = pf->fdir_pf_filter_count - i40e_pf_get_fdir_active_filters(pf);
 
 	if (!(time_after(jiffies, min_flush_time)) &&
 	    (fd_room < I40E_FDIR_BUFFER_HEAD_ROOM_FOR_ATR)) {
@@ -6002,7 +6085,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
 		dev_warn(&pf->pdev->dev, "FD table did not flush, needs more time\n");
 	} else {
 		/* replay sideband filters */
-		i40e_fdir_filter_restore(pf->vsi[pf->lan_vsi]);
+		i40e_fdir_filter_restore(pf);
 		if (!disable_atr)
 			pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
 		clear_bit(__I40E_FD_FLUSH_REQUESTED, &pf->state);
@@ -6017,7 +6100,7 @@ static void i40e_fdir_flush_and_replay(struct i40e_pf *pf)
  **/
 u32 i40e_get_current_atr_cnt(struct i40e_pf *pf)
 {
-	return i40e_get_current_fd_count(pf) - pf->fdir_pf_active_filters;
+	return i40e_get_current_fd_count(pf) - i40e_pf_get_fdir_active_filters(pf);
 }
 
 /* We can see up to 256 filter programming desc in transit if the filters are
@@ -6732,6 +6815,7 @@ static void i40e_fdir_teardown(struct i40e_pf *pf)
 	int i;
 
 	i40e_fdir_filter_exit(pf);
+
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
 			i40e_vsi_release(pf->vsi[i]);
@@ -8665,7 +8749,6 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 		pf->auto_disable_flags &= ~I40E_FLAG_FD_SB_ENABLED;
 		/* reset fd counters */
 		pf->fd_add_err = pf->fd_atr_cnt = pf->fd_tcp_rule = 0;
-		pf->fdir_pf_active_filters = 0;
 		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
 		if (I40E_DEBUG_FD & pf->hw.debug_mask)
 			dev_info(&pf->pdev->dev, "ATR re-enabled.\n");
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index df7ecc9..b2f6ca6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -463,6 +463,7 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
 static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 				  union i40e_rx_desc *rx_desc, u8 prog_id)
 {
+	struct i40e_vsi *vsi = rx_ring->vsi;
 	struct i40e_pf *pf = rx_ring->vsi->back;
 	struct pci_dev *pdev = pf->pdev;
 	u32 fcnt_prog, fcnt_avail;
@@ -474,11 +475,11 @@ static void i40e_fd_handle_status(struct i40e_ring *rx_ring,
 		I40E_RX_PROG_STATUS_DESC_QW1_ERROR_SHIFT;
 
 	if (error == BIT(I40E_RX_PROG_STATUS_DESC_FD_TBL_FULL_SHIFT)) {
-		pf->fd_inv = le32_to_cpu(rx_desc->wb.qword0.hi_dword.fd_id);
+		vsi->fd_inv = le32_to_cpu(rx_desc->wb.qword0.hi_dword.fd_id);
 		if ((rx_desc->wb.qword0.hi_dword.fd_id != 0) ||
 		    (I40E_DEBUG_FD & pf->hw.debug_mask))
 			dev_warn(&pdev->dev, "ntuple filter loc = %d, could not be added\n",
-				 pf->fd_inv);
+				 vsi->fd_inv);
 
 		/* Check if the programming error is for ATR.
 		 * If so, auto disable ATR and set a state for
-- 
2.5.5

