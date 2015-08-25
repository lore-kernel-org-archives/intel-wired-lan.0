From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 24 Aug 2015 17:01:58 -0700
Subject: [Intel-wired-lan] [next-queue] fm10k: use snprintf() instead of
	sprintf() to avoid buffer overflow
Message-ID: <1440460921-28318-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 6 +++---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 08ecf43dffc7..5304bc1fbecd 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -176,7 +176,7 @@ void fm10k_dbg_q_vector_init(struct fm10k_q_vector *q_vector)
 		return;
 
 	/* Generate a folder for each q_vector */
-	sprintf(name, "q_vector.%03d", q_vector->v_idx);
+	snprintf(name, sizeof(name), "q_vector.%03d", q_vector->v_idx);
 
 	q_vector->dbg_q_vector = debugfs_create_dir(name, interface->dbg_intfc);
 	if (!q_vector->dbg_q_vector)
@@ -186,7 +186,7 @@ void fm10k_dbg_q_vector_init(struct fm10k_q_vector *q_vector)
 	for (i = 0; i < q_vector->tx.count; i++) {
 		struct fm10k_ring *ring = &q_vector->tx.ring[i];
 
-		sprintf(name, "tx_ring.%03d", ring->queue_index);
+		snprintf(name, sizeof(name), "tx_ring.%03d", ring->queue_index);
 
 		debugfs_create_file(name, 0600,
 				    q_vector->dbg_q_vector, ring,
@@ -197,7 +197,7 @@ void fm10k_dbg_q_vector_init(struct fm10k_q_vector *q_vector)
 	for (i = 0; i < q_vector->rx.count; i++) {
 		struct fm10k_ring *ring = &q_vector->rx.ring[i];
 
-		sprintf(name, "rx_ring.%03d", ring->queue_index);
+		snprintf(name, sizeof(name), "rx_ring.%03d", ring->queue_index);
 
 		debugfs_create_file(name, 0600,
 				    q_vector->dbg_q_vector, ring,
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 4ef2fbd22911..447a5f8da42f 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -206,13 +206,13 @@ static void fm10k_get_stat_strings(struct net_device *dev, u8 *data)
 	}
 
 	for (i = 0; i < interface->hw.mac.max_queues; i++) {
-		sprintf(p, "tx_queue_%u_packets", i);
+		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_packets", i);
 		p += ETH_GSTRING_LEN;
-		sprintf(p, "tx_queue_%u_bytes", i);
+		snprintf(p, ETH_GSTRING_LEN, "tx_queue_%u_bytes", i);
 		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_queue_%u_packets", i);
+		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_packets", i);
 		p += ETH_GSTRING_LEN;
-		sprintf(p, "rx_queue_%u_bytes", i);
+		snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_bytes", i);
 		p += ETH_GSTRING_LEN;
 	}
 }
-- 
2.5.0.280.g4aaba03

