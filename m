From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 16 Feb 2022 13:37:34 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 07/11] ice: use
 ice_for_each_vf for iteration during removal
In-Reply-To: <20220216213738.3826664-1-jacob.e.keller@intel.com>
References: <20220216213738.3826664-1-jacob.e.keller@intel.com>
Message-ID: <20220216213738.3826664-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When removing VFs, the driver takes a weird approach of assigning
pf->num_alloc_vfs to 0 before iterating over the VFs using a temporary
variable.

This logic has been in the driver for a long time, and seems to have
been carried forward from i40e.

We want to refactor the way VFs are stored, and iterating over the data
structure without the ice_for_each_vf interface impedes this work.

The logic relies on implicitly using the num_alloc_vfs as a sort of
"safe guard" for accessing VF data.

While this sort of guard makes sense for Single Root IOV where all VFs
are added at once, the data structures don't work for VFs which can be
added and removed dynamically. We also have a separate state flag,
ICE_VF_DEINIT_IN_PROGRESS which is a stronger protection against
concurrent removal and access.

Avoid the custom tmp iteration and replace it with the standard
ice_for_each_vf iterator. Delay the assignment of num_alloc_vfs until
after this loop finishes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 6351af58f74e..3e2357460f34 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -500,7 +500,7 @@ void ice_free_vfs(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	unsigned int tmp, i;
+	unsigned int i;
 
 	if (!pf->vf)
 		return;
@@ -519,10 +519,7 @@ void ice_free_vfs(struct ice_pf *pf)
 	else
 		dev_warn(dev, "VFs are assigned - not disabling SR-IOV\n");
 
-	tmp = pf->num_alloc_vfs;
-	pf->num_qps_per_vf = 0;
-	pf->num_alloc_vfs = 0;
-	for (i = 0; i < tmp; i++) {
+	ice_for_each_vf(pf, i) {
 		struct ice_vf *vf = &pf->vf[i];
 
 		mutex_lock(&vf->cfg_lock);
@@ -558,6 +555,8 @@ void ice_free_vfs(struct ice_pf *pf)
 	if (ice_sriov_free_msix_res(pf))
 		dev_err(dev, "Failed to free MSIX resources used by SR-IOV\n");
 
+	pf->num_qps_per_vf = 0;
+	pf->num_alloc_vfs = 0;
 	devm_kfree(dev, pf->vf);
 	pf->vf = NULL;
 
-- 
2.35.1.129.gb80121027d12

