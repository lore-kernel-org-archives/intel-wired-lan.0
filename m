From: Colin King <colin.king@canonical.com>
Date: Sat, 22 Feb 2020 17:10:54 +0000
Subject: [Intel-wired-lan] [PATCH][next] ice: remove redundant assignment to
 pointer vsi
Message-ID: <20200222171054.171505-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Pointer vsi is being re-assigned a value that is never read,
the assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 169b72a94b9d..2c8e334c47a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2191,7 +2191,6 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		set_bit(vf_q_id, vf->rxq_ena);
 	}
 
-	vsi = pf->vsi[vf->lan_vsi_idx];
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_BASE_QS_PER_VF) {
 		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
-- 
2.25.0

