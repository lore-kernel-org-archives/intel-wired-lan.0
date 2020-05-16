From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:11 -0700
Subject: [Intel-wired-lan] [PATCH S45 05/15] ice: Renaming and
 simplification in VF init path
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Some function names weren't very clear and some portions of VF creation
could be moved into functions for clarity. Fix this by renaming some
functions and move pieces of code into clearly name functions.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 83 ++++++++++++-------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 5b9f01f1f65b..d5c1c55f7ebc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1469,16 +1469,56 @@ static int ice_start_vfs(struct ice_pf *pf)
 }
 
 /**
- * ice_alloc_vfs - Allocate and set up VFs resources
+ * ice_set_dflt_settings - set VF defaults during initialization/creation
+ * @pf: PF holding reference to all VFs for default configuration
+ */
+static void ice_set_dflt_settings_vfs(struct ice_pf *pf)
+{
+	int i;
+
+	ice_for_each_vf(pf, i) {
+		struct ice_vf *vf = &pf->vf[i];
+
+		vf->pf = pf;
+		vf->vf_id = i;
+		vf->vf_sw_id = pf->first_sw;
+		/* assign default capabilities */
+		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vf->vf_caps);
+		vf->spoofchk = true;
+		vf->num_vf_qs = pf->num_qps_per_vf;
+	}
+}
+
+/**
+ * ice_alloc_vfs - allocate num_vfs in the PF structure
+ * @pf: PF to store the allocated VFs in
+ * @num_vfs: number of VFs to allocate
+ */
+static int ice_alloc_vfs(struct ice_pf *pf, int num_vfs)
+{
+	struct ice_vf *vfs;
+
+	vfs = devm_kcalloc(ice_pf_to_dev(pf), num_vfs, sizeof(*vfs),
+			   GFP_KERNEL);
+	if (!vfs)
+		return -ENOMEM;
+
+	pf->vf = vfs;
+	pf->num_alloc_vfs = num_vfs;
+
+	return 0;
+}
+
+/**
+ * ice_ena_vfs - enable VFs so they are ready to be used
  * @pf: pointer to the PF structure
- * @num_alloc_vfs: number of VFs to allocate
+ * @num_vfs: number of VFs to enable
  */
-static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
+static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	struct ice_vf *vfs;
-	int i, ret;
+	int ret;
 
 	/* Disable global interrupt 0 so we don't try to handle the VFLR. */
 	wr32(hw, GLINT_DYN_CTL(pf->oicr_idx),
@@ -1486,38 +1526,24 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 	set_bit(__ICE_OICR_INTR_DIS, pf->state);
 	ice_flush(hw);
 
-	ret = pci_enable_sriov(pf->pdev, num_alloc_vfs);
+	ret = pci_enable_sriov(pf->pdev, num_vfs);
 	if (ret) {
 		pf->num_alloc_vfs = 0;
 		goto err_unroll_intr;
 	}
-	/* allocate memory */
-	vfs = devm_kcalloc(dev, num_alloc_vfs, sizeof(*vfs), GFP_KERNEL);
-	if (!vfs) {
-		ret = -ENOMEM;
+
+	ret = ice_alloc_vfs(pf, num_vfs);
+	if (ret)
 		goto err_pci_disable_sriov;
-	}
-	pf->vf = vfs;
-	pf->num_alloc_vfs = num_alloc_vfs;
 
 	if (ice_set_per_vf_res(pf)) {
 		dev_err(dev, "Not enough resources for %d VFs, try with fewer number of VFs\n",
-			num_alloc_vfs);
+			num_vfs);
 		ret = -ENOSPC;
 		goto err_unroll_sriov;
 	}
 
-	/* apply default profile */
-	ice_for_each_vf(pf, i) {
-		vfs[i].pf = pf;
-		vfs[i].vf_sw_id = pf->first_sw;
-		vfs[i].vf_id = i;
-
-		/* assign default capabilities */
-		set_bit(ICE_VIRTCHNL_VF_CAP_L2, &vfs[i].vf_caps);
-		vfs[i].spoofchk = true;
-		vfs[i].num_vf_qs = pf->num_qps_per_vf;
-	}
+	ice_set_dflt_settings_vfs(pf);
 
 	if (ice_start_vfs(pf)) {
 		dev_err(dev, "Failed to start VF(s)\n");
@@ -1529,9 +1555,8 @@ static int ice_alloc_vfs(struct ice_pf *pf, u16 num_alloc_vfs)
 	return 0;
 
 err_unroll_sriov:
+	devm_kfree(dev, pf->vf);
 	pf->vf = NULL;
-	devm_kfree(dev, vfs);
-	vfs = NULL;
 	pf->num_alloc_vfs = 0;
 err_pci_disable_sriov:
 	pci_disable_sriov(pf->pdev);
@@ -1566,8 +1591,8 @@ static int ice_pci_sriov_ena(struct ice_pf *pf, int num_vfs)
 		return -EOPNOTSUPP;
 	}
 
-	dev_info(dev, "Allocating %d VFs\n", num_vfs);
-	err = ice_alloc_vfs(pf, num_vfs);
+	dev_info(dev, "Enabling %d VFs\n", num_vfs);
+	err = ice_ena_vfs(pf, num_vfs);
 	if (err) {
 		dev_err(dev, "Failed to enable SR-IOV: %d\n", err);
 		return err;
-- 
2.20.1

