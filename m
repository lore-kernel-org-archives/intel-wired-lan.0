From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 07 Feb 2018 14:23:06 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix crash in build_skb Rx code path
Message-ID: <20180207222306.30003.49713.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add check for build_skb enabled ring in ixgbe_dma_sync_frag().
In that case &skb_shinfo(skb)->frags[0] may not always be set which
can lead to a crash. Instead we derive the page offset from skb->data.

Fixes: 42073d91a214
("ixgbe: Have the CPU take ownership of the buffers sooner")
Reported-by: Ambarish Soman <asoman@redhat.com>
Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b032091..8536942 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1888,6 +1888,14 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
 				     ixgbe_rx_pg_size(rx_ring),
 				     DMA_FROM_DEVICE,
 				     IXGBE_RX_DMA_ATTR);
+	} else if (ring_uses_build_skb(rx_ring)) {
+		unsigned long offset = (unsigned long)(skb->data) & ~PAGE_MASK;
+
+		dma_sync_single_range_for_cpu(rx_ring->dev,
+					      IXGBE_CB(skb)->dma,
+					      offset,
+					      skb_headlen(skb),
+					      DMA_FROM_DEVICE);
 	} else {
 		struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[0];
 

