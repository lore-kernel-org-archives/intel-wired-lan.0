From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 30 Nov 2021 15:51:34 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 02/14] ice: Add helper
 function for adding VLAN 0
In-Reply-To: <20211130235146.28731-1-anthony.l.nguyen@intel.com>
References: <20211130235146.28731-1-anthony.l.nguyen@intel.com>
Message-ID: <20211130235146.28731-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

There are multiple places where VLAN 0 is being added. Create a function
to be called in order to minimize changes as the implementation is expanded
to support double VLAN and avoid duplicated code.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c     |  4 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c         | 11 ++++++++++-
 drivers/net/ethernet/intel/ice/ice_lib.h         |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a737c54c4895..291748553800 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -127,7 +127,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	__dev_mc_unsync(uplink_netdev, NULL);
 	netif_addr_unlock_bh(uplink_netdev);
 
-	if (ice_vsi_add_vlan(uplink_vsi, 0, ICE_FWD_TO_VSI))
+	if (ice_vsi_add_vlan_zero(uplink_vsi))
 		goto err_def_rx;
 
 	if (!ice_is_dflt_vsi_in_use(uplink_vsi->vsw)) {
@@ -231,7 +231,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 			goto err;
 		}
 
-		if (ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI)) {
+		if (ice_vsi_add_vlan_zero(vsi)) {
 			ice_fltr_add_mac_and_broadcast(vsi,
 						       vf->hw_lan_addr.addr,
 						       ICE_FWD_TO_VSI);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 2db3cd6d8907..cc135792834e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2621,7 +2621,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi,
 		 * so this handles those cases (i.e. adding the PF to a bridge
 		 * without the 8021q module loaded).
 		 */
-		ret = ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI);
+		ret = ice_vsi_add_vlan_zero(vsi);
 		if (ret)
 			goto unroll_clear_rings;
 
@@ -4069,6 +4069,15 @@ int ice_set_link(struct ice_vsi *vsi, bool ena)
 	return 0;
 }
 
+/**
+ * ice_vsi_add_vlan_zero - add VLAN 0 filter(s) for this VSI
+ * @vsi: VSI used to add VLAN filters
+ */
+int ice_vsi_add_vlan_zero(struct ice_vsi *vsi)
+{
+	return ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI);
+}
+
 /**
  * ice_is_feature_supported
  * @pf: pointer to the struct ice_pf instance
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 9fdd95dd5a14..28e0f1147c82 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -133,7 +133,7 @@ void ice_vsi_ctx_clear_antispoof(struct ice_vsi_ctx *ctx);
 void ice_vsi_ctx_set_allow_override(struct ice_vsi_ctx *ctx);
 
 void ice_vsi_ctx_clear_allow_override(struct ice_vsi_ctx *ctx);
-
+int ice_vsi_add_vlan_zero(struct ice_vsi *vsi);
 bool ice_is_feature_supported(struct ice_pf *pf, enum ice_feature f);
 void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f947d936def3..ab03010c822d 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1855,7 +1855,7 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
 	if (!vsi)
 		return -ENOMEM;
 
-	err = ice_vsi_add_vlan(vsi, 0, ICE_FWD_TO_VSI);
+	err = ice_vsi_add_vlan_zero(vsi);
 	if (err) {
 		dev_warn(dev, "Failed to add VLAN 0 filter for VF %d\n",
 			 vf->vf_id);
-- 
2.20.1

