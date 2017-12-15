From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Date: Fri, 15 Dec 2017 13:08:35 +0530
Subject: [Intel-wired-lan] [PATCH 20/27] e1000e: Use timecounter_reset
 interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-21-git-send-email-sagar.a.kamble@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With new interface timecounter_reset we can update the start time for
timecounter. Update e1000e_phc_settime with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/intel/e1000e/ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 03d5f2a..5b368aa 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -222,7 +222,7 @@ static int e1000e_phc_settime(struct ptp_clock_info *ptp,
 
 	/* reset the timecounter */
 	spin_lock_irqsave(&adapter->systim_lock, flags);
-	timecounter_init(&adapter->tc, ns);
+	timecounter_reset(&adapter->tc, ns);
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	return 0;
-- 
1.9.1

