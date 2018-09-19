From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 19 Sep 2018 13:34:59 -0700
Subject: [Intel-wired-lan] [PATCH v3] i40e: Introduce recovery mode support
Message-ID: <20180919203459.17064-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alice Michael <alice.michael@intel.com>

This patch introduces "recovery mode" to the i40e driver. It is
part of a new Any2Any idea of upgrading the firmware. In this
approach, it is required for the driver to have support for
"transition firmware", that is used for migrating from structured
to flat firmware image. In this new, very basic mode, i40e driver
must be able to handle particular IOCTL calls from the NVM Update
Tool and run a small set of AQ commands.

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
v2: combined all the patches in Series 94 into one patch since all of
the patches in the series were either introducing the recovery mode
support or were fixing the recovery mode.  Thanks to  Shannon Nelson
for pointing this out.
Also fixed where we forgot to set vsi->netdev to NULL after calling
free_netdev().

v3: Fixed up code comments and style based on feedback from Shannon
Nelson.  Also fixed up a conflict which occurred due to changes to the
driver since this patch was last submitted.

 drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 326 ++++++++++++++++--
 3 files changed, 308 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 876cac317e79..11f0987f16c7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -140,6 +140,7 @@ enum i40e_state_t {
 	__I40E_RESET_FAILED,
 	__I40E_PORT_SUSPENDED,
 	__I40E_VF_DISABLE,
+	__I40E_RECOVERY_MODE,
 	__I40E_MACVLAN_SYNC_PENDING,
 	__I40E_UDP_FILTER_SYNC_PENDING,
 	__I40E_TEMP_LINK_POLLING,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9f8464f80783..f35a26c39d7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4904,6 +4904,12 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+static const struct ethtool_ops i40e_ethtool_recovery_mode_ops = {
+	.set_eeprom		= i40e_set_eeprom,
+	.get_eeprom_len		= i40e_get_eeprom_len,
+	.get_eeprom		= i40e_get_eeprom,
+};
+
 static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_drvinfo		= i40e_get_drvinfo,
 	.get_regs_len		= i40e_get_regs_len,
@@ -4949,5 +4955,11 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 
 void i40e_set_ethtool_ops(struct net_device *netdev)
 {
-	netdev->ethtool_ops = &i40e_ethtool_ops;
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf		*pf = np->vsi->back;
+
+	if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
+		netdev->ethtool_ops = &i40e_ethtool_ops;
+	else
+		netdev->ethtool_ops = &i40e_ethtool_recovery_mode_ops;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 330bafe6a689..eb3ea9e630ee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -46,6 +46,10 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf);
 static void i40e_prep_for_reset(struct i40e_pf *pf, bool lock_acquired);
 static int i40e_reset(struct i40e_pf *pf);
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired);
+static int i40e_setup_misc_vector_for_recovery_mode(struct i40e_pf *pf);
+static int i40e_restore_interrupt_scheme(struct i40e_pf *pf);
+static bool i40e_check_recovery_mode(struct i40e_pf *pf);
+static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw);
 static void i40e_fdir_sb_setup(struct i40e_pf *pf);
 static int i40e_veb_get_bw_info(struct i40e_veb *veb);
 static int i40e_get_capabilities(struct i40e_pf *pf,
@@ -278,8 +282,9 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
  **/
 void i40e_service_event_schedule(struct i40e_pf *pf)
 {
-	if (!test_bit(__I40E_DOWN, pf->state) &&
-	    !test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
+	if ((!test_bit(__I40E_DOWN, pf->state) &&
+	     !test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state)) ||
+	      test_bit(__I40E_RECOVERY_MODE, pf->state))
 		queue_work(i40e_wq, &pf->service_task);
 }
 
@@ -3974,7 +3979,8 @@ static irqreturn_t i40e_intr(int irq, void *data)
 enable_intr:
 	/* re-enable interrupt causes */
 	wr32(hw, I40E_PFINT_ICR0_ENA, ena_mask);
-	if (!test_bit(__I40E_DOWN, pf->state)) {
+	if (!test_bit(__I40E_DOWN, pf->state) ||
+	    test_bit(__I40E_RECOVERY_MODE, pf->state)) {
 		i40e_service_event_schedule(pf);
 		i40e_irq_dynamic_enable_icr0(pf);
 	}
@@ -9393,6 +9399,7 @@ static int i40e_reset(struct i40e_pf *pf)
  **/
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 {
+	int old_recovery_mode_bit = test_bit(__I40E_RECOVERY_MODE, pf->state);
 	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
 	struct i40e_hw *hw = &pf->hw;
 	u8 set_fc_aq_fail = 0;
@@ -9400,7 +9407,14 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	u32 val;
 	int v;
 
-	if (test_bit(__I40E_DOWN, pf->state))
+	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
+	    i40e_check_recovery_mode(pf)) {
+		i40e_set_ethtool_ops(pf->vsi[pf->lan_vsi]->netdev);
+	}
+
+	if (test_bit(__I40E_DOWN, pf->state) &&
+	    !test_bit(__I40E_RECOVERY_MODE, pf->state) &&
+	    !old_recovery_mode_bit)
 		goto clear_recovery;
 	dev_dbg(&pf->pdev->dev, "Rebuilding internal switch\n");
 
@@ -9429,6 +9443,44 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state))
 		i40e_verify_eeprom(pf);
 
