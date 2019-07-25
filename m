From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 02:53:55 -0700
Subject: [Intel-wired-lan] [PATCH S25 06/12] ice: Sanitize ice_ena_vsi and
 ice_dis_vsi
In-Reply-To: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725095401.24590-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

1. ndo_open and ndo_stop are implemented by ice_open and ice_stop
   respectively. When enabling/disabling VSIs, just call
   ice_open/ice_stop instead of ndo_open/ndo_stop.

2. Rework logic around rtnl_lock/rtnl_unlock

3. In ice_ena_vsi, remove an unnecessary stack variable and return
   0 instead of err when __ICE_NEEDS_RESTART is not set.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 +++++++++++------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 920122443c0f..1abbea7a69e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -436,13 +436,13 @@ static void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 
 	if (vsi->type == ICE_VSI_PF && vsi->netdev) {
 		if (netif_running(vsi->netdev)) {
-			if (!locked) {
+			if (!locked)
 				rtnl_lock();
-				vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
+
+			ice_stop(vsi->netdev);
+
+			if (!locked)
 				rtnl_unlock();
-			} else {
-				vsi->netdev->netdev_ops->ndo_stop(vsi->netdev);
-			}
 		} else {
 			ice_vsi_close(vsi);
 		}
@@ -3690,21 +3690,19 @@ static int ice_ena_vsi(struct ice_vsi *vsi, bool locked)
 	int err = 0;
 
 	if (!test_bit(__ICE_NEEDS_RESTART, vsi->state))
-		return err;
+		return 0;
 
 	clear_bit(__ICE_NEEDS_RESTART, vsi->state);
 
 	if (vsi->netdev && vsi->type == ICE_VSI_PF) {
-		struct net_device *netd = vsi->netdev;
-
 		if (netif_running(vsi->netdev)) {
-			if (locked) {
-				err = netd->netdev_ops->ndo_open(netd);
-			} else {
+			if (!locked)
 				rtnl_lock();
-				err = netd->netdev_ops->ndo_open(netd);
+
+			err = ice_open(vsi->netdev);
+
+			if (!locked)
 				rtnl_unlock();
-			}
 		}
 	}
 
-- 
2.20.1

