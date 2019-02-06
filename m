From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 11:36:15 -0800
Subject: [Intel-wired-lan] [next PATCH S2 06/13] i40e: Update i40e_init_dcb
 to return correct error
In-Reply-To: <20190206193622.69370-1-alice.michael@intel.com>
References: <20190206193622.69370-1-alice.michael@intel.com>
Message-ID: <20190206193622.69370-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

Modify the i40e_init_dcb to return the correct error when LLDP or DCBX
is not in operational state.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c  | 28 ++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_dcb.h  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 56bff8faf371..292eeb3def10 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -863,22 +863,23 @@ i40e_status i40e_get_dcb_config(struct i40e_hw *hw)
 /**
  * i40e_init_dcb
  * @hw: pointer to the hw struct
+ * @enable_mib_change: enable mib change event
  *
  * Update DCB configuration from the Firmware
  **/
-i40e_status i40e_init_dcb(struct i40e_hw *hw)
+i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change)
 {
 	i40e_status ret = 0;
 	struct i40e_lldp_variables lldp_cfg;
 	u8 adminstatus = 0;
 
 	if (!hw->func_caps.dcb)
-		return ret;
+		return I40E_NOT_SUPPORTED;
 
 	/* Read LLDP NVM area */
 	ret = i40e_read_lldp_cfg(hw, &lldp_cfg);
 	if (ret)
-		return ret;
+		return I40E_ERR_NOT_READY;
 
 	/* Get the LLDP AdminStatus for the current port */
 	adminstatus = lldp_cfg.adminstatus >> (hw->port * 4);
@@ -887,7 +888,7 @@ i40e_status i40e_init_dcb(struct i40e_hw *hw)
 	/* LLDP agent disabled */
 	if (!adminstatus) {
 		hw->dcbx_status = I40E_DCBX_STATUS_DISABLED;
-		return ret;
+		return I40E_ERR_NOT_READY;
 	}
 
 	/* Get DCBX status */
@@ -896,26 +897,19 @@ i40e_status i40e_init_dcb(struct i40e_hw *hw)
 		return ret;
 
 	/* Check the DCBX Status */
-	switch (hw->dcbx_status) {
-	case I40E_DCBX_STATUS_DONE:
-	case I40E_DCBX_STATUS_IN_PROGRESS:
+	if (hw->dcbx_status == I40E_DCBX_STATUS_DONE ||
+	    hw->dcbx_status == I40E_DCBX_STATUS_IN_PROGRESS) {
 		/* Get current DCBX configuration */
 		ret = i40e_get_dcb_config(hw);
 		if (ret)
 			return ret;
-		break;
-	case I40E_DCBX_STATUS_DISABLED:
-		return ret;
-	case I40E_DCBX_STATUS_NOT_STARTED:
-	case I40E_DCBX_STATUS_MULTIPLE_PEERS:
-	default:
-		break;
+	} else if (hw->dcbx_status == I40E_DCBX_STATUS_DISABLED) {
+		return I40E_ERR_NOT_READY;
 	}
 
 	/* Configure the LLDP MIB change event */
-	ret = i40e_aq_cfg_lldp_mib_change_event(hw, true, NULL);
-	if (ret)
-		return ret;
+	if (enable_mib_change)
+		ret = i40e_aq_cfg_lldp_mib_change_event(hw, true, NULL);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 2b748a60a843..ddb48ae7cce4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -124,5 +124,5 @@ i40e_status i40e_aq_get_dcb_config(struct i40e_hw *hw, u8 mib_type,
 					     u8 bridgetype,
 					     struct i40e_dcbx_config *dcbcfg);
 i40e_status i40e_get_dcb_config(struct i40e_hw *hw);
-i40e_status i40e_init_dcb(struct i40e_hw *hw);
+i40e_status i40e_init_dcb(struct i40e_hw *hw, bool enable_mib_change);
 #endif /* _I40E_DCB_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 91796d2c6ac6..527a4b694f85 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6393,7 +6393,7 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 		goto out;
 
 	/* Get the initial DCB configuration */
-	err = i40e_init_dcb(hw);
+	err = i40e_init_dcb(hw, true);
 	if (!err) {
 		/* Device/Function is not DCBX capable */
 		if ((!hw->func_caps.dcb) ||
-- 
2.19.2