+	/* if we are going out of or into recovery mode we have to act
+	 * accordingly with regard to resources initialization
+	 * and deinitialization
+	 */
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state) ||
+	    old_recovery_mode_bit) {
+		if (i40e_get_capabilities(pf,
+					  i40e_aqc_opc_list_func_capabilities))
+			goto end_unlock;
+
+		if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+			/* we're staying in recovery mode so we'll reinitialize
+			 * misc vector here
+			 */
+			if (i40e_setup_misc_vector_for_recovery_mode(pf))
+				goto end_unlock;
+		} else {
+			if (!lock_acquired)
+				rtnl_lock();
+			/* we're going out of recovery mode so we'll free
+			 * the IRQ allocated specifically for recovery mode
+			 * and restore the interrupt scheme
+			 */
+			free_irq(pf->pdev->irq, pf);
+			i40e_clear_interrupt_scheme(pf);
+			if (i40e_restore_interrupt_scheme(pf))
+				goto end_unlock;
+		}
+
+		/* tell the firmware that we're starting */
+		i40e_send_version(pf);
+
+		/* bail out in case recovery mode was detected, as there is
+		 * no need for further configuration.
+		 */
+		goto end_unlock;
+	}
+
 	i40e_clear_pxe_mode(hw);
 	ret = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
 	if (ret)
@@ -9895,25 +9947,31 @@ static void i40e_service_task(struct work_struct *work)
 	if (test_and_set_bit(__I40E_SERVICE_SCHED, pf->state))
 		return;
 
-	i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
-	i40e_sync_filters_subtask(pf);
-	i40e_reset_subtask(pf);
-	i40e_handle_mdd_event(pf);
-	i40e_vc_process_vflr_event(pf);
-	i40e_watchdog_subtask(pf);
-	i40e_fdir_reinit_subtask(pf);
-	if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state)) {
-		/* Client subtask will reopen next time through. */
-		i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], true);
-	} else {
-		i40e_client_subtask(pf);
-		if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
-				       pf->state))
-			i40e_notify_client_of_l2_param_changes(
+	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
+		i40e_sync_filters_subtask(pf);
+		i40e_reset_subtask(pf);
+		i40e_handle_mdd_event(pf);
+		i40e_vc_process_vflr_event(pf);
+		i40e_watchdog_subtask(pf);
+		i40e_fdir_reinit_subtask(pf);
+		if (test_and_clear_bit(__I40E_CLIENT_RESET, pf->state)) {
+			/* Client subtask will reopen next time through. */
+			i40e_notify_client_of_netdev_close(
+						pf->vsi[pf->lan_vsi], true);
+		} else {
+			i40e_client_subtask(pf);
+			if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
+					       pf->state))
+				i40e_notify_client_of_l2_param_changes(
 							pf->vsi[pf->lan_vsi]);
+		}
+		i40e_sync_udp_filters_subtask(pf);
+
+	} else {
+		i40e_reset_subtask(pf);
 	}
 	i40e_sync_filters_subtask(pf);
