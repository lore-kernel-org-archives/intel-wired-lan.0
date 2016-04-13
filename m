From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:28 -0700
Subject: [Intel-wired-lan] [next PATCH S34 08/12] i40e: ptp - avoid
	aggregate return warnings
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-9-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Aggregate return warnings are when struct types are returned
and must be copied to the lvalue with a struct copy by the compiler.

This fixes warnings of type aggregate-return from gcc with W=2.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: I896b1bf514544bf0faeb458869d79914b9f1b168
---
Testing Hints: make sure PTP still works,
as it should because this code makes no functional change

 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 565ca7c..a1b878a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -158,9 +158,10 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	struct timespec64 now, then = ns_to_timespec64(delta);
+	struct timespec64 now, then;
 	unsigned long flags;
 
+	then = ns_to_timespec64(delta);
 	spin_lock_irqsave(&pf->tmreg_lock, flags);
 
 	i40e_ptp_read(pf, &now);
-- 
2.4.3

