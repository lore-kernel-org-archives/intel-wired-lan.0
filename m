From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:36 -0800
Subject: [Intel-wired-lan] [PATCH S56 04/13] ice: Refactor ice_set/get_rss
 into LUT and key specific functions
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently ice_set/get_rss are used to set/get the RSS LUT and/or RSS
key. However nearly everywhere these functions are called only the LUT
or key are set/get. Also, making this change reduces how many things
ice_set/get_rss are doing. Fix this by adding ice_set/get_rss_lut and
ice_set/get_rss_key functions.

Also, consolidate all calls for setting/getting the RSS LUT and RSS Key
to use ice_set/get_rss_lut() and ice_set/get_rss_key().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  43 +++---
 drivers/net/ethernet/intel/ice/ice_lib.c      |  42 ++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 139 ++++++++++--------
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   4 +-
 5 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5304296c1e39..4041859ab89b 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -621,8 +621,10 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
-int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
-int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
+int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
+int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
+int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed);
+int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b0da7fe5468b..7bc9cdefa169 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3170,7 +3170,7 @@ ice_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
-	int ret = 0, i;
+	int err, i;
 	u8 *lut;
 
 	if (hfunc)
@@ -3189,17 +3189,20 @@ ice_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
 	if (!lut)
 		return -ENOMEM;
 
-	if (ice_get_rss(vsi, key, lut, vsi->rss_table_size)) {
-		ret = -EIO;
+	err = ice_get_rss_key(vsi, key);
+	if (err)
+		goto out;
+
+	err = ice_get_rss_lut(vsi, lut, vsi->rss_table_size);
+	if (err)
 		goto out;
-	}
 
 	for (i = 0; i < vsi->rss_table_size; i++)
 		indir[i] = (u32)(lut[i]);
 
 out:
 	kfree(lut);
-	return ret;
+	return err;
 }
 
 /**
@@ -3220,7 +3223,7 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
-	u8 *seed = NULL;
+	int err;
 
 	dev = ice_pf_to_dev(pf);
 	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
@@ -3241,7 +3244,10 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
 				return -ENOMEM;
 		}
 		memcpy(vsi->rss_hkey_user, key, ICE_VSIQF_HKEY_ARRAY_SIZE);
-		seed = vsi->rss_hkey_user;
+
+		err = ice_set_rss_key(vsi, vsi->rss_hkey_user);
+		if (err)
+			return err;
 	}
 
 	if (!vsi->rss_lut_user) {
@@ -3262,8 +3268,9 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
 				 vsi->rss_size);
 	}
 
-	if (ice_set_rss(vsi, seed, vsi->rss_lut_user, vsi->rss_table_size))
-		return -EIO;
+	err = ice_set_rss_lut(vsi, vsi->rss_lut_user, vsi->rss_table_size);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -3358,12 +3365,10 @@ static int ice_get_valid_rss_size(struct ice_hw *hw, int new_size)
  */
 static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 {
-	struct ice_aq_get_set_rss_lut_params set_params = {};
 	struct ice_pf *pf = vsi->back;
-	enum ice_status status;
 	struct device *dev;
 	struct ice_hw *hw;
-	int err = 0;
+	int err;
 	u8 *lut;
 
 	dev = ice_pf_to_dev(pf);
@@ -3384,18 +3389,10 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 
 	/* create/set RSS LUT */
 	ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
-	set_params.vsi_handle = vsi->idx;
-	set_params.lut_size = vsi->rss_table_size;
-	set_params.lut_type = vsi->rss_lut_type;
-	set_params.lut = lut;
-	set_params.global_lut_id = 0;
-	status = ice_aq_set_rss_lut(hw, &set_params);
-	if (status) {
-		dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
-			ice_stat_str(status),
+	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	if (err)
+		dev_err(dev, "Cannot set RSS lut, err %d aq_err %s\n", err,
 			ice_aq_str(hw->adminq.sq_last_status));
-		err = -EIO;
-	}
 
 	kfree(lut);
 	return err;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0ded64de38f3..0b0f13ed757f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1326,7 +1326,7 @@ int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
 					 vsi->rss_size);
 	}
 
-	err = ice_set_rss(vsi, NULL, lut, vsi->rss_table_size);
+	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
 	kfree(lut);
 	return err;
 }
