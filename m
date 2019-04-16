From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:27 -0700
Subject: [Intel-wired-lan] [PATCH S18 14/15] ice: Disable sniffing VF
 traffic on PF
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Delete code that add default Tx rule on PF. With this rule PF can see
Tx VF traffic that should go outside. For traffic from VF to another
VF default Tx rule on PF doesn't apply because of lower priority than
VF mac rule.

With this change on PF in promisc mode we can see only Rx traffic that
doesn't match any other rule (mac etc.). We can't see Tx traffic from
other VSI.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 ++---------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index aa832d9b2458..7843abf4d44d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -317,42 +317,22 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 	    test_bit(ICE_VSI_FLAG_PROMISC_CHANGED, vsi->flags)) {
 		clear_bit(ICE_VSI_FLAG_PROMISC_CHANGED, vsi->flags);
 		if (vsi->current_netdev_flags & IFF_PROMISC) {
-			/* Apply Tx filter rule to get traffic from VMs */
-			status = ice_cfg_dflt_vsi(hw, vsi->idx, true,
-						  ICE_FLTR_TX);
-			if (status) {
-				netdev_err(netdev, "Error setting default VSI %i tx rule\n",
-					   vsi->vsi_num);
-				vsi->current_netdev_flags &= ~IFF_PROMISC;
-				err = -EIO;
-				goto out_promisc;
-			}
 			/* Apply Rx filter rule to get traffic from wire */
 			status = ice_cfg_dflt_vsi(hw, vsi->idx, true,
 						  ICE_FLTR_RX);
 			if (status) {
-				netdev_err(netdev, "Error setting default VSI %i rx rule\n",
+				netdev_err(netdev, "Error setting default VSI %i Rx rule\n",
 					   vsi->vsi_num);
 				vsi->current_netdev_flags &= ~IFF_PROMISC;
 				err = -EIO;
 				goto out_promisc;
 			}
 		} else {
-			/* Clear Tx filter rule to stop traffic from VMs */
-			status = ice_cfg_dflt_vsi(hw, vsi->idx, false,
-						  ICE_FLTR_TX);
-			if (status) {
-				netdev_err(netdev, "Error clearing default VSI %i tx rule\n",
-					   vsi->vsi_num);
-				vsi->current_netdev_flags |= IFF_PROMISC;
-				err = -EIO;
-				goto out_promisc;
-			}
 			/* Clear Rx filter to remove traffic from wire */
 			status = ice_cfg_dflt_vsi(hw, vsi->idx, false,
 						  ICE_FLTR_RX);
 			if (status) {
-				netdev_err(netdev, "Error clearing default VSI %i rx rule\n",
+				netdev_err(netdev, "Error clearing default VSI %i Rx rule\n",
 					   vsi->vsi_num);
 				vsi->current_netdev_flags |= IFF_PROMISC;
 				err = -EIO;
-- 
2.20.1

