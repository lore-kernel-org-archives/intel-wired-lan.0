From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 26 Feb 2019 16:35:18 -0800
Subject: [Intel-wired-lan] [PATCH S13 v2 12/17] ice: Don't let VF know that
 it is untrusted
In-Reply-To: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190227003523.28733-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

Don't let the VF know it's not trusted when it tries to add more than
permitted additional MAC addresses.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f0de80d182d0..70bd81ea1943 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1969,7 +1969,7 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 	    (struct virtchnl_ether_addr_list *)msg;
 	struct ice_pf *pf = vf->pf;
 	enum virtchnl_ops vc_op;
-	enum ice_status ret;
+	enum ice_status ret = 0;
 	LIST_HEAD(mac_list);
 	struct ice_vsi *vsi;
 	int mac_count = 0;
@@ -1989,8 +1989,11 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 	if (set && !ice_is_vf_trusted(vf) &&
 	    (vf->num_mac + al->num_elements) > ICE_MAX_MACADDR_PER_VF) {
 		dev_err(&pf->pdev->dev,
-			"Can't add more MAC addresses, because VF is not trusted, switch the VF to trusted mode in order to add more functionalities\n");
-		ret = ICE_ERR_PARAM;
+			"Can't add more MAC addresses, because VF-%d is not trusted, switch the VF to trusted mode in order to add more functionalities\n",
+			vf->vf_id);
+		/* There is no need to let VF know about not being trusted
+		 * to add more MAC addr, so we can just return success message.
+		 */
 		goto handle_mac_exit;
 	}
 
@@ -2270,7 +2273,8 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 	if (add_v && !ice_is_vf_trusted(vf) &&
 	    vf->num_vlan >= ICE_MAX_VLAN_PER_VF) {
 		dev_info(&pf->pdev->dev,
-			 "VF is not trusted, switch the VF to trusted mode, in order to add more VLAN addresses\n");
+			 "VF-%d is not trusted, switch the VF to trusted mode, in order to add more VLAN addresses\n",
+			 vf->vf_id);
 		/* There is no need to let VF know about being not trusted,
 		 * so we can just return success message here
 		 */
-- 
2.14.5

