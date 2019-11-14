From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 10:45:03 -0800
Subject: [Intel-wired-lan] [PATCH net 09/13] mv88e6xxx: Reject requests to
 enable time stamping on both edges.
Message-ID: <20191114184507.18937-10-richardcochran@gmail.com>
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
 drivers/net/dsa/mv88e6xxx/ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 3b1985902f95..d838c174dc0d 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -280,6 +280,12 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 				PTP_STRICT_FLAGS))
 		return -EOPNOTSUPP;
 
+	/* Reject requests to enable time stamping on both edges. */
+	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
+	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
+	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
 	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, rq->extts.index);
 
 	if (pin < 0)
-- 
2.20.1

