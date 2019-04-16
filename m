From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:37 -0700
Subject: [Intel-wired-lan] [PATCH S19 13/15] ice: Fix couple of issues in
 ice_vsi_release
In-Reply-To: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172439.27908-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently the driver is calling ice_napi_del() and then
unregister_netdev(). The call to unregister_netdev() will result in a
call to ice_stop() and then ice_vsi_close(). This is where we call
napi_disable() for all the MSI-X vectors. This flow is reversed so make
the changes to ensure napi_disable() happens prior to napi_del().

Before calling napi_del() and free_netdev() make sure
unregister_netdev() was called. This is done by making sure the
__ICE_DOWN bit is set in the vsi->state for the interested VSI.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      |  1 -
 drivers/net/ethernet/intel/ice/ice_lib.c  | 24 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 23e30a69f5fa..b5990ba0ee4c 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -451,7 +451,6 @@ int ice_set_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
-void ice_napi_del(struct ice_vsi *vsi);
 #ifdef CONFIG_DCB
 int ice_pf_ena_all_vsi(struct ice_pf *pf, bool locked);
 void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index fbf1eba0cc2a..f14fa51cc704 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2754,19 +2754,14 @@ int ice_vsi_release(struct ice_vsi *vsi)
 
 	if (vsi->type == ICE_VSI_VF)
 		vf = &pf->vf[vsi->vf_id];
-	/* do not unregister and free netdevs while driver is in the reset
-	 * recovery pending state. Since reset/rebuild happens through PF
-	 * service task workqueue, its not a good idea to unregister netdev
-	 * that is associated to the PF that is running the work queue items
-	 * currently. This is done to avoid check_flush_dependency() warning
-	 * on this wq
+	/* do not unregister while driver is in the reset recovery pending
+	 * state. Since reset/rebuild happens through PF service task workqueue,
+	 * it's not a good idea to unregister netdev that is associated to the
+	 * PF that is running the work queue items currently. This is done to
+	 * avoid check_flush_dependency() warning on this wq
 	 */
-	if (vsi->netdev && !ice_is_reset_in_progress(pf->state)) {
-		ice_napi_del(vsi);
+	if (vsi->netdev && !ice_is_reset_in_progress(pf->state))
 		unregister_netdev(vsi->netdev);
-		free_netdev(vsi->netdev);
-		vsi->netdev = NULL;
-	}
 
 	if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
 		ice_rss_clean(vsi);
@@ -2799,6 +2794,13 @@ int ice_vsi_release(struct ice_vsi *vsi)
 	ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
 	ice_vsi_delete(vsi);
 	ice_vsi_free_q_vectors(vsi);
+
+	/* make sure unregister_netdev() was called by checking __ICE_DOWN */
+	if (vsi->netdev && test_bit(__ICE_DOWN, vsi->state)) {
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+	}
+
 	ice_vsi_clear_rings(vsi);
 
 	ice_vsi_put_qs(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 65def2773313..0a4abc21890c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1667,7 +1667,7 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
  * ice_napi_del - Remove NAPI handler for the VSI
  * @vsi: VSI for which NAPI handler is to be removed
  */
-void ice_napi_del(struct ice_vsi *vsi)
+static void ice_napi_del(struct ice_vsi *vsi)
 {
 	int v_idx;
 
-- 
2.20.1

