From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Wed, 17 Feb 2021 20:21:19 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix inconsistent indenting
Message-ID: <20210217202119.228020-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed new static analysis findings:
"warn: inconsistent indenting" - introduced lately,
reported with lkp and smatch build.

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 65fed08..c517209 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6739,9 +6739,9 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 			set_bit(__I40E_CLIENT_SERVICE_REQUESTED, pf->state);
 			set_bit(__I40E_CLIENT_L2_CHANGE, pf->state);
 		}
-	/* registers are set, lets apply */
-	if (pf->hw_features & I40E_HW_USE_SET_LLDP_MIB)
-		ret = i40e_hw_set_dcb_config(pf, new_cfg);
+		/* registers are set, lets apply */
+		if (pf->hw_features & I40E_HW_USE_SET_LLDP_MIB)
+			ret = i40e_hw_set_dcb_config(pf, new_cfg);
 	}
 
 err:
@@ -10594,7 +10594,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 			i40e_aq_set_dcb_parameters(hw, false, NULL);
 			dev_warn(&pf->pdev->dev,
 				 "DCB is not supported for X710-T*L 2.5/5G speeds\n");
-				 pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
 		} else {
 			i40e_aq_set_dcb_parameters(hw, true, NULL);
 			ret = i40e_init_pf_dcb(pf);

base-commit: b24edd0ad20365ec6d3ed342b58f65a2eaa7eded
-- 
2.18.4

