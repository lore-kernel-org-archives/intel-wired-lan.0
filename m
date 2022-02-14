From: trix@redhat.com <trix@redhat.com>
Date: Mon, 14 Feb 2022 06:33:27 -0800
Subject: [Intel-wired-lan] [PATCH] ice: check the return of
 ice_ptp_gettimex64
Message-ID: <20220214143327.2884183-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
time64.h:69:50: warning: The left operand of '+'
  is a garbage value
  set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
                                       ~~~~~~~~~~ ^
In ice_ptp_adjtime_nonatomic(), the timespec64 variable 'now'
is set by ice_ptp_gettimex64().  This function can fail
with -EBUSY, so 'now' can have a gargbage value.
So check the return.

Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810 devices")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ae291d442539..000c39d163a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1533,9 +1533,12 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 static int ice_ptp_adjtime_nonatomic(struct ptp_clock_info *info, s64 delta)
 {
 	struct timespec64 now, then;
+	int ret;
 
 	then = ns_to_timespec64(delta);
-	ice_ptp_gettimex64(info, &now, NULL);
+	ret = ice_ptp_gettimex64(info, &now, NULL);
+	if (ret)
+		return ret;
 	now = timespec64_add(now, then);
 
 	return ice_ptp_settime64(info, (const struct timespec64 *)&now);
-- 
2.26.3

