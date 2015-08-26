From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:17 -0400
Subject: [Intel-wired-lan] [next PATCH S11 11/15] i40e/i40evf: give up the
	__func__
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

During early development, we added the function name to all of the error
strings to make debugging simpler. Now that we've released the driver,
our users should have more comprehensible error messages. So tear the
roof off and give up the __func__. Ow.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I7e1766252c7a032b9af6520da6aff536bdfd533c
---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      |  5 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 40 ++++++---------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  9 ++--
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 59 ++++++++++------------
 4 files changed, 47 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 1c51f73..dbadad7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -240,9 +240,8 @@ static void i40e_dcbnl_del_app(struct i40e_pf *pf,
 		if (pf->vsi[v] && pf->vsi[v]->netdev) {
 			err = i40e_dcbnl_vsi_del_app(pf->vsi[v], app);
 			if (err)
-				dev_info(&pf->pdev->dev, "%s: Failed deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
-					 __func__, pf->vsi[v]->seid,
-					 err, app->selector,
+				dev_info(&pf->pdev->dev, "Failed deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
+					 pf->vsi[v]->seid, err, app->selector,
 					 app->protocolid, app->priority);
 		}
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f7da41b..6af199a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3049,8 +3049,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 				  q_vector);
 		if (err) {
 			dev_info(&pf->pdev->dev,
-				 "%s: request_irq failed, error: %d\n",
-				 __func__, err);
+				 "MSIX request_irq failed, error: %d\n", err);
 			goto free_queue_irqs;
 		}
 		/* assign the mask for this irq */
@@ -3574,9 +3573,8 @@ static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
 		ret = i40e_pf_txq_wait(pf, pf_q, enable);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "%s: VSI seid %d Tx ring %d %sable timeout\n",
-				 __func__, vsi->seid, pf_q,
-				 (enable ? "en" : "dis"));
+				 "VSI seid %d Tx ring %d %sable timeout\n",
+				 vsi->seid, pf_q, (enable ? "en" : "dis"));
 			break;
 		}
 	}
@@ -3652,9 +3650,8 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
 		ret = i40e_pf_rxq_wait(pf, pf_q, enable);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "%s: VSI seid %d Rx ring %d %sable timeout\n",
-				 __func__, vsi->seid, pf_q,
-				 (enable ? "en" : "dis"));
+				 "VSI seid %d Rx ring %d %sable timeout\n",
+				 vsi->seid, pf_q, (enable ? "en" : "dis"));
 			break;
 		}
 	}
@@ -3948,8 +3945,7 @@ static void i40e_quiesce_vsi(struct i40e_vsi *vsi)
 	if ((test_bit(__I40E_PORT_TX_SUSPENDED, &vsi->back->state)) &&
 	    vsi->type == I40E_VSI_FCOE) {
 		dev_dbg(&vsi->back->pdev->dev,
-			"%s: VSI seid %d skipping FCoE VSI disable\n",
-			 __func__, vsi->seid);
+			 "VSI seid %d skipping FCoE VSI disable\n", vsi->seid);
 		return;
 	}
 
@@ -4023,8 +4019,8 @@ static int i40e_vsi_wait_txq_disabled(struct i40e_vsi *vsi)
 		ret = i40e_pf_txq_wait(pf, pf_q, false);
 		if (ret) {
 			dev_info(&pf->pdev->dev,
-				 "%s: VSI seid %d Tx ring %d disable timeout\n",
-				 __func__, vsi->seid, pf_q);
+				 "VSI seid %d Tx ring %d disable timeout\n",
+				 vsi->seid, pf_q);
 			return ret;
 		}
 	}
@@ -5213,8 +5209,7 @@ bool i40e_dcb_need_reconfig(struct i40e_pf *pf,
 		dev_dbg(&pf->pdev->dev, "APP Table change detected.\n");
 	}
 
-	dev_dbg(&pf->pdev->dev, "%s: need_reconfig=%d\n", __func__,
-		need_reconfig);
+	dev_dbg(&pf->pdev->dev, "dcb need_reconfig=%d\n", need_reconfig);
 	return need_reconfig;
 }
 
