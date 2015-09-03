From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:55 -0400
Subject: [Intel-wired-lan] [next PATCH S15 08/15] i40e: allow FD SB if MFP
	mode only has 1 partition
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Even though the device might be in MFP mode, if there's only one partition
enabled, then we still have plenty of interrupts for managing the Flow
Directory Sideband activity.  This patch enables FD SB in this case.
This patch also reverses the sense of the conditional in order to remove
the negative logic.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I9edf211a6219fc8d159b4be9964f9fd7f4e00bc0
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dd04b61..6a28c04 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8061,12 +8061,12 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		pf->flags |= I40E_FLAG_FD_ATR_ENABLED;
 		pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		if (!(pf->flags & I40E_FLAG_MFP_ENABLED)) {
-			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
-		} else {
+		if (pf->flags & I40E_FLAG_MFP_ENABLED &&
+		    pf->hw.num_partitions > 1)
 			dev_info(&pf->pdev->dev,
 				 "Flow Director Sideband mode Disabled in MFP mode\n");
-		}
+		else
+			pf->flags |= I40E_FLAG_FD_SB_ENABLED;
 		pf->fdir_pf_filter_count =
 				 pf->hw.func_caps.fd_filters_guaranteed;
 		pf->hw.fdir_shared_filter_count =
-- 
1.9.3

