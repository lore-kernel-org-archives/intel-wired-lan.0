From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:41 -0400
Subject: [Intel-wired-lan] [next PATCH S8 08/12] i40e: Remove function
 i40e_update_dcb_config()
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Grzegorz Siwik <grzegorz.siwik@intel.com>

This patch removes function i40e_update_dcb_config(). Instead of
i40e_update_dcb_config() we use i40e_init_dcb(), which implements the
correct nvm read.

Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 46 +--------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5c280c025085..8d6b9515b595 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6419,50 +6419,6 @@ static int i40e_resume_port_tx(struct i40e_pf *pf)
 	return ret;
 }
 
-/**
- * i40e_update_dcb_config
- * @hw: pointer to the HW struct
- * @enable_mib_change: enable MIB change event
- *
- * Update DCB configuration from the firmware
- **/
-static enum i40e_status_code
-i40e_update_dcb_config(struct i40e_hw *hw, bool enable_mib_change)
-{
-	struct i40e_lldp_variables lldp_cfg;
-	i40e_status ret;
-
-	if (!hw->func_caps.dcb)
-		return I40E_NOT_SUPPORTED;
-
-	/* Read LLDP NVM area */
-	ret = i40e_read_lldp_cfg(hw, &lldp_cfg);
-	if (ret)
-		return I40E_ERR_NOT_READY;
-
-	/* Get DCBX status */
-	ret = i40e_get_dcbx_status(hw, &hw->dcbx_status);
-	if (ret)
-		return ret;
-
-	/* Check the DCBX Status */
-	if (hw->dcbx_status == I40E_DCBX_STATUS_DONE ||
-	    hw->dcbx_status == I40E_DCBX_STATUS_IN_PROGRESS) {
-		/* Get current DCBX configuration */
-		ret = i40e_get_dcb_config(hw);
-		if (ret)
-			return ret;
-	} else if (hw->dcbx_status == I40E_DCBX_STATUS_DISABLED) {
-		return I40E_ERR_NOT_READY;
-	}
-
-	/* Configure the LLDP MIB change event */
-	if (enable_mib_change)
-		ret = i40e_aq_cfg_lldp_mib_change_event(hw, true, NULL);
-
-	return ret;
-}
-
 /**
  * i40e_init_pf_dcb - Initialize DCB configuration
  * @pf: PF being configured
@@ -6485,7 +6441,7 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 		goto out;
 	}
 
-	err = i40e_update_dcb_config(hw, true);
+	err = i40e_init_dcb(hw, true);
 	if (!err) {
 		/* Device/Function is not DCBX capable */
 		if ((!hw->func_caps.dcb) ||
-- 
2.21.0

