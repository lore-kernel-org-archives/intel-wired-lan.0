From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:54 -0800
Subject: [Intel-wired-lan] [net-next PATCH 07/25] ice: refactor spoofchk
 control code in ice_sriov.c
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-8-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The API to control the VSI spoof checking for a VF VSI has three
functions: enable, disable, and set. The set function takes the VSI and
the VF and decides whether to call enable or disable based on the
vf->spoofchk field.

In some flows, vf->spoofchk is not yet set, such as the function used to
control the setting for a VF. (vf->spoofchk is only updated after a
success).

Simplify this API by refactoring ice_vf_set_spoofchk_cfg to be
"ice_vsi_apply_spoofchk" which takes the boolean and allows all callers
to avoid having to determine whether to call enable or disable
themselves.

This matches the expected callers better, and will prevent the need to
export more than one function when this code must be called from another
file.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7cd910bb7a7a..8d22b5d94706 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -985,16 +985,15 @@ static int ice_vsi_dis_spoofchk(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vf_set_spoofchk_cfg - apply Tx spoof checking setting
- * @vf: VF set spoofchk for
+ * ice_vsi_apply_spoofchk - Apply Tx spoof checking setting to a VSI
  * @vsi: VSI associated to the VF
+ * @enable: whether to enable or disable the spoof checking
  */
-static int
-ice_vf_set_spoofchk_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
+static int ice_vsi_apply_spoofchk(struct ice_vsi *vsi, bool enable)
 {
 	int err;
 
-	if (vf->spoofchk)
+	if (enable)
 		err = ice_vsi_ena_spoofchk(vsi);
 	else
 		err = ice_vsi_dis_spoofchk(vsi);
@@ -1478,7 +1477,7 @@ static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
 		dev_err(dev, "failed to rebuild Tx rate limiting configuration for VF %u\n",
 			vf->vf_id);
 
-	if (ice_vf_set_spoofchk_cfg(vf, vsi))
+	if (ice_vsi_apply_spoofchk(vsi, vf->spoofchk))
 		dev_err(dev, "failed to rebuild spoofchk configuration for VF %d\n",
 			vf->vf_id);
 
@@ -1915,7 +1914,7 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 		goto release_vsi;
 	}
 
-	err = ice_vf_set_spoofchk_cfg(vf, vsi);
+	err = ice_vsi_apply_spoofchk(vsi, vf->spoofchk);
 	if (err) {
 		dev_warn(dev, "Failed to initialize spoofchk setting for VF %d\n",
 			 vf->vf_id);
@@ -3129,10 +3128,7 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 		goto out_put_vf;
 	}
 
-	if (ena)
-		ret = ice_vsi_ena_spoofchk(vf_vsi);
-	else
-		ret = ice_vsi_dis_spoofchk(vf_vsi);
+	ret = ice_vsi_apply_spoofchk(vf_vsi, ena);
 	if (ret)
 		dev_err(dev, "Failed to set spoofchk %s for VF %d VSI %d\n error %d\n",
 			ena ? "ON" : "OFF", vf->vf_id, vf_vsi->vsi_num, ret);
-- 
2.35.1.129.gb80121027d12

