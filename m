From: =?unknown-8bit?q?Micha=C5=82_Ma=C5=82oszewski?= <michal.maloszewski@intel.com>
Date: Wed, 24 Feb 2021 12:07:48 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix NULL ptr dereference on
 VSI filter sync
Message-ID: <1614168468-16223-1-git-send-email-michal.maloszewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the reason of null pointer dereference in sync vsi filters.
Added new I40E_VSI_RELEASING flag to signalize deleting and releasing
of VSI resources to sync this thread with sync filters subtask.
Without this patch it is possible to start update the vsi filter list
after vsi is removed, that's causing a kernel oops.

Fixes: 17652c6336fd("i40e: remove unused argument")
Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Signed-off by: Michal Maloszewski <michal.maloszewski@intel.com>
Reviewed-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Reviewed-by: Fijalkowski, WitoldX <witoldx.fijalkowski@intel.com>
Reviewed-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v3: removed features of other patches and changed permissions to 664
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index b6830e3..558b0ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -158,6 +158,7 @@ enum i40e_vsi_state_t {
 	__I40E_VSI_OVERFLOW_PROMISC,
 	__I40E_VSI_REINIT_REQUESTED,
 	__I40E_VSI_DOWN_REQUESTED,
+	__I40E_VSI_RELEASING,
 	/* This must be last as it determines the size of the BITMAP */
 	__I40E_VSI_STATE_SIZE__,
 };
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3ed7f0e..c29678b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2634,7 +2634,8 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 
 	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v] &&
-		    (pf->vsi[v]->flags & I40E_VSI_FLAG_FILTER_CHANGED)) {
+		    (pf->vsi[v]->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
+		    !test_bit(__I40E_VSI_RELEASING, pf->vsi[v]->state)) {
 			int ret = i40e_sync_vsi_filters(pf->vsi[v]);
 
 			if (ret) {
@@ -13787,7 +13788,7 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev, "Can't remove PF VSI\n");
 		return -ENODEV;
 	}
-
+	set_bit(__I40E_VSI_RELEASING, vsi->state);
 	uplink_seid = vsi->uplink_seid;
 	if (vsi->type != I40E_VSI_SRIOV) {
 		if (vsi->netdev_registered) {
-- 
1.8.3.1

