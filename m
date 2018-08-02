From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:28 -0700
Subject: [Intel-wired-lan] [next PATCH S94 05/13] i40e: Enable interrupts in
 recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch enables interrupts in recovery mode. Thanks to
this, NVM update process speed is significantly increased since
we do not wait for watchdog to trigger the driver to take a look
at AdminQ in order to check if there is an event to read.
Instead we are immediately notified via an interrupt.

Additionally this patch corrects interrupts reinitialization
in i40e_rebuild.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 104 +++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c1bccf8..d53938c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -44,6 +44,7 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf);
 static void i40e_prep_for_reset(struct i40e_pf *pf, bool lock_acquired);
 static int i40e_reset(struct i40e_pf *pf);
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired);
+static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf);
 static bool i40e_check_recovery_mode(struct i40e_pf *pf);
 static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw);
 static void i40e_fdir_sb_setup(struct i40e_pf *pf);
@@ -3929,7 +3930,8 @@ static irqreturn_t i40e_intr(int irq, void *data)
 enable_intr:
 	/* re-enable interrupt causes */
 	wr32(hw, I40E_PFINT_ICR0_ENA, ena_mask);
-	if (!test_bit(__I40E_DOWN, pf->state)) {
+	if (!test_bit(__I40E_DOWN, pf->state) ||
+	    test_bit(__I40E_RECOVERY_MODE, pf->state)) {
 		i40e_service_event_schedule(pf);
 		i40e_irq_dynamic_enable_icr0(pf);
 	}
@@ -9335,8 +9337,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	u32 val;
 	int v;
 
-	if (pf->hw.mac.type == I40E_MAC_X722 &&
-	    test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
+	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
 	    i40e_check_recovery_mode(pf)) {
 		i40e_set_ethtool_ops(pf->vsi[pf->lan_vsi]->netdev);
 	}
@@ -9370,11 +9371,24 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	/* re-verify the eeprom if we just had an EMP reset */
 	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state)) {
 		i40e_verify_eeprom(pf);
+	}
+
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+		if (i40e_get_capabilities(pf,
+					  i40e_aqc_opc_list_func_capabilities))
+			goto end_unlock;
+
+		/* reinit the misc interrupt */
+		if (i40e_setup_misc_vector_for_recovery_mode(pf))
+			goto end_unlock;
+
+		/* tell the firmware that we're starting */
+		i40e_send_version(pf);
+
 		/* bail out in case recovery mode was detected, as there is
 		 * no need for further configuration.
 		 */
-		if (test_bit(__I40E_RECOVERY_MODE, pf->state))
-			goto end_unlock;
+		goto end_unlock;
 	}
 
 	i40e_clear_pxe_mode(hw);
@@ -10682,6 +10696,48 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
 }
 
 /**
+ * i40e_setup_misc_vector_for_recovery_mode - Setup the misc vector to handle
+ * non queue events in recovery mode
+ * @pf: board private structure
+ *
+ * This sets up the handler for MSIX 0 or MSI/legacy, which is used to manage
+ * the non-queue interrupts, e.g. AdminQ and errors in recovery mode.
+ * This is handled differently than in recovery mode since no Tx/Rx resources
+ * are being allocated.
+ **/
+static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf)
+{
+	int err;
+
+	if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
+		err = i40e_setup_misc_vector(pf);
+
+		if (err) {
+			dev_info(&pf->pdev->dev,
+				 "MSI-X misc vector request failed, error %d\n",
+				 err);
+			return err;
+		}
+	} else {
+		u32 flags = pf->flags & I40E_FLAG_MSI_ENABLED ? 0 : IRQF_SHARED;
+
+		err = request_irq(pf->pdev->irq, i40e_intr, flags,
+				  pf->int_name, pf);
+
+		if (err) {
+			dev_info(&pf->pdev->dev,
+				 "MSI/legacy misc vector request failed, error %d\n",
+				 err);
+			return err;
+		}
+		i40e_enable_misc_int_causes(pf);
+		i40e_irq_dynamic_enable_icr0(pf);
+	}
+
+	return 0;
+}
+
+/**
  * i40e_setup_misc_vector - Setup the misc vector to handle non queue events
  * @pf: board private structure
  *
@@ -13587,12 +13643,6 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	int err;
 	int v_idx;
 
-	err = i40e_sw_init(pf);
-	if (err) {
-		dev_info(&pf->pdev->dev, "sw_init failed: %d\n", err);
-		goto err_sw_init;
-	}
-
 	pci_save_state(pf->pdev);
 
 	/* set up periodic task facility */
