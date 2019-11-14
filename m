From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:45:04 -0800
Subject: [Intel-wired-lan] [PATCH net 10/13] dp83640: Reject requests to
 enable time stamping on both edges.
Message-ID: <20191114184507.18937-11-richardcochran@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This driver enables rising edge or falling edge, but not both, and so
this patch validates that the request contains only one of the two
edges.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/phy/dp83640.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 3bba2bea3a88..8f241b57fcf6 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -475,6 +475,13 @@ static int ptp_dp83640_enable(struct ptp_clock_info *ptp,
 					PTP_FALLING_EDGE |
 					PTP_STRICT_FLAGS))
 			return -EOPNOTSUPP;
+
+		/* Reject requests to enable time stamping on both edges. */
+		if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
+		    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
+		    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+			return -EOPNOTSUPP;
+
 		index = rq->extts.index;
 		if (index >= N_EXT_TS)
 			return -EINVAL;
-- 
2.20.1

