From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:35 -0800
Subject: [Intel-wired-lan] [PATCH S56 03/13] ice: Refactor get/set RSS LUT
 to use struct parameter
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Update ice_aq_get_rss_lut() and ice_aq_set_rss_lut() to take a new
structure ice_aq_get_set_rss_params instead of passing individual
parameters. This is done for 2 reasons:

1. Reduce the number of parameters passed to the functions.
2. Reduce the amount of change required if the arguments ever need to be
   updated in the future.

Also, reduce duplicate code that was checking for an invalid vsi_handle
and lut parameter by moving the checks to the lower level
__ice_aq_get_set_rss_lut().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 54 +++++++++-----------
 drivers/net/ethernet/intel/ice/ice_common.h  |  6 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  9 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  9 +++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++--
 drivers/net/ethernet/intel/ice/ice_type.h    |  8 +++
 6 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 105504c8cfe7..3fdd76a85ab9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3206,23 +3206,33 @@ ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 /**
  * __ice_aq_get_set_rss_lut
  * @hw: pointer to the hardware structure
- * @vsi_id: VSI FW index
- * @lut_type: LUT table type
- * @lut: pointer to the LUT buffer provided by the caller
- * @lut_size: size of the LUT buffer
- * @glob_lut_idx: global LUT index
+ * @params: RSS LUT parameters
  * @set: set true to set the table, false to get the table
  *
  * Internal function to get (0x0B05) or set (0x0B03) RSS look up table
  */
 static enum ice_status
-__ice_aq_get_set_rss_lut(struct ice_hw *hw, u16 vsi_id, u8 lut_type, u8 *lut,
-			 u16 lut_size, u8 glob_lut_idx, bool set)
+__ice_aq_get_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *params, bool set)
 {
+	u16 flags = 0, vsi_id, lut_type, lut_size, glob_lut_idx, vsi_handle;
 	struct ice_aqc_get_set_rss_lut *cmd_resp;
 	struct ice_aq_desc desc;
 	enum ice_status status;
-	u16 flags = 0;
+	u8 *lut;
+
+	if (!params)
+		return ICE_ERR_PARAM;
+
+	vsi_handle = params->vsi_handle;
+	lut = params->lut;
+
+	if (!ice_is_vsi_valid(hw, vsi_handle) || !lut)
+		return ICE_ERR_PARAM;
+
+	lut_size = params->lut_size;
+	lut_type = params->lut_type;
+	glob_lut_idx = params->global_lut_id;
+	vsi_id = ice_get_hw_vsi_num(hw, vsi_handle);
 
 	cmd_resp = &desc.params.get_set_rss_lut;
 
@@ -3296,43 +3306,27 @@ __ice_aq_get_set_rss_lut(struct ice_hw *hw, u16 vsi_id, u8 lut_type, u8 *lut,
 /**
  * ice_aq_get_rss_lut
  * @hw: pointer to the hardware structure
- * @vsi_handle: software VSI handle
- * @lut_type: LUT table type
- * @lut: pointer to the LUT buffer provided by the caller
- * @lut_size: size of the LUT buffer
+ * @get_params: RSS LUT parameters used to specify which RSS LUT to get
  *
  * get the RSS lookup table, PF or VSI type
  */
 enum ice_status
-ice_aq_get_rss_lut(struct ice_hw *hw, u16 vsi_handle, u8 lut_type,
-		   u8 *lut, u16 lut_size)
+ice_aq_get_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *get_params)
 {
-	if (!ice_is_vsi_valid(hw, vsi_handle) || !lut)
-		return ICE_ERR_PARAM;
-
-	return __ice_aq_get_set_rss_lut(hw, ice_get_hw_vsi_num(hw, vsi_handle),
-					lut_type, lut, lut_size, 0, false);
+	return __ice_aq_get_set_rss_lut(hw, get_params, false);
 }
 
 /**
  * ice_aq_set_rss_lut
  * @hw: pointer to the hardware structure
- * @vsi_handle: software VSI handle
- * @lut_type: LUT table type
- * @lut: pointer to the LUT buffer provided by the caller
- * @lut_size: size of the LUT buffer
+ * @set_params: RSS LUT parameters used to specify how to set the RSS LUT
  *
  * set the RSS lookup table, PF or VSI type
  */
 enum ice_status
-ice_aq_set_rss_lut(struct ice_hw *hw, u16 vsi_handle, u8 lut_type,
-		   u8 *lut, u16 lut_size)
+ice_aq_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *set_params)
 {
-	if (!ice_is_vsi_valid(hw, vsi_handle) || !lut)
-		return ICE_ERR_PARAM;
-
-	return __ice_aq_get_set_rss_lut(hw, ice_get_hw_vsi_num(hw, vsi_handle),
-					lut_type, lut, lut_size, 0, true);
+	return __ice_aq_get_set_rss_lut(hw, set_params, true);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index baf4064fcbfe..81fd69cb1485 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -51,11 +51,9 @@ ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		  u32 rxq_index);
 
 enum ice_status
