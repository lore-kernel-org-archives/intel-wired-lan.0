From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:22 -0700
Subject: [Intel-wired-lan] [next PATCH S35 02/14] i40e: Fix up 32 bit
	timespec references
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-3-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

As it turns out there was only a small set of errors
on 32 bit, and we just needed to be using the right calls
for dealing with timespec64 variables.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: I307345bf658b34a1d573f4f4263fe9ba2fa72051
---
Testing Hints : build tests, test PTP works.

 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index a1b878a..a5a6d2d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -158,14 +158,13 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	struct timespec64 now, then;
+	struct timespec64 now;
 	unsigned long flags;
 
-	then = ns_to_timespec64(delta);
 	spin_lock_irqsave(&pf->tmreg_lock, flags);
 
 	i40e_ptp_read(pf, &now);
-	now = timespec64_add(now, then);
+	timespec64_add_ns(&now, delta);
 	i40e_ptp_write(pf, (const struct timespec64 *)&now);
 
 	spin_unlock_irqrestore(&pf->tmreg_lock, flags);
-- 
2.4.3

