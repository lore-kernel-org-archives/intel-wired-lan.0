From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:31 -0700
Subject: [Intel-wired-lan] [next PATCH S37 01/15] i40e: add functions to
	control default VSI
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Add functions to enable and disable default VSI on a VEB. This allows
for configuration of limited promiscuous mode specifically for bridging
purposes.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I0cc5bd68b31c500fdff4d47e1f15d50d2739faf4
---
 drivers/net/ethernet/intel/i40e/i40e_common.c    | 56 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  2 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 422b41d..b87bfc6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1967,6 +1967,62 @@ aq_add_vsi_exit:
 }
 
 /**
+ * i40e_aq_set_default_vsi
+ * @hw: pointer to the hw struct
+ * @seid: vsi number
+ * @cmd_details: pointer to command details structure or NULL
+ **/
+i40e_status i40e_aq_set_default_vsi(struct i40e_hw *hw,
+				    u16 seid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)
+		&desc.params.raw;
+	i40e_status status;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_vsi_promiscuous_modes);
+
+	cmd->promiscuous_flags = cpu_to_le16(I40E_AQC_SET_VSI_DEFAULT);
+	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_DEFAULT);
+	cmd->seid = cpu_to_le16(seid);
+
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+	return status;
+}
+
+/**
+ * i40e_aq_clear_default_vsi
+ * @hw: pointer to the hw struct
+ * @seid: vsi number
+ * @cmd_details: pointer to command details structure or NULL
+ **/
+i40e_status i40e_aq_clear_default_vsi(struct i40e_hw *hw,
+				      u16 seid,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_vsi_promiscuous_modes *cmd =
+		(struct i40e_aqc_set_vsi_promiscuous_modes *)
+		&desc.params.raw;
+	i40e_status status;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_vsi_promiscuous_modes);
+
+	cmd->promiscuous_flags = cpu_to_le16(0);
+	cmd->valid_flags = cpu_to_le16(I40E_AQC_SET_VSI_DEFAULT);
+	cmd->seid = cpu_to_le16(seid);
+
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+	return status;
+}
+
+/**
  * i40e_aq_set_vsi_unicast_promiscuous
  * @hw: pointer to the hw struct
  * @seid: vsi number
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 80403c6..4660c5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -98,6 +98,8 @@ i40e_status i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_set_default_vsi(struct i40e_hw *hw, u16 vsi_id,
 				struct i40e_asq_cmd_details *cmd_details);
+i40e_status i40e_aq_clear_default_vsi(struct i40e_hw *hw, u16 vsi_id,
+				      struct i40e_asq_cmd_details *cmd_details);
 enum i40e_status_code i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 			bool qualified_modules, bool report_init,
 			struct i40e_aq_get_phy_abilities_resp *abilities,
-- 
2.4.11

