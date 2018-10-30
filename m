From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 30 Oct 2018 10:50:42 -0700
Subject: [Intel-wired-lan] [next S97 v2 1/6] i40e: Use a local variable for
 readability
Message-ID: <20181030175047.18874-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

Use a local variable to make the code a bit more readable.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index aef3c89ee79c..7f20eb1f5b00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3526,6 +3526,7 @@ static int i40e_xmit_xdp_ring(struct xdp_frame *xdpf,
 	u16 i = xdp_ring->next_to_use;
 	struct i40e_tx_buffer *tx_bi;
 	struct i40e_tx_desc *tx_desc;
+	void *data = xdpf->data;
 	u32 size = xdpf->len;
 	dma_addr_t dma;
 
@@ -3533,8 +3534,7 @@ static int i40e_xmit_xdp_ring(struct xdp_frame *xdpf,
 		xdp_ring->tx_stats.tx_busy++;
 		return I40E_XDP_CONSUMED;
 	}
-
-	dma = dma_map_single(xdp_ring->dev, xdpf->data, size, DMA_TO_DEVICE);
+	dma = dma_map_single(xdp_ring->dev, data, size, DMA_TO_DEVICE);
 	if (dma_mapping_error(xdp_ring->dev, dma))
 		return I40E_XDP_CONSUMED;
 
-- 
2.17.2

