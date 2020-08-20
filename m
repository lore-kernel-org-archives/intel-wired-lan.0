From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 20 Aug 2020 16:02:16 -0700
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/2] igc: Remove references
 to SYSTIMR register
Message-ID: <20200820230217.2005122-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In i225, it's no longer necessary to use the SYSTIMR register to
latch the timer value, the timestamp is latched when SYSTIML is read.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index a841ac1088aa..d1c01fd6f5cc 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -22,11 +22,7 @@ static void igc_ptp_read_i225(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 	u32 sec, nsec;
 
-	/* The timestamp latches on lowest register read. For I210/I211, the
-	 * lowest register is SYSTIMR. Since we only need to provide nanosecond
-	 * resolution, we can ignore it.
-	 */
-	rd32(IGC_SYSTIMR);
+	/* The timestamp is latched when SYSTIML is read. */
 	nsec = rd32(IGC_SYSTIML);
 	sec = rd32(IGC_SYSTIMH);
 
@@ -39,9 +35,6 @@ static void igc_ptp_write_i225(struct igc_adapter *adapter,
 {
 	struct igc_hw *hw = &adapter->hw;
 
-	/* Writing the SYSTIMR register is not necessary as it only
-	 * provides sub-nanosecond resolution.
-	 */
 	wr32(IGC_SYSTIML, ts->tv_nsec);
 	wr32(IGC_SYSTIMH, ts->tv_sec);
 }
@@ -102,10 +95,9 @@ static int igc_ptp_gettimex64_i225(struct ptp_clock_info *ptp,
 	spin_lock_irqsave(&igc->tmreg_lock, flags);
 
 	ptp_read_system_prets(sts);
-	rd32(IGC_SYSTIMR);
-	ptp_read_system_postts(sts);
 	ts->tv_nsec = rd32(IGC_SYSTIML);
 	ts->tv_sec = rd32(IGC_SYSTIMH);
+	ptp_read_system_postts(sts);
 
 	spin_unlock_irqrestore(&igc->tmreg_lock, flags);
 
-- 
2.28.0

