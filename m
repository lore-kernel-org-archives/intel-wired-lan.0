From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:23 -0700
Subject: [Intel-wired-lan] [next PATCH S95 02/12] i40e: convert queue stats
 to i40e_stats array
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Use an i40e_stats array to handle the queue stats, instead of coding
similar functionality separately. Because of how the queue stats are
accessed on some kernels, we can't easily use i40e_add_ethtool_stats.

Instead, implement a separate helper, i40e_add_queue_stats, which we'll
use instead. This helper will correctly implement the
u64_stats_fetch_begin_irq logic and allow retries until successful. We
share the most complex code by re-using i40e_add_one_ethtool_stat.

This logic additionally easily supports skipping disabled rings by using
a ternary operator before calling the u64_stats_fetch_begin_irq()
function, so that we correctly zero-out the stats values without having
to perform two separate sections of code.

This significantly reduces the boiler plate code in
i40e_get_ethtool_stats, and helps keep the complex logic contained to as
few functions as possible.

With this patch, we've finally converted all the statistics to use the
helpers and the i40e_stats function.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 148 +++++++++++++++----------
 1 file changed, 89 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 19606a2..9ac41c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -33,6 +33,8 @@ struct i40e_stats {
 	I40E_STAT(struct i40e_veb, _name, _stat)
 #define I40E_PFC_STAT(_name, _stat) \
 	I40E_STAT(struct i40e_pfc_stats, _name, _stat)
+#define I40E_QUEUE_STAT(_name, _stat) \
+	I40E_STAT(struct i40e_ring, _name, _stat)
 
 static const struct i40e_stats i40e_gstrings_net_stats[] = {
 	I40E_NETDEV_STAT(rx_packets),
@@ -171,20 +173,16 @@ static const struct i40e_stats i40e_gstrings_pfc_stats[] = {
 	I40E_PFC_STAT("port.rx_priority_%u_xon_2_xoff", priority_xon_2_xoff),
 };
 
-/* We use num_tx_queues here as a proxy for the maximum number of queues
- * available because we always allocate queues symmetrically.
- */
-#define I40E_MAX_NUM_QUEUES(n) ((n)->num_tx_queues)
-#define I40E_QUEUE_STATS_LEN(n)                                              \
-	   (I40E_MAX_NUM_QUEUES(n)                                           \
-	    * 2 /* Tx and Rx together */                                     \
-	    * (sizeof(struct i40e_queue_stats) / sizeof(u64)))
-#define I40E_GLOBAL_STATS_LEN	ARRAY_SIZE(i40e_gstrings_stats)
+static const struct i40e_stats i40e_gstrings_queue_stats[] = {
+	I40E_QUEUE_STAT("%s-%u.packets", stats.packets),
+	I40E_QUEUE_STAT("%s-%u.bytes", stats.bytes),
+};
+
 #define I40E_NETDEV_STATS_LEN	ARRAY_SIZE(i40e_gstrings_net_stats)
+
 #define I40E_MISC_STATS_LEN	ARRAY_SIZE(i40e_gstrings_misc_stats)
-#define I40E_VSI_STATS_LEN(n)	(I40E_NETDEV_STATS_LEN + \
-				 I40E_MISC_STATS_LEN + \
-				 I40E_QUEUE_STATS_LEN((n)))
+
+#define I40E_VSI_STATS_LEN	(I40E_NETDEV_STATS_LEN + I40E_MISC_STATS_LEN)
 
 #define I40E_PFC_STATS_LEN	(ARRAY_SIZE(i40e_gstrings_pfc_stats) * \
 				 I40E_MAX_USER_PRIORITY)
@@ -193,10 +191,15 @@ static const struct i40e_stats i40e_gstrings_pfc_stats[] = {
 				 (ARRAY_SIZE(i40e_gstrings_veb_tc_stats) * \
 				  I40E_MAX_TRAFFIC_CLASS))
 
-#define I40E_PF_STATS_LEN(n)	(I40E_GLOBAL_STATS_LEN + \
+#define I40E_GLOBAL_STATS_LEN	ARRAY_SIZE(i40e_gstrings_stats)
+
+#define I40E_PF_STATS_LEN	(I40E_GLOBAL_STATS_LEN + \
 				 I40E_PFC_STATS_LEN + \
 				 I40E_VEB_STATS_LEN + \
-				 I40E_VSI_STATS_LEN((n)))
+				 I40E_VSI_STATS_LEN)
+
+/* Length of stats for a single queue */
+#define I40E_QUEUE_STATS_LEN	ARRAY_SIZE(i40e_gstrings_queue_stats)
 
 enum i40e_ethtool_test_id {
 	I40E_ETH_TEST_REG = 0,
@@ -1701,11 +1704,30 @@ static int i40e_get_stats_count(struct net_device *netdev)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
+	int stats_len;
 
 	if (vsi == pf->vsi[pf->lan_vsi] && pf->hw.partition_id == 1)
-		return I40E_PF_STATS_LEN(netdev);
+		stats_len = I40E_PF_STATS_LEN;
 	else
-		return I40E_VSI_STATS_LEN(netdev);
+		stats_len = I40E_VSI_STATS_LEN;
+
+	/* The number of stats reported for a given net_device must remain
+	 * constant throughout the life of that device.
+	 *
+	 * This is because the API for obtaining the size, strings, and stats
+	 * is spread out over three separate ethtool ioctls. There is no safe
+	 * way to lock the number of stats across these calls, so we must
+	 * assume that they will never change.
+	 *
+	 * Due to this, we report the maximum number of queues, even if not
+	 * every queue is currently configured. Since we always allocate
+	 * queues in pairs, we'll just use netdev->num_tx_queues * 2. This
+	 * works because the num_tx_queues is set at device creation and never
+	 * changes.
+	 */
+	stats_len += I40E_QUEUE_STATS_LEN * 2 * netdev->num_tx_queues;
+
+	return stats_len;
 }
 
 static int i40e_get_sset_count(struct net_device *netdev, int sset)