@@ -5241,16 +5236,14 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 	/* Ignore if event is not for Nearest Bridge */
 	type = ((mib->type >> I40E_AQ_LLDP_BRIDGE_TYPE_SHIFT)
 		& I40E_AQ_LLDP_BRIDGE_TYPE_MASK);
-	dev_dbg(&pf->pdev->dev,
-		"%s: LLDP event mib bridge type 0x%x\n", __func__, type);
+	dev_dbg(&pf->pdev->dev, "LLDP event mib bridge type 0x%x\n", type);
 	if (type != I40E_AQ_LLDP_BRIDGE_TYPE_NEAREST_BRIDGE)
 		return ret;
 
 	/* Check MIB Type and return if event for Remote MIB update */
 	type = mib->type & I40E_AQ_LLDP_MIB_TYPE_MASK;
 	dev_dbg(&pf->pdev->dev,
-		"%s: LLDP event mib type %s\n", __func__,
-		type ? "remote" : "local");
+		"LLDP event mib type %s\n", type ? "remote" : "local");
 	if (type == I40E_AQ_LLDP_MIB_REMOTE) {
 		/* Update the remote cached instance and return */
 		ret = i40e_aq_get_dcb_config(hw, I40E_AQ_LLDP_MIB_REMOTE,
@@ -8983,8 +8976,7 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		if (veb) {
 			if (vsi->seid != pf->vsi[pf->lan_vsi]->seid) {
 				dev_info(&vsi->back->pdev->dev,
-					 "%s: New VSI creation error, uplink seid of LAN VSI expected.\n",
-					 __func__);
+					 "New VSI creation error, uplink seid of LAN VSI expected.\n");
 				return NULL;
 			}
 			/* We come up by default in VEPA mode if SRIOV is not
@@ -10428,7 +10420,7 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 	int err;
 	u32 reg;
 
-	dev_info(&pdev->dev, "%s\n", __func__);
+	dev_dbg(&pdev->dev, "%s\n", __func__);
 	if (pci_enable_device_mem(pdev)) {
 		dev_info(&pdev->dev,
 			 "Cannot re-enable PCI device after reset.\n");
@@ -10468,7 +10460,7 @@ static void i40e_pci_error_resume(struct pci_dev *pdev)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
-	dev_info(&pdev->dev, "%s\n", __func__);
+	dev_dbg(&pdev->dev, "%s\n", __func__);
 	if (test_bit(__I40E_SUSPENDED, &pf->state))
 		return;
 
@@ -10560,9 +10552,7 @@ static int i40e_resume(struct pci_dev *pdev)
 
 	err = pci_enable_device_mem(pdev);
 	if (err) {
-		dev_err(&pdev->dev,
-			"%s: Cannot enable PCI device from suspend\n",
-			__func__);
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
 	pci_set_master(pdev);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index d5d099b9..3fc5606 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -411,8 +411,7 @@ i40evf_request_traffic_irqs(struct i40evf_adapter *adapter, char *basename)
 			q_vector);
 		if (err) {
 			dev_info(&adapter->pdev->dev,
-				 "%s: request_irq failed, error: %d\n",
-				__func__, err);
+				 "Request_irq failed, error: %d\n", err);
 			goto free_queue_irqs;
 		}
 		/* assign the mask for this irq */
@@ -1775,8 +1774,7 @@ static int i40evf_setup_all_tx_resources(struct i40evf_adapter *adapter)
 		if (!err)
 			continue;
 		dev_err(&adapter->pdev->dev,
-			"%s: Allocation for Tx Queue %u failed\n",
-			__func__, i);
+			"Allocation for Tx Queue %u failed\n", i);
 		break;
 	}
 
