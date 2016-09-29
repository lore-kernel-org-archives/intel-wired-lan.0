From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Thu, 29 Sep 2016 10:11:33 -0700
Subject: [Intel-wired-lan] [next PATCH S49 13/15] i40e: use a mutex instead
	of spinlock in PTP user entry points
In-Reply-To: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
References: <1475169095-20873-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1475169095-20873-14-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

We need a locking mechanism to protect the hardware SYSTIME register
which is split over 2 values, and has internal hardware latching. We
can't allow multiple accesses at the same time. However....

The spinlock_t is overkill here, especially use of spin_lock_irqsave,
since every PTP access will halt hardirqs. Notice that the only places
which need the SYSTIME value are user context and are capable of sleeping.
Thus, it is safe to use a mutex here instead of the spinlock.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I971761a89b58c6aad953590162e85a327fbba232
---
Testing-hints:
  Suggested by Alex after seeing that the code flows don't take the lock
  in irq context. Not sure how to test this directly, but should ensure
  that PTP functionality remains unchanged, and that driver
  functionality remains consistent especially when using PTP software.

 drivers/net/ethernet/intel/i40e/i40e.h     |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 20 +++++++-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 1d9a6b9..f7f32aa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -430,7 +430,7 @@ struct i40e_pf {
 	struct sk_buff *ptp_tx_skb;
 	struct hwtstamp_config tstamp_config;
 	unsigned long last_rx_ptp_check;
-	spinlock_t tmreg_lock; /* Used to protect the device time registers. */
+	struct mutex tmreg_lock; /* Used to protect the SYSTIME registers. */
 	u64 ptp_base_adj;
 	u32 tx_hwtstamp_timeouts;
 	u32 rx_hwtstamp_cleared;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f1fecea..177b7fb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -159,16 +159,15 @@ static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
 	struct timespec64 now, then;
-	unsigned long flags;
 
 	then = ns_to_timespec64(delta);
-	spin_lock_irqsave(&pf->tmreg_lock, flags);
+	mutex_lock(&pf->tmreg_lock);
 
 	i40e_ptp_read(pf, &now);
 	now = timespec64_add(now, then);
 	i40e_ptp_write(pf, (const struct timespec64 *)&now);
 
-	spin_unlock_irqrestore(&pf->tmreg_lock, flags);
+	mutex_unlock(&pf->tmreg_lock);
 
 	return 0;
 }
@@ -184,11 +183,10 @@ static int i40e_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static int i40e_ptp_gettime(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	unsigned long flags;
 
-	spin_lock_irqsave(&pf->tmreg_lock, flags);
+	mutex_lock(&pf->tmreg_lock);
 	i40e_ptp_read(pf, ts);
-	spin_unlock_irqrestore(&pf->tmreg_lock, flags);
+	mutex_unlock(&pf->tmreg_lock);
 
 	return 0;
 }
@@ -205,11 +203,10 @@ static int i40e_ptp_settime(struct ptp_clock_info *ptp,
 			    const struct timespec64 *ts)
 {
 	struct i40e_pf *pf = container_of(ptp, struct i40e_pf, ptp_caps);
-	unsigned long flags;
 
-	spin_lock_irqsave(&pf->tmreg_lock, flags);
+	mutex_lock(&pf->tmreg_lock);
 	i40e_ptp_write(pf, ts);
-	spin_unlock_irqrestore(&pf->tmreg_lock, flags);
+	mutex_unlock(&pf->tmreg_lock);
 
 	return 0;
 }
@@ -658,10 +655,7 @@ void i40e_ptp_init(struct i40e_pf *pf)
 		return;
 	}
 
-	/* we have to initialize the lock first, since we can't control
-	 * when the user will enter the PHC device entry points
-	 */
-	spin_lock_init(&pf->tmreg_lock);
+	mutex_init(&pf->tmreg_lock);
 
 	/* ensure we have a clock device */
 	err = i40e_ptp_create_clock(pf);
-- 
2.4.11

