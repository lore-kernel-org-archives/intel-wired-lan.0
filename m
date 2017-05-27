From: Gangfeng <gangfeng.huang@ni.com>
Date: Sat, 27 May 2017 09:17:53 +0800
Subject: [Intel-wired-lan] [PATCH v2] igb: Fix error of RX network flow
	classification
Message-ID: <1495847873-845-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Gangfeng Huang <gangfeng.huang@ni.com>

After add an ethertype filter, if user change the adapter speed several
times, the error "ethtool -N: etype filters are all used" is reported by
igb driver.

In older patch, function igb_nfc_filter_exit() and igb_nfc_filter_restore()
is not paried. igb_nfc_filter_restore() exist in igb_up(), but function
igb_nfc_filter_exit() is exist in __igb_close(). In the process of speed
changing, only igb_nfc_filter_restore() is called, it will take a position
of ethertype bitmap.

Reproduce steps:
Step 1: Add a etype filter by ethtool
$ethtool -N eth0 flow-type ether proto 0x88F8 action 1
Step 2: Change the adapter speed to 100M/full duplex
$ethtool -s eth0 speed 100 duplex full
Step 3: Change the adapter speed to 1000M/full duplex
ethtool -s eth0 speed 1000 duplex full
Repeat step2 and step3, then dmesg the system log, you can find the error
message, add new ethtype filter is also failed.

This fixing is move igb_nfc_filter_exit() from __igb_close() to igb_down()
to make igb_nfc_filter_restore()/igb_nfc_filter_exit() is paired.

Signed-off-by: Gangfeng <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 64fd230..d834765 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1791,6 +1791,8 @@ void igb_down(struct igb_adapter *adapter)
 	wr32(E1000_RCTL, rctl & ~E1000_RCTL_EN);
 	/* flush and sleep below */
 
+	igb_nfc_filter_exit(adapter);
+
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
@@ -3317,8 +3319,6 @@ static int __igb_close(struct net_device *netdev, bool suspending)
 	igb_down(adapter);
 	igb_free_irq(adapter);
 
-	igb_nfc_filter_exit(adapter);
-
 	igb_free_all_tx_resources(adapter);
 	igb_free_all_rx_resources(adapter);
 
-- 
2.7.2

