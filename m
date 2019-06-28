From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:32 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 15/15] ice: improve print for VF's
 when adding/deleting MAC filters
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

When we fail to add/delete MAC filters in the VF, the print doesn't
distinguish between the two. Fix that by printing whether or not we
failed to add/delete the MAC filter respectively.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index b8fc08c1d365..1d162146dcee 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2285,8 +2285,8 @@ ice_vc_handle_mac_addr_msg(struct ice_vf *vf, u8 *msg, bool set)
 
 	if (v_ret) {
 		dev_err(&pf->pdev->dev,
-			"can't update MAC filters for VF %d, error %d\n",
-			vf->vf_id, v_ret);
+			"can't %s MAC filters for VF %d, error %d\n",
+			set ? "add" : "remove", vf->vf_id, v_ret);
 	} else {
 		if (set)
 			vf->num_mac += mac_count;
-- 
2.20.1

