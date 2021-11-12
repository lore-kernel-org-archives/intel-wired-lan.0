From: Karol Kolacinski <karol.kolacinski@intel.com>
Date: Fri, 12 Nov 2021 14:53:59 +0100
Subject: [Intel-wired-lan] [PATCH intel-next] ice: Don't put stale
 timestamps in the skb
Message-ID: <20211112135359.155502-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver has to check if it does not accidentally put the timestamp in
the SKB before previous timestamp gets overwritten.
Timestamp values in the PHY are read only and do not get cleared except
at hardware reset or when a new timestamp value is captured.
The cached_tstamp field is used to detect the case where a new timestamp
has not yet been captured, ensuring that we avoid sending stale
timestamp data to the stack.
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 11 ++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  6 ++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2b3b2060b504..9a1a09661c78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2069,19 +2069,16 @@ static void ice_ptp_tx_tstamp_work(struct kthread_work *work)
 		if (err)
 			continue;
 
-		/* Check if the timestamp is valid */
-		if (!(raw_tstamp & ICE_PTP_TS_VALID))
+		/* Check if the timestamp is invalid or stale */
+		if (!(raw_tstamp & ICE_PTP_TS_VALID) ||
+		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
 			continue;
 
-		/* clear the timestamp register, so that it won't show valid
-		 * again when re-used.
-		 */
-		ice_clear_phy_tstamp(hw, tx->quad, phy_idx);
-
 		/* The timestamp is valid, so we'll go ahead and clear this
 		 * index and then send the timestamp up to the stack.
 		 */
 		spin_lock(&tx->lock);
+		tx->tstamps[idx].cached_tstamp = raw_tstamp;
 		clear_bit(idx, tx->in_use);
 		skb = tx->tstamps[idx].skb;
 		tx->tstamps[idx].skb = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 92b202ef3c15..eef8ec894871 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -55,15 +55,21 @@ struct ice_perout_channel {
  * struct ice_tx_tstamp - Tracking for a single Tx timestamp
  * @skb: pointer to the SKB for this timestamp request
  * @start: jiffies when the timestamp was first requested
+ * @cached_tstamp: last read timestamp
  *
  * This structure tracks a single timestamp request. The SKB pointer is
  * provided when initiating a request. The start time is used to ensure that
  * we discard old requests that were not fulfilled within a 2 second time
  * window.
+ * Timestamp values in the PHY are read only and do not get cleared except at
+ * hardware reset or when a new timestamp value is captured. The cached_tstamp
+ * field is used to detect the case where a new timestamp has not yet been
+ * captured, ensuring that we avoid sending stale timestamp data to the stack.
  */
 struct ice_tx_tstamp {
 	struct sk_buff *skb;
 	unsigned long start;
+	u64 cached_tstamp;
 };
 
 /**
-- 
2.32.0

