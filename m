From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:29 -0400
Subject: [Intel-wired-lan] [next PATCH S12 01/15] i40e/i40evf: Add a stat to
	keep track of linearization count
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Keep track of how many times we ask the stack to linearize the
skb because the HW cannot handle skbs with more than 8 frags per
segment/single packet.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: If455452060963a769bbe6112cba952e79e944b52
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 5 +++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c  | 5 +++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 +
 7 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 3d4f2e4..73d2e86 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -477,6 +477,7 @@ struct i40e_vsi {
 #endif
 	u32 tx_restart;
 	u32 tx_busy;
+	u64 tx_linearize;
 	u32 rx_buf_failed;
 	u32 rx_page_failed;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 1fa38f6..ffa9431 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -87,6 +87,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_broadcast", eth_stats.rx_broadcast),
 	I40E_VSI_STAT("tx_broadcast", eth_stats.tx_broadcast),
 	I40E_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
+	I40E_VSI_STAT("tx_linearize", tx_linearize),
 };
 
 static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d6ba5f6..b3328ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -796,6 +796,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	u32 rx_page, rx_buf;
 	u64 bytes, packets;
 	unsigned int start;
+	u64 tx_linearize;
 	u64 rx_p, rx_b;
 	u64 tx_p, tx_b;
 	u16 q;
@@ -814,7 +815,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	 */
 	rx_b = rx_p = 0;
 	tx_b = tx_p = 0;
-	tx_restart = tx_busy = 0;
+	tx_restart = tx_busy = tx_linearize = 0;
 	rx_page = 0;
 	rx_buf = 0;
 	rcu_read_lock();
@@ -831,6 +832,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 		tx_p += packets;
 		tx_restart += p->tx_stats.restart_queue;
 		tx_busy += p->tx_stats.tx_busy;
+		tx_linearize += p->tx_stats.tx_linearize;
 
 		/* Rx queue is part of the same block as Tx queue */
 		p = &p[1];
@@ -847,6 +849,7 @@ static void i40e_update_vsi_stats(struct i40e_vsi *vsi)
 	rcu_read_unlock();
 	vsi->tx_restart = tx_restart;
 	vsi->tx_busy = tx_busy;
+	vsi->tx_linearize = tx_linearize;
 	vsi->rx_page_failed = rx_page;
 	vsi->rx_buf_failed = rx_buf;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b93c2dc..79c8f71 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2809,10 +2809,11 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	if (tsyn)
 		tx_flags |= I40E_TX_FLAGS_TSYN;
 
-	if (i40e_chk_linearize(skb, tx_flags))
+	if (i40e_chk_linearize(skb, tx_flags)) {
 		if (skb_linearize(skb))
 			goto out_drop;
-
+		tx_ring->tx_stats.tx_linearize++;
+	}
 	skb_tx_timestamp(skb);
 
 	/* always enable CRC insertion offload */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index db2130f..c6d2995 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -188,6 +188,7 @@ struct i40e_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
 	u64 tx_done_old;
+	u64 tx_linearize;
 };
 
 struct i40e_rx_queue_stats {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 37e2b05..1d0e38f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2005,10 +2005,11 @@ static netdev_tx_t i40e_xmit_frame_ring(struct sk_buff *skb,
 	else if (tso)
 		tx_flags |= I40E_TX_FLAGS_TSO;
 
-	if (i40e_chk_linearize(skb, tx_flags))
+	if (i40e_chk_linearize(skb, tx_flags)) {
 		if (skb_linearize(skb))
 			goto out_drop;
-
+		tx_ring->tx_stats.tx_linearize++;
+	}
 	skb_tx_timestamp(skb);
 
 	/* always enable CRC insertion offload */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 9a30f5d..e8dd651 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -187,6 +187,7 @@ struct i40e_tx_queue_stats {
 	u64 restart_queue;
 	u64 tx_busy;
 	u64 tx_done_old;
+	u64 tx_linearize;
 };
 
 struct i40e_rx_queue_stats {
-- 
1.9.3

