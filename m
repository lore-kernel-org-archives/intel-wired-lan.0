From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  8 Nov 2019 06:23:21 -0800
Subject: [Intel-wired-lan] [PATCH S33 05/15] ice: fix stack leakage
In-Reply-To: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
Message-ID: <20191108142331.10221-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

In the case of an invalid virtchannel request the driver
would return uninitialized data to the VF from the PF stack
which is a bug.  Fix by initializing the stack variable
earlier in the function before any return paths can be taken.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index fd419230a6c0..f8d26674cf5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1886,8 +1886,8 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_queue_select *vqs =
 		(struct virtchnl_queue_select *)msg;
+	struct ice_eth_stats stats = { 0 };
 	struct ice_pf *pf = vf->pf;
-	struct ice_eth_stats stats;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -1906,7 +1906,6 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	memset(&stats, 0, sizeof(struct ice_eth_stats));
 	ice_update_eth_stats(vsi);
 
 	stats = vsi->eth_stats;
-- 
2.20.1

