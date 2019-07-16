From: Kevin Laatz <kevin.laatz@intel.com>
Date: Tue, 16 Jul 2019 03:06:29 +0000
Subject: [Intel-wired-lan] [PATCH v2 02/10] ixgbe: simplify Rx buffer recycle
In-Reply-To: <20190716030637.5634-1-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
 <20190716030637.5634-1-kevin.laatz@intel.com>
Message-ID: <20190716030637.5634-3-kevin.laatz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, the dma, addr and handle are modified when we reuse Rx buffers
in zero-copy mode. However, this is not required as the inputs to the
function are copies, not the original values themselves. As we use the
copies within the function, we can use the original 'obi' values
directly without having to mask and add the headroom.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 6b609553329f..bc86057628c8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -201,8 +201,6 @@ ixgbe_rx_buffer *ixgbe_get_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 				     struct ixgbe_rx_buffer *obi)
 {
-	unsigned long mask = (unsigned long)rx_ring->xsk_umem->chunk_mask;
-	u64 hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
 	u16 nta = rx_ring->next_to_alloc;
 	struct ixgbe_rx_buffer *nbi;
 
@@ -212,14 +210,9 @@ static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
 	/* transfer page from old buffer to new buffer */
-	nbi->dma = obi->dma & mask;
-	nbi->dma += hr;
-
-	nbi->addr = (void *)((unsigned long)obi->addr & mask);
-	nbi->addr += hr;
-
-	nbi->handle = obi->handle & mask;
-	nbi->handle += rx_ring->xsk_umem->headroom;
+	nbi->dma = obi->dma;
+	nbi->addr = obi->addr;
+	nbi->handle = obi->handle;
 
 	obi->addr = NULL;
 	obi->skb = NULL;
-- 
2.17.1

