From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:11 -0400
Subject: [Intel-wired-lan] [net-next S4 14/15] i40e/i40evf: remove
	time_stamp member
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver doesn't use the time_stamp member to determine if there is a
tx_hang any more. There really isn't any point to the variable at all
so just remove it. It was left over from a previous tx_hang design.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I4c814827e1bcb46e45118fe37acdcfa814fb62a0
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 10 ----------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  7 -------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 -
 4 files changed, 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ca21f9a..e1596dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -165,9 +165,6 @@ int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data, u8 *raw_packet,
 	tx_desc->cmd_type_offset_bsz =
 		build_ctob(td_cmd, 0, I40E_FDIR_MAX_RAW_PACKET_SIZE, 0);
 
-	/* set the timestamp */
-	tx_buf->time_stamp = jiffies;
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.
 	 */
@@ -810,10 +807,6 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 			 tx_ring->vsi->seid,
 			 tx_ring->queue_index,
 			 tx_ring->next_to_use, i);
-		dev_info(tx_ring->dev, "tx_bi[next_to_clean]\n"
-			 "  time_stamp           <%lx>\n"
-			 "  jiffies              <%lx>\n",
-			 tx_ring->tx_bi[i].time_stamp, jiffies);
 
 		netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
 
@@ -2608,9 +2601,6 @@ static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 						 tx_ring->queue_index),
 			     first->bytecount);
 
-	/* set the timestamp */
-	first->time_stamp = jiffies;
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
 	 * applicable for weak-ordered memory model archs,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index ea1df3b..0dc48dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -147,7 +147,6 @@ enum i40e_dyn_idx_t {
 
 struct i40e_tx_buffer {
 	struct i40e_tx_desc *next_to_watch;
-	unsigned long time_stamp;
 	union {
 		struct sk_buff *skb;
 		void *raw_buf;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index fa2458b..11de5a5 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -322,10 +322,6 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 			 tx_ring->vsi->seid,
 			 tx_ring->queue_index,
 			 tx_ring->next_to_use, i);
-		dev_info(tx_ring->dev, "tx_bi[next_to_clean]\n"
-			 "  time_stamp           <%lx>\n"
-			 "  jiffies              <%lx>\n",
-			 tx_ring->tx_bi[i].time_stamp, jiffies);
 
 		netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
 
@@ -1826,9 +1822,6 @@ static inline void i40evf_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
 						 tx_ring->queue_index),
 			     first->bytecount);
 
-	/* set the timestamp */
-	first->time_stamp = jiffies;
-
 	/* Force memory writes to complete before letting h/w
 	 * know there are new descriptors to fetch.  (Only
 	 * applicable for weak-ordered memory model archs,
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index a23f5e8..e7a34f8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -146,7 +146,6 @@ enum i40e_dyn_idx_t {
 
 struct i40e_tx_buffer {
 	struct i40e_tx_desc *next_to_watch;
-	unsigned long time_stamp;
 	union {
 		struct sk_buff *skb;
 		void *raw_buf;
-- 
1.9.3

