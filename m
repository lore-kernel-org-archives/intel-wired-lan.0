From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 Feb 2020 01:28:10 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix the conditional for
 i40e_vc_validate_vqs_bitmaps
Message-ID: <20200206092810.26378-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Commit d9d6a9aed3f6 ("i40e: Fix virtchnl_queue_select bitmap
validation") introduced a necessary change for verifying how queue
bitmaps from the iavf driver get validated. Unfortunately, the
conditional was reversed. Fix this.

Fixes: d9d6a9aed3f6 ("i40e: Fix virtchnl_queue_select bitmap validation")
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 69523ac85639..56b9e445732b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2362,7 +2362,7 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (i40e_vc_validate_vqs_bitmaps(vqs)) {
+	if (!i40e_vc_validate_vqs_bitmaps(vqs)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2424,7 +2424,7 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (i40e_vc_validate_vqs_bitmaps(vqs)) {
+	if (!i40e_vc_validate_vqs_bitmaps(vqs)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
-- 
2.20.1

