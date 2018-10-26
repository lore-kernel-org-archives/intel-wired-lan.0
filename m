From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:41:04 -0700
Subject: [Intel-wired-lan] [PATCH S8 15/16] ice: Avoid nested RTNL locking
 in ice_dis_vsi
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-16-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

ice_dis_vsi() performs an rtnl_lock() if it detects a netdev that is
running on the VSI. In cases where the RTNL lock has already been
acquired, a deadlock results. Add a boolean to pass to ice_dis_vsi to
tell it if the RTNL lock is already held.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ea79e5e1f589..089b0f0b2e71 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3137,8 +3137,9 @@ static void ice_vsi_release_all(struct ice_pf *pf)
 /**
  * ice_dis_vsi - pause a VSI
  * @vsi: the VSI being paused
+ * @locked: is the rtnl_lock already held
  */
-static void ice_dis_vsi(struct ice_vsi *vsi)
+static void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 {
 	if (test_bit(__ICE_DOWN, vsi->state))
 		return;
@@ -3147,9 +3148,13 @@ static void ice_dis_vsi(struct ice_vsi *vsi)
 
 	if (vsi->type == ICE_VSI_PF && vsi->netdev) {
 		if (netif_running(vsi->netdev)) {
-			rtnl_lock();
-			vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
-			rtnl_unlock();
+			if (!locked) {
+				rtnl_lock();
+				vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
+				rtnl_unlock();
+			} else {
+				vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
+			}
 		} else {
 			ice_vsi_close(vsi);
 		}
@@ -3188,7 +3193,7 @@ static void ice_pf_dis_all_vsi(struct ice_pf *pf)
 
 	ice_for_each_vsi(pf, v)
 		if (pf->vsi[v])
-			ice_dis_vsi(pf->vsi[v]);
+			ice_dis_vsi(pf->vsi[v], false);
 }
 
 /**
-- 
2.14.3

