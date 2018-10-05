From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Fri, 5 Oct 2018 01:09:47 +0000
Subject: [Intel-wired-lan] [next PATCH S97 1/7] i40e: Fix for xdp frame
 struct usage
In-Reply-To: <20181004221830.16212-1-alice.michael@intel.com>
References: <20181004221830.16212-1-alice.michael@intel.com>
Message-ID: <253CF818969A9240AB2054BF91F2C2BC8B2F4343@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I don't think this change matches the description, as the code before/after is functionally the same in this patch.
Maybe just change the description to say clean up code by using a local variable.

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Alice Michael
Sent: Thursday, October 4, 2018 3:18 PM
To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [next PATCH S97 1/7] i40e: Fix for xdp frame struct usage

From: Jan Sokolowski <jan.sokolowski@intel.com>

Current ifdefs used for xdp frame structs and methods
are not properly used, thus failing to build.

Use proper definitions for sections of code using xdp_frame.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 740ea58..c9d209a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3527,6 +3527,7 @@ static int i40e_xmit_xdp_ring(struct xdp_frame *xdpf,
 	u16 i = xdp_ring->next_to_use;
 	struct i40e_tx_buffer *tx_bi;
 	struct i40e_tx_desc *tx_desc;
+	void *data = xdpf->data;
 	u32 size = xdpf->len;
 	dma_addr_t dma;
 
@@ -3534,8 +3535,7 @@ static int i40e_xmit_xdp_ring(struct xdp_frame *xdpf,
 		xdp_ring->tx_stats.tx_busy++;
 		return I40E_XDP_CONSUMED;
 	}
-
-	dma = dma_map_single(xdp_ring->dev, xdpf->data, size, DMA_TO_DEVICE);
+	dma = dma_map_single(xdp_ring->dev, data, size, DMA_TO_DEVICE);
 	if (dma_mapping_error(xdp_ring->dev, dma))
 		return I40E_XDP_CONSUMED;
 
-- 
2.9.5

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
