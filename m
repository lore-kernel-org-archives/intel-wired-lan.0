From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:24:26 -0700
Subject: [Intel-wired-lan] [PATCH S19 02/15] ice: Cleanup an unnecessary
 variable initialization
In-Reply-To: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172439.27908-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Commit 3463688e6ced ("ice: Add more validation in ice_vc_cfg_irq_map_msg")
added an assignment of vsi making the assignment during declaration
unnecessary.

Also, cleanup the declaration and assignment of irqmap_info to not use two
lines in the variable declaration section.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index a805cbdd69be..693f5d09326a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1807,16 +1807,16 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 static int ice_vc_cfg_irq_map_msg(struct ice_vf *vf, u8 *msg)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_irq_map_info *irqmap_info =
-	    (struct virtchnl_irq_map_info *)msg;
+	struct virtchnl_irq_map_info *irqmap_info;
 	u16 vsi_id, vsi_q_id, vector_id;
 	struct virtchnl_vector_map *map;
-	struct ice_vsi *vsi = NULL;
 	struct ice_pf *pf = vf->pf;
+	struct ice_vsi *vsi;
 	unsigned long qmap;
 	u16 num_q_vectors;
 	int i;
 
+	irqmap_info = (struct virtchnl_irq_map_info *)msg;
 	num_q_vectors = irqmap_info->num_vectors - ICE_NONQ_VECS_VF;
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
-- 
2.20.1

