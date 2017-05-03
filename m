From: Gangfeng <gangfeng.huang@ni.com>
Date: Wed, 3 May 2017 09:20:09 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Fix error that repeat to add filter
	when changing adapter speed
Message-ID: <1493774409-7536-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Gangfeng Huang <gangfeng.huang@ni.com>

Function igb_nfc_filter_exit()/igb_nfc_filter_restore() should be paried,
igb_nfc_filter_restore exist in igb_up(), but igb_nfc_filter_exit() exist
in __igb_close(), so move the igb_nfc_filter_exit() to igb_down().

Signed-off-by: Gangfeng <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 8f624af..e01e01a 100644
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

