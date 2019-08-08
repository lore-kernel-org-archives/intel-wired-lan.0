From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:31 -0700
Subject: [Intel-wired-lan] [PATCH S27 08/15] ice: Update fields in
 ice_vsi_set_num_qs when reconfiguring
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently when vsi->req_txqs or vsi->req_rxqs are set we don't
correctly set the number of vsi->num_q_vectors. Fix this by
setting the the number of queue vectors based on the max
between the vsi->alloc_txqs and vsi->alloc_rxqs.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 212c532fabd6..3c5a86881a6f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -353,7 +353,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi, u16 vf_id)
 			vsi->alloc_rxq = vsi->req_rxq;
 			vsi->num_rxq = vsi->req_rxq;
 		}
-		vsi->num_q_vectors = max_t(int, pf->num_lan_rx, pf->num_lan_tx);
+		vsi->num_q_vectors = max_t(int, vsi->alloc_rxq, vsi->alloc_txq);
 		break;
 	case ICE_VSI_VF:
 		vf = &pf->vf[vsi->vf_id];
-- 
2.20.1

