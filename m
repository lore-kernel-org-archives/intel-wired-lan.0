From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:50 -0700
Subject: [Intel-wired-lan] [next PATCH S9 2/7] i40e: use ktime_get_real_ts64
 instead of ktime_to_timespec64
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Remove a call to ktime_to_timespec64 by calling ktime_get_real_ts64
directly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 11394a52e21c..9bf1ad4319f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -725,7 +725,7 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	pf->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 
 	/* Set the previous "reset" time to the current Kernel clock time */
-	pf->ptp_prev_hw_time = ktime_to_timespec64(ktime_get_real());
+	ktime_get_real_ts64(&pf->ptp_prev_hw_time);
 	pf->ptp_reset_start = ktime_get();
 
 	return 0;
-- 
2.21.0

