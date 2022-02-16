From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 15 Feb 2022 17:31:17 -0800
Subject: [Intel-wired-lan] [net-next PATCH 01/11] ice: refactor unwind
 cleanup in eswitch mode
In-Reply-To: <20220216013127.3263153-1-jacob.e.keller@intel.com>
References: <20220216013127.3263153-1-jacob.e.keller@intel.com>
Message-ID: <20220216013127.3263153-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The code for supporting eswitch mode and port representors on VFs uses
an unwind based cleanup flow when handling errors.

These flows are used to cleanup and get everything back to the state
prior to attempting to switch from legacy to representor mode or back.

The unwind iterations make sense, but complicate a plan to refactor the
VF array structure. In the future we won't have a clean method of
reversing an iteration of the VFs.

Instead, we can change the cleanup flow to just iterate over all VF
structures and clean up appropriately.

First notice that ice_repr_add_for_all_vfs and ice_repr_rem_from_all_vfs
have an additional step of re-assigning the VC ops. There is no good
reason to do this outside of ice_repr_add and ice_repr_rem. It can
simply be done as the last step of these functions.

Second, make sure ice_repr_rem is safe to call on a VF which does not
have a representor. Check if vf->repr is NULL first and exit early if
so.

Move ice_repr_rem_from_all_vfs above ice_repr_add_for_all_vfs so that we
can call it from the cleanup function.

In ice_eswitch.c, replace the unwind iteration with a call to
ice_eswitch_release_reprs. This will go through all of the VFs and
revert the VF back to the standard model without the eswitch mode.

To make this safe, ensure this function checks whether or not the
represent or has been moved. Rely on the metadata destination in
vf->repr->dst. This must be NULL if the representor has not been moved
to eswitch mode.

Ensure that we always re-assign this value back to NULL after freeing
it, and move the ice_eswitch_release_reprs so that it can be called from
the setup function.

With these changes, eswitch cleanup no longer uses an unwind flow that
is problematic for the planned VF data structure change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 63 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_repr.c    | 47 +++++++--------
 2 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 95c81fc9ec9f..22babf59d40b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -202,6 +202,34 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_eswitch_release_reprs - clear PR VSIs configuration
+ * @pf: poiner to PF struct
+ * @ctrl_vsi: pointer to switchdev control VSI
+ */
+static void
+ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
+{
+	int i;
+
+	ice_for_each_vf(pf, i) {
+		struct ice_vsi *vsi = pf->vf[i].repr->src_vsi;
+		struct ice_vf *vf = &pf->vf[i];
+
+		/* Skip VFs that aren't configured */
+		if (!vf->repr->dst)
+			continue;
+
+		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
+		metadata_dst_free(vf->repr->dst);
+		vf->repr->dst = NULL;
+		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr.addr,
+					       ICE_FWD_TO_VSI);
+
+		netif_napi_del(&vf->repr->q_vector->napi);
+	}
+}
+
 /**
  * ice_eswitch_setup_reprs - configure port reprs to run in switchdev mode
  * @pf: pointer to PF struct
@@ -231,6 +259,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 						       vf->hw_lan_addr.addr,
 						       ICE_FWD_TO_VSI);
 			metadata_dst_free(vf->repr->dst);
+			vf->repr->dst = NULL;
 			goto err;
 		}
 
@@ -239,6 +268,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 						       vf->hw_lan_addr.addr,
 						       ICE_FWD_TO_VSI);
 			metadata_dst_free(vf->repr->dst);
+			vf->repr->dst = NULL;
 			ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
 			goto err;
 		}
@@ -266,42 +296,11 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 	return 0;
 
 err:
-	for (i = i - 1; i >= 0; i--) {
-		struct ice_vsi *vsi = pf->vf[i].repr->src_vsi;
-		struct ice_vf *vf = &pf->vf[i];
-
-		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-		metadata_dst_free(vf->repr->dst);
-		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr.addr,
-					       ICE_FWD_TO_VSI);
-	}
+	ice_eswitch_release_reprs(pf, ctrl_vsi);
 
 	return -ENODEV;
 }
 
-/**
- * ice_eswitch_release_reprs - clear PR VSIs configuration
- * @pf: poiner to PF struct
- * @ctrl_vsi: pointer to switchdev control VSI
- */
-static void
-ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
-{
-	int i;
-
-	ice_for_each_vf(pf, i) {
-		struct ice_vsi *vsi = pf->vf[i].repr->src_vsi;
-		struct ice_vf *vf = &pf->vf[i];
-
-		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-		metadata_dst_free(vf->repr->dst);
-		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr.addr,
-					       ICE_FWD_TO_VSI);
-
-		netif_napi_del(&vf->repr->q_vector->napi);
-	}
-}
-
 /**
  * ice_eswitch_update_repr - reconfigure VF port representor
  * @vsi: VF VSI for which port representor is configured
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 3f4af6a168d5..0f9826e89381 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -339,6 +339,8 @@ static int ice_repr_add(struct ice_vf *vf)
 
 	devlink_port_type_eth_set(&vf->devlink_port, repr->netdev);
 
+	ice_vc_change_ops_to_repr(&vf->vc_ops);
+
 	return 0;
 
 err_netdev:
@@ -366,6 +368,9 @@ static int ice_repr_add(struct ice_vf *vf)
  */
 static void ice_repr_rem(struct ice_vf *vf)
 {
+	if (!vf->repr)
+		return;
+
 	ice_devlink_destroy_vf_port(vf);
 	kfree(vf->repr->q_vector);
 	vf->repr->q_vector = NULL;
@@ -378,6 +383,23 @@ static void ice_repr_rem(struct ice_vf *vf)
 #endif
 	kfree(vf->repr);
 	vf->repr = NULL;
+
+	ice_vc_set_dflt_vf_ops(&vf->vc_ops);
+}
+
+/**
+ * ice_repr_rem_from_all_vfs - remove port representor for all VFs
+ * @pf: pointer to PF structure
+ */
+void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
+{
+	int i;
+
+	ice_for_each_vf(pf, i) {
+		struct ice_vf *vf = &pf->vf[i];
+
+		ice_repr_rem(vf);
+	}
 }
 
 /**
@@ -395,39 +417,16 @@ int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 		err = ice_repr_add(vf);
 		if (err)
 			goto err;
-
-		ice_vc_change_ops_to_repr(&vf->vc_ops);
 	}
 
 	return 0;
 
 err:
-	for (i = i - 1; i >= 0; i--) {
-		struct ice_vf *vf = &pf->vf[i];
-
-		ice_repr_rem(vf);
-		ice_vc_set_dflt_vf_ops(&vf->vc_ops);
-	}
+	ice_repr_rem_from_all_vfs(pf);
 
 	return err;
 }
 
-/**
- * ice_repr_rem_from_all_vfs - remove port representor for all VFs
- * @pf: pointer to PF structure
- */
-void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
-{
-	int i;
-
-	ice_for_each_vf(pf, i) {
-		struct ice_vf *vf = &pf->vf[i];
-
-		ice_repr_rem(vf);
-		ice_vc_set_dflt_vf_ops(&vf->vc_ops);
-	}
-}
-
 /**
  * ice_repr_start_tx_queues - start Tx queues of port representor
  * @repr: pointer to repr structure
-- 
2.35.1.129.gb80121027d12