-	i40e_sync_udp_filters_subtask(pf);
 	i40e_clean_adminq_subtask(pf);
 
 	/* flush memory to make sure state is correct before next watchdog */
@@ -10727,6 +10785,47 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
 	return err;
 }
 
+/**
+ * i40e_setup_misc_vector_for_recovery_mode - Setup misc vector in recovery mode
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
 /**
  * i40e_setup_misc_vector - Setup the misc vector to handle non queue events
  * @pf: board private structure
@@ -13848,6 +13947,127 @@ static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
 		i40e_get_mac_addr(&pf->hw, pf->hw.mac.addr);
 }
 
+/**
+ * i40e_check_recovery_mode - check if we are running transition firmware
+ * @pf: board private structure
+ *
+ * Check registers indicating the firmware runs in recovery mode. Sets the
+ * appropriate driver state.
+ *
+ * Returns true if the recovery mode was detected, false otherwise
+ **/
+static bool i40e_check_recovery_mode(struct i40e_pf *pf)
+{
+	u32 val = rd32(&pf->hw, I40E_GL_FWSTS);
+
+	if (val & I40E_GL_FWSTS_FWS1B_MASK) {
+		dev_notice(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
+		dev_notice(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
+		set_bit(__I40E_RECOVERY_MODE, pf->state);
+
+		return true;
+	}
+	if (test_and_clear_bit(__I40E_RECOVERY_MODE, pf->state))
+		dev_info(&pf->pdev->dev, "Reinitializing in normal mode with full functionality.\n");
+
+	return false;
+}
+
+/**
+ * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
+ * @pf: board private structure
+ * @hw: ptr to the hardware info
+ *
+ * This function does a minimal setup of all subsystems needed for running
+ * recovery mode.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
+{
+	struct i40e_vsi *vsi;
+	int v_idx;
+	int err;
+
+	pci_save_state(pf->pdev);
+
+	/* set up periodic task facility */
+	timer_setup(&pf->service_timer, i40e_service_timer, (unsigned long)pf);
+	pf->service_timer_period = HZ;
+
+	INIT_WORK(&pf->service_task, i40e_service_task);
+	clear_bit(__I40E_SERVICE_SCHED, pf->state);
+
+	err = i40e_init_interrupt_scheme(pf);
+	if (err)
+		goto err_switch_setup;
+
+	/* The number of VSIs reported by the FW is the minimum guaranteed
+	 * to us; HW supports far more and we share the remaining pool with
+	 * the other PFs. We allocate space for more than the guarantee with
+	 * the understanding that we might not get them all later.
+	 */
+	if (pf->hw.func_caps.num_vsis < I40E_MIN_VSI_ALLOC)
+		pf->num_alloc_vsi = I40E_MIN_VSI_ALLOC;
+	else
+		pf->num_alloc_vsi = pf->hw.func_caps.num_vsis;
+
+	/* Set up the vsi struct and our local tracking of the MAIN PF vsi. */
+	pf->vsi = kcalloc(pf->num_alloc_vsi, sizeof(struct i40e_vsi *),
+			  GFP_KERNEL);
+	if (!pf->vsi) {
+		err = -ENOMEM;
+		goto err_switch_setup;
+	}
+
+	/* We allocate one VSI which is needed as absolute minimum
+	 * in order to register the netdev
+	 */
+	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
+	if (v_idx < 0)
+		goto err_switch_setup;
+	pf->lan_vsi = v_idx;
+	vsi = pf->vsi[v_idx];
+	if (!vsi)
+		goto err_switch_setup;
+	vsi->alloc_queue_pairs = 1;
+	err = i40e_config_netdev(vsi);
+	if (err)
+		goto err_switch_setup;
+	err = register_netdev(vsi->netdev);
+	if (err)
+		goto err_switch_setup;
+	vsi->netdev_registered = true;
+	i40e_dbg_pf_init(pf);
+
+	err = i40e_setup_misc_vector_for_recovery_mode(pf);
+	if (err)
+		goto err_switch_setup;
+
+	/* tell the firmware that we're starting */
+	i40e_send_version(pf);
+
+	/* since everything's happy, start the service_task timer */
+	mod_timer(&pf->service_timer,
+		  round_jiffies(jiffies + pf->service_timer_period));
+
+	return 0;
+
+err_switch_setup:
+	i40e_reset_interrupt_capability(pf);
+	del_timer_sync(&pf->service_timer);
+	i40e_shutdown_adminq(hw);
+	iounmap(hw->hw_addr);
+	pci_disable_pcie_error_reporting(pf->pdev);
+	pci_release_selected_regions(pf->pdev,
+				     pci_select_bars(pf->pdev,
+						     IORESOURCE_MEM));
+	pci_disable_device(pf->pdev);
+	kfree(pf);
+
+	return err;
+}
+
 /**
  * i40e_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -13972,12 +14192,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Reset here to make sure all is clean and to define PF 'n' */
 	i40e_clear_hw(hw);
-	err = i40e_pf_reset(hw);
-	if (err) {
-		dev_info(&pdev->dev, "Initial pf_reset failed: %d\n", err);
-		goto err_pf_reset;
+	if (!i40e_check_recovery_mode(pf)) {
+		err = i40e_pf_reset(hw);
+		if (err) {
+			dev_info(&pdev->dev, "Initial pf_reset failed: %d\n",
+				 err);
+			goto err_pf_reset;
+		}
+		pf->pfr_count++;
 	}
-	pf->pfr_count++;
 
 	hw->aq.num_arq_entries = I40E_AQ_LEN;
 	hw->aq.num_asq_entries = I40E_AQ_LEN;
@@ -14043,6 +14266,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_sw_init;
 	}
 
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
+		return i40e_init_recovery_mode(pf, hw);
+
 	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
 				hw->func_caps.num_rx_qp, 0, 0);
 	if (err) {
@@ -14425,6 +14651,20 @@ static void i40e_remove(struct pci_dev *pdev)
 	if (pf->service_task.func)
 		cancel_work_sync(&pf->service_task);
 
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+		struct i40e_vsi *vsi = pf->vsi[0];
+
+		/* We know that we have allocated only one vsi for this PF,
+		 * it was just for registering netdevice, so the interface
+		 * could be visible in the 'ifconfig' output
+		 */
+		unregister_netdev(vsi->netdev);
+		free_netdev(vsi->netdev);
+		vsi->netdev = NULL;
+
+		goto unmap;
+	}
+
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
@@ -14474,25 +14714,37 @@ static void i40e_remove(struct pci_dev *pdev)
 				 ret_code);
 	}
 
