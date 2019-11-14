From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:45:05 -0800
Subject: [Intel-wired-lan] [PATCH net 11/13] igb: Reject requests that fail
 to enable time stamping on both edges.
Message-ID: <20191114184507.18937-12-richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This hardware always time stamps rising and falling edges, and so this
patch validates that the request does contains both edges.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 3fd60715bca7..c39e921757ba 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -528,6 +528,12 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
 					PTP_STRICT_FLAGS))
 			return -EOPNOTSUPP;
 
+		/* Reject requests failing to enable both edges. */
+		if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
+		    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
+		    (rq->extts.flags & PTP_EXTTS_EDGES) != PTP_EXTTS_EDGES)
+			return -EOPNOTSUPP;
+
 		if (on) {
 			pin = ptp_find_pin(igb->ptp_clock, PTP_PF_EXTTS,
 					   rq->extts.index);
-- 
2.20.1

