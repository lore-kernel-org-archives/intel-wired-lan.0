From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Wed, 15 Sep 2021 09:01:00 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix refreshing iavf adapter
 stats on ethtool request
Message-ID: <20210915090100.25340-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently iavf adapter statistics are refreshed only in a
watchdog task, triggered approximately every two seconds,
which causes some ethtool requests to return outdated values.

Add explicit statistics refresh when requested by ethtool -S.

Fixes: b476b0030e61 ("iavf: Move commands processing to the separate function")
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
V2: Squash 44a4808a78f6 ("iavf: Fix ethtool stats request scheduling")
V3: Change value returning by iavf_process_aq_command()
---
 drivers/net/ethernet/intel/iavf/iavf.h         |  2 ++
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  3 +++
 drivers/net/ethernet/intel/iavf/iavf_main.c    | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 21c95775509a..afe6b0d24a9a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -306,6 +306,7 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_DEL_FDIR_FILTER		BIT(26)
 #define IAVF_FLAG_AQ_ADD_ADV_RSS_CFG		BIT(27)
 #define IAVF_FLAG_AQ_DEL_ADV_RSS_CFG		BIT(28)
+#define IAVF_FLAG_AQ_REQUEST_STATS		BIT(29)
 
 	/* OS defined structs */
 	struct net_device *netdev;
@@ -399,6 +400,7 @@ int iavf_up(struct iavf_adapter *adapter);
 void iavf_down(struct iavf_adapter *adapter);
 int iavf_process_config(struct iavf_adapter *adapter);
 void iavf_schedule_reset(struct iavf_adapter *adapter);
+void iavf_schedule_request_stats(struct iavf_adapter *adapter);
 void iavf_reset(struct iavf_adapter *adapter);
 void iavf_set_ethtool_ops(struct net_device *netdev);
 void iavf_update_stats(struct iavf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 7cbe59beeebb..21c4d4180f3e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -354,6 +354,9 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	unsigned int i;
 
+	/* Explicitly request stats refresh */
+	iavf_schedule_request_stats(adapter);
+
 	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
 
 	rcu_read_lock();
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26391..c93025ec4667 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -165,6 +165,19 @@ void iavf_schedule_reset(struct iavf_adapter *adapter)
 	}
 }
 
+/**
+ * iavf_schedule_request_stats - Set the flags and schedule statistics request
+ * @adapter: board private structure
+ *
+ * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task() will explicitly
+ * request and refresh ethtool stats
+ **/
+void iavf_schedule_request_stats(struct iavf_adapter *adapter)
+{
+	adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
+	mod_delayed_work(iavf_wq, &adapter->watchdog_task, 0);
+}
+
 /**
  * iavf_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
@@ -1700,6 +1713,11 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_del_adv_rss_cfg(adapter);
 		return 0;
 	}
+	if (adapter->aq_required & IAVF_FLAG_AQ_REQUEST_STATS) {
+		iavf_request_stats(adapter);
+		return 0;
+	}
+
 	return -EAGAIN;
 }
 
-- 
2.27.0

