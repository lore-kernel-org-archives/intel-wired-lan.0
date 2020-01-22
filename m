From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:21:33 -0800
Subject: [Intel-wired-lan] [PATCH S38 10/15] ice: Fix virtchnl_queue_select
 bitmap validation
In-Reply-To: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152138.41585-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently in ice_vc_ena_qs_msg() we are incorrectly validating the
virtchnl queue select bitmaps. The virtchnl_queue_select rx_queues and
tx_queue bitmap is being compared against ICE_MAX_BASE_QS_PER_VF, but
the problem is that these bitmaps can have a value greater than
ICE_MAX_BASE_QS_PER_VF. Fix this by comparing the bitmaps against
BIT(ICE_MAX_BASE_QS_PER_VF).

Also, add the function ice_vc_validate_vqs_bitmaps() that checks to see
if both virtchnl_queue_select bitmaps are empty along with checking that
the bitmaps only have valid bits set. This function can then be used in
both the queue enable and disable flows.

Arkady Gilinksky's patch on the intel-wired-lan mailing list
("i40e/iavf: Fix msg interface between VF and PF") made me
aware of this issue.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 26 +++++++++++++------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 5513ee42de3c..7d778b3d5d5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2045,6 +2045,22 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 				     (u8 *)&stats, sizeof(stats));
 }
 
+/**
+ * ice_vc_validate_vqs_bitmaps - validate Rx/Tx queue bitmaps from VIRTCHNL
+ * @vqs: virtchnl_queue_select structure containing bitmaps to validate
+ *
+ * Return true on successful validation, else false
+ */
+static bool ice_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
+{
+	if ((!vqs->rx_queues && !vqs->tx_queues) ||
+	    vqs->rx_queues >= BIT(ICE_MAX_BASE_QS_PER_VF) ||
+	    vqs->tx_queues >= BIT(ICE_MAX_BASE_QS_PER_VF))
+		return false;
+
+	return true;
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -2072,13 +2088,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (!vqs->rx_queues && !vqs->tx_queues) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (vqs->rx_queues > ICE_MAX_BASE_QS_PER_VF ||
-	    vqs->tx_queues > ICE_MAX_BASE_QS_PER_VF) {
+	if (!ice_vc_validate_vqs_bitmaps(vqs)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
@@ -2168,7 +2178,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	if (!vqs->rx_queues && !vqs->tx_queues) {
+	if (!ice_vc_validate_vqs_bitmaps(vqs)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 		goto error_param;
 	}
-- 
2.20.1

