From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 13 Feb 2020 13:31:22 -0800
Subject: [Intel-wired-lan] [PATCH S39 v2 08/15] ice: Support XDP UMEM wake
 up mechanism
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <20200213213129.34023-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

Add support for a new AF_XDP feature that has already been introduced in
upstreamed Intel NIC drivers. If a user space application signals that
it might sleep using the new bind flag XDP_USE_NEED_WAKEUP, the driver
will then set this flag if it has no more buffers on the NIC Rx ring and
yield to the application. For Tx, it will set the flag if it has no
outstanding Tx completion interrupts and return to the application.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 55d994f2d71e..3fd31ad73e0e 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -937,6 +937,15 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 	ice_finalize_xdp_rx(rx_ring, xdp_xmit);
 	ice_update_rx_ring_stats(rx_ring, total_rx_packets, total_rx_bytes);
 
+	if (xsk_umem_uses_need_wakeup(rx_ring->xsk_umem)) {
+		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
+			xsk_set_rx_need_wakeup(rx_ring->xsk_umem);
+		else
+			xsk_clear_rx_need_wakeup(rx_ring->xsk_umem);
+
+		return (int)total_rx_packets;
+	}
+
 	return failure ? budget : (int)total_rx_packets;
 }
 
@@ -988,6 +997,8 @@ static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
 	if (tx_desc) {
 		ice_xdp_ring_update_tail(xdp_ring);
 		xsk_umem_consume_tx_done(xdp_ring->xsk_umem);
+		if (xsk_umem_uses_need_wakeup(xdp_ring->xsk_umem))
+			xsk_clear_tx_need_wakeup(xdp_ring->xsk_umem);
 	}
 
 	return budget > 0 && work_done;
@@ -1063,6 +1074,13 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring, int budget)
 	if (xsk_frames)
 		xsk_umem_complete_tx(xdp_ring->xsk_umem, xsk_frames);
 
+	if (xsk_umem_uses_need_wakeup(xdp_ring->xsk_umem)) {
+		if (xdp_ring->next_to_clean == xdp_ring->next_to_use)
+			xsk_set_tx_need_wakeup(xdp_ring->xsk_umem);
+		else
+			xsk_clear_tx_need_wakeup(xdp_ring->xsk_umem);
+	}
+
 	ice_update_tx_ring_stats(xdp_ring, total_packets, total_bytes);
 	xmit_done = ice_xmit_zc(xdp_ring, ICE_DFLT_IRQ_WORK);
 
-- 
2.20.1

