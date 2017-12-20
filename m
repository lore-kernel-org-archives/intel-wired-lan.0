From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 19 Dec 2017 16:00:01 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 09/10] ixgbe: ipsec offload
 stats
In-Reply-To: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513728002-7643-10-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a simple statistic to count the ipsec offloads.

v2: change per ring counter to adapter rx and tx counters
    move tx_ipsec count to the tx clean code

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   | 2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 5 ++++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 3d2b7bf..1dfe147 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -629,10 +629,12 @@ struct ixgbe_adapter {
 	int num_tx_queues;
 	u16 tx_itr_setting;
 	u16 tx_work_limit;
+	u64 tx_ipsec;
 
 	/* Rx fast path data */
 	int num_rx_queues;
 	u16 rx_itr_setting;
+	u64 rx_ipsec;
 
 	/* Port number used to identify VXLAN traffic */
 	__be16 vxlan_port;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index c3e7a81..bcf011e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -114,6 +114,8 @@ static const struct ixgbe_stats ixgbe_gstrings_stats[] = {
 	{"tx_hwtstamp_timeouts", IXGBE_STAT(tx_hwtstamp_timeouts)},
 	{"tx_hwtstamp_skipped", IXGBE_STAT(tx_hwtstamp_skipped)},
 	{"rx_hwtstamp_cleared", IXGBE_STAT(rx_hwtstamp_cleared)},
+	{"tx_ipsec", IXGBE_STAT(tx_ipsec)},
+	{"rx_ipsec", IXGBE_STAT(rx_ipsec)},
 #ifdef IXGBE_FCOE
 	{"fcoe_bad_fccrc", IXGBE_STAT(stats.fccrc)},
 	{"rx_fcoe_dropped", IXGBE_STAT(stats.fcoerpdc)},
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index c2fd2ac..4b16466 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -837,6 +837,8 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 	xo = xfrm_offload(skb);
 	xo->flags = CRYPTO_DONE;
 	xo->status = CRYPTO_SUCCESS;
+
+	adapter->rx_ipsec++;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6b9a9b2..8c88d32 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1173,7 +1173,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 	struct ixgbe_adapter *adapter = q_vector->adapter;
 	struct ixgbe_tx_buffer *tx_buffer;
 	union ixgbe_adv_tx_desc *tx_desc;
-	unsigned int total_bytes = 0, total_packets = 0;
+	unsigned int total_bytes = 0, total_packets = 0, total_ipsec = 0;
 	unsigned int budget = q_vector->tx.work_limit;
 	unsigned int i = tx_ring->next_to_clean;
 
@@ -1204,6 +1204,8 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 		/* update the statistics for this packet */
 		total_bytes += tx_buffer->bytecount;
 		total_packets += tx_buffer->gso_segs;
+		if (tx_buffer->tx_flags & IXGBE_TX_FLAGS_IPSEC)
+			total_ipsec++;
 
 		/* free the skb */
 		if (ring_is_xdp(tx_ring))
@@ -1266,6 +1268,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 	u64_stats_update_end(&tx_ring->syncp);
 	q_vector->tx.total_bytes += total_bytes;
 	q_vector->tx.total_packets += total_packets;
+	adapter->tx_ipsec += total_ipsec;
 
 	if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
 		/* schedule immediate reset if we believe we hung */
-- 
2.7.4

