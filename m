From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:21 -0700
Subject: [Intel-wired-lan] [PATCH S44 09/14] ice: Refactor ice_setup_rx_ctx
In-Reply-To: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516004226.4795-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>

Move AF_XDP logic and buffer allocation out of ice_setup_rx_ctx() to a
new function ice_vsi_cfg_rxq(), so the function actually sets up the Rx
context.

Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 123 +++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_base.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c  |   2 +-
 4 files changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 74fdd4296937..798b173e81e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -278,11 +278,9 @@ ice_setup_tx_ctx(struct ice_ring *ring, struct ice_tlan_ctx *tlan_ctx, u16 pf_q)
  *
  * Configure the Rx descriptor ring in RLAN context.
  */
-int ice_setup_rx_ctx(struct ice_ring *ring)
+static int ice_setup_rx_ctx(struct ice_ring *ring)
 {
-	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	int chain_len = ICE_MAX_CHAINED_RX_BUFS;
-	u16 num_bufs = ICE_DESC_UNUSED(ring);
 	struct ice_vsi *vsi = ring->vsi;
 	u32 rxdid = ICE_RXDID_FLEX_NIC;
 	struct ice_rlan_ctx rlan_ctx;
@@ -299,49 +297,6 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	/* clear the context structure first */
 	memset(&rlan_ctx, 0, sizeof(rlan_ctx));
 
-	ring->rx_buf_len = vsi->rx_buf_len;
-
-	if (ring->vsi->type == ICE_VSI_PF) {
-		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-			/* coverity[check_return] */
-			xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
-					 ring->q_index);
-
-		ring->xsk_umem = ice_xsk_umem(ring);
-		if (ring->xsk_umem) {
-			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
-
-			ring->rx_buf_len = ring->xsk_umem->chunk_size_nohr -
-					   XDP_PACKET_HEADROOM;
-			/* For AF_XDP ZC, we disallow packets to span on
-			 * multiple buffers, thus letting us skip that
-			 * handling in the fast-path.
-			 */
-			chain_len = 1;
-			ring->zca.free = ice_zca_free;
-			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-							 MEM_TYPE_ZERO_COPY,
-							 &ring->zca);
-			if (err)
-				return err;
-
-			dev_info(dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
-				 ring->q_index);
-		} else {
-			ring->zca.free = NULL;
-			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
-				/* coverity[check_return] */
-				xdp_rxq_info_reg(&ring->xdp_rxq,
-						 ring->netdev,
-						 ring->q_index);
-
-			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-							 MEM_TYPE_PAGE_SHARED,
-							 NULL);
-			if (err)
-				return err;
-		}
-	}
 	/* Receive Queue Base Address.
 	 * Indicates the starting address of the descriptor queue defined in
 	 * 128 Byte units.
@@ -376,6 +331,12 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	 */
 	rlan_ctx.showiv = 0;
 
+	/* For AF_XDP ZC, we disallow packets to span on
+	 * multiple buffers, thus letting us skip that
+	 * handling in the fast-path.
+	 */
+	if (ring->xsk_umem)
+		chain_len = 1;
 	/* Max packet size for this queue - must not be set to a larger value
 	 * than 5 x DBUF
 	 */
@@ -410,7 +371,8 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	/* Absolute queue number out of 2K needs to be passed */
 	err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
 	if (err) {
-		dev_err(dev, "Failed to set LAN Rx queue context for absolute Rx queue %d error: %d\n",
+		dev_err(ice_pf_to_dev(vsi->back),
+			"Failed to set LAN Rx queue context for absolute Rx queue %d error: %d\n",
 			pf_q, err);
 		return -EIO;
 	}
@@ -428,6 +390,67 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	ring->tail = hw->hw_addr + QRX_TAIL(pf_q);
 	writel(0, ring->tail);
 
+	return 0;
+}
+
+/**
+ * ice_vsi_cfg_rxq - Configure an Rx queue
+ * @ring: the ring being configured
+ *
+ * Return 0 on success and a negative value on error.
+ */
+int ice_vsi_cfg_rxq(struct ice_ring *ring)
+{
+	struct device *dev = ice_pf_to_dev(ring->vsi->back);
+	u16 num_bufs = ICE_DESC_UNUSED(ring);
+	int err;
+
+	ring->rx_buf_len = ring->vsi->rx_buf_len;
+
+	if (ring->vsi->type == ICE_VSI_PF) {
+		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
+			/* coverity[check_return] */
+			xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->q_index);
+
+		ring->xsk_umem = ice_xsk_umem(ring);
+		if (ring->xsk_umem) {
+			xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+
+			ring->rx_buf_len = ring->xsk_umem->chunk_size_nohr -
+					   XDP_PACKET_HEADROOM;
+			ring->zca.free = ice_zca_free;
+			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+							 MEM_TYPE_ZERO_COPY,
+							 &ring->zca);
+			if (err)
+				return err;
+
+			dev_info(dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
+				 ring->q_index);
+		} else {
+			ring->zca.free = NULL;
+			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
+				/* coverity[check_return] */
+				xdp_rxq_info_reg(&ring->xdp_rxq,
+						 ring->netdev,
+						 ring->q_index);
+
+			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+							 MEM_TYPE_PAGE_SHARED,
+							 NULL);
+			if (err)
+				return err;
+		}
+	}
+
+	err = ice_setup_rx_ctx(ring);
+	if (err) {
+		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
+			ring->q_index, err);
+		return err;
+	}
+
 	if (ring->xsk_umem) {
 		if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
 			dev_warn(dev, "UMEM does not provide enough addresses to fill %d buffers on Rx ring %d\n",
@@ -438,9 +461,13 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 		}
 
 		err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
-		if (err)
+		if (err) {
+			u16 pf_q = ring->vsi->rxq_map[ring->q_index];
+
 			dev_info(dev, "Failed to allocate some buffers on UMEM enabled Rx ring %d (pf_q %d)\n",
 				 ring->q_index, pf_q);
+		}
+
 		return 0;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index 44efdb627043..20e1c29aa68a 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -6,7 +6,7 @@
 
 #include "ice.h"
 
-int ice_setup_rx_ctx(struct ice_ring *ring);
+int ice_vsi_cfg_rxq(struct ice_ring *ring);
 int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 51a20958e0d0..9bee0d947651 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1648,15 +1648,11 @@ int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
 	ice_vsi_cfg_frame_size(vsi);
 setup_rings:
 	/* set up individual rings */
-	for (i = 0; i < vsi->num_rxq; i++) {
-		int err;
+	ice_for_each_rxq(vsi, i) {
+		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
 
-		err = ice_setup_rx_ctx(vsi->rx_rings[i]);
-		if (err) {
-			dev_err(ice_pf_to_dev(vsi->back), "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
-				i, err);
+		if (err)
 			return err;
-		}
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 1e9cc550ec98..5f556faef405 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -237,7 +237,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		xdp_ring->xsk_umem = ice_xsk_umem(xdp_ring);
 	}
 
-	err = ice_setup_rx_ctx(rx_ring);
+	err = ice_vsi_cfg_rxq(rx_ring);
 	if (err)
 		goto free_buf;
 
-- 
2.20.1

