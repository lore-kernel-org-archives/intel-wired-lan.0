From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:58 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 4/8] i40evf:
	handle big resets
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-5-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The most common type of reset that the VF will encounter is a PF reset
that cascades down into a VF reset for each VF. In this case, the VF
will always be assigned the same VSI and recovery is fairly simple.

However, in the case of 'bigger' resets, such as a Core or EMP reset,
when the device is reinitialized, it's probable that the VF will NOT get
the same VSI. When this happens, the VF will not be able to recover, as
it will continue to request resources for its original VSI.

Add an extra state to the admin queue state machine so that the driver
can re-request its configuration information at runtime. During reset
recovery, set this bit in the aq_required field, and fetch the (possibly
new) configuration information before attempting to bring the driver
back up. Since the driver doesn't know what kind of reset it has
encountered, this step is done even for a PF reset, but it doesn't hurt
anything - it just gets the same VSI back.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I915d59ffb40375215117362f4ac7a37811aba748
---
 drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 109 +++++++++++++--------
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  30 +++++-
 3 files changed, 95 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 9961e17..c741181 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -234,6 +234,7 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_AQ_CONFIGURE_QUEUES		(u32)(1 << 6)
 #define I40EVF_FLAG_AQ_MAP_VECTORS		(u32)(1 << 7)
 #define I40EVF_FLAG_AQ_HANDLE_RESET		(u32)(1 << 8)
+#define I40EVF_FLAG_AQ_GET_CONFIG		(u32)(1 << 10)
 
 	/* OS defined structs */
 	struct net_device *netdev;
@@ -273,6 +274,7 @@ extern const char i40evf_driver_version[];
 
 int i40evf_up(struct i40evf_adapter *adapter);
 void i40evf_down(struct i40evf_adapter *adapter);
+int i40evf_process_config(struct i40evf_adapter *adapter);
 void i40evf_reinit_locked(struct i40evf_adapter *adapter);
 void i40evf_reset(struct i40evf_adapter *adapter);
 void i40evf_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 27f01c6..e2b7bf6 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1370,6 +1370,10 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		}
 		goto watchdog_done;
 	}
