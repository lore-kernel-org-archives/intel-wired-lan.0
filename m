From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 16:13:45 -0700
Subject: [Intel-wired-lan] [PATCH 10/13] ice: Implement ice_bridge_getlink
 and ice_bridge_setlink
In-Reply-To: <20180723231348.14838-1-anirudh.venkataramanan@intel.com>
References: <20180723231348.14838-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723231348.14838-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>

ice_bridge_getlink returns the current bridge mode using
ndo_dflt_bridge_getlink and the mode parameter available in
first_switch->bridge_mode.

ice_bridge_setlink is invoked when the bridge mode needs to
changed. The value to be changed to is available as a netlink
message which is parsed in this function. If the mode has to
be changed, switch_flags is set appropriately (set ALLOW_LB
for VEB mode and clear it for VEPA mode) and ice_aq_update_vsi
is called. Also change the unicast switch filter rules.

Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   | 145 +++++++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_switch.c |  41 ++++++++
 drivers/net/ethernet/intel/ice/ice_switch.h |   1 +
 3 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index acb9a4055688..889631be02f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3601,7 +3601,11 @@ static int ice_probe(struct pci_dev *pdev,
 		goto err_msix_misc_unroll;
 	}
 
-	pf->first_sw->bridge_mode = BRIDGE_MODE_VEB;
+	if (hw->evb_veb)
+		pf->first_sw->bridge_mode = BRIDGE_MODE_VEB;
+	else
+		pf->first_sw->bridge_mode = BRIDGE_MODE_VEPA;
+
 	pf->first_sw->pf = pf;
 
 	/* record the sw_id available for later use */
@@ -5697,6 +5701,143 @@ int ice_get_rss(struct ice_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
 	return 0;
 }
 