@@ -13616,7 +13666,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	else
 		pf->num_alloc_vsi = pf->hw.func_caps.num_vsis;
 
-	/* Set up the *vsi struct and our local tracking of the MAIN PF vsi. */
+	/* Set up the vsi struct and our local tracking of the MAIN PF vsi. */
 	pf->vsi = kcalloc(pf->num_alloc_vsi, sizeof(struct i40e_vsi *),
 			  GFP_KERNEL);
 	if (!pf->vsi) {
@@ -13624,6 +13674,9 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 		goto err_switch_setup;
 	}
 
+	/* We allocate one VSI which is needed as absolute minimum
+	 * in order to register the netdev
+	 */
 	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
 	if (v_idx < 0)
 		goto err_switch_setup;
@@ -13631,6 +13684,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	vsi = pf->vsi[v_idx];
 	if (!vsi)
 		goto err_switch_setup;
+	vsi->alloc_queue_pairs = 1;
 	err = i40e_config_netdev(vsi);
 	if (err)
 		goto err_switch_setup;
@@ -13639,6 +13693,10 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 		goto err_switch_setup;
 	i40e_dbg_pf_init(pf);
 
+	err = i40e_setup_misc_vector_for_recovery_mode(pf);
+	if (err)
+		goto err_switch_setup;
+
 	/* tell the firmware that we're starting */
 	i40e_send_version(pf);
 
@@ -13651,7 +13709,6 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 err_switch_setup:
 	i40e_reset_interrupt_capability(pf);
 	del_timer_sync(&pf->service_timer);
-err_sw_init:
 	i40e_shutdown_adminq(hw);
 	iounmap(hw->hw_addr);
 	kfree(pf);
@@ -13849,11 +13906,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_warn(&pdev->dev, "This device is a pre-production adapter/LOM. Please be aware there may be issues with your hardware. If you are experiencing problems please contact your Intel or hardware representative who provided you with this hardware.\n");
 
 	i40e_clear_pxe_mode(hw);
-
-	if (pf->hw.mac.type == I40E_MAC_X722)
-		if (i40e_check_recovery_mode(pf))
-			return i40e_init_recovery_mode(pf, hw);
-
 	err = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
 	if (err)
 		goto err_adminq_setup;
@@ -13864,6 +13916,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_sw_init;
 	}
 
+	if (i40e_check_recovery_mode(pf))
+		return i40e_init_recovery_mode(pf, hw);
+
 	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
 				hw->func_caps.num_rx_qp, 0, 0);
 	if (err) {
@@ -14316,11 +14371,22 @@ static void i40e_remove(struct pci_dev *pdev)
 	mutex_destroy(&hw->aq.arq_mutex);
 	mutex_destroy(&hw->aq.asq_mutex);
 
+	/* Free MSI/legacy interrupt 0 when in recovery mode.
+	 * This is normally done in i40e_vsi_free_irq on
+	 * VSI close but since recovery mode doesn't allow to up
+	 * an interface and we do not allocate all Rx/Tx resources
+	 * for it we'll just do it here
+	 */
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state) &&
+	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
+		free_irq(pf->pdev->irq, pf);
+
 	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
 	i40e_clear_interrupt_scheme(pf);
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		if (pf->vsi[i]) {
-			i40e_vsi_clear_rings(pf->vsi[i]);
+			if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
+				i40e_vsi_clear_rings(pf->vsi[i]);
 			i40e_vsi_clear(pf->vsi[i]);
 			pf->vsi[i] = NULL;
 		}
-- 
2.9.5

