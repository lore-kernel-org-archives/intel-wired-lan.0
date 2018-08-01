From: JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>
Date: Wed, 1 Aug 2018 07:29:34 +0000
Subject: [Intel-wired-lan] [E1000-devel] [PATCH] igb: CPU0 latency and
 updating statistics
Message-ID: <1533108587.16601.56.camel@atviedlbe741.rss.d3s.at.thales>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The Watchdog workqueue in igb driver is scheduled every 2s for each 
network interface. That includes updating a statistics protected by 
spinlock. Function igb_update_stats in this case will be protected 
against preemption. According to number of a statistics registers 
(cca 60), processing this function might cause additional cpu load
 on CPU0.

In case of statistics spinlock may be replaced with mutex, which 
reduce latency on CPU0.


# Measurements
Measurements were performed on Intel Atom E3950 (Quad-Core), 
E3930 (Dual-Core)

# Cyclictest
High latency is always on CPU0 which might be in range 
from 70us to 140us (sometimes higher)


# cyclictest -l1000000 -Smp90 -i200 -q

# E3930
# default
T: 0 ( 1745) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 72
T: 1 ( 1746) P:90 I:700 C: 285737 Min: 3 Act: 4 Avg: 3 Max: 13

# with patch
T: 0 (  932) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 22
T: 1 (  933) P:90 I:700 C: 285736 Min: 2 Act: 3 Avg: 3 Max: 12


# E3950
# default
T: 0 ( 1103) P:90 I:200 C:1000000 Min: 2 Act: 2 Avg: 2 Max: 89
T: 1 ( 1104) P:90 I:700 C: 285738 Min: 2 Act: 4 Avg: 2 Max: 9
T: 2 ( 1105) P:90 I:1200 C: 166678 Min: 2 Act: 5 Avg: 3 Max: 22
T: 3 ( 1106) P:90 I:1700 C: 117653 Min: 2 Act: 6 Avg: 2 Max: 13

# with patch
T: 0 (  879) P:90 I:200 C:1000000 Min: 2 Act: 3 Avg: 3 Max: 26
T: 1 (  880) P:90 I:700 C: 285729 Min: 3 Act: 4 Avg: 3 Max: 22
T: 2 (  881) P:90 I:1200 C: 166672 Min: 3 Act: 7 Avg: 3 Max: 24
T: 3 (  882) P:90 I:1700 C: 117649 Min: 3 Act: 7 Avg: 3 Max: 8


Additionally I think updating statistics and watchdog task should 
be implemented in 2 separated ways

Patch is created against a linux-4.4

Reviewed also by: Bernhard Kaindl  <bernhard.kaindl@thalesgroup.com>

Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c    | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h
b/drivers/net/ethernet/intel/igb/igb.h
index e3cb93b..85d68ea 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -401,7 +401,7 @@ struct igb_adapter {
 	/* OS defined structs */
 	struct pci_dev *pdev;
 
-	spinlock_t stats64_lock;
+	struct mutex stats64_lock;
 	struct rtnl_link_stats64 stats64;
 
 	/* structs defined in e1000_hw.h */
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c
b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 2529bc6..07cc2b6 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2276,7 +2276,7 @@ static void igb_get_ethtool_stats(struct
net_device *netdev,
 	int i, j;
 	char *p;
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter, net_stats);
 
 	for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++) {
@@ -2319,7 +2319,7 @@ static void igb_get_ethtool_stats(struct
net_device *netdev,
 		} while (u64_stats_fetch_retry_irq(&ring->rx_syncp, start));
 		i += IGB_RX_QUEUE_STATS_LEN;
 	}
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 }
 
 static void igb_get_strings(struct net_device *netdev, u32 stringset,
u8 *data)
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
b/drivers/net/ethernet/intel/igb/igb_main.c
index 02b23f6..9d22398 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1810,9 +1810,9 @@ void igb_down(struct igb_adapter *adapter)
 	del_timer_sync(&adapter->phy_info_timer);
 
 	/* record the stats before reset*/
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter, &adapter->stats64);
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 
 	adapter->link_speed = 0;
 	adapter->link_duplex = 0;
@@ -2975,7 +2975,7 @@ static int igb_sw_init(struct igb_adapter
*adapter)
 				  VLAN_HLEN;
 	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
 
-	spin_lock_init(&adapter->stats64_lock);
+	mutex_init(&adapter->stats64_lock);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -4367,9 +4367,9 @@ static void igb_watchdog_task(struct work_struct
*work)
 		}
 	}
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter, &adapter->stats64);
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igb_ring *tx_ring = adapter->tx_ring[i];
@@ -5152,10 +5152,10 @@ static struct rtnl_link_stats64
*igb_get_stats64(struct net_device *netdev,
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
-	spin_lock(&adapter->stats64_lock);
+	mutex_lock(&adapter->stats64_lock);
 	igb_update_stats(adapter, &adapter->stats64);
 	memcpy(stats, &adapter->stats64, sizeof(*stats));
-	spin_unlock(&adapter->stats64_lock);
+	mutex_unlock(&adapter->stats64_lock);
 
 	return stats;
 }
