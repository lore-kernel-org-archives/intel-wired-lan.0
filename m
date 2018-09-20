From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:43:06 -0700
Subject: [Intel-wired-lan] [PATCH v2 14/16] ice: Use the right function to
 enable/disable VSI
In-Reply-To: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920004308.13772-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

The ice_ena/dis_vsi should have a single differentiating
factor to determine if the netdev_ops call is used or a
direct call to ice_vsi_open/close.  This is if the netif is
running or not.  If netif is running, use ndo_open/ndo_close.
Else, use ice_vsi_open/ice_vsi_close.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3e254281da63..ecd9cbc457d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3232,13 +3232,14 @@ static void ice_dis_vsi(struct ice_vsi *vsi)
 
 	set_bit(__ICE_NEEDS_RESTART, vsi->state);
 
-	if (vsi->netdev && netif_running(vsi->netdev) &&
-	    vsi->type == ICE_VSI_PF) {
-		rtnl_lock();
-		vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
-		rtnl_unlock();
-	} else {
-		ice_vsi_close(vsi);
+	if (vsi->type == ICE_VSI_PF && vsi->netdev) {
+		if (netif_running(vsi->netdev)) {
+			rtnl_lock();
+			vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
+			rtnl_unlock();
+		} else {
+			ice_vsi_close(vsi);
+		}
 	}
 }
 
@@ -3250,12 +3251,16 @@ static int ice_ena_vsi(struct ice_vsi *vsi)
 {
 	int err = 0;
 
-	if (test_and_clear_bit(__ICE_NEEDS_RESTART, vsi->state))
-		if (vsi->netdev && netif_running(vsi->netdev)) {
+	if (test_and_clear_bit(__ICE_NEEDS_RESTART, vsi->state) &&
+	    vsi->netdev) {
+		if (netif_running(vsi->netdev)) {
 			rtnl_lock();
 			err = vsi->netdev->netdev_ops->ndo_open(vsi->netdev);
 			rtnl_unlock();
+		} else {
+			err = ice_vsi_open(vsi);
 		}
+	}
 
 	return err;
 }
-- 
2.14.3

