From: Kevin Laatz <kevin.laatz@intel.com>
Date: Thu, 20 Jun 2019 09:09:52 +0000
Subject: [Intel-wired-lan] [PATCH 05/11] ixgbe: add offset to zca_free
In-Reply-To: <20190620090958.2135-1-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
Message-ID: <20190620090958.2135-6-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the offset param to for zero_copy_allocator to
ixgbe_zca_free. This change is required to calculate the handle, otherwise,
this function will not work in unaligned chunk mode since we can't easily mask
back to the original handle in unaligned chunk mode.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h | 3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c         | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index d93a690aff74..49702e2a4360 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -33,7 +33,8 @@ struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
 int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
 			 u16 qid);
 
-void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
+void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off);
 
 void ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count);
 int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 49536adafe8e..1ec02077ccb2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -268,16 +268,16 @@ static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 	obi->skb = NULL;
 }
 
-void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
+void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off)
 {
 	struct ixgbe_rx_buffer *bi;
 	struct ixgbe_ring *rx_ring;
-	u64 hr, mask;
+	u64 hr;
 	u16 nta;
 
 	rx_ring = container_of(alloc, struct ixgbe_ring, zca);
 	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
-	mask = rx_ring->xsk_umem->chunk_mask;
 
 	nta = rx_ring->next_to_alloc;
 	bi = rx_ring->rx_buffer_info;
@@ -285,7 +285,7 @@ void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
-	handle &= mask;
+	handle -= off;
 
 	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
 	bi->dma += hr;
-- 
2.17.1