+/**
+ * ice_bridge_getlink - Get the hardware bridge mode
+ * @skb: skb buff
+ * @pid: process id
+ * @seq: RTNL message seq
+ * @dev: the netdev being configured
+ * @filter_mask: filter mask passed in
+ * @nlflags: netlink flags passed in
+ *
+ * Return the bridge mode (VEB/VEPA)
+ */
+static int
+ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
+		   struct net_device *dev, u32 filter_mask, int nlflags)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_vsi *vsi = np->vsi;
+	struct ice_pf *pf = vsi->back;
+	u16 bmode;
+
+	bmode = pf->first_sw->bridge_mode;
+
+	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, bmode, 0, 0, nlflags,
+				       filter_mask, NULL);
+}
+
+/**
+ * ice_vsi_update_bridge_mode - Update VSI for switching bridge mode (VEB/VEPA)
+ * @vsi: Pointer to VSI structure
+ * @bmode: Hardware bridge mode (VEB/VEPA)
+ *
+ * Returns 0 on success, negative on failure
+ */
+static int ice_vsi_update_bridge_mode(struct ice_vsi *vsi, u16 bmode)
+{
+	struct device *dev = &vsi->back->pdev->dev;
+	struct ice_aqc_vsi_props *vsi_props;
+	struct ice_hw *hw = &vsi->back->hw;
+	struct ice_vsi_ctx ctxt = { 0 };
+	enum ice_status status;
+
+	vsi_props = &vsi->info;
+	ctxt.info = vsi->info;
+
+	if (bmode == BRIDGE_MODE_VEB)
+		/* change from VEPA to VEB mode */
+		ctxt.info.sw_flags |= ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+	else
+		/* change from VEB to VEPA mode */
+		ctxt.info.sw_flags &= ~ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+	ctxt.vsi_num = vsi->vsi_num;
+	ctxt.info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_SW_VALID);
+	status = ice_aq_update_vsi(hw, &ctxt, NULL);
+	if (status) {
+		dev_err(dev, "update VSI for bridge mode failed, bmode = %d err %d aq_err %d\n",
+			bmode, status, hw->adminq.sq_last_status);
+		return -EIO;
+	}
+	/* Update sw flags for book keeping */
+	if (bmode == BRIDGE_MODE_VEB)
+		/* change from VEPA to VEB mode */
+		vsi_props->sw_flags |= ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+	else
+		/* change from VEB to VEPA mode */
+		vsi_props->sw_flags &= ~ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
+
+	return 0;
+}
+
+/**
+ * ice_bridge_setlink - Set the hardware bridge mode
+ * @dev: the netdev being configured
+ * @nlh: RTNL message
+ * @flags: bridge setlink flags
+ *
+ * Sets the bridge mode (VEB/VEPA) of the switch to which the netdev (VSI) is
+ * hooked up to. Iterates through the PF VSI list and sets the loopback mode (if
+ * not already set for all VSIs connected to this switch. And also update the
+ * unicast switch filter rules for the corresponding switch of the netdev.
+ */
+static int
+ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
+		   u16 __always_unused flags)
+{
+	struct ice_netdev_priv *np = netdev_priv(dev);
+	struct ice_pf *pf = np->vsi->back;
+	struct nlattr *attr, *br_spec;
+	struct ice_hw *hw = &pf->hw;
+	enum ice_status status;
+	struct ice_sw *pf_sw;
+	int rem, v, err = 0;
+
+	pf_sw = pf->first_sw;
+	/* find the attribute in the netlink message */
+	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+
+	nla_for_each_nested(attr, br_spec, rem) {
+		__u16 mode;
+
+		if (nla_type(attr) != IFLA_BRIDGE_MODE)
+			continue;
+		mode = nla_get_u16(attr);
+		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
+			return -EINVAL;
+		/* Continue  if bridge mode is not being flipped */
+		if (mode == pf_sw->bridge_mode)
+			continue;
+		/* Iterates through the PF VSI list and update the loopback
+		 * mode of the VSI
+		 */
+		ice_for_each_vsi(pf, v) {
+			if (!pf->vsi[v])
+				continue;
+			err = ice_vsi_update_bridge_mode(pf->vsi[v], mode);
+			if (err)
+				return err;
+		}
+
+		hw->evb_veb = (mode == BRIDGE_MODE_VEB);
+		/* Update the unicast switch filter rules for the corresponding
+		 * switch of the netdev
+		 */
+		status = ice_update_sw_rule_bridge_mode(hw);
+		if (status) {
+			netdev_err(dev, "update SW_RULE for bridge mode failed,  = %d err %d aq_err %d\n",
+				   mode, status, hw->adminq.sq_last_status);
+			/* revert hw->evb_veb */
+			hw->evb_veb = (pf_sw->bridge_mode == BRIDGE_MODE_VEB);
+			return -EIO;
+		}
+
+		pf_sw->bridge_mode = mode;
+	}
+
+	return 0;
+}
+
 /**
  * ice_tx_timeout - Respond to a Tx Hang
  * @netdev: network interface device structure
@@ -5909,6 +6050,8 @@ static const struct net_device_ops ice_netdev_ops = {
 	.ndo_vlan_rx_add_vid = ice_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid = ice_vlan_rx_kill_vid,
 	.ndo_set_features = ice_set_features,
+	.ndo_bridge_getlink = ice_bridge_getlink,
+	.ndo_bridge_setlink = ice_bridge_setlink,
 	.ndo_fdb_add = ice_fdb_add,
 	.ndo_fdb_del = ice_fdb_del,
 	.ndo_tx_timeout = ice_tx_timeout,
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 40e069edd59f..c2e361287996 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1129,6 +1129,47 @@ ice_update_pkt_fwd_rule(struct ice_hw *hw, struct ice_fltr_info *f_info)
 	return status;
 }
 
+/**
+ * ice_update_sw_rule_bridge_mode
+ * @hw: pointer to the hw struct
+ *
+ * Updates unicast switch filter rules based on VEB/VEPA mode
+ */
+enum ice_status ice_update_sw_rule_bridge_mode(struct ice_hw *hw)
+{
+	struct ice_switch_info *sw = hw->switch_info;
+	struct ice_fltr_mgmt_list_entry *fm_entry;
+	enum ice_status status = 0;
+	struct list_head *rule_head;
+	struct mutex *rule_lock; /* Lock to protect filter rule list */
+
+	rule_lock = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rule_lock;
+	rule_head = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rules;
+
+	mutex_lock(rule_lock);
+	list_for_each_entry(fm_entry, rule_head, list_entry) {
+		struct ice_fltr_info *fi = &fm_entry->fltr_info;
+		u8 *addr = fi->l_data.mac.mac_addr;
+
+		/* Update unicast Tx rules to reflect the selected
+		 * VEB/VEPA mode
+		 */
+		if ((fi->flag & ICE_FLTR_TX) && is_unicast_ether_addr(addr) &&
+		    (fi->fltr_act == ICE_FWD_TO_VSI ||
+		     fi->fltr_act == ICE_FWD_TO_VSI_LIST ||
+		     fi->fltr_act == ICE_FWD_TO_Q ||
+		     fi->fltr_act == ICE_FWD_TO_QGRP)) {
+			status = ice_update_pkt_fwd_rule(hw, fi);
+			if (status)
+				break;
+		}
+	}
+
+	mutex_unlock(rule_lock);
+
+	return status;
+}
+
 /**
  * ice_add_update_vsi_list
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 11a481644dac..646389ca1238 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -169,6 +169,7 @@ ice_free_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
 enum ice_status ice_get_initial_sw_cfg(struct ice_hw *hw);
 
 /* Switch/bridge related commands */
+enum ice_status ice_update_sw_rule_bridge_mode(struct ice_hw *hw);
 enum ice_status ice_add_mac(struct ice_hw *hw, struct list_head *m_lst);
 enum ice_status ice_remove_mac(struct ice_hw *hw, struct list_head *m_lst);
 void ice_remove_vsi_fltr(struct ice_hw *hw, u16 vsi_id);
-- 
2.14.3

