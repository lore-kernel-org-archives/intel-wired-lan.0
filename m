From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 14 Sep 2020 08:37:15 -0700
Subject: [Intel-wired-lan] [PATCH S52 2/7] ice: rename shared Flow Director
 functions
In-Reply-To: <20200914153720.48498-1-anthony.l.nguyen@intel.com>
References: <20200914153720.48498-1-anthony.l.nguyen@intel.com>
Message-ID: <20200914153720.48498-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These functions are currently used to add Flow Director filters, however,
they will be expanded to also add ACL filters. Rename the functions,
replacing 'fdir' to 'ntuple', to reflect that they are being
used to for ntuple filters and are not solely used for Flow Director.

Co-developed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  4 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +--
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 30 +++++++++----------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index b5710a17e8d2..b4d4eeb92b1b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -592,8 +592,8 @@ int
 ice_fdir_write_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input, bool add,
 		    bool is_tun);
 void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena);
-int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
-int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd);
 int
 ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index caf64eb5e96d..3c874ea0bf63 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2652,9 +2652,9 @@ static int ice_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		return ice_add_fdir_ethtool(vsi, cmd);
+		return ice_add_ntuple_ethtool(vsi, cmd);
 	case ETHTOOL_SRXCLSRLDEL:
-		return ice_del_fdir_ethtool(vsi, cmd);
+		return ice_del_ntuple_ethtool(vsi, cmd);
 	case ETHTOOL_SRXFH:
 		return ice_set_rss_hash_opt(vsi, cmd);
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 2d27f66ac853..f3d2199a2b42 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1388,7 +1388,7 @@ ice_fdir_do_rem_flow(struct ice_pf *pf, enum ice_fltr_ptype flow_type)
 }
 
 /**
- * ice_fdir_update_list_entry - add or delete a filter from the filter list
+ * ice_ntuple_update_list_entry - add or delete a filter from the filter list
  * @pf: PF structure
  * @input: filter structure
  * @fltr_idx: ethtool index of filter to modify
@@ -1396,8 +1396,8 @@ ice_fdir_do_rem_flow(struct ice_pf *pf, enum ice_fltr_ptype flow_type)
  * returns 0 on success and negative on errors
  */
 static int
-ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
-			   int fltr_idx)
+ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
+			     int fltr_idx)
 {
 	struct ice_fdir_fltr *old_fltr;
 	struct ice_hw *hw = &pf->hw;
@@ -1429,13 +1429,13 @@ ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
 }
 
 /**
- * ice_del_fdir_ethtool - delete Flow Director filter
+ * ice_del_ntuple_ethtool - delete Flow Director or ACL filter
  * @vsi: pointer to target VSI
- * @cmd: command to add or delete Flow Director filter
+ * @cmd: command to add or delete the filter
  *
  * Returns 0 on success and negative values for failure
  */
-int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
+int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp =
 		(struct ethtool_rx_flow_spec *)&cmd->fs;
@@ -1456,21 +1456,21 @@ int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -EBUSY;
 
 	mutex_lock(&hw->fdir_fltr_lock);
-	val = ice_fdir_update_list_entry(pf, NULL, fsp->location);
+	val = ice_ntuple_update_list_entry(pf, NULL, fsp->location);
 	mutex_unlock(&hw->fdir_fltr_lock);
 
 	return val;
 }
 
 /**
- * ice_set_fdir_input_set - Set the input set for Flow Director
+ * ice_ntuple_set_input_set - Set the input set for Flow Director
  * @vsi: pointer to target VSI
  * @fsp: pointer to ethtool Rx flow specification
  * @input: filter structure
  */
 static int
-ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
-		       struct ice_fdir_fltr *input)
+ice_ntuple_set_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
+			 struct ice_fdir_fltr *input)
 {
 	u16 dest_vsi, q_index = 0;
 	struct ice_pf *pf;
@@ -1594,13 +1594,13 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
 }
 
 /**
- * ice_add_fdir_ethtool - Add/Remove Flow Director filter
+ * ice_add_ntuple_ethtool - Add/Remove Flow Director or ACL filter
  * @vsi: pointer to target VSI
- * @cmd: command to add or delete Flow Director filter
+ * @cmd: command to add or delete the filter
  *
  * Returns 0 on success and negative values for failure
  */
-int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
+int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 {
 	struct ice_rx_flow_userdef userdata;
 	struct ethtool_rx_flow_spec *fsp;
@@ -1657,7 +1657,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (!input)
 		return -ENOMEM;
 
-	ret = ice_set_fdir_input_set(vsi, fsp, input);
+	ret = ice_ntuple_set_input_set(vsi, fsp, input);
 	if (ret)
 		goto free_input;
 
@@ -1674,7 +1674,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	}
 
 	/* input struct is added to the HW filter list */
-	ice_fdir_update_list_entry(pf, input, fsp->location);
+	ice_ntuple_update_list_entry(pf, input, fsp->location);
 
 	ret = ice_fdir_write_all_fltr(pf, input, true);
 	if (ret)
-- 
2.20.1