+	if (adapter->aq_required & I40EVF_FLAG_AQ_GET_CONFIG) {
+		i40evf_send_vf_config_msg(adapter);
+		goto watchdog_done;
+	}
 
 	if (adapter->aq_required & I40EVF_FLAG_AQ_DISABLE_QUEUES) {
 		i40evf_disable_queues(adapter);
@@ -1592,7 +1596,8 @@ continue_reset:
 		dev_info(&adapter->pdev->dev, "Failed to init adminq: %d\n",
 			 err);
 
-	i40evf_map_queues(adapter);
+	adapter->aq_required = I40EVF_FLAG_AQ_GET_CONFIG;
+	adapter->aq_required |= I40EVF_FLAG_AQ_MAP_VECTORS;
 
 	/* re-add all MAC filters */
 	list_for_each_entry(f, &adapter->mac_filter_list, list) {
@@ -1602,7 +1607,7 @@ continue_reset:
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
 		f->add = true;
 	}
-	adapter->aq_required = I40EVF_FLAG_AQ_ADD_MAC_FILTER;
+	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
 	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 
@@ -1999,6 +2004,62 @@ static int i40evf_check_reset_complete(struct i40e_hw *hw)
 }
 
 /**
+ * i40evf_process_config - Process the config information we got from the PF
+ * @adapter: board private structure
+ *
+ * Verify that we have a valid config struct, and set up our netdev features
+ * and our VSI struct.
+ **/
+int i40evf_process_config(struct i40evf_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int i;
+
+	/* got VF config message back from PF, now we can parse it */
+	for (i = 0; i < adapter->vf_res->num_vsis; i++) {
+		if (adapter->vf_res->vsi_res[i].vsi_type == I40E_VSI_SRIOV)
+			adapter->vsi_res = &adapter->vf_res->vsi_res[i];
+	}
+	if (!adapter->vsi_res) {
+		dev_err(&adapter->pdev->dev, "No LAN VSI found\n");
+		return -ENODEV;
+	}
+
+	if (adapter->vf_res->vf_offload_flags
+	    & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
+		netdev->vlan_features = netdev->features;
+		netdev->features |= NETIF_F_HW_VLAN_CTAG_TX |
+				    NETIF_F_HW_VLAN_CTAG_RX |
+				    NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+	netdev->features |= NETIF_F_HIGHDMA |
+			    NETIF_F_SG |
+			    NETIF_F_IP_CSUM |
+			    NETIF_F_SCTP_CSUM |
+			    NETIF_F_IPV6_CSUM |
+			    NETIF_F_TSO |
+			    NETIF_F_TSO6 |
+			    NETIF_F_RXCSUM |
+			    NETIF_F_GRO;
+
+	/* copy netdev features into list of user selectable features */
+	netdev->hw_features |= netdev->features;
+	netdev->hw_features &= ~NETIF_F_RXCSUM;
+
+	adapter->vsi.id = adapter->vsi_res->vsi_id;
+
+	adapter->vsi.back = adapter;
+	adapter->vsi.base_vector = 1;
+	adapter->vsi.work_limit = I40E_DEFAULT_IRQ_WORK;
+	adapter->vsi.rx_itr_setting = (I40E_ITR_DYNAMIC |
+				       ITR_REG_TO_USEC(I40E_ITR_RX_DEF));
+	adapter->vsi.tx_itr_setting = (I40E_ITR_DYNAMIC |
+				       ITR_REG_TO_USEC(I40E_ITR_TX_DEF));
+	adapter->vsi.netdev = adapter->netdev;
+	return 0;
+}
+
+/**
  * i40evf_init_task - worker thread to perform delayed initialization
  * @work: pointer to work_struct containing our data
  *
@@ -2018,7 +2079,7 @@ static void i40evf_init_task(struct work_struct *work)
 	struct net_device *netdev = adapter->netdev;
 	struct i40e_hw *hw = &adapter->hw;
 	struct pci_dev *pdev = adapter->pdev;
-	int i, err, bufsz;
+	int err, bufsz;
 
 	switch (adapter->state) {
 	case __I40EVF_STARTUP:
@@ -2104,42 +2165,15 @@ static void i40evf_init_task(struct work_struct *work)
 	default:
 		goto err_alloc;
 	}
-	/* got VF config message back from PF, now we can parse it */
-	for (i = 0; i < adapter->vf_res->num_vsis; i++) {
-		if (adapter->vf_res->vsi_res[i].vsi_type == I40E_VSI_SRIOV)
-			adapter->vsi_res = &adapter->vf_res->vsi_res[i];
-	}
-	if (!adapter->vsi_res) {
-		dev_err(&pdev->dev, "No LAN VSI found\n");
+	if (i40evf_process_config(adapter))
 		goto err_alloc;
-	}
+	adapter->current_op = I40E_VIRTCHNL_OP_UNKNOWN;
 
 	adapter->flags |= I40EVF_FLAG_RX_CSUM_ENABLED;
 
 	netdev->netdev_ops = &i40evf_netdev_ops;
 	i40evf_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
-	netdev->features |= NETIF_F_HIGHDMA |
-			    NETIF_F_SG |
-			    NETIF_F_IP_CSUM |
-			    NETIF_F_SCTP_CSUM |
-			    NETIF_F_IPV6_CSUM |
-			    NETIF_F_TSO |
-			    NETIF_F_TSO6 |
-			    NETIF_F_RXCSUM |
-			    NETIF_F_GRO;
-
-	if (adapter->vf_res->vf_offload_flags
-	    & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
-		netdev->vlan_features = netdev->features;
-		netdev->features |= NETIF_F_HW_VLAN_CTAG_TX |
-				    NETIF_F_HW_VLAN_CTAG_RX |
-				    NETIF_F_HW_VLAN_CTAG_FILTER;
-	}
-
-	/* copy netdev features into list of user selectable features */
-	netdev->hw_features |= netdev->features;
-	netdev->hw_features &= ~NETIF_F_RXCSUM;
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
@@ -2170,17 +2204,6 @@ static void i40evf_init_task(struct work_struct *work)
 
 	netif_carrier_off(netdev);
 
-	adapter->vsi.id = adapter->vsi_res->vsi_id;
-	adapter->vsi.seid = adapter->vsi_res->vsi_id; /* dummy */
-	adapter->vsi.back = adapter;
-	adapter->vsi.base_vector = 1;
-	adapter->vsi.work_limit = I40E_DEFAULT_IRQ_WORK;
-	adapter->vsi.rx_itr_setting = (I40E_ITR_DYNAMIC |
-				       ITR_REG_TO_USEC(I40E_ITR_RX_DEF));
-	adapter->vsi.tx_itr_setting = (I40E_ITR_DYNAMIC |
-				       ITR_REG_TO_USEC(I40E_ITR_TX_DEF));
-	adapter->vsi.netdev = adapter->netdev;
-
 	if (!adapter->netdev_registered) {
 		err = register_netdev(netdev);
 		if (err)
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 61e0905..a37d56b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -145,8 +145,24 @@ out:
  **/
 int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 {
-	return i40evf_send_pf_msg(adapter, I40E_VIRTCHNL_OP_GET_VF_RESOURCES,
-				  NULL, 0);
+	u32 caps;
+
+	adapter->current_op = I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
+	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
+	caps = I40E_VIRTCHNL_VF_OFFLOAD_L2 |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ |
+	       I40E_VIRTCHNL_VF_OFFLOAD_RSS_REG |
+	       I40E_VIRTCHNL_VF_OFFLOAD_VLAN;
+	adapter->current_op = I40E_VIRTCHNL_OP_GET_VF_RESOURCES;
+	adapter->aq_required &= ~I40EVF_FLAG_AQ_GET_CONFIG;
+	if (PF_IS_V11(adapter))
+		return i40evf_send_pf_msg(adapter,
+					  I40E_VIRTCHNL_OP_GET_VF_RESOURCES,
+					  (u8 *)&caps, sizeof(caps));
+	else
+		return i40evf_send_pf_msg(adapter,
+					  I40E_VIRTCHNL_OP_GET_VF_RESOURCES,
+					  NULL, 0);
 }
 
 /**
@@ -729,6 +745,15 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		adapter->current_stats = *stats;
 		}
 		break;
+	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES: {
+		u16 len = sizeof(struct i40e_virtchnl_vf_resource) +
+			  I40E_MAX_VF_VSI *
+			  sizeof(struct i40e_virtchnl_vsi_resource);
+		memcpy(adapter->vf_res, msg, min(msglen, len));
+		i40e_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
+		i40evf_process_config(adapter);
+		}
+		break;
 	case I40E_VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		i40evf_irq_enable(adapter, true);
@@ -740,7 +765,6 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 		i40evf_free_all_rx_resources(adapter);
 		break;
 	case I40E_VIRTCHNL_OP_VERSION:
-	case I40E_VIRTCHNL_OP_GET_VF_RESOURCES:
 	case I40E_VIRTCHNL_OP_CONFIG_IRQ_MAP:
 		/* Don't display an error if we get these out of sequence.
 		 * If the firmware needed to get kicked, we'll get these and
-- 
1.9.3

