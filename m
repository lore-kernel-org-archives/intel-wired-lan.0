From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:54 -0800
Subject: [Intel-wired-lan] [PATCH S12 07/14] ice: use ice_for_each_vsi macro
 when possible
In-Reply-To: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205101.12078-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Replace all instances of:
	for (i = 0; i < pf->num_alloc_vsi; i++)

with the following macro:
	ice_for_each_vsi(pf, i)

This will allow the code to be consistent since there are currently
cases of using both.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c     |  3 +--
 drivers/net/ethernet/intel/ice/ice_main.c        | 12 ++++++------
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 1be757f63876..b906c7d15d46 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1400,13 +1400,12 @@ ice_set_link_ksettings(struct net_device *netdev,
 		return -EOPNOTSUPP;
 
 	/* Check if this is lan vsi */
-	for (idx = 0 ; idx <  pf->num_alloc_vsi ; idx++) {
+	ice_for_each_vsi(pf, idx)
 		if (pf->vsi[idx]->type == ICE_VSI_PF) {
 			if (np->vsi != pf->vsi[idx])
 				return -EOPNOTSUPP;
 			break;
 		}
-	}
 
 	if (p->phy.media_type != ICE_MEDIA_BASET &&
 	    p->phy.media_type != ICE_MEDIA_FIBER &&
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ad1bd3fe1f34..f5ade04cb9de 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -322,7 +322,7 @@ static void ice_sync_fltr_subtask(struct ice_pf *pf)
 
 	clear_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
 
-	for (v = 0; v < pf->num_alloc_vsi; v++)
+	ice_for_each_vsi(pf, v)
 		if (pf->vsi[v] && ice_vsi_fltr_changed(pf->vsi[v]) &&
 		    ice_vsi_sync_fltr(pf->vsi[v])) {
 			/* come back and try again later */
@@ -642,7 +642,7 @@ static void ice_watchdog_subtask(struct ice_pf *pf)
 	 * can look at updated numbers whenever it cares to
 	 */
 	ice_update_pf_stats(pf);
-	for (i = 0; i < pf->num_alloc_vsi; i++)
+	ice_for_each_vsi(pf, i)
 		if (pf->vsi[i] && pf->vsi[i]->netdev)
 			ice_update_vsi_stats(pf->vsi[i]);
 }
@@ -3273,7 +3273,7 @@ static void ice_vsi_release_all(struct ice_pf *pf)
 	if (!pf->vsi)
 		return;
 
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
+	ice_for_each_vsi(pf, i) {
 		if (!pf->vsi[i])
 			continue;
 
@@ -3372,7 +3372,7 @@ static int ice_vsi_rebuild_all(struct ice_pf *pf)
 	int i;
 
 	/* loop through pf->vsi array and reinit the VSI if found */
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
+	ice_for_each_vsi(pf, i) {
 		int err;
 
 		if (!pf->vsi[i])
@@ -3409,7 +3409,7 @@ static int ice_vsi_replay_all(struct ice_pf *pf)
 	int i;
 
 	/* loop through pf->vsi array and replay the VSI if found */
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
+	ice_for_each_vsi(pf, i) {
 		if (!pf->vsi[i])
 			continue;
 
@@ -3520,7 +3520,7 @@ static void ice_rebuild(struct ice_pf *pf)
 
 	ice_reset_all_vfs(pf, true);
 
-	for (i = 0; i < pf->num_alloc_vsi; i++) {
+	ice_for_each_vsi(pf, i) {
 		bool link_up;
 
 		if (!pf->vsi[i] || pf->vsi[i]->type != ICE_VSI_PF)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index a7e1594521ec..99c8cddb2162 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1385,7 +1385,7 @@ static struct ice_vsi *ice_find_vsi_from_id(struct ice_pf *pf, u16 id)
 {
 	int i;
 
-	for (i = 0; i < pf->num_alloc_vsi; i++)
+	ice_for_each_vsi(pf, i)
 		if (pf->vsi[i] && pf->vsi[i]->vsi_num == id)
 			return pf->vsi[i];
 
-- 
2.14.5

