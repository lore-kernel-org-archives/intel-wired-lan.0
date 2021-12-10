From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 10 Dec 2021 15:59:40 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 4/5] ice: xsk: allow empty Rx
 descriptors on XSK ZC data path
In-Reply-To: <20211210145941.5865-1-maciej.fijalkowski@intel.com>
References: <20211210145941.5865-1-maciej.fijalkowski@intel.com>
Message-ID: <20211210145941.5865-5-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit ac6f733a7bd5 ("ice: allow empty Rx descriptors") stated that ice
HW can produce empty descriptors that are valid and they should be
processed.

Add this support to xsk ZC path to avoid potential processing problems.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 874fce9fa1c3..80f5a6194a49 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -537,12 +537,18 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
+		xdp = *ice_xdp_buf(rx_ring, rx_ring->next_to_clean);
+
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 				   ICE_RX_FLX_DESC_PKT_LEN_M;
-		if (!size)
-			break;
+		if (!size) {
+			xdp->data = NULL;
+			xdp->data_end = NULL;
+			xdp->data_hard_start = NULL;
+			xdp->data_meta = NULL;
+			goto construct_skb;
+		}
 
-		xdp = *ice_xdp_buf(rx_ring, rx_ring->next_to_clean);
 		xsk_buff_set_size(xdp, size);
 		xsk_buff_dma_sync_for_cpu(xdp, rx_ring->xsk_pool);
 
@@ -560,7 +566,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring, int budget)
 			ice_bump_ntc(rx_ring);
 			continue;
 		}
-
+construct_skb:
 		/* XDP_PASS path */
 		skb = ice_construct_skb_zc(rx_ring, xdp);
 		if (!skb) {
-- 
2.33.1

