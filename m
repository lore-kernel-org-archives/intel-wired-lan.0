From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:39 -0700
Subject: [Intel-wired-lan] [next PATCH S92 8/9] i40e: add function doc
 headers for ethtool stats functions
In-Reply-To: <20180517080840.30192-1-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
Message-ID: <20180517080840.30192-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Add documentation for the i40e_get_stats_count, i40e_get_stat_strings
and i40e_get_ethtool_stats explaining that the number and ordering of
statistics must remain constant for a given netdevice.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 94e1995..487a9a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1540,6 +1540,20 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
+/**
+ * i40e_get_stats_count - return the stats count for a device
+ * @netdev: the netdev to return the count for
+ *
+ * Returns the total number of statistics for this netdev. Note that even
+ * though this is a function, it is required that the count for a specific
+ * netdev must never change. Basing the count on static values such as the
+ * maximum number of queues or the device type is ok. However, the API for
+ * obtaining stats is *not* safe against changes based on non-static
+ * values such as the *current* number of queues, or runtime flags.
+ *
+ * If a statistic is not always enabled, return it as part of the count
+ * anyways, always return its string, and report its value as zero.
+ **/
 static int i40e_get_stats_count(struct net_device *netdev)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
@@ -1571,6 +1585,20 @@ static int i40e_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
+/**
+ * i40e_get_ethtool_stats - copy stat values into supplied buffer
+ * @netdev: the netdev to collect stats for
+ * @stats: ethtool stats command structure
+ * @data: ethtool supplied buffer
+ *
+ * Copy the stats values for this netdev into the buffer. Expects data to be
+ * pre-allocated to the size returned by i40e_get_stats_count.. Note that all
+ * statistics must be copied in a static order, and the count must not change
+ * for a given netdev. See i40e_get_stats_count for more details.
+ *
+ * If a statistic is not currently valid (such as a disabled queue), this
+ * function reports its value as zero.
+ **/
 static void i40e_get_ethtool_stats(struct net_device *netdev,
 				   struct ethtool_stats *stats, u64 *data)
 {
@@ -1667,6 +1695,16 @@ static void i40e_get_ethtool_stats(struct net_device *netdev,
 		*(data++) = pf->stats.priority_xon_2_xoff[j];
 }
 
+/**
+ * i40e_get_stat_strings - copy stat strings into supplied buffer
+ * @netdev: the netdev to collect strings for
+ * @data: supplied buffer to copy strings into
+ *
+ * Copy the strings related to stats for this netdev. Expects data to be
+ * pre-allocated with the size reported by i40e_get_stats_count. Note that the
+ * strings must be copied in a static order and the total count must not
+ * change for a given netdev. See i40e_get_stats_count for more details.
+ **/
 static void i40e_get_stat_strings(struct net_device *netdev, u8 *data)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
-- 
2.9.5