@@ -1734,8 +1756,8 @@ static int i40e_get_sset_count(struct net_device *netdev, int sset)
  * @stat: the stat definition
  *
  * Copies the stat data defined by the pointer and stat structure pair into
- * the memory supplied as data. Used to implement i40e_add_ethtool_stats.
- * If the pointer is null, data will be zero'd.
+ * the memory supplied as data. Used to implement i40e_add_ethtool_stats and
+ * i40e_add_queue_stats. If the pointer is null, data will be zero'd.
  */
 static inline void
 i40e_add_one_ethtool_stat(u64 *data, void *pointer,
@@ -1811,6 +1833,45 @@ __i40e_add_ethtool_stats(u64 **data, void *pointer,
 	__i40e_add_ethtool_stats(data, pointer, stats, ARRAY_SIZE(stats))
 
 /**
+ * i40e_add_queue_stats - copy queue statistics into supplied buffer
+ * @data: ethtool stats buffer
+ * @ring: the ring to copy
+ *
+ * Queue statistics must be copied while protected by
+ * u64_stats_fetch_begin_irq, so we can't directly use i40e_add_ethtool_stats.
+ * Assumes that queue stats are defined in i40e_gstrings_queue_stats. If the
+ * ring pointer is null, zero out the queue stat values and update the data
+ * pointer. Otherwise safely copy the stats from the ring into the supplied
+ * buffer and update the data pointer when finished.
+ *
+ * This function expects to be called while under rcu_read_lock().
+ **/
+static inline void
+i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
+{
+	const unsigned int size = ARRAY_SIZE(i40e_gstrings_queue_stats);
+	const struct i40e_stats *stats = i40e_gstrings_queue_stats;
+	unsigned int start;
+	unsigned int i;
+
+	/* To avoid invalid statistics values, ensure that we keep retrying
+	 * the copy until we get a consistent value according to
+	 * u64_stats_fetch_retry_irq. But first, make sure our ring is
+	 * non-null before attempting to access its syncp.
+	 */
+	do {
+		start = !ring ? 0 : u64_stats_fetch_begin_irq(&ring->syncp);
+		for (i = 0; i < size; i++) {
+			i40e_add_one_ethtool_stat(&(*data)[i], ring,
+						  &stats[i]);
+		}
+	} while (ring && u64_stats_fetch_retry_irq(&ring->syncp, start));
+
+	/* Once we successfully copy the stats in, update the data pointer */
+	data += size;
+}
+
+/**
  * i40e_get_pfc_stats - copy HW PFC statistics to formatted structure
  * @pf: the PF device structure
  * @i: the priority value to copy
@@ -1853,12 +1914,10 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 				   struct ethtool_stats *stats, u64 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
-	struct i40e_ring *tx_ring, *rx_ring;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_veb *veb = pf->veb[pf->lan_veb];
 	unsigned int i;
-	unsigned int start;
 	bool veb_stats;
 	u64 *p = data;
 
@@ -1870,38 +1929,12 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 	i40e_add_ethtool_stats(&data, vsi, i40e_gstrings_misc_stats);
 
 	rcu_read_lock();
-	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev) ; i++) {
-		tx_ring = READ_ONCE(vsi->tx_rings[i]);
-
-		if (!tx_ring) {
-			/* Bump the stat counter to skip these stats, and make
-			 * sure the memory is zero'd
-			 */
-			*(data++) = 0;
-			*(data++) = 0;
-			*(data++) = 0;
-			*(data++) = 0;
-			continue;
-		}
-
-		/* process Tx ring statistics */
-		do {
-			start = u64_stats_fetch_begin_irq(&tx_ring->syncp);
-			data[0] = tx_ring->stats.packets;
-			data[1] = tx_ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&tx_ring->syncp, start));
-		data += 2;
-
-		/* Rx ring is the 2nd half of the queue pair */
-		rx_ring = &tx_ring[1];
-		do {
-			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
-			data[0] = rx_ring->stats.packets;
-			data[1] = rx_ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
-		data += 2;
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		i40e_add_queue_stats(&data, READ_ONCE(vsi->tx_rings[i]));
+		i40e_add_queue_stats(&data, READ_ONCE(vsi->rx_rings[i]));
 	}
 	rcu_read_unlock();
+
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		goto check_data_pointer;
 
@@ -1990,16 +2023,13 @@ static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 
 	i40e_add_stat_strings(&data, i40e_gstrings_misc_stats);
 
-	for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
-		snprintf(data, ETH_GSTRING_LEN, "tx-%u.tx_packets", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN, "tx-%u.tx_bytes", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN, "rx-%u.rx_packets", i);
-		data += ETH_GSTRING_LEN;
-		snprintf(data, ETH_GSTRING_LEN, "rx-%u.rx_bytes", i);
-		data += ETH_GSTRING_LEN;
+	for (i = 0; i < netdev->num_tx_queues; i++) {
+		i40e_add_stat_strings(&data, i40e_gstrings_queue_stats,
+				      "tx", i);
+		i40e_add_stat_strings(&data, i40e_gstrings_queue_stats,
+				      "rx", i);
 	}
+
 	if (vsi != pf->vsi[pf->lan_vsi] || pf->hw.partition_id != 1)
 		return;
 
-- 
2.9.5

