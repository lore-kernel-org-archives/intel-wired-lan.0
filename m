From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 28 Jul 2020 16:37:52 -0700
Subject: [Intel-wired-lan] [PATCH 2/4] igc: Don't reschedule ptp_tx work
In-Reply-To: <20200728233754.65747-1-andre.guedes@intel.com>
References: <20200728233754.65747-1-andre.guedes@intel.com>
Message-ID: <20200728233754.65747-3-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ptp_tx work is scheduled only if TSICR.TXTS bit is set, therefore
TSYNCTXCTL.TXTT_0 bit is expected to be set when we check it igc_ptp_tx_
work(). If it isn't, something is really off and rescheduling the ptp_tx
work to check it later doesn't help much. This patch changes the code to
WARN_ON_ONCE() if this situation ever happens.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 79802fb4ea83..b912830ea7bb 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -410,11 +410,10 @@ static void igc_ptp_tx_work(struct work_struct *work)
 	}
 
 	tsynctxctl = rd32(IGC_TSYNCTXCTL);
-	if (tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)
-		igc_ptp_tx_hwtstamp(adapter);
-	else
-		/* reschedule to check later */
-		schedule_work(&adapter->ptp_tx_work);
+	if (WARN_ON_ONCE(!(tsynctxctl & IGC_TSYNCTXCTL_TXTT_0)))
+		return;
+
+	igc_ptp_tx_hwtstamp(adapter);
 }
 
 /**
-- 
2.26.2

