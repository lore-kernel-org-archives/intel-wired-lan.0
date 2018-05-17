From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:34 -0700
Subject: [Intel-wired-lan] [next PATCH S92 3/9] i40e: always return all
 queue stat strings
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ethtool API for obtaining device statistics is not intended to allow
runtime changes in the number of statistics reported. It may *appear*
this way, as there is an ability to request the number of stats using
ethtool_get_set_count(). However, it is expected that this must always
return the same value for invocations of the same device.

If we don't satisfy this contract, and allow the number of stats to
change during run time, we could cause invalid memory accesses or report
the stat strings incorrectly. This is because the API for obtaining
stats is to (1) get the size, (2) get the strings and finally (3) get
the stats. Since these are each separate ethtool op commands, it is not
possible to maintain consistency by holding the RTNL lock over the whole
operation. This results in the potential for a race condition to occur
where the size changed between any of the 3 calls.

Avoid this issue by requiring that we always return the same value for
a given device. We can check any values which remain constant for the
life of the device, but must not report different sizes depending on
runtime attributes.

This patch specifically fixes the queue statistics to always return
every queue even if it's not currently in use.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 5a0e4d4..698f096 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -140,8 +140,12 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("rx_lpi_count", stats.rx_lpi_count),
 };
 
-#define I40E_QUEUE_STATS_LEN(n) \
-	(((struct i40e_netdev_priv *)netdev_priv((n)))->vsi->num_queue_pairs \
+/* We use num_tx_queues here as a proxy for the maximum number of queues
+ * available because we always allocate queues symmetrically.
+ */
+#define I40E_MAX_NUM_QUEUES(n) ((n)->num_tx_queues)
+#define I40E_QUEUE_STATS_LEN(n)                                              \
+	   (I40E_MAX_NUM_QUEUES(n)                                           \
 	    * 2 /* Tx and Rx together */                                     \
 	    * (sizeof(struct i40e_queue_stats) / sizeof(u64)))
 #define I40E_GLOBAL_STATS_LEN	ARRAY_SIZE(i40e_gstrings_stats)
@@ -1592,11 +1596,19 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 			    sizeof(u64)) ? *(u64 *)p : *(u32 *)p;
 	}
 	rcu_read_lock();
-	for (j = 0; j < vsi->num_queue_pairs; j++) {
+	for (j = 0; j < I40E_MAX_NUM_QUEUES(netdev) ; j++) {
 		tx_ring = READ_ONCE(vsi->tx_rings[j]);
 
-		if (!tx_ring)
+		if (!tx_ring) {
+			/* Bump the stat counter to skip these stats, and make
+			 * sure the memory is zero'd
+			 */
+			data[i++] = 0;
+			data[i++] = 0;
+			data[i++] = 0;
+			data[i++] = 0;
 			continue;
+		}
 
 		/* process Tx ring statistics */
 		do {
@@ -1680,7 +1692,7 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 				 i40e_gstrings_misc_stats[i].stat_string);
 			p += ETH_GSTRING_LEN;
 		}
-		for (i = 0; i < vsi->num_queue_pairs; i++) {
+		for (i = 0; i < I40E_MAX_NUM_QUEUES(netdev); i++) {
 			snprintf(p, ETH_GSTRING_LEN, "tx-%d.tx_packets", i);
 			p += ETH_GSTRING_LEN;
 			snprintf(p, ETH_GSTRING_LEN, "tx-%d.tx_bytes", i);
-- 
2.9.5

