From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:36 -0800
Subject: [Intel-wired-lan] [PATCH S11 09/16] ice: only use the VF for
 ICE_VSI_VF in ice_vsi_release
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-10-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

In ice_vsi_release we are always assigning a value to the local VF
variable. Change this to only be assigned if the VSI is a VF VSI.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d93a0d5a783c..fa61203bee26 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2518,13 +2518,15 @@ void ice_vsi_dis_irq(struct ice_vsi *vsi)
  */
 int ice_vsi_release(struct ice_vsi *vsi)
 {
+	struct ice_vf *vf = NULL;
 	struct ice_pf *pf;
-	struct ice_vf *vf;
 
 	if (!vsi->back)
 		return -ENODEV;
 	pf = vsi->back;
-	vf = &pf->vf[vsi->vf_id];
+
+	if (vsi->type == ICE_VSI_VF)
+		vf = &pf->vf[vsi->vf_id];
 	/* do not unregister and free netdevs while driver is in the reset
 	 * recovery pending state. Since reset/rebuild happens through PF
 	 * service task workqueue, its not a good idea to unregister netdev
-- 
2.14.5

