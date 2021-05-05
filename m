From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  5 May 2021 14:17:57 -0700
Subject: [Intel-wired-lan] [PATCH net 1/4] ice: Remove toggling of antispoof
 for VF trusted promiscuous mode
Message-ID: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently when a trusted VF enables promiscuous mode spoofchk will be
disabled. This is wrong and should only be modified from the
ndo_set_vf_spoofchk callback. Fix this by removing the call to toggle
spoofchk for trusted VFs.

Fixes: 01b5e89aab49 ("ice: Add VF promiscuous support")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index d7115a2a10d7..4001dc723e1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2992,24 +2992,6 @@ static int ice_vc_cfg_promiscuous_mode_msg(struct ice_vf *vf, u8 *msg)
 	rm_promisc = !allmulti && !alluni;
 
 	if (vsi->num_vlan || vf->port_vlan_info) {
-		struct ice_vsi *pf_vsi = ice_get_main_vsi(pf);
-		struct net_device *pf_netdev;
-
-		if (!pf_vsi) {
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-			goto error_param;
-		}
-
-		pf_netdev = pf_vsi->netdev;
-
-		ret = ice_set_vf_spoofchk(pf_netdev, vf->vf_id, rm_promisc);
-		if (ret) {
-			dev_err(dev, "Failed to update spoofchk to %s for VF %d VSI %d when setting promiscuous mode\n",
-				rm_promisc ? "ON" : "OFF", vf->vf_id,
-				vsi->vsi_num);
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		}
-
 		ret = ice_cfg_vlan_pruning(vsi, true, !rm_promisc);
 		if (ret) {
 			dev_err(dev, "Failed to configure VLAN pruning in promiscuous mode\n");
-- 
2.20.1

