From: Alice Michael <alice.michael@intel.com>
Date: Tue, 11 Jul 2017 08:01:17 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V2 10/12] i40e/i40evf: support
	for VF VLAN tag stripping control
In-Reply-To: <20170711120118.44095-1-alice.michael@intel.com>
References: <20170711120118.44095-1-alice.michael@intel.com>
Message-ID: <20170711120118.44095-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch gives VF capability to control VLAN tag stripping via
ethtool. As rx-vlan-offload was fixed before, now the VF is able to
change it using "ethtool --offload <IF> rxvlan on/off" settings.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 60 ++++++++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 ++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 33 ++++++++++++
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 40 +++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index aa8d30b..d551f84 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2530,6 +2530,60 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg, u16 msglen)
 }
 
 /**
+ * i40e_vc_enable_vlan_stripping
+ * @vf: pointer to the VF info
+ * @msg: pointer to the msg buffer
+ * @msglen: msg length
+ *
+ * Enable vlan header stripping for the VF
+ **/
+static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg,
+					 u16 msglen)
+{
+	struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	i40e_status aq_ret = 0;
+
+	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err;
+	}
+
+	i40e_vlan_stripping_enable(vsi);
+
+	/* send the response to the VF */
+err:
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
+				       aq_ret);
+}
+
+/**
+ * i40e_vc_disable_vlan_stripping
+ * @vf: pointer to the VF info
+ * @msg: pointer to the msg buffer
+ * @msglen: msg length
+ *
+ * Disable vlan header stripping for the VF
+ **/
+static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg,
+					  u16 msglen)
+{
+	struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	i40e_status aq_ret = 0;
+
+	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
+		aq_ret = I40E_ERR_PARAM;
+		goto err;
+	}
+
+	i40e_vlan_stripping_disable(vsi);
+
+	/* send the response to the VF */
+err:
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
+				       aq_ret);
+}
+
+/**
  * i40e_vc_process_vf_msg
  * @pf: pointer to the PF structure
  * @vf_id: source VF id
@@ -2648,6 +2702,12 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 	case VIRTCHNL_OP_SET_RSS_HENA:
 		ret = i40e_vc_set_rss_hena(vf, msg, msglen);
 		break;
+	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
+		ret = i40e_vc_enable_vlan_stripping(vf, msg, msglen);
+		break;
+	case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
+		ret = i40e_vc_disable_vlan_stripping(vf, msg, msglen);
+		break;
 
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index f028c09..b659358 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -261,6 +261,8 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_AQ_RELEASE_PROMISC		BIT(16)
 #define I40EVF_FLAG_AQ_REQUEST_ALLMULTI		BIT(17)
 #define I40EVF_FLAG_AQ_RELEASE_ALLMULTI		BIT(18)
+#define I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING	BIT(19)
+#define I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING   BIT(20)
 
 	/* OS defined structs */
 	struct net_device *netdev;
@@ -358,6 +360,8 @@ void i40evf_get_hena(struct i40evf_adapter *adapter);
 void i40evf_set_hena(struct i40evf_adapter *adapter);
 void i40evf_set_rss_key(struct i40evf_adapter *adapter);
 void i40evf_set_rss_lut(struct i40evf_adapter *adapter);
+void i40evf_enable_vlan_stripping(struct i40evf_adapter *adapter);
+void i40evf_disable_vlan_stripping(struct i40evf_adapter *adapter);
 void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				enum virtchnl_ops v_opcode,
 				i40e_status v_retval, u8 *msg, u16 msglen);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a8bc1ed..ad4c833 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1676,6 +1676,16 @@ static void i40evf_watchdog_task(struct work_struct *work)
 		goto watchdog_done;
 	}
 
+	if (adapter->aq_required & I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING) {
+		i40evf_enable_vlan_stripping(adapter);
+		goto watchdog_done;
+	}
+
+	if (adapter->aq_required & I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING) {
+		i40evf_disable_vlan_stripping(adapter);
+		goto watchdog_done;
+	}
+
 	if (adapter->aq_required & I40EVF_FLAG_AQ_CONFIGURE_QUEUES) {
 		i40evf_configure_queues(adapter);
 		goto watchdog_done;
@@ -2295,6 +2305,28 @@ static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
 }
 
 /**
+ * i40e_set_features - set the netdev feature flags
+ * @netdev: ptr to the netdev being adjusted
+ * @features: the feature set that the stack is suggesting
+ * Note: expects to be called while under rtnl_lock()
+ **/
+static int i40evf_set_features(struct net_device *netdev,
+			       netdev_features_t features)
+{
+	struct i40evf_adapter *adapter = netdev_priv(netdev);
+
+	if (!VLAN_ALLOWED(adapter))
+		return -EINVAL;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		adapter->aq_required |= I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
+	else
+		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+
+	return 0;
+}
+
+/**
  * i40evf_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
  * @netdev: This physical port's netdev
@@ -2387,6 +2419,7 @@ static const struct net_device_ops i40evf_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= i40evf_vlan_rx_kill_vid,
 	.ndo_features_check	= i40evf_features_check,
 	.ndo_fix_features	= i40evf_fix_features,
+	.ndo_set_features	= i40evf_set_features,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= i40evf_netpoll,
 #endif
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 6c403bf..85876f4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -821,6 +821,46 @@ void i40evf_set_rss_lut(struct i40evf_adapter *adapter)
 }
 
 /**
+ * i40evf_enable_vlan_stripping
+ * @adapter: adapter structure
+ *
+ * Request VLAN header stripping to be enabled
+ **/
+void i40evf_enable_vlan_stripping(struct i40evf_adapter *adapter)
+{
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot enable stripping, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+	adapter->current_op = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
+	adapter->aq_required &= ~I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
+	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
+			   NULL, 0);
+}
+
+/**
+ * i40evf_disable_vlan_stripping
+ * @adapter: adapter structure
+ *
+ * Request VLAN header stripping to be disabled
+ **/
+void i40evf_disable_vlan_stripping(struct i40evf_adapter *adapter)
+{
+	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
+		/* bail because we already have a command pending */
+		dev_err(&adapter->pdev->dev, "Cannot disable stripping, command %d pending\n",
+			adapter->current_op);
+		return;
+	}
+	adapter->current_op = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
+	adapter->aq_required &= ~I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+	i40evf_send_pf_msg(adapter, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
+			   NULL, 0);
+}
+
+/**
  * i40evf_print_link_message - print link up or down
  * @adapter: adapter structure
  *
-- 
2.9.3

