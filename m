From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:20 -0700
Subject: [Intel-wired-lan] [PATCH S44 08/14] ice: Check UMEM FQ size when
 allocating bufs
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

If a UMEM is present on a queue when an interface/queue pair is being
enabled, the driver will try to prepare the Rx buffers in advance to
improve performance. However, if fill queue is shorter than HW Rx ring,
the driver will report failure after getting the last address from the
fill queue.

This still lets the driver process the packets correctly during the NAPI
poll, but leads to a constant NAPI rescheduling. Not allocating the
buffers in advance would result in a potential performance decrease.

Commit d57d76428ae9 ("xsk: Add API to check for available entries in FQ")
provides an API that lets drivers check the number of addresses that the
fill queue holds.

Notify the user if fill queue is not long enough to prepare all buffers
before packet processing starts, and allocate the buffers during the
NAPI poll. If the fill queue size is sufficient, prepare Rx buffers in
advance.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 30 ++++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index a964f5055f37..74fdd4296937 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -280,7 +280,9 @@ ice_setup_tx_ctx(struct ice_ring *ring, struct ice_tlan_ctx *tlan_ctx, u16 pf_q)
  */
 int ice_setup_rx_ctx(struct ice_ring *ring)
 {
+	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	int chain_len = ICE_MAX_CHAINED_RX_BUFS;
+	u16 num_bufs = ICE_DESC_UNUSED(ring);
 	struct ice_vsi *vsi = ring->vsi;
 	u32 rxdid = ICE_RXDID_FLEX_NIC;
 	struct ice_rlan_ctx rlan_ctx;
@@ -323,7 +325,7 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 			if (err)
 				return err;
 
-			dev_info(ice_pf_to_dev(vsi->back), "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
+			dev_info(dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
 				 ring->q_index);
 		} else {
 			ring->zca.free = NULL;
@@ -408,7 +410,7 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	/* Absolute queue number out of 2K needs to be passed */
 	err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
 	if (err) {
-		dev_err(ice_pf_to_dev(vsi->back), "Failed to set LAN Rx queue context for absolute Rx queue %d error: %d\n",
+		dev_err(dev, "Failed to set LAN Rx queue context for absolute Rx queue %d error: %d\n",
 			pf_q, err);
 		return -EIO;
 	}
@@ -426,13 +428,23 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	ring->tail = hw->hw_addr + QRX_TAIL(pf_q);
 	writel(0, ring->tail);
 
-	err = ring->xsk_umem ?
-	      ice_alloc_rx_bufs_slow_zc(ring, ICE_DESC_UNUSED(ring)) :
-	      ice_alloc_rx_bufs(ring, ICE_DESC_UNUSED(ring));
-	if (err)
-		dev_info(ice_pf_to_dev(vsi->back), "Failed allocate some buffers on %sRx ring %d (pf_q %d)\n",
-			 ring->xsk_umem ? "UMEM enabled " : "",
-			 ring->q_index, pf_q);
+	if (ring->xsk_umem) {
+		if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
+			dev_warn(dev, "UMEM does not provide enough addresses to fill %d buffers on Rx ring %d\n",
+				 num_bufs, ring->q_index);
+			dev_warn(dev, "Change Rx ring/fill queue size to avoid performance issues\n");
+
+			return 0;
+		}
+
+		err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
+		if (err)
+			dev_info(dev, "Failed to allocate some buffers on UMEM enabled Rx ring %d (pf_q %d)\n",
+				 ring->q_index, pf_q);
+		return 0;
+	}
+
+	ice_alloc_rx_bufs(ring, num_bufs);
 
 	return 0;
 }
-- 
2.20.1

