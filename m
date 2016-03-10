From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:46 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 08/13] i40e: Notify VFs of all
	resets
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-9-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Notify VFs in the reset interrupt handler, instead of the actual
reset initiation code. This allows the VFs to get properly notified for
all resets, including resets initiated by different PFs on the same
physical device.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 298a73c..b42303c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5512,8 +5512,6 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags)
 
 	WARN_ON(in_interrupt());
 
-	if (i40e_check_asq_alive(&pf->hw))
-		i40e_vc_notify_reset(pf);
 
 	/* do the biggest reset indicated */
 	if (reset_flags & BIT_ULL(__I40E_GLOBAL_RESET_REQUESTED)) {
@@ -6715,6 +6713,8 @@ static void i40e_prep_for_reset(struct i40e_pf *pf)
 	clear_bit(__I40E_RESET_INTR_RECEIVED, &pf->state);
 	if (test_and_set_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state))
 		return;
+	if (i40e_check_asq_alive(&pf->hw))
+		i40e_vc_notify_reset(pf);
 
 	dev_dbg(&pf->pdev->dev, "Tearing down internal switch for reset\n");
 
-- 
2.4.3

