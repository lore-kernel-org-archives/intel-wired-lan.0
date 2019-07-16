From: Kevin Laatz <kevin.laatz@intel.com>
Date: Tue, 16 Jul 2019 03:06:31 +0000
Subject: [Intel-wired-lan] [PATCH v2 04/10] i40e: modify driver for handling
 offsets
In-Reply-To: <20190716030637.5634-1-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190716030637.5634-1-kevin.laatz@intel.com>
Message-ID: <20190716030637.5634-5-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the addition of the unaligned chunks option, we need to make sure we
handle the offsets accordingly based on the mode we are currently running
in. This patch modifies the driver to appropriately mask the address for
each case.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 26 +++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index dfa096db2244..b8316e9ba159 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -190,7 +190,9 @@ int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
  **/
 static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 {
+	struct xdp_umem *umem = rx_ring->xsk_umem;
 	int err, result = I40E_XDP_PASS;
+	u64 offset = umem->headroom;
 	struct i40e_ring *xdp_ring;
 	struct bpf_prog *xdp_prog;
 	u32 act;
@@ -201,7 +203,13 @@ static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
 	 */
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	xdp->handle += xdp->data - xdp->data_hard_start;
+	offset += xdp->data - xdp->data_hard_start;
+
+	if (umem->flags & XDP_UMEM_UNALIGNED_CHUNKS)
+		xdp->handle |= (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
+	else
+		xdp->handle += offset;
+
 	switch (act) {
 	case XDP_PASS:
 		break;
@@ -262,7 +270,7 @@ static bool i40e_alloc_buffer_zc(struct i40e_ring *rx_ring,
 	bi->addr = xdp_umem_get_data(umem, handle);
 	bi->addr += hr;
 
-	bi->handle = handle + umem->headroom;
+	bi->handle = handle;
 
 	xsk_umem_discard_addr(umem);
 	return true;
@@ -299,7 +307,7 @@ static bool i40e_alloc_buffer_slow_zc(struct i40e_ring *rx_ring,
 	bi->addr = xdp_umem_get_data(umem, handle);
 	bi->addr += hr;
 
-	bi->handle = handle + umem->headroom;
+	bi->handle = handle;
 
 	xsk_umem_discard_addr_rq(umem);
 	return true;
@@ -456,7 +464,10 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
-	handle &= mask;
+	if (rx_ring->xsk_umem->flags & XDP_UMEM_UNALIGNED_CHUNKS)
+		handle &= XSK_UNALIGNED_BUF_ADDR_MASK;
+	else
+		handle &= mask;
 
 	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
 	bi->dma += hr;
@@ -635,6 +646,7 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 	struct i40e_tx_buffer *tx_bi;
 	bool work_done = true;
 	struct xdp_desc desc;
+	u64 addr, offset;
 	dma_addr_t dma;
 
 	while (budget-- > 0) {
@@ -647,7 +659,11 @@ static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
 		if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &desc))
 			break;
 
-		dma = xdp_umem_get_dma(xdp_ring->xsk_umem, desc.addr);
+		/* for unaligned chunks need to take offset from upper bits */
+		offset = (desc.addr >> XSK_UNALIGNED_BUF_OFFSET_SHIFT);
+		addr = (desc.addr & XSK_UNALIGNED_BUF_ADDR_MASK);
+
+		dma = xdp_umem_get_dma(xdp_ring->xsk_umem, addr + offset);
 
 		dma_sync_single_for_device(xdp_ring->dev, dma, desc.len,
 					   DMA_BIDIRECTIONAL);
-- 
2.17.1

