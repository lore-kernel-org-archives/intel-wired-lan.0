From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Sep 2018 02:04:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next] e1000: remove set but not used
 variable 'txb2b'
Message-ID: <1537409078-2374-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ethernet/intel/e1000/e1000_main.c: In function 'e1000_watchdog':
drivers/net/ethernet/intel/e1000/e1000_main.c:2436:9: warning:
 variable 'txb2b' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 7e0f1f9..43b6d3c 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2433,7 +2433,6 @@ static void e1000_watchdog(struct work_struct *work)
 	if (link) {
 		if (!netif_carrier_ok(netdev)) {
 			u32 ctrl;
-			bool txb2b = true;
 			/* update snapshot of PHY registers on LSC */
 			e1000_get_speed_and_duplex(hw,
 						   &adapter->link_speed,
@@ -2455,11 +2454,9 @@ static void e1000_watchdog(struct work_struct *work)
 			adapter->tx_timeout_factor = 1;
 			switch (adapter->link_speed) {
 			case SPEED_10:
-				txb2b = false;
 				adapter->tx_timeout_factor = 16;
 				break;
 			case SPEED_100:
-				txb2b = false;
 				/* maybe add some timeout factor ? */
 				break;
 			}

