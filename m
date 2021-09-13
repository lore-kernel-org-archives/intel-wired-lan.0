From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 13 Sep 2021 07:34:34 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix displaying queue
 statistics shown by ethtool
Message-ID: <20210913073434.77748-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Driver provided too many lines as an output to ethtool -S command.
Return actual length of string set of ethtool stats. Instead of predefined
maximal value use the actual value on netdev, iterate over active queues.
Without this patch, ethtool -S report would produce additional
erroneous lines.

Without this change in statistics after showing them by ethtool -S
will be displayed queues that are not configured.

Fixes: 6dba41cd02fc ("i40evf: update ethtool stats code and use helper functions")
Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 7cbe59beeebb..c585ad13cb37 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -331,9 +331,16 @@ static int iavf_get_link_ksettings(struct net_device *netdev,
  **/
 static int iavf_get_sset_count(struct net_device *netdev, int sset)
 {
+	/* Report the maximum number queues, even if not every queue is
+	 * currently configured. Since allocation of queues is in pairs,
+	 * use netdev->real_num_tx_queues * 2. The real_num_tx_queues is set
+	 * at device creation and never changes.
+	 */
+
 	if (sset == ETH_SS_STATS)
 		return IAVF_STATS_LEN +
-			(IAVF_QUEUE_STATS_LEN * 2 * IAVF_MAX_REQ_QUEUES);
+			(IAVF_QUEUE_STATS_LEN * 2 *
+			 netdev->real_num_tx_queues);
 	else if (sset == ETH_SS_PRIV_FLAGS)
 		return IAVF_PRIV_FLAGS_STR_LEN;
 	else
@@ -357,17 +364,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
 	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
 	rcu_read_lock();
-	for (i = 0; i < IAVF_MAX_REQ_QUEUES; i++) {
+	/* As num_active_queues describe both tx and rx queues, we can use
+	 * it to iterate over rings' stats.
+	 */
+	for (i = 0; i < adapter->num_active_queues; i++) {
+
 		struct iavf_ring *ring;
 
-		/* Avoid accessing un-allocated queues */
-		ring = (i < adapter->num_active_queues ?
-			&adapter->tx_rings[i] : NULL);
+		/* Tx rings stats */
+		ring = &adapter->tx_rings[i];
 		iavf_add_queue_stats(&data, ring);
 
-		/* Avoid accessing un-allocated queues */
-		ring = (i < adapter->num_active_queues ?
-			&adapter->rx_rings[i] : NULL);
+		/* Rx rings stats */
+		ring = &adapter->rx_rings[i];
 		iavf_add_queue_stats(&data, ring);
 	}
 	rcu_read_unlock();
@@ -404,10 +413,10 @@ static void iavf_get_stat_strings(struct net_device *netdev, u8 *data)
 
 	iavf_add_stat_strings(&data, iavf_gstrings_stats);
 
-	/* Queues are always allocated in pairs, so we just use num_tx_queues
-	 * for both Tx and Rx queues.
+	/* Queues are always allocated in pairs, so we just use
+	 * real_num_tx_queues for both Tx and Rx queues.
 	 */
-	for (i = 0; i < netdev->num_tx_queues; i++) {
+	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
 				      "tx", i);
 		iavf_add_stat_strings(&data, iavf_gstrings_queue_stats,
-- 
2.27.0