@@ -1803,8 +1801,7 @@ static int i40evf_setup_all_rx_resources(struct i40evf_adapter *adapter)
 		if (!err)
 			continue;
 		dev_err(&adapter->pdev->dev,
-			"%s: Allocation for Rx Queue %u failed\n",
-			__func__, i);
+			"Allocation for Rx Queue %u failed\n", i);
 		break;
 	}
 	return err;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index d4eb1a5..317e240 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -234,8 +234,8 @@ void i40evf_configure_queues(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot configure queues, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	adapter->current_op = I40E_VIRTCHNL_OP_CONFIG_VSI_QUEUES;
@@ -288,8 +288,8 @@ void i40evf_enable_queues(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot enable queues, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	adapter->current_op = I40E_VIRTCHNL_OP_ENABLE_QUEUES;
@@ -313,8 +313,8 @@ void i40evf_disable_queues(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot disable queues, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	adapter->current_op = I40E_VIRTCHNL_OP_DISABLE_QUEUES;
@@ -341,8 +341,8 @@ void i40evf_map_queues(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot map queues to vectors, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	adapter->current_op = I40E_VIRTCHNL_OP_CONFIG_IRQ_MAP;
@@ -393,8 +393,8 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
@@ -410,8 +410,7 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 	len = sizeof(struct i40e_virtchnl_ether_addr_list) +
 	      (count * sizeof(struct i40e_virtchnl_ether_addr));
 	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
-		dev_warn(&adapter->pdev->dev, "%s: Too many MAC address changes in one request\n",
-			 __func__);
+		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
 		count = (I40EVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct i40e_virtchnl_ether_addr_list)) /
 			sizeof(struct i40e_virtchnl_ether_addr);
@@ -453,8 +452,8 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot remove filters, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
@@ -470,8 +469,7 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 	len = sizeof(struct i40e_virtchnl_ether_addr_list) +
 	      (count * sizeof(struct i40e_virtchnl_ether_addr));
 	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
-		dev_warn(&adapter->pdev->dev, "%s: Too many MAC address changes in one request\n",
-			 __func__);
+		dev_warn(&adapter->pdev->dev, "Too many delete MAC changes in one request\n");
 		count = (I40EVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct i40e_virtchnl_ether_addr_list)) /
 			sizeof(struct i40e_virtchnl_ether_addr);
@@ -513,8 +511,8 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot add VLANs, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 
@@ -531,8 +529,7 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 	len = sizeof(struct i40e_virtchnl_vlan_filter_list) +
 	      (count * sizeof(u16));
 	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
-		dev_warn(&adapter->pdev->dev, "%s: Too many VLAN changes in one request\n",
-			 __func__);
+		dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
 		count = (I40EVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct i40e_virtchnl_vlan_filter_list)) /
 			sizeof(u16);
@@ -572,8 +569,8 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot remove VLANs, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 
@@ -590,8 +587,7 @@ void i40evf_del_vlans(struct i40evf_adapter *adapter)
 	len = sizeof(struct i40e_virtchnl_vlan_filter_list) +
 	      (count * sizeof(u16));
 	if (len > I40EVF_MAX_AQ_BUF_SIZE) {
-		dev_warn(&adapter->pdev->dev, "%s: Too many VLAN changes in one request\n",
-			 __func__);
+		dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
 		count = (I40EVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct i40e_virtchnl_vlan_filter_list)) /
 			sizeof(u16);
@@ -629,8 +625,8 @@ void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
 
 	if (adapter->current_op != I40E_VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-		dev_err(&adapter->pdev->dev, "%s: command %d pending\n",
-			__func__, adapter->current_op);
+		dev_err(&adapter->pdev->dev, "Cannot set promiscuous mode, command %d pending\n",
+			adapter->current_op);
 		return;
 	}
 	adapter->current_op = I40E_VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE;
@@ -720,17 +716,16 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			}
 			break;
 		default:
-			dev_err(&adapter->pdev->dev,
-				"%s: Unknown event %d from pf\n",
-				__func__, vpe->event);
+			dev_err(&adapter->pdev->dev, "Unknown event %d from PF\n",
+				vpe->event);
 			break;
 		}
 		return;
 	}
 	if (v_retval) {
-		dev_err(&adapter->pdev->dev, "%s: PF returned error %d (%s) to our request %d\n",
-			__func__, v_retval,
-			i40evf_stat_str(&adapter->hw, v_retval), v_opcode);
+		dev_err(&adapter->pdev->dev, "PF returned error %d (%s) to our request %d\n",
+			v_retval, i40evf_stat_str(&adapter->hw, v_retval),
+			v_opcode);
 	}
 	switch (v_opcode) {
 	case I40E_VIRTCHNL_OP_GET_STATS: {
-- 
1.9.3

