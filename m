From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:29 -0700
Subject: [Intel-wired-lan] [next PATCH S94 06/13] i40e: Limit initialization
 when going out of recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch limits adapter (re)initialization when going out
of recovery mode when the driver was initially loaded in
recovery mode and no SW initialization has been done.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d53938c..d7eeced 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9330,6 +9330,7 @@ static int i40e_reset(struct i40e_pf *pf)
  **/
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 {
+	int old_recovery_mode_bit = test_bit(__I40E_RECOVERY_MODE, pf->state);
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_hw *hw = &pf->hw;
 	u8 set_fc_aq_fail = 0;
@@ -9343,7 +9344,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 
 	if (test_bit(__I40E_DOWN, pf->state) &&
-	    !test_bit(__I40E_RECOVERY_MODE, pf->state))
+	    !test_bit(__I40E_RECOVERY_MODE, pf->state) &&
+	    !old_recovery_mode_bit)
 		goto clear_recovery;
 	dev_dbg(&pf->pdev->dev, "Rebuilding internal switch\n");
 
@@ -9373,7 +9375,8 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		i40e_verify_eeprom(pf);
 	}
 
-	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state) ||
+	    old_recovery_mode_bit) {
 		if (i40e_get_capabilities(pf,
 					  i40e_aqc_opc_list_func_capabilities))
 			goto end_unlock;
-- 
2.9.5

