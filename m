From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon,  5 Jul 2021 18:43:37 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-next 3/4] ice: do not create
 xdp_frame on XDP_TX
In-Reply-To: <20210705164338.58313-1-maciej.fijalkowski@intel.com>
References: <20210705164338.58313-1-maciej.fijalkowski@intel.com>
Message-ID: <20210705164338.58313-4-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

xdp_frame is not needed for XDP_TX data path in ice driver case.
For this data path cleaning of sent descriptor will not happen anywhere
outside of the driver, which means that carrying the information about
the underlying memory model via xdp_frame will not be used. Therefore,
this conversion can be simply dropped, which would relieve CPU a bit.

Call directly ice_xmit_xdp_ring instead of ice_xmit_xdp_buff for XDP_TX
action returned from BPF program.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 23b97c9579fb..fef1f74562e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -586,7 +586,7 @@ ice_run_xdp(struct ice_ring *rx_ring, struct xdp_buff *xdp,
 		return ICE_XDP_PASS;
 	case XDP_TX:
 		xdp_ring = rx_ring->vsi->xdp_rings[smp_processor_id()];
-		result = ice_xmit_xdp_buff(xdp, xdp_ring);
+		result = ice_xmit_xdp_ring(xdp->data, xdp->data_end - xdp->data, xdp_ring);
 		if (result == ICE_XDP_CONSUMED)
 			goto out_failure;
 		return result;
-- 
2.20.1

