From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:16 -0700
Subject: [Intel-wired-lan] [PATCH S18 03/15] ice: Don't remove VLAN filters
 that were never programmed
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

In case of non-trusted VFs, it is possible to program VLAN filter far
less than what is requested by the VF originally, thereby makes number of
VLAN elements being tracked by VF different from actual VLAN tags. This
patch makes sure that we are not attempting to remove VLAN filter that
does not exist.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_lib.c         |  6 +++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 +++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 947730d74612..83d0aef7f77e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1616,7 +1616,11 @@ int ice_vsi_kill_vlan(struct ice_vsi *vsi, u16 vid)
 	list_add(&list->list_entry, &tmp_add_list);
 
 	status = ice_remove_vlan(&pf->hw, &tmp_add_list);
-	if (status) {
+	if (status == ICE_ERR_DOES_NOT_EXIST) {
+		dev_dbg(&pf->pdev->dev,
+			"Failed to remove VLAN %d on VSI %i, it does not exist, status: %d\n",
+			vid, vsi->vsi_num, status);
+	} else if (status) {
 		dev_err(&pf->pdev->dev,
 			"Error removing VLAN %d on vsi %i error: %d\n",
 			vid, vsi->vsi_num, status);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index abc958788267..f4b466cd4b7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2402,7 +2402,17 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 			}
 		}
 	} else {
-		for (i = 0; i < vfl->num_elements; i++) {
+		/* In case of non_trusted VF, number of VLAN elements passed
+		 * to PF for removal might be greater than number of VLANs
+		 * filter programmed for that VF - So, use actual number of
+		 * VLANS added earlier with add VLAN opcode. In order to avoid
+		 * removing VLAN that doesn't exist, which result to sending
+		 * erroneous failed message back to the VF
+		 */
+		int num_vf_vlan;
+
+		num_vf_vlan = vf->num_vlan;
+		for (i = 0; i < vfl->num_elements && i < num_vf_vlan; i++) {
 			u16 vid = vfl->vlan_id[i];
 
 			/* Make sure ice_vsi_kill_vlan is successful before
-- 
2.20.1

