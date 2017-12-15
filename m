From: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Date: Fri, 15 Dec 2017 13:08:36 +0530
Subject: [Intel-wired-lan] [PATCH 21/27] igb: Use timecounter_reset interface
In-Reply-To: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <1513323522-15021-22-git-send-email-sagar.a.kamble@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With new interface timecounter_reset we can update the start time for
timecounter. Update igb_ptp_settime_82576 with this new function.

Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index f6c1a8d..90344b2 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -330,7 +330,7 @@ static int igb_ptp_settime_82576(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&igb->tmreg_lock, flags);
 
-	timecounter_init(&igb->tc, ns);
+	timecounter_reset(&igb->tc, ns);
 
 	spin_unlock_irqrestore(&igb->tmreg_lock, flags);
 
-- 
1.9.1

