From: Colin King <colin.king@canonical.com>
Date: Sun, 29 Aug 2021 17:51:50 +0100
Subject: [Intel-wired-lan] [PATCH][next] igc: remove redundant continue
 statement
Message-ID: <20210829165150.531678-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The continue statement at the end of a for-loop has no effect,
remove it.

Addresses-Coverity: ("Continue has no effect")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 0f021909b430..b615a980f563 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -860,7 +860,6 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 			 * so write the previous error status to clear it.
 			 */
 			wr32(IGC_PTM_STAT, stat);
-			continue;
 		}
 	} while (--count);
 
-- 
2.32.0

