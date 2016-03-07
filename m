From: Alexander Duyck <aduyck@mirantis.com>
Date: Mon, 07 Mar 2016 09:30:21 -0800
Subject: [Intel-wired-lan] [PATCH 5/5] igb: Add support for bulk Tx cleanup
 & cleanup boolean logic
In-Reply-To: <20160307172722.5682.38580.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
Message-ID: <20160307173021.5682.83995.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch enables bulk free in Tx cleanup for igb and cleans up the
boolean logic in the polling routines for igb in the hopes of avoiding
any mix-ups similar to what occurred with i40e and i40evf.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1846b8584ef2..99d37b0605d9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -151,7 +151,7 @@ static void igb_update_dca(struct igb_q_vector *);
 static void igb_setup_dca(struct igb_adapter *);
 #endif /* CONFIG_IGB_DCA */
 static int igb_poll(struct napi_struct *, int);
-static bool igb_clean_tx_irq(struct igb_q_vector *);
+static bool igb_clean_tx_irq(struct igb_q_vector *, int);
 static int igb_clean_rx_irq(struct igb_q_vector *, int);
 static int igb_ioctl(struct net_device *, struct ifreq *, int cmd);
 static void igb_tx_timeout(struct net_device *);
@@ -6534,13 +6534,14 @@ static int igb_poll(struct napi_struct *napi, int budget)
 		igb_update_dca(q_vector);
 #endif
 	if (q_vector->tx.ring)
-		clean_complete = igb_clean_tx_irq(q_vector);
+		clean_complete = igb_clean_tx_irq(q_vector, budget);
 
 	if (q_vector->rx.ring) {
 		int cleaned = igb_clean_rx_irq(q_vector, budget);
 
 		work_done += cleaned;
-		clean_complete &= (cleaned < budget);
+		if (cleaned >= budget)
+			clean_complete = false;
 	}
 
 	/* If all work not completed, return budget and keep polling */
@@ -6557,10 +6558,11 @@ static int igb_poll(struct napi_struct *napi, int budget)
 /**
  *  igb_clean_tx_irq - Reclaim resources after transmit completes
  *  @q_vector: pointer to q_vector containing needed info
+ *  @napi_budget: Used to determine if we are in netpoll
  *
  *  returns true if ring is completely cleaned
  **/
-static bool igb_clean_tx_irq(struct igb_q_vector *q_vector)
+static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
 	struct igb_ring *tx_ring = q_vector->tx.ring;
@@ -6599,7 +6601,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector)
 		total_packets += tx_buffer->gso_segs;
 
 		/* free the skb */
-		dev_consume_skb_any(tx_buffer->skb);
+		napi_consume_skb(tx_buffer->skb, napi_budget);
 
 		/* unmap skb header data */
 		dma_unmap_single(tx_ring->dev,

