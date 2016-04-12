From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:50 -0700
Subject: [Intel-wired-lan] [next PATCH S33 11/13] i40e: Add promiscuous on
	VLAN support
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-12-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

NFV use cases require the ability to steer packets to VSIs by VLAN tag
alone while being in promiscuous mode for multicast and unicast MAC
addresses.  These two new functions support that ability.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 70 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  8 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 25872f2..0e8552b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2039,6 +2039,76 @@ i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
 }
 
 /**
+ * i40e_aq_set_vsi_mc_promisc_on_vlan
+ * @hw: pointer to the hw struct
+ * @seid: vsi number
+ * @enable: set MAC L2 layer unicast promiscuous enable/disable for a given VLAN
+ * @vid: The VLAN tag filter - capture any multicast packet with this VLAN tag
+ * @cmd_details: pointer to command details structure or NULL
+ **/
+enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
+							 u16 seid, bool enable,
+							 u16 vid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
+	enum i40e_status_code status;
+	u16 flags = 0;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_vsi_promiscuous_modes);
+
+	if (enable)
+		flags |= I40E_AQC_SET_VSI_PROMISC_MULTICAST;
+
+	cmd->promiscuous_flags = cpu_to_le16(flags);
+	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_MULTICAST);
+	cmd->seid = cpu_to_le16(seid);
+	cmd->vlan_tag = cpu_to_le16(vid | I40E_AQC_SET_VSI_VLAN_VALID);
+
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+	return status;
+}
+
+/**
+ * i40e_aq_set_vsi_uc_promisc_on_vlan
+ * @hw: pointer to the hw struct
+ * @seid: vsi number
+ * @enable: set MAC L2 layer unicast promiscuous enable/disable for a given VLAN
+ * @vid: The VLAN tag filter - capture any unicast packet with this VLAN tag
+ * @cmd_details: pointer to command details structure or NULL
+ **/
+enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+							 u16 seid, bool enable,
+							 u16 vid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
+	enum i40e_status_code status;
+	u16 flags = 0;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_vsi_promiscuous_modes);
+
+	if (enable)
+		flags |= I40E_AQC_SET_VSI_PROMISC_UNICAST;
+
+	cmd->promiscuous_flags = cpu_to_le16(flags);
+	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_PROMISC_UNICAST);
+	cmd->seid = cpu_to_le16(seid);
+	cmd->vlan_tag = cpu_to_le16(vid | I40E_AQC_SET_VSI_VLAN_VALID);
+
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+	return status;
+}
+
+/**
  * i40e_aq_set_vsi_broadcast
  * @hw: pointer to the hw struct
  * @seid: vsi number
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 134035f..8afb237 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -133,6 +133,14 @@ i40e_status i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
 		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
 		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details);
+enum i40e_status_code i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
+							 u16 seid, bool enable,
+							 u16 vid,
+				struct i40e_asq_cmd_details *cmd_details);
+enum i40e_status_code i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+							 u16 seid, bool enable,
+							 u16 vid,
+				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_set_vsi_vlan_promisc(struct i40e_hw *hw,
 				u16 seid, bool enable,
 				struct i40e_asq_cmd_details *cmd_details);
-- 
2.4.3

