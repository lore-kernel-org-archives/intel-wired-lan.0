From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 27 Oct 2021 12:38:36 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 2/4] ice: use prefetch methods
In-Reply-To: <20211023004128.86999-1-jesse.brandeburg@intel.com>
References: <20211023004128.86999-1-jesse.brandeburg@intel.com>
Message-ID: <20211027193836.372561-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The kernel provides some prefetch mechanisms to speed up commonly
cold cache line accesses during receive processing. Since these are
software structures it helps to have these strategically placed
prefetches.

Be careful to call BQL prefetch complete only for non XDP queues.

Co-developed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Testing Hints:
Run AF_XDP socket and then terminate it or run xdp2
sample and send some traffic into the port.

Performance numbers for xdp2 sample are not noticeably
affected by introducing branch from this patch.
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 12a2edd13877..de9247d45c39 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -3,8 +3,9 @@
 
 /* The driver transmit and receive code */
 
-#include <linux/prefetch.h>
 #include <linux/mm.h>
+#include <linux/netdevice.h>
+#include <linux/prefetch.h>
 #include <linux/bpf_trace.h>
 #include <net/dsfield.h>
 #include <net/xdp.h>
@@ -219,6 +220,10 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 	struct ice_tx_desc *tx_desc;
 	struct ice_tx_buf *tx_buf;
 
+	/* get the bql data ready */
+	if (!ice_ring_is_xdp(tx_ring))
+		netdev_txq_bql_complete_prefetchw(txring_txq(tx_ring));
+
 	tx_buf = &tx_ring->tx_buf[i];
 	tx_desc = ICE_TX_DESC(tx_ring, i);
 	i -= tx_ring->count;
@@ -232,6 +237,9 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
 		if (!eop_desc)
 			break;
 
+		/* follow the guidelines of other drivers */
+		prefetchw(&tx_buf->skb->users);
+
 		smp_rmb();	/* prevent any other reads prior to eop_desc */
 
 		ice_trace(clean_tx_irq, tx_ring, tx_desc, tx_buf);
@@ -2265,6 +2273,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		return NETDEV_TX_BUSY;
 	}
 
+	/* prefetch for bql data which is infrequently used */
+	netdev_txq_bql_enqueue_prefetchw(txring_txq(tx_ring));
+
 	offload.tx_ring = tx_ring;
 
 	/* record the location of the first descriptor for this packet */
-- 
2.31.1

