From: Sasha Levin <sashal@kernel.org>
Date: Fri, 24 Jan 2020 09:17:08 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.4 038/107] i40e: Fix
 virtchnl_queue_select bitmap validation
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
Message-ID: <20200124141817.28793-38-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

[ Upstream commit d9d6a9aed3f66f8ce5fa3ca6ca26007d75032296 ]

Currently in i40e_vc_disable_queues_msg() we are incorrectly
validating the virtchnl queue select bitmaps. The
virtchnl_queue_select rx_queues and tx_queue bitmap is being
compared against ICE_MAX_VF_QUEUES, but the problem is that
these bitmaps can have a value greater than I40E_MAX_VF_QUEUES.
Fix this by comparing the bitmaps against BIT(I40E_MAX_VF_QUEUES).

Also, add the function i40e_vc_validate_vqs_bitmaps() that checks to see
if both virtchnl_queue_select bitmaps are empty along with checking that
the bitmaps only have valid bits set. This function can then be used in
both the queue enable and disable flows.

Suggested-by: Arkady Gilinksky <arkady.gilinsky@harmonicinc.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3d24408388226..3515ace0f0201 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2322,6 +2322,22 @@ static int i40e_ctrl_vf_rx_rings(struct i40e_vsi *vsi, unsigned long q_map,
 	return ret;
 }
 
+/**
+ * i40e_vc_validate_vqs_bitmaps - validate Rx/Tx queue bitmaps from VIRTHCHNL
+ * @vqs: virtchnl_queue_select structure containing bitmaps to validate
+ *
+ * Returns true if validation was successful, else false.
+ */
+static bool i40e_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
+{
+	if ((!vqs->rx_queues && !vqs->tx_queues) ||
+	    vqs->rx_queues >= BIT(I40E_MAX_VF_QUEUES) ||
+	    vqs->tx_queues >= BIT(I40E_MAX_VF_QUEUES))
+		return false;
+
+	return true;
+}
+
 /**
  * i40e_vc_enable_queues_msg
  * @vf: pointer to the VF info
@@ -2347,7 +2363,7 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if ((0 == vqs->rx_queues) && (0 == vqs->tx_queues)) {
+	if (i40e_vc_validate_vqs_bitmaps(vqs)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
@@ -2409,9 +2425,7 @@ static int i40e_vc_disable_queues_msg(struct i40e_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if ((vqs->rx_queues == 0 && vqs->tx_queues == 0) ||
-	    vqs->rx_queues > I40E_MAX_VF_QUEUES ||
-	    vqs->tx_queues > I40E_MAX_VF_QUEUES) {
+	if (i40e_vc_validate_vqs_bitmaps(vqs)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
 	}
-- 
2.20.1

