From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 12:03:01 -0500
Subject: [Intel-wired-lan] [PATCH AUTOSEL 4.19 543/671] ixgbe: sync the
 first fragment unconditionally
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
Message-ID: <20200116170509.12787-280-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Firo Yang <firo.yang@suse.com>

[ Upstream commit e7ba676c6188d394a0133fc4b9bcd7ee50d54b7f ]

In Xen environment, if Xen-swiotlb is enabled, ixgbe driver
could possibly allocate a page, DMA memory buffer, for the first
fragment which is not suitable for Xen-swiotlb to do DMA operations.
Xen-swiotlb have to internally allocate another page for doing DMA
operations. This mechanism requires syncing the data from the internal
page to the page which ixgbe sends to upper network stack. However,
since commit f3213d932173 ("ixgbe: Update driver to make use of DMA
attributes in Rx path"), the unmap operation is performed with
DMA_ATTR_SKIP_CPU_SYNC. As a result, the sync is not performed.
Since the sync isn't performed, the upper network stack could receive
a incomplete network packet. By incomplete, it means the linear data
on the first fragment(between skb->head and skb->end) is invalid. So
we have to copy the data from the internal xen-swiotlb page to the page
which ixgbe sends to upper network stack through the sync operation.

More details from Alexander Duyck:
Specifically since we are mapping the frame with
DMA_ATTR_SKIP_CPU_SYNC we have to unmap with that as well. As a result
a sync is not performed on an unmap and must be done manually as we
skipped it for the first frag. As such we need to always sync before
possibly performing a page unmap operation.

Fixes: f3213d932173 ("ixgbe: Update driver to make use of DMA attributes in Rx path")
Signed-off-by: Firo Yang <firo.yang@suse.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index de65ca1e6558..51cd58fbab69 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1822,13 +1822,7 @@ static void ixgbe_pull_tail(struct ixgbe_ring *rx_ring,
 static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
 				struct sk_buff *skb)
 {
-	/* if the page was released unmap it, else just sync our portion */
-	if (unlikely(IXGBE_CB(skb)->page_released)) {
-		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
-				     ixgbe_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE,
-				     IXGBE_RX_DMA_ATTR);
-	} else if (ring_uses_build_skb(rx_ring)) {
+	if (ring_uses_build_skb(rx_ring)) {
 		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
 
 		dma_sync_single_range_for_cpu(rx_ring->dev,
@@ -1845,6 +1839,14 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
 					      skb_frag_size(frag),
 					      DMA_FROM_DEVICE);
 	}
+
+	/* If the page was released, just unmap it. */
+	if (unlikely(IXGBE_CB(skb)->page_released)) {
+		dma_unmap_page_attrs(rx_ring->dev, IXGBE_CB(skb)->dma,
+				     ixgbe_rx_pg_size(rx_ring),
+				     DMA_FROM_DEVICE,
+				     IXGBE_RX_DMA_ATTR);
+	}
 }
 
 /**
-- 
2.20.1

