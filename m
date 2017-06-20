From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Jun 2017 15:16:56 -0700
Subject: [Intel-wired-lan] [next PATCH S73-V2 4/9] i40e: fix up 32 bit
	timespec references
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170620221701.46765-4-jeffrey.t.kirsher@intel.com>
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
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 1a0be83..0129ed3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -158,13 +158,12 @@ static int i40e_ptp_adjfreq(struct ptp_clock_info *ptp, s32 ppb)
 static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	struct timespec64 now, then;
+	struct timespec64 now;
 
-	then = ns_to_timespec64(delta);
 	mutex_lock(&pf->tmreg_lock);
 
 	i40e_ptp_read(pf, &now);
-	now = timespec64_add(now, then);
+	timespec64_add_ns(&now, delta);
 	i40e_ptp_write(pf, (const struct timespec64 *)&now);
 
 	mutex_unlock(&pf->tmreg_lock);
-- 
2.9.3