-ice_aq_get_rss_lut(struct ice_hw *hw, u16 vsi_handle, u8 lut_type, u8 *lut,
-		   u16 lut_size);
+ice_aq_get_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *get_params);
 enum ice_status
-ice_aq_set_rss_lut(struct ice_hw *hw, u16 vsi_handle, u8 lut_type, u8 *lut,
-		   u16 lut_size);
+ice_aq_set_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *set_params);
 enum ice_status
 ice_aq_get_rss_key(struct ice_hw *hw, u16 vsi_handle,
 		   struct ice_aqc_get_set_rss_keys *keys);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 26a7be2f7193..b0da7fe5468b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3358,6 +3358,7 @@ static int ice_get_valid_rss_size(struct ice_hw *hw, int new_size)
  */
 static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 {
+	struct ice_aq_get_set_rss_lut_params set_params = {};
 	struct ice_pf *pf = vsi->back;
 	enum ice_status status;
 	struct device *dev;
@@ -3383,8 +3384,12 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 
 	/* create/set RSS LUT */
 	ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
-	status = ice_aq_set_rss_lut(hw, vsi->idx, vsi->rss_lut_type, lut,
-				    vsi->rss_table_size);
+	set_params.vsi_handle = vsi->idx;
+	set_params.lut_size = vsi->rss_table_size;
+	set_params.lut_type = vsi->rss_lut_type;
+	set_params.lut = lut;
+	set_params.global_lut_id = 0;
+	status = ice_aq_set_rss_lut(hw, &set_params);
 	if (status) {
 		dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
 			ice_stat_str(status),
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f67b58a154fa..0ded64de38f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1337,6 +1337,7 @@ int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
  */
 static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 {
+	struct ice_aq_get_set_rss_lut_params set_params = {};
 	struct ice_aqc_get_set_rss_keys *key;
 	struct ice_pf *pf = vsi->back;
 	enum ice_status status;
@@ -1356,8 +1357,12 @@ static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 	else
 		ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
 
-	status = ice_aq_set_rss_lut(&pf->hw, vsi->idx, vsi->rss_lut_type, lut,
-				    vsi->rss_table_size);
+	set_params.vsi_handle = vsi->idx;
+	set_params.lut_size = vsi->rss_table_size;
+	set_params.lut_type = vsi->rss_lut_type;
+	set_params.lut = lut;
+	set_params.global_lut_id = 0;
+	status = ice_aq_set_rss_lut(&pf->hw, &set_params);
 
 	if (status) {
 		dev_err(dev, "set_rss_lut failed, error %s\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3e5f71bf333b..ed9b226156ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6366,8 +6366,13 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 	}
 
 	if (lut) {
-		status = ice_aq_set_rss_lut(hw, vsi->idx, vsi->rss_lut_type,
-					    lut, lut_size);
+		struct ice_aq_get_set_rss_lut_params set_params = {
+			.vsi_handle = vsi->idx, .lut_size = lut_size,
+			.lut_type = vsi->rss_lut_type, .lut = lut,
+			.global_lut_id = 0
+		};
+
+		status = ice_aq_set_rss_lut(hw, &set_params);
 		if (status) {
 			dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
 				ice_stat_str(status),
@@ -6410,8 +6415,13 @@ int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 	}
 
 	if (lut) {
-		status = ice_aq_get_rss_lut(hw, vsi->idx, vsi->rss_lut_type,
-					    lut, lut_size);
+		struct ice_aq_get_set_rss_lut_params get_params = {
+			.vsi_handle = vsi->idx, .lut_size = lut_size,
+			.lut_type = vsi->rss_lut_type, .lut = lut,
+			.global_lut_id = 0
+		};
+
+		status = ice_aq_get_rss_lut(hw, &get_params);
 		if (status) {
 			dev_err(dev, "Cannot get RSS lut, err %s aq_err %s\n",
 				ice_stat_str(status),
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 208989b5629d..b99c815f2bd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -910,6 +910,14 @@ struct ice_hw_port_stats {
 	u64 fd_sb_match;
 };
 
+struct ice_aq_get_set_rss_lut_params {
+	u16 vsi_handle;		/* software VSI handle */
+	u16 lut_size;		/* size of the LUT buffer */
+	u8 lut_type;		/* type of the LUT (i.e. VSI, PF, Global) */
+	u8 *lut;		/* input RSS LUT for set and output RSS LUT for get */
+	u8 global_lut_id;	/* only valid when lut_type is global */
+};
+
 /* Checksum and Shadow RAM pointers */
 #define ICE_SR_NVM_CTRL_WORD		0x00
 #define ICE_SR_BOOT_CFG_PTR		0x132
-- 
2.20.1

