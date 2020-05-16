From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:10 -0700
Subject: [Intel-wired-lan] [PATCH S45 04/15] ice: Separate VF VSI
 initialization/creation from reset flow
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the same flow is used for VF VSI initialization/creation and VF
VSI reset. This makes the initialization/creation flow unnecessarily
complicated. Fix this by separating the initialization/creation of the
VF VSI from the reset flow.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 110 +++++++++++++++++-
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 18fe4cfe4443..5b9f01f1f65b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1375,6 +1375,99 @@ static void ice_vc_notify_vf_reset(struct ice_vf *vf)
 			      NULL);
 }
 
+/**
+ * ice_init_vf_vsi_res - initialize/setup VF VSI resources
+ * @vf: VF to initialize/setup the VSI for
+ *
+ * This function creates a VSI for the VF, adds a VLAN 0 filter, and sets up the
+ * VF VSI's broadcast filter and is only used during initial VF creation.
+ */
+static int ice_init_vf_vsi_res(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+	u8 broadcast[ETH_ALEN];
+	enum ice_status status;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	int err;
+
+	vf->first_vector_idx = ice_calc_vf_first_vector_idx(pf, vf);
+
+	dev = ice_pf_to_dev(pf);
+	vsi = ice_vf_vsi_setup(pf, pf->hw.port_info, vf->vf_id);
+	if (!vsi) {
+		dev_err(dev, "Failed to create VF VSI\n");
+		return -ENOMEM;
+	}
+
+	vf->lan_vsi_idx = vsi->idx;
+	vf->lan_vsi_num = vsi->vsi_num;
+
+	err = ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI);
+	if (err) {
+		dev_warn(dev, "Failed to add VLAN 0 filter for VF %d\n",
+			 vf->vf_id);
+		goto release_vsi;
+	}
+
+	eth_broadcast_addr(broadcast);
+	status = ice_fltr_add_mac(vsi, broadcast, ICE_FWD_TO_VSI);
+	if (status) {
+		dev_err(dev, "Failed to add broadcast MAC filter for VF %d, status %s\n",
+			vf->vf_id, ice_stat_str(status));
+		err = ice_status_to_errno(status);
+		goto release_vsi;
+	}
+
+	vf->num_mac = 1;
+
+	return 0;
+
+release_vsi:
+	ice_vsi_release(vsi);
+	return err;
+}
+
+/**
+ * ice_start_vfs - start VFs so they are ready to be used by SR-IOV
+ * @pf: PF the VFs are associated with
+ */
+static int ice_start_vfs(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+	int retval, i;
+
+	ice_for_each_vf(pf, i) {
+		struct ice_vf *vf = &pf->vf[i];
+
+		ice_clear_vf_reset_trigger(vf);
+
+		retval = ice_init_vf_vsi_res(vf);
+		if (retval) {
+			dev_err(ice_pf_to_dev(pf), "Failed to initialize VSI resources for VF %d, error %d\n",
+				vf->vf_id, retval);
+			goto teardown;
+		}
+
+		set_bit(ICE_VF_STATE_INIT, vf->vf_states);
+		ice_ena_vf_mappings(vf);
+		wr32(hw, VFGEN_RSTAT(vf->vf_id), VIRTCHNL_VFR_VFACTIVE);
+	}
+
+	ice_flush(hw);
+	return 0;
+
+teardown:
+	for (i = i - 1; i >= 0; i--) {
+		struct ice_vf *vf = &pf->vf[i];
+
+		ice_dis_vf_mappings(vf);
+		ice_vsi_release(pf->vsi[vf->lan_vsi_idx]);
+	}
+
+	return retval;
+}
+
 /**
  * ice_alloc_vfs - Allocate and set up VFs resources
  * @pf: pointer to the PF structure
@@ -1407,6 +1500,13 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 	pf->vf = vfs;
 	pf->num_alloc_vfs = num_alloc_vfs;
 
+	if (ice_set_per_vf_res(pf)) {
+		dev_err(dev, "Not enough resources for %d VFs, try with fewer number of VFs\n",
+			num_alloc_vfs);
+		ret = -ENOSPC;
+		goto err_unroll_sriov;
+	}
+
 	/* apply default profile */
 	ice_for_each_vf(pf, i) {
 		vfs[i].pf = pf;
@@ -1416,15 +1516,17 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 		/* assign default capabilities */
 		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vfs[i].vf_caps);
 		vfs[i].spoofchk = true;
+		vfs[i].num_vf_qs = pf->num_qps_per_vf;
 	}
 
-	/* VF resources get allocated with initialization */
-	if (!ice_config_res_vfs(pf)) {
-		ret = -EIO;
+	if (ice_start_vfs(pf)) {
+		dev_err(dev, "Failed to start VF(s)\n");
+		ret = -EAGAIN;
 		goto err_unroll_sriov;
 	}
 
-	return ret;
+	clear_bit(__ICE_VF_DIS, pf->state);
+	return 0;
 
 err_unroll_sriov:
 	pf->vf = NULL;
-- 
2.20.1

