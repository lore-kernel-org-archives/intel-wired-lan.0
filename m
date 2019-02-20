From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 20 Feb 2019 09:11:48 -0800
Subject: [Intel-wired-lan] [PATCH S15 v2 03/14] ice: Fix issue with VF
 attempt to delete default MAC address
Message-ID: <20190220171148.30904-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch fixes issue that occurs when VF is attempting to remove
default LAN/MAC address, which is programmed by the administrator.
We shouldn't return error for the call by the VF, but continue with
the remaining steps to handle MAC opcode. Also update the dev_err
message to explicitly say that VF can't change MAC programmed by PF.

Also change "mac" to "MAC" for kernel print statements in the same file.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> fixed commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 7a4f86ad8149..e322bde45c59 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2061,23 +2061,22 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 				 * already added. Just continue.
 				 */
 				dev_info(&pf->pdev->dev,
-					 "mac %pM already set for VF %d\n",
+					 "MAC %pM already set for VF %d\n",
 					 maddr, vf->vf_id);
 				continue;
 			} else {
 				/* VF can't remove dflt_lan_addr/bcast mac */
 				dev_err(&pf->pdev->dev,
-					"can't remove mac %pM for VF %d\n",
+					"VF can't remove default MAC address or MAC %pM programmed by PF for VF %d\n",
 					maddr, vf->vf_id);
-				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-				goto handle_mac_exit;
+				continue;
 			}
 		}
 
 		/* check for the invalid cases and bail if necessary */
 		if (is_zero_ether_addr(maddr)) {
 			dev_err(&pf->pdev->dev,
-				"invalid mac %pM provided for VF %d\n",
+				"invalid MAC %pM provided for VF %d\n",
 				maddr, vf->vf_id);
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto handle_mac_exit;
@@ -2086,7 +2085,7 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 		if (is_unicast_ether_addr(maddr) &&
 		    !ice_can_vf_change_mac(vf)) {
 			dev_err(&pf->pdev->dev,
-				"can't change unicast mac for untrusted VF %d\n",
+				"can't change unicast MAC for untrusted VF %d\n",
 				vf->vf_id);
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto handle_mac_exit;
@@ -2108,7 +2107,7 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 
 	if (v_ret) {
 		dev_err(&pf->pdev->dev,
-			"can't update mac filters for VF %d, error %d\n",
+			"can't update MAC filters for VF %d, error %d\n",
 			vf->vf_id, v_ret);
 	} else {
 		if (set)
@@ -2809,7 +2808,7 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	ether_addr_copy(vf->dflt_lan_addr.addr, mac);
 	vf->pf_set_mac = true;
 	netdev_info(netdev,
-		    "mac on VF %d set to %pM. VF driver will be reinitialized\n",
+		    "MAC on VF %d set to %pM. VF driver will be reinitialized\n",
 		    vf_id, mac);
 
 	ice_vc_dis_vf(vf);
-- 
2.14.5

