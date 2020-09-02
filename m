From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  2 Sep 2020 08:53:46 -0700
Subject: [Intel-wired-lan] [net 5/6] ice: fix memory leak if
 register_netdev_fails
In-Reply-To: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
Message-ID: <20200902155347.16972-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_setup_pf_sw function can cause a memory leak if register_netdev
fails, due to accidentally failing to free the VSI rings. Fix the memory
leak by using ice_vsi_release, ensuring we actually go through the full
teardown process.

This should be safe even if the netdevice is not registered because we
will have set the netdev pointer to NULL, ensuring ice_vsi_release won't
call unregister_netdev.

An alternative fix would be moving management of the PF VSI netdev into
the main VSI setup code. This is complicated and likely requires
significant refactor in how we manage VSIs

Fixes: 3a858ba392c3 ("ice: Add support for VSI allocation and deallocation")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  |  6 +++---
 drivers/net/ethernet/intel/ice/ice_lib.h  |  6 ------
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++----------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f2682776f8c8..65cc78279501 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -246,7 +246,7 @@ static int ice_get_free_slot(void *array, int size, int curr)
  * ice_vsi_delete - delete a VSI from the switch
  * @vsi: pointer to VSI being removed
  */
-void ice_vsi_delete(struct ice_vsi *vsi)
+static void ice_vsi_delete(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_vsi_ctx *ctxt;
@@ -313,7 +313,7 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
  *
  * Returns 0 on success, negative on failure
  */
-int ice_vsi_clear(struct ice_vsi *vsi)
+static int ice_vsi_clear(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = NULL;
 	struct device *dev;
@@ -563,7 +563,7 @@ static int ice_vsi_get_qs(struct ice_vsi *vsi)
  * ice_vsi_put_qs - Release queues from VSI to PF
  * @vsi: the VSI that is going to release queues
  */
-void ice_vsi_put_qs(struct ice_vsi *vsi)
+static void ice_vsi_put_qs(struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	int i;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 981f3a156c24..3da17895a2b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -45,10 +45,6 @@ int ice_cfg_vlan_pruning(struct ice_vsi *vsi, bool ena, bool vlan_promisc);
 
 void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
 
-void ice_vsi_delete(struct ice_vsi *vsi);
-
-int ice_vsi_clear(struct ice_vsi *vsi);
-
 #ifdef CONFIG_DCB
 int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 #endif /* CONFIG_DCB */
@@ -79,8 +75,6 @@ bool ice_is_reset_in_progress(unsigned long *state);
 void
 ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio);
 
-void ice_vsi_put_qs(struct ice_vsi *vsi);
-
 void ice_vsi_dis_irq(struct ice_vsi *vsi);
 
 void ice_vsi_free_irq(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ebec34d23865..d148bb71f290 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3178,10 +3178,8 @@ static int ice_setup_pf_sw(struct ice_pf *pf)
 		return -EBUSY;
 
 	vsi = ice_pf_vsi_setup(pf, pf->hw.port_info);
-	if (!vsi) {
-		status = -ENOMEM;
-		goto unroll_vsi_setup;
-	}
+	if (!vsi)
+		return -ENOMEM;
 
 	status = ice_cfg_netdev(vsi);
 	if (status) {
@@ -3228,12 +3226,7 @@ static int ice_setup_pf_sw(struct ice_pf *pf)
 	}
 
 unroll_vsi_setup:
-	if (vsi) {
-		ice_vsi_free_q_vectors(vsi);
-		ice_vsi_delete(vsi);
-		ice_vsi_put_qs(vsi);
-		ice_vsi_clear(vsi);
-	}
+	ice_vsi_release(vsi);
 	return status;
 }
 
-- 
2.20.1

