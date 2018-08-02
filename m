From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:24 -0700
Subject: [Intel-wired-lan] [next PATCH S94 01/13] i40e: Introduce recovery
 mode support
Message-ID: <20180802004036.89363-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch introduces "recovery mode" to the i40e driver. It is
part of a new Any2Any idea of upgrading the firmware. In this
approach, it is required for the driver to have support for
"transition firmware", that is used for migrating from structured
to flat firmware image. In this new, very basic mode, i40e driver
must be able to handle particular IOCTL calls from the NVM Update
Tool and run a small set of AQ commands.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |   1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 212 ++++++++++++++++++++++---
 3 files changed, 206 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7a80652..db911e3 100644
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
index abcd096..19606a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4829,6 +4829,12 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
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
@@ -4874,5 +4880,11 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 
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
index a730f48..c4ba44c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -44,6 +44,8 @@ static int i40e_setup_pf_filter_control(struct i40e_pf *pf);
 static void i40e_prep_for_reset(struct i40e_pf *pf, bool lock_acquired);
 static int i40e_reset(struct i40e_pf *pf);
 static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired);
+static bool i40e_check_recovery_mode(struct i40e_pf *pf);
+static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw);
 static void i40e_fdir_sb_setup(struct i40e_pf *pf);
 static int i40e_veb_get_bw_info(struct i40e_veb *veb);
 static int i40e_get_capabilities(struct i40e_pf *pf,
@@ -276,8 +278,9 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
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
 
@@ -9332,7 +9335,14 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	u32 val;
 	int v;
 
-	if (test_bit(__I40E_DOWN, pf->state))
+	if (pf->hw.mac.type == I40E_MAC_X722 &&
+	    test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
+	    i40e_check_recovery_mode(pf)) {
+		i40e_set_ethtool_ops(pf->vsi[pf->lan_vsi]->netdev);
+	}
+
+	if (test_bit(__I40E_DOWN, pf->state) &&
+	    !test_bit(__I40E_RECOVERY_MODE, pf->state))
 		goto clear_recovery;
 	dev_dbg(&pf->pdev->dev, "Rebuilding internal switch\n");
 
@@ -9358,8 +9368,14 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 
 	/* re-verify the eeprom if we just had an EMP reset */
-	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state))
+	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state)) {
 		i40e_verify_eeprom(pf);
+		/* bail out in case recovery mode was detected, as there is
+		 * no need for further configuration.
+		 */
+		if (test_bit(__I40E_RECOVERY_MODE, pf->state))
+			goto end_unlock;
+	}
 
 	i40e_clear_pxe_mode(hw);
 	ret = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
@@ -9827,25 +9843,31 @@ static void i40e_service_task(struct work_struct *work)
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
+		if (pf->flags & __I40E_CLIENT_RESET) {
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
@@ -13524,6 +13546,137 @@ static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
 }
 
 /**
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
+		dev_info(&pf->pdev->dev, "transition FW detected, running in recovery mode\n");
+		set_bit(__I40E_RECOVERY_MODE, pf->state);
+
+		return true;
+	}
+	clear_bit(__I40E_RECOVERY_MODE, pf->state);
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
+	int err;
+	int v_idx;
+
+	err = i40e_sw_init(pf);
+	if (err) {
+		dev_info(&pf->pdev->dev, "sw_init failed: %d\n", err);
+		goto err_sw_init;
+	}
+
+	/* allow a platform config to override the HW addr */
+	i40e_get_platform_mac_addr(pf->pdev, pf);
+
+	if (!is_valid_ether_addr(hw->mac.addr)) {
+		/* normally we would return -EIO here */
+		dev_info(&pf->pdev->dev, "invalid MAC address %pM\n",
+			 hw->mac.addr);
+	} else {
+		dev_info(&pf->pdev->dev, "MAC address: %pM\n", hw->mac.addr);
+	}
+	ether_addr_copy(hw->mac.perm_addr, hw->mac.addr);
+	i40e_get_port_mac_addr(hw, hw->mac.port_addr);
+	if (is_valid_ether_addr(hw->mac.port_addr))
+		pf->hw_features |= I40E_HW_PORT_ID_VALID;
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
+	/* Set up the *vsi struct and our local tracking of the MAIN PF vsi. */
+	pf->vsi = kcalloc(pf->num_alloc_vsi, sizeof(struct i40e_vsi *),
+			  GFP_KERNEL);
+	if (!pf->vsi) {
+		err = -ENOMEM;
+		goto err_switch_setup;
+	}
+
+	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
+	if (v_idx < 0)
+		goto err_switch_setup;
+	vsi = pf->vsi[v_idx];
+	if (!vsi)
+		goto err_switch_setup;
+	err = i40e_config_netdev(vsi);
+	if (err)
+		goto err_switch_setup;
+	err = register_netdev(vsi->netdev);
+	if (err)
+		goto err_switch_setup;
+	i40e_dbg_pf_init(pf);
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
+err_sw_init:
+	i40e_shutdown_adminq(hw);
+	iounmap(hw->hw_addr);
+	kfree(pf);
+	pci_disable_pcie_error_reporting(pf->pdev);
+	pci_release_selected_regions(pf->pdev,
+				     pci_select_bars(pf->pdev,
+						     IORESOURCE_MEM));
+	pci_disable_device(pf->pdev);
+
+	return err;
+}
+
+/**
  * i40e_probe - Device initialization routine
  * @pdev: PCI device information struct
  * @ent: entry in i40e_pci_tbl
@@ -13708,6 +13861,11 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_warn(&pdev->dev, "This device is a pre-production adapter/LOM. Please be aware there may be issues with your hardware. If you are experiencing problems please contact your Intel or hardware representative who provided you with this hardware.\n");
 
 	i40e_clear_pxe_mode(hw);
+
+	if (pf->hw.mac.type == I40E_MAC_X722)
+		if (i40e_check_recovery_mode(pf))
+			return i40e_init_recovery_mode(pf, hw);
+
 	err = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
 	if (err)
 		goto err_adminq_setup;
@@ -14100,6 +14258,19 @@ static void i40e_remove(struct pci_dev *pdev)
 	if (pf->service_task.func)
 		cancel_work_sync(&pf->service_task);
 
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state)) {
+		struct i40e_vsi *vsi = pf->vsi[0];
+
+		/* We know that we have allocated only one vsi for this PF,
+		 * * it was just for registering netdevice, so the interface
+		 * could be visible in the 'ifconfig' output
+		 */
+		unregister_netdev(vsi->netdev);
+		free_netdev(vsi->netdev);
+
+		goto unmap;
+	}
+
 	/* Client close must be called explicitly here because the timer
 	 * has been stopped.
 	 */
@@ -14149,6 +14320,7 @@ static void i40e_remove(struct pci_dev *pdev)
 				 ret_code);
 	}
 
+unmap:
 	/* shutdown the adminq */
 	i40e_shutdown_adminq(hw);
 
-- 
2.9.5

