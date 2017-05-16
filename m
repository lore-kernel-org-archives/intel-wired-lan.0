From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 16 May 2017 15:55:16 -0700
Subject: [Intel-wired-lan] [next-queue v2] igb: Remove useless argument
Message-ID: <20170516225516.65557-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Benjamin Poirier <bpoirier@suse.com>

Given that all callers of igb_update_stats() pass the same two arguments:
(adapter, &adapter->stats64), the second argument can be removed.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/igb/igb.h         |    2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
 drivers/net/ethernet/intel/igb/igb_main.c    |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index ff4d9073781a..06ffb2bc713e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -667,7 +667,7 @@ void igb_setup_tctl(struct igb_adapter *);
 void igb_setup_rctl(struct igb_adapter *);
 netdev_tx_t igb_xmit_frame_ring(struct sk_buff *, struct igb_ring *);
 void igb_alloc_rx_buffers(struct igb_ring *, u16);
-void igb_update_stats(struct igb_adapter *, struct rtnl_link_stats64 *);
+void igb_update_stats(struct igb_adapter *);
 bool igb_has_link(struct igb_adapter *adapter);
 void igb_set_ethtool_ops(struct net_device *);
 void igb_power_up_link(struct igb_adapter *);
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 8730f7cbce68..d06a8db514d4 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2316,7 +2316,7 @@ static void igb_get_ethtool_stats(struct net_device *netdev,
 	char *p;
 
 	spin_lock(&adapter->stats64_lock);
-	igb_update_stats(adapter, net_stats);
+	igb_update_stats(adapter);
 
 	for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++) {
 		p = (char *)adapter + igb_gstrings_stats[i].stat_offset;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8f624af3fa47..64fd23045e0c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1818,7 +1818,7 @@ void igb_down(struct igb_adapter *adapter)
 
 	/* record the stats before reset*/
 	spin_lock(&adapter->stats64_lock);
-	igb_update_stats(adapter, &adapter->stats64);
+	igb_update_stats(adapter);
 	spin_unlock(&adapter->stats64_lock);
 
 	adapter->link_speed = 0;
@@ -4686,7 +4686,7 @@ static void igb_watchdog_task(struct work_struct *work)
 	}
 
 	spin_lock(&adapter->stats64_lock);
-	igb_update_stats(adapter, &adapter->stats64);
+	igb_update_stats(adapter);
 	spin_unlock(&adapter->stats64_lock);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
@@ -5499,7 +5499,7 @@ static void igb_get_stats64(struct net_device *netdev,
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
 	spin_lock(&adapter->stats64_lock);
-	igb_update_stats(adapter, &adapter->stats64);
+	igb_update_stats(adapter);
 	memcpy(stats, &adapter->stats64, sizeof(*stats));
 	spin_unlock(&adapter->stats64_lock);
 }
@@ -5548,9 +5548,9 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
  *  igb_update_stats - Update the board statistics counters
  *  @adapter: board private structure
  **/
-void igb_update_stats(struct igb_adapter *adapter,
-		      struct rtnl_link_stats64 *net_stats)
+void igb_update_stats(struct igb_adapter *adapter)
 {
+	struct rtnl_link_stats64 *net_stats = &adapter->stats64;
 	struct e1000_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
 	u32 reg, mpc;
