From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  2 Aug 2018 10:13:10 -0700
Subject: [Intel-wired-lan] [PATCH] igb: reduce CPU0 latency when updating
 statistics
Message-ID: <20180802171310.9295-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change is based off of the work and suggestion of Jan Jablonsky
<jan.jablonsky@thalesgroup.com>.

The Watchdog workqueue in igb driver is scheduled every 2s for each
network interface. That includes updating a statistics protected by
spinlock. Function igb_update_stats in this case will be protected
against preemption. According to number of a statistics registers
(cca 60), processing this function might cause additional cpu load
 on CPU0.

In case of statistics spinlock may be replaced with mutex, which
reduce latency on CPU0.

CC: Bernhard Kaindl  <bernhard.kaindl@thalesgroup.com>
CC: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c    | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index ca54e268d157..fe1592ae8769 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -515,7 +515,7 @@ struct igb_adapter {
 	/* OS defined structs */
 	struct pci_dev *pdev;
 
-	spinlock_t stats64_lock;
+	struct mutex stats64_lock;
 	struct rtnl_link_stats64 stats64;
 
 	/* structs defined in e1000_hw.h */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 5acf3b743876..e0a0e62b142a 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2295,7 +2295,7 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 	int i, j;
 	char *p;
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter);
 
 	for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++) {
@@ -2338,7 +2338,7 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
 		i += IGB_RX_QUEUE_STATS_LEN;
 	}
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 }
 
 static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ed4f073e7e0..3cca19dade84 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2209,9 +2209,9 @@ void igb_down(struct igb_adapter *adapter)
 	del_timer_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter);
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 
 	adapter->link_speed = 0;
 	adapter->link_duplex = 0;
@@ -3849,7 +3849,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
 	spin_lock_init(&adapter->nfc_lock);
-	spin_lock_init(&adapter->stats64_lock);
+	mutex_init(&adapter->stats64_lock);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -5414,9 +5414,9 @@ static void igb_watchdog_task(struct work_struct *work)
 		}
 	}
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter);
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igb_ring *tx_ring = adapter->tx_ring[i];
@@ -6242,10 +6242,10 @@ static void igb_get_stats64(struct net_device *netdev,
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter);
 	memcpy(stats, &adapter->stats64, sizeof(*stats));
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 }
 
 /**
-- 
2.17.1