-	/* shutdown the adminq */
-	i40e_shutdown_adminq(hw);
-
-	/* destroy the locks only once, here */
-	mutex_destroy(&hw->aq.arq_mutex);
-	mutex_destroy(&hw->aq.asq_mutex);
+unmap:
+	/* Free MSI/legacy interrupt 0 when in recovery mode.
+	 * This is normally done in i40e_vsi_free_irq on
+	 * VSI close but since recovery mode doesn't allow to up
+	 * an interface and we do not allocate all Rx/Tx resources
+	 * for it we'll just do it here
+	 */
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state) &&
+	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
+		free_irq(pf->pdev->irq, pf);
 
 	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
 	rtnl_lock();
 	i40e_clear_interrupt_scheme(pf);
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		if (pf->vsi[i]) {
-			i40e_vsi_clear_rings(pf->vsi[i]);
+			if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
+				i40e_vsi_clear_rings(pf->vsi[i]);
 			i40e_vsi_clear(pf->vsi[i]);
 			pf->vsi[i] = NULL;
 		}
 	}
 	rtnl_unlock();
 
+	/* shutdown the adminq */
+	i40e_shutdown_adminq(hw);
+
+	/* destroy the locks only once, here */
+	mutex_destroy(&hw->aq.arq_mutex);
+	mutex_destroy(&hw->aq.asq_mutex);
+
 	for (i = 0; i < I40E_MAX_VEB; i++) {
 		kfree(pf->veb[i]);
 		pf->veb[i] = NULL;
@@ -14703,6 +14955,16 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	wr32(hw, I40E_PFPM_WUFC,
 	     (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
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
 	/* Since we're going to destroy queues during the
 	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
 	 * whole section
-- 
2.17.1

