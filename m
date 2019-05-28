From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:19 -0700
Subject: [Intel-wired-lan] [next PATCH S6 5/7] i40e: missing priorities for
 any QoS traffic
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch fixes reading f/w lldp agent status at dcb init time.
It's done by removing direct nvm reading in i40e_update_dcb_config()
and checking whether f/w lldp agent is disabled via
I40E_FLAG_DISABLE_FW_LLDP flag in i40e_init_pf_dcb(). The function
i40e_update_dcb_config() in i40e_main.c is a temporary solution which
will be later renamed to i40e_init_dcb() in the i40e_dcb module. Also
logging was extended to make visible if f/w lldp agent is running or not
and always log a message when dcb was not initialized. Without this
patch for new f/w versions f/w lldp agent status was always read
from nvm as disabled and dcb initialization failed without
clear reason in logs.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 57 +++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7c93f28b7b1d..1dd5fcf256ef 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6411,6 +6411,50 @@ static int i40e_resume_port_tx(struct i40e_pf *pf)
 	return ret;
 }
 
+/**
+ * i40e_update_dcb_config
+ * @hw: pointer to the hw struct
+ * @enable_mib_change: enable mib change event
+ *
+ * Update DCB configuration from the Firmware
+ **/
+static enum i40e_status_code
+i40e_update_dcb_config(struct i40e_hw *hw, bool enable_mib_change)
+{
+	struct i40e_lldp_variables lldp_cfg;
+	i40e_status ret;
+
+	if (!hw->func_caps.dcb)
+		return I40E_NOT_SUPPORTED;
+
+	/* Read LLDP NVM area */
+	ret = i40e_read_lldp_cfg(hw, &lldp_cfg);
+	if (ret)
+		return I40E_ERR_NOT_READY;
+
+	/* Get DCBX status */
+	ret = i40e_get_dcbx_status(hw, &hw->dcbx_status);
+	if (ret)
+		return ret;
+
+	/* Check the DCBX Status */
+	if (hw->dcbx_status == I40E_DCBX_STATUS_DONE ||
+	    hw->dcbx_status == I40E_DCBX_STATUS_IN_PROGRESS) {
+		/* Get current DCBX configuration */
+		ret = i40e_get_dcb_config(hw);
+		if (ret)
+			return ret;
+	} else if (hw->dcbx_status == I40E_DCBX_STATUS_DISABLED) {
+		return I40E_ERR_NOT_READY;
+	}
+
+	/* Configure the LLDP MIB change event */
+	if (enable_mib_change)
+		ret = i40e_aq_cfg_lldp_mib_change_event(hw, true, NULL);
+
+	return ret;
+}
+
 /**
  * i40e_init_pf_dcb - Initialize DCB configuration
  * @pf: PF being configured
@@ -6427,11 +6471,13 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	 * Also do not enable DCBx if FW LLDP agent is disabled
 	 */
 	if ((pf->hw_features & I40E_HW_NO_DCB_SUPPORT) ||
-	    (pf->flags & I40E_FLAG_DISABLE_FW_LLDP))
+	    (pf->flags & I40E_FLAG_DISABLE_FW_LLDP)) {
+		dev_info(&pf->pdev->dev, "DCB is not supported or FW LLDP is disabled\n");
+		err = I40E_NOT_SUPPORTED;
 		goto out;
+	}
 
-	/* Get the initial DCB configuration */
-	err = i40e_init_dcb(hw, true);
+	err = i40e_update_dcb_config(hw, true);
 	if (!err) {
 		/* Device/Function is not DCBX capable */
 		if ((!hw->func_caps.dcb) ||
@@ -14881,6 +14927,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_drvdata(pdev, pf);
 	pci_save_state(pdev);
 
+	dev_info(&pdev->dev,
+		 (pf->flags & I40E_FLAG_DISABLE_FW_LLDP) ?
+			"FW LLDP is disabled\n" :
+			"FW LLDP is enabled\n");
+
 	/* Enable FW to write default DCB config on link-up */
 	i40e_aq_set_dcb_parameters(hw, true, NULL);
 
-- 
2.19.2

