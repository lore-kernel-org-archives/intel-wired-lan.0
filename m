From: Brett Creeley <brett.creeley@intel.com>
Date: Mon, 28 Jun 2021 10:53:45 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix failure to re-add LAN/RDMA Tx
 queues
Message-ID: <20210628175345.50764-1-brett.creeley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently if the VSI is rebuilt/removed and the RDMA PF driver is active
the RDMA Tx queue scheduler node configuration will not be cleaned up.
This will cause the rebuild/re-add of the VSI to fail due to the
software structures not being correctly cleaned up for the VSI index.
Fix this by always calling ice_rm_vsi_rdma_cfg() for all VSI. If there
are no RDMA scheduler nodes created, then there is no harm in calling
ice_rm_vsi_rdma_cfg(). This change applies to all VSI types, so if
RDMA support is added for other VSI types they will also get this
change.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c   |  9 +++++++++
 drivers/net/ethernet/intel/ice/ice_sched.c | 13 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_sched.h |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index dde9802c6c72..7bacc0af60d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2842,6 +2842,7 @@ void ice_napi_del(struct ice_vsi *vsi)
 int ice_vsi_release(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf;
+	int err;
 
 	if (!vsi->back)
 		return -ENODEV;
@@ -2912,6 +2913,10 @@ int ice_vsi_release(struct ice_vsi *vsi)
 
 	ice_fltr_remove_all(vsi);
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
+	err = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
+	if (err)
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
+			vsi->vsi_num, err);
 	ice_vsi_delete(vsi);
 	ice_vsi_free_q_vectors(vsi);
 
@@ -3092,6 +3097,10 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
 
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
+	ret = ice_rm_vsi_rdma_cfg(vsi->port_info, vsi->idx);
+	if (ret)
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
+			vsi->vsi_num, ret);
 	ice_vsi_free_q_vectors(vsi);
 
 	/* SR-IOV determines needed MSIX resources all at once instead of per
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index a17e24e54cf3..aa19c470edce 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2070,6 +2070,19 @@ enum ice_status ice_rm_vsi_lan_cfg(struct ice_port_info *pi, u16 vsi_handle)
 	return ice_sched_rm_vsi_cfg(pi, vsi_handle, ICE_SCHED_NODE_OWNER_LAN);
 }
 
+/**
+ * ice_rm_vsi_rdma_cfg - remove VSI and its RDMA children nodes
+ * @pi: port information structure
+ * @vsi_handle: software VSI handle
+ *
+ * This function clears the VSI and its RDMA children nodes from scheduler tree
+ * for all TCs.
+ */
+enum ice_status ice_rm_vsi_rdma_cfg(struct ice_port_info *pi, u16 vsi_handle)
+{
+	return ice_sched_rm_vsi_cfg(pi, vsi_handle, ICE_SCHED_NODE_OWNER_RDMA);
+}
+
 /**
  * ice_get_agg_info - get the aggregator ID
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 9beef8f0ec76..fdf7a5882f07 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -89,6 +89,7 @@ enum ice_status
 ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 maxqs,
 		  u8 owner, bool enable);
 enum ice_status ice_rm_vsi_lan_cfg(struct ice_port_info *pi, u16 vsi_handle);
+enum ice_status ice_rm_vsi_rdma_cfg(struct ice_port_info *pi, u16 vsi_handle);
 
 /* Tx scheduler rate limiter functions */
 enum ice_status
-- 
2.26.3

