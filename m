From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 28 Jul 2020 16:37:53 -0700
Subject: [Intel-wired-lan] [PATCH 3/4] igc: Remove timeout check from ptp_tx
 work
In-Reply-To: <20200728233754.65747-1-andre.guedes@intel.com>
References: <20200728233754.65747-1-andre.guedes@intel.com>
Message-ID: <20200728233754.65747-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The tx timestamp timeout is already checked by the watchdog_task work
which runs periodically. In addition to that, from the ptp_tx work
perspective, if __IGC_PTP_TX_IN_PROGRESS flag is set we always want
handle the timestamp stored in hardware and update the skb. So this
patch removes the timeout check in igc_ptp_tx_work() function.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index b912830ea7bb..22b2cf80b22f 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -403,12 +403,6 @@ static void igc_ptp_tx_work(struct work_struct *work)
 	if (!test_bit(__IGC_PTP_TX_IN_PROGRESS, &adapter->state))
 		return;
 
-	if (time_is_before_jiffies(adapter->ptp_tx_start +
-				   IGC_PTP_TX_TIMEOUT)) {
-		igc_ptp_tx_timeout(adapter);
-		return;
-	}
-
 	tsynctxctl = rd32(IGC_TSYNCTXCTL);
 	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
 		return;
-- 
2.26.2

