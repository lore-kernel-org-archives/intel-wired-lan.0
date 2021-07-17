From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Date: Sun, 18 Jul 2021 00:12:22 +0800
Subject: [Intel-wired-lan] [PATCH v2] igc: Increase timeout value for Speed
 100/1000/2500
Message-ID: <20210717161222.24288-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As the cycle time is set to maximum of 1s, the TX Hang timeout need to
be increase to avoid possible TX Hang.

There is no dedicated number specific in data sheet for the timeout factor.
Timeout factor was determined during the debugging to solve the "Tx Hang"
issues that happen in some cases mainly during ETF(Earliest TxTime First).

This can be test by using TSN Schedule Tx Tools udp_tai sample application.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Sasha Neftin <sasha.neftin@intel.com>

---

V1 -> V2: Add reason for the timeout factor

---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 4959078e111e..380e21e56398 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5321,7 +5321,9 @@ static void igc_watchdog_task(struct work_struct *work)
 				adapter->tx_timeout_factor = 14;
 				break;
 			case SPEED_100:
-				/* maybe add some timeout factor ? */
+			case SPEED_1000:
+			case SPEED_2500:
+				adapter->tx_timeout_factor = 7;
 				break;
 			}
 
-- 
2.17.1

