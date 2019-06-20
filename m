From: Kevin Laatz <kevin.laatz@intel.com>
Date: Thu, 20 Jun 2019 09:09:51 +0000
Subject: [Intel-wired-lan] [PATCH 04/11] i40e: add offset to zca_free
In-Reply-To: <20190620090958.2135-1-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
Message-ID: <20190620090958.2135-5-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds the offset param to for zero_copy_allocator to
i40e_zca_free. This change is required to calculate the handle, otherwise,
this function will not work in unaligned chunk mode since we can't easily mask
back to the original handle in unaligned chunk mode.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_xsk.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index c89e692e8663..8c281f356293 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -438,16 +438,16 @@ static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
  * @alloc: Zero-copy allocator
  * @handle: Buffer handle
  **/
-void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
+void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off)
 {
 	struct i40e_rx_buffer *bi;
 	struct i40e_ring *rx_ring;
-	u64 hr, mask;
+	u64 hr;
 	u16 nta;
 
 	rx_ring = container_of(alloc, struct i40e_ring, zca);
 	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
-	mask = rx_ring->xsk_umem->chunk_mask;
 
 	nta = rx_ring->next_to_alloc;
 	bi = &rx_ring->rx_bi[nta];
@@ -455,7 +455,7 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
-	handle &= mask;
+	handle -= off;
 
 	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
 	bi->dma += hr;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index 8cc0a2e7d9a2..85691dc9ac42 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -12,7 +12,8 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair);
 int i40e_queue_pair_enable(struct i40e_vsi *vsi, int queue_pair);
 int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
 			u16 qid);
-void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
+void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off);
 bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 cleaned_count);
 int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
 
-- 
2.17.1

