From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:56 -0700
Subject: [Intel-wired-lan] [PATCH S8 07/16] ice: Fix typo in error message
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Print should say "Enabling" instead of "Enaabling"

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5bacad01f0c9..c604a44c8cfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1997,7 +1997,7 @@ int ice_cfg_vlan_pruning(struct ice_vsi *vsi, bool ena)
 	status = ice_update_vsi(&vsi->back->hw, vsi->idx, ctxt, NULL);
 	if (status) {
 		netdev_err(vsi->netdev, "%sabling VLAN pruning on VSI handle: %d, VSI HW ID: %d failed, err = %d, aq_err = %d\n",
-			   ena ? "Ena" : "Dis", vsi->idx, vsi->vsi_num, status,
+			   ena ? "En" : "Dis", vsi->idx, vsi->vsi_num, status,
 			   vsi->back->hw.adminq.sq_last_status);
 		goto err_out;
 	}
-- 
2.14.3

