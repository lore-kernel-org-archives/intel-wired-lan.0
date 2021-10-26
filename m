From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 25 Oct 2021 17:08:26 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/4] ice: use modern kernel
 API for kick
In-Reply-To: <20211026000826.156803-1-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
Message-ID: <20211026000826.156803-5-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The kernel gained a new interface for drivers to use to combine tail
bump (doorbell) and BQL updates, attempt to use those new interfaces.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index de9247d45c39..3987a0dd0e11 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1576,6 +1576,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 	struct sk_buff *skb;
 	skb_frag_t *frag;
 	dma_addr_t dma;
+	bool kick;
 
 	td_tag = off->td_l2tag1;
 	td_cmd = off->td_cmd;
@@ -1657,9 +1658,6 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		tx_buf = &tx_ring->tx_buf[i];
 	}
 
-	/* record bytecount for BQL */
-	netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount);
-
 	/* record SW timestamp if HW timestamp is not available */
 	skb_tx_timestamp(first->skb);
 
@@ -1688,7 +1686,10 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 	ice_maybe_stop_tx(tx_ring, DESC_NEEDED);
 
 	/* notify HW of packet */
-	if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more())
+	kick = __netdev_tx_sent_queue(txring_txq(tx_ring), first->bytecount,
+				      netdev_xmit_more());
+	if (kick)
+		/* notify HW of packet */
 		writel(i, tx_ring->tail);
 
 	return;
-- 
2.31.1

