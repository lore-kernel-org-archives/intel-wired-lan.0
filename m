From: Richard Cochran <richardcochran@gmail.com>
Date: Tue,  8 Nov 2016 22:49:17 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ptp: igb: Use the high
	resolution frequency method.
In-Reply-To: <cover.1478526333.git.richardcochran@gmail.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
Message-ID: <b1d732324e0b1960b294e90ca5eb2a31b6559188.1478526333.git.richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 82580 and related devices offer a frequency resolution of about
0.029 ppb.  This patch lets users of the device benefit from the
increased frequency resolution when tuning the clock.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index a7895c4..c30eea8 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -226,7 +226,7 @@ static int igb_ptp_adjfreq_82576(struct ptp_clock_info *ptp, s32 ppb)
 	return 0;
 }
 
-static int igb_ptp_adjfreq_82580(struct ptp_clock_info *ptp, s32 ppb)
+static int igb_ptp_adjfine_82580(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct igb_adapter *igb = container_of(ptp, struct igb_adapter,
 					       ptp_caps);
@@ -235,13 +235,13 @@ static int igb_ptp_adjfreq_82580(struct ptp_clock_info *ptp, s32 ppb)
 	u64 rate;
 	u32 inca;
 
-	if (ppb < 0) {
+	if (scaled_ppm < 0) {
 		neg_adj = 1;
-		ppb = -ppb;
+		scaled_ppm = -scaled_ppm;
 	}
-	rate = ppb;
-	rate <<= 26;
-	rate = div_u64(rate, 1953125);
+	rate = scaled_ppm;
+	rate <<= 13;
+	rate = div_u64(rate, 15625);
 
 	inca = rate & INCVALUE_MASK;
 	if (neg_adj)
@@ -1103,7 +1103,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.max_adj = 62499999;
 		adapter->ptp_caps.n_ext_ts = 0;
 		adapter->ptp_caps.pps = 0;
-		adapter->ptp_caps.adjfreq = igb_ptp_adjfreq_82580;
+		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
 		adapter->ptp_caps.adjtime = igb_ptp_adjtime_82576;
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_82576;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_82576;
@@ -1131,7 +1131,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		adapter->ptp_caps.n_pins = IGB_N_SDP;
 		adapter->ptp_caps.pps = 1;
 		adapter->ptp_caps.pin_config = adapter->sdp_config;
-		adapter->ptp_caps.adjfreq = igb_ptp_adjfreq_82580;
+		adapter->ptp_caps.adjfine = igb_ptp_adjfine_82580;
 		adapter->ptp_caps.adjtime = igb_ptp_adjtime_i210;
 		adapter->ptp_caps.gettime64 = igb_ptp_gettime_i210;
 		adapter->ptp_caps.settime64 = igb_ptp_settime_i210;
-- 
2.1.4