@@ -1337,13 +1337,10 @@ int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
  */
 static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 {
-	struct ice_aq_get_set_rss_lut_params set_params = {};
-	struct ice_aqc_get_set_rss_keys *key;
 	struct ice_pf *pf = vsi->back;
-	enum ice_status status;
 	struct device *dev;
-	int err = 0;
-	u8 *lut;
+	u8 *lut, *key;
+	int err;
 
 	dev = ice_pf_to_dev(pf);
 	vsi->rss_size = min_t(u16, vsi->rss_size, vsi->num_rxq);
@@ -1357,41 +1354,26 @@ static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 	else
 		ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
 
-	set_params.vsi_handle = vsi->idx;
-	set_params.lut_size = vsi->rss_table_size;
-	set_params.lut_type = vsi->rss_lut_type;
-	set_params.lut = lut;
-	set_params.global_lut_id = 0;
-	status = ice_aq_set_rss_lut(&pf->hw, &set_params);
-
-	if (status) {
-		dev_err(dev, "set_rss_lut failed, error %s\n",
-			ice_stat_str(status));
-		err = -EIO;
+	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	if (err) {
+		dev_err(dev, "set_rss_lut failed, error %d\n", err);
 		goto ice_vsi_cfg_rss_exit;
 	}
 
-	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	key = kzalloc(ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE, GFP_KERNEL);
 	if (!key) {
 		err = -ENOMEM;
 		goto ice_vsi_cfg_rss_exit;
 	}
 
 	if (vsi->rss_hkey_user)
-		memcpy(key,
-		       (struct ice_aqc_get_set_rss_keys *)vsi->rss_hkey_user,
-		       ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
+		memcpy(key, vsi->rss_hkey_user, ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
 	else
-		netdev_rss_key_fill((void *)key,
-				    ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
-
-	status = ice_aq_set_rss_key(&pf->hw, vsi->idx, key);
+		netdev_rss_key_fill((void *)key, ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
 
-	if (status) {
-		dev_err(dev, "set_rss_key failed, error %s\n",
-			ice_stat_str(status));
-		err = -EIO;
-	}
+	err = ice_set_rss_key(vsi, key);
+	if (err)
+		dev_err(dev, "set_rss_key failed, error %d\n", err);
 
 	kfree(key);
 ice_vsi_cfg_rss_exit:
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ed9b226156ce..25a3f06c7828 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6335,99 +6335,118 @@ const char *ice_stat_str(enum ice_status stat_err)
 }
 
 /**
- * ice_set_rss - Set RSS keys and lut
+ * ice_set_rss_lut - Set RSS LUT
  * @vsi: Pointer to VSI structure
- * @seed: RSS hash seed
  * @lut: Lookup table
  * @lut_size: Lookup table size
  *
  * Returns 0 on success, negative on failure
  */
-int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
+int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size)
 {
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_aq_get_set_rss_lut_params params = {};
+	struct ice_hw *hw = &vsi->back->hw;
 	enum ice_status status;
-	struct device *dev;
 
-	dev = ice_pf_to_dev(pf);
-	if (seed) {
-		struct ice_aqc_get_set_rss_keys *buf =
-				  (struct ice_aqc_get_set_rss_keys *)seed;
+	if (!lut)
+		return -EINVAL;
 
-		status = ice_aq_set_rss_key(hw, vsi->idx, buf);
+	params.vsi_handle = vsi->idx;
+	params.lut_size = lut_size;
+	params.lut_type = vsi->rss_lut_type;
+	params.lut = lut;
 
-		if (status) {
-			dev_err(dev, "Cannot set RSS key, err %s aq_err %s\n",
-				ice_stat_str(status),
-				ice_aq_str(hw->adminq.sq_last_status));
-			return -EIO;
-		}
+	status = ice_aq_set_rss_lut(hw, &params);
+	if (status) {
+		dev_err(ice_pf_to_dev(vsi->back), "Cannot set RSS lut, err %s aq_err %s\n",
+			ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+		return -EIO;
 	}
 
-	if (lut) {
-		struct ice_aq_get_set_rss_lut_params set_params = {
-			.vsi_handle = vsi->idx, .lut_size = lut_size,
-			.lut_type = vsi->rss_lut_type, .lut = lut,
-			.global_lut_id = 0
-		};
+	return 0;
+}
 
-		status = ice_aq_set_rss_lut(hw, &set_params);
-		if (status) {
-			dev_err(dev, "Cannot set RSS lut, err %s aq_err %s\n",
-				ice_stat_str(status),
-				ice_aq_str(hw->adminq.sq_last_status));
-			return -EIO;
-		}
+/**
+ * ice_set_rss_key - Set RSS key
+ * @vsi: Pointer to the VSI structure
+ * @seed: RSS hash seed
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	enum ice_status status;
+
+	if (!seed)
+		return -EINVAL;
+
+	status = ice_aq_set_rss_key(hw, vsi->idx, (struct ice_aqc_get_set_rss_keys *)seed);
+	if (status) {
+		dev_err(ice_pf_to_dev(vsi->back), "Cannot set RSS key, err %s aq_err %s\n",
+			ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+		return -EIO;
 	}
 
 	return 0;
 }
 
 /**
- * ice_get_rss - Get RSS keys and lut
+ * ice_get_rss_lut - Get RSS LUT
  * @vsi: Pointer to VSI structure
- * @seed: Buffer to store the keys
  * @lut: Buffer to store the lookup table entries
  * @lut_size: Size of buffer to store the lookup table entries
  *
  * Returns 0 on success, negative on failure
  */
-int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
+int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size)
 {
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
+	struct ice_aq_get_set_rss_lut_params params = {};
+	struct ice_hw *hw = &vsi->back->hw;
 	enum ice_status status;
-	struct device *dev;
 
-	dev = ice_pf_to_dev(pf);
-	if (seed) {
-		struct ice_aqc_get_set_rss_keys *buf =
-				  (struct ice_aqc_get_set_rss_keys *)seed;
+	if (!lut)
+		return -EINVAL;
 
-		status = ice_aq_get_rss_key(hw, vsi->idx, buf);
-		if (status) {
-			dev_err(dev, "Cannot get RSS key, err %s aq_err %s\n",
-				ice_stat_str(status),
-				ice_aq_str(hw->adminq.sq_last_status));
-			return -EIO;
-		}
+	params.vsi_handle = vsi->idx;
+	params.lut_size = lut_size;
+	params.lut_type = vsi->rss_lut_type;
+	params.lut = lut;
+
+	status = ice_aq_get_rss_lut(hw, &params);
+	if (status) {
+		dev_err(ice_pf_to_dev(vsi->back), "Cannot get RSS lut, err %s aq_err %s\n",
+			ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+		return -EIO;
 	}
 
-	if (lut) {
-		struct ice_aq_get_set_rss_lut_params get_params = {
-			.vsi_handle = vsi->idx, .lut_size = lut_size,
-			.lut_type = vsi->rss_lut_type, .lut = lut,
-			.global_lut_id = 0
-		};
+	return 0;
+}
 
-		status = ice_aq_get_rss_lut(hw, &get_params);
-		if (status) {
-			dev_err(dev, "Cannot get RSS lut, err %s aq_err %s\n",
-				ice_stat_str(status),
-				ice_aq_str(hw->adminq.sq_last_status));
-			return -EIO;
-		}
+/**
+ * ice_get_rss_key - Get RSS key
+ * @vsi: Pointer to VSI structure
+ * @seed: Buffer to store the key in
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	enum ice_status status;
+
+	if (!seed)
+		return -EINVAL;
+
+	status = ice_aq_get_rss_key(hw, vsi->idx, (struct ice_aqc_get_set_rss_keys *)seed);
+	if (status) {
+		dev_err(ice_pf_to_dev(vsi->back), "Cannot get RSS key, err %s aq_err %s\n",
+			ice_stat_str(status),
+			ice_aq_str(hw->adminq.sq_last_status));
+		return -EIO;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index c30b1dd9ac29..07294cd936e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2252,7 +2252,7 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (ice_set_rss(vsi, vrk->key, NULL, 0))
+	if (ice_set_rss_key(vsi, vrk->key))
 		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
 error_param:
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_KEY, v_ret,
@@ -2299,7 +2299,7 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (ice_set_rss(vsi, NULL, vrl->lut, ICE_VSIQF_HLUT_ARRAY_SIZE))
+	if (ice_set_rss_lut(vsi, vrl->lut, ICE_VSIQF_HLUT_ARRAY_SIZE))
 		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
 error_param:
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_LUT, v_ret,
-- 
2.20.1

