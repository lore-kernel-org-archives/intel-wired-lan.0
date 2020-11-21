From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 20 Nov 2020 16:39:31 -0800
Subject: [Intel-wired-lan] [PATCH S54 07/14] ice: improve AF_XDP single
 socket performance
In-Reply-To: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
References: <20201121003938.48514-1-anthony.l.nguyen@intel.com>
Message-ID: <20201121003938.48514-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Raczynski <piotr.raczynski@intel.com>

Recent commit "ice: Fix AF_XDP multi queue TX scaling issue"
improved multi socket performance dramatically,
however a regression was introduced into single socket
TX performance. This change helps to regain some of the
single socket performance with no noticeable reggression
on scaling. With Current implementation, for most ring
lengths, the driver will send the whole ring of packets at
a time which limits performance since then driver will
not send any packets until all descriptors are done.

Add some send budget limiting dependent on ring length.
During measurement it seems that limiting AF_XDP send
budget to ring_len/4 yields the best balance and performance.

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 793e39e30d4c..3c76e42b15b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -687,9 +687,9 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring)
 {
 	u16 next_rs_idx = xdp_ring->next_rs_idx;
 	u16 ntc = xdp_ring->next_to_clean;
+	u16 frames_ready = 0, send_budget;
 	struct ice_tx_desc *next_rs_desc;
 	struct ice_tx_buf *tx_buf;
-	u16 frames_ready = 0;
 	u32 total_bytes = 0;
 	u32 xsk_frames = 0;
 	u16 i;
@@ -740,7 +740,9 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring)
 	if (xsk_uses_need_wakeup(xdp_ring->xsk_pool))
 		xsk_set_tx_need_wakeup(xdp_ring->xsk_pool);
 
-	return ice_xmit_zc(xdp_ring, ICE_DESC_UNUSED(xdp_ring));
+	send_budget = ICE_DESC_UNUSED(xdp_ring);
+	send_budget = min_t(u16, send_budget, xdp_ring->count >> 2);
+	return ice_xmit_zc(xdp_ring, send_budget);
 }
 
 /**
-- 
2.20.1

