From: Markus Boehme <markubo@amazon.com>
Date: Tue, 25 May 2021 00:05:31 +0200
Subject: [Intel-wired-lan] [PATCH net] ixgbe: Fix packet corruption due to
 missing DMA sync
Message-ID: <20210524220531.64640-1-markubo@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When receiving a packet with multiple fragments, hardware may still
touch the first fragment until the entire packet has been received. The
driver therefore keeps the first fragment mapped for DMA until end of
packet has been asserted, and delays its dma_sync call until then.

The driver tries to fit multiple receive buffers on one page. When using
3K receive buffers (e.g. using Jumbo frames and legacy-rx is turned
off/build_skb is being used) on an architecture with 4K pages, the
driver allocates an order 1 compound page and uses one page per receive
buffer. To determine the correct offset for a delayed DMA sync of the
first fragment of a multi-fragment packet, the driver then cannot just
use PAGE_MASK on the DMA address but has to construct a mask based on
the actual size of the backing page.

Using PAGE_MASK in the 3K RX buffer/4K page architecture configuration
will always sync the first page of a compound page. With the SWIOTLB
enabled this can lead to corrupted packets (zeroed out first fragment,
re-used garbage from another packet) and various consequences, such as
slow/stalling data transfers and connection resets. For example, testing
on a link with MTU exceeding 3058 bytes on a host with SWIOTLB enabled
(e.g. "iommu=soft swiotlb=262144,force") TCP transfers quickly fizzle
out without this patch.

Cc: stable at vger.kernel.org
Fixes: 0c5661ecc5dd7 ("ixgbe: fix crash in build_skb Rx code path")
Signed-off-by: Markus Boehme <markubo@amazon.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c5ec17d19c59..507ef3471301 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1825,7 +1825,8 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
 				struct sk_buff *skb)
 {
 	if (ring_uses_build_skb(rx_ring)) {
-		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
+		unsigned long mask = (unsigned long)ixgbe_rx_pg_size(rx_ring) - 1;
+		unsigned long offset = (unsigned long)(skb->data) & mask;
 
 		dma_sync_single_range_for_cpu(rx_ring->dev,
 					      IXGBE_CB(skb)->dma,
-- 
2.25.1

