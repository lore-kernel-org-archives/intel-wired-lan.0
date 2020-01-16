From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 11:42:26 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 5.4 171/205] ice: fix stack leakage
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
Message-ID: <20200116164300.6705-171-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 949375de945f7042df2b6488228a1a2b36e69f35 ]

In the case of an invalid virtchannel request the driver
would return uninitialized data to the VF from the PF stack
which is a bug.  Fix by initializing the stack variable
earlier in the function before any return paths can be taken.

Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF support")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index c0637a0cbfe8..e92a00a61755 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1873,8 +1873,8 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_queue_select *vqs =
 		(struct virtchnl_queue_select *)msg;
+	struct ice_eth_stats stats = { 0 };
 	struct ice_pf *pf = vf->pf;
-	struct ice_eth_stats stats;
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -1893,7 +1893,6 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 		goto error_param;
 	}
 
-	memset(&stats, 0, sizeof(struct ice_eth_stats));
 	ice_update_eth_stats(vsi);
 
 	stats = vsi->eth_stats;
-- 
2.20.1

