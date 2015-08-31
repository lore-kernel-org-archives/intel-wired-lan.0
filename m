From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:52 -0400
Subject: [Intel-wired-lan] [next PATCH S14 12/15] i40e: Add promiscuous on
	VLAN support
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-13-git-send-email-catherine.sullivan@intel.com>
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
Change-ID: Ifef704b07e0ee8a39d3c351dbd5dc83bb2f63c45
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 68 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  6 +++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 2d012d9..d9519ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2013,6 +2013,74 @@ i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
 }
 
 /**
+ * i40e_aq_set_vsi_mc_promisc_on_vlan
+ * @hw: pointer to the hw struct
+ * @seid: vsi number
+ * @enable: set MAC L2 layer unicast promiscuous enable/disable for a given VLAN
+ * @vid: The VLAN tag filter - capture any multicast packet with this VLAN tag
+ * @cmd_details: pointer to command details structure or NULL
+ **/
+i40e_status i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
+				u16 seid, bool enable, u16 vid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
+	i40e_status status;
+	u16 flags = 0;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					i40e_aqc_opc_set_vsi_promiscuous_modes);
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
+i40e_status i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+				u16 seid, bool enable, u16 vid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)&desc.params.raw;
+	i40e_status status;
+	u16 flags = 0;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					i40e_aqc_opc_set_vsi_promiscuous_modes);
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
index e51e156..757bf2c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -127,6 +127,12 @@ i40e_status i40e_aq_set_vsi_unicast_promiscuous(struct i40e_hw *hw,
 		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_set_vsi_multicast_promiscuous(struct i40e_hw *hw,
 		u16 vsi_id, bool set, struct i40e_asq_cmd_details *cmd_details);
+i40e_status i40e_aq_set_vsi_mc_promisc_on_vlan(struct i40e_hw *hw,
+				u16 seid, bool enable, u16 vid,
+				struct i40e_asq_cmd_details *cmd_details);
+i40e_status i40e_aq_set_vsi_uc_promisc_on_vlan(struct i40e_hw *hw,
+				u16 seid, bool enable, u16 vid,
+				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_get_vsi_params(struct i40e_hw *hw,
 				struct i40e_vsi_context *vsi_ctx,
 				struct i40e_asq_cmd_details *cmd_details);
-- 
1.9.3

