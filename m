From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 12 Dec 2019 03:13:07 -0800
Subject: [Intel-wired-lan] [PATCH S35 15/15] ice: Suppress Coverity warnings
 for xdp_rxq_info_reg
In-Reply-To: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
Message-ID: <20191212111307.33566-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

Coverity reports some of the calls to xdp_rxq_info_reg() as potential
issues, because the driver does not check its return value. However,
those calls are wrapped with "if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))"
and this check alone is enough to be sure that the function will never
fail.

All possible states of xdp_rxq_info are:
 - NEW,
 - REGISTERED,
 - UNREGISTERED,
 - UNUSED.

The driver won't mark a queue as UNUSED under no circumstance, so the
return value can be ignored safely.

Add comments for Coverity right above calls to xdp_rxq_info_reg() to
suppress the warnings.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 25f2e0fb3833..d8e975cceb21 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -302,6 +302,7 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 
 	if (ring->vsi->type == ICE_VSI_PF) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
+			/* coverity[check_return] */
 			xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 					 ring->q_index);
 
@@ -328,6 +329,7 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 		} else {
 			ring->zca.free = NULL;
 			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
+				/* coverity[check_return] */
 				xdp_rxq_info_reg(&ring->xdp_rxq,
 						 ring->netdev,
 						 ring->q_index);
-- 
2.20.1

