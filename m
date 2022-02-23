From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:58 -0800
Subject: [Intel-wired-lan] [net-next PATCH 11/25] ice: use ice_is_vf_trusted
 helper function
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ice_vc_cfg_promiscuous_mode_msg function directly checks
ICE_VIRTCHNL_VF_CAP_PRIVILEGE, instead of using the existing helper
function ice_is_vf_trusted. Switch this to use the helper function so
that all trusted checks are consistent. This aids in any potential
future refactor by ensuring consistent code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index d41fce16ddfb..432841ab4352 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -3148,6 +3148,15 @@ int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 	return ret;
 }
 
+/**
+ * ice_is_vf_trusted
+ * @vf: pointer to the VF info
+ */
+static bool ice_is_vf_trusted(struct ice_vf *vf)
+{
+	return test_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
 /**
  * ice_is_any_vf_in_promisc - check if any VF(s) are in promiscuous mode
  * @pf: PF structure for accessing VF(s)
@@ -3212,7 +3221,7 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 	}
 
 	dev = ice_pf_to_dev(pf);
-	if (!test_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
+	if (!ice_is_vf_trusted(vf)) {
 		dev_err(dev, "Unprivileged VF %d is attempting to configure promiscuous mode\n",
 			vf->vf_id);
 		/* Leave v_ret alone, lie to the VF on purpose. */
@@ -3862,15 +3871,6 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				     NULL, 0);
 }
 
-/**
- * ice_is_vf_trusted
- * @vf: pointer to the VF info
- */
-static bool ice_is_vf_trusted(struct ice_vf *vf)
-{
-	return test_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
-}
-
 /**
  * ice_can_vf_change_mac
  * @vf: pointer to the VF info
-- 
2.35.1.129.gb80121027d12

