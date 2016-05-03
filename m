From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  3 May 2016 15:13:11 -0700
Subject: [Intel-wired-lan] [next PATCH S36 03/12] i40e: Implement the API
	function for aq_set_switch_config
In-Reply-To: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1462313600-3123-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the support code for calling the AdminQ API call aq_set_switch_config

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
---
Testing Hints : Apply and compile cleanly

 drivers/net/ethernet/intel/i40e/i40e_common.c    | 29 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_prototype.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 4a934e1..4739a9c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2283,6 +2283,35 @@ i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
 }
 
 /**
+ * i40e_aq_set_switch_config
+ * @hw: pointer to the hardware structure
+ * @flags: bit flag values to set
+ * @valid_flags: which bit flags to set
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Set switch configuration bits
+ **/
+enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
+						u16 flags,
+						u16 valid_flags,
+				struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_desc desc;
+	struct i40e_aqc_set_switch_config *scfg =
+		(struct i40e_aqc_set_switch_config *)&desc.params.raw;
+	enum i40e_status_code status;
+
+	i40e_fill_default_direct_cmd_desc(&desc,
+					  i40e_aqc_opc_set_switch_config);
+	scfg->flags = cpu_to_le16(flags);
+	scfg->valid_flags = cpu_to_le16(valid_flags);
+
+	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+
+	return status;
+}
+
+/**
  * i40e_aq_get_firmware_version
  * @hw: pointer to the hw struct
  * @fw_major_version: firmware major version
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 4c8977c..b76b158 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -182,6 +182,10 @@ i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
 				struct i40e_aqc_get_switch_config_resp *buf,
 				u16 buf_size, u16 *start_seid,
 				struct i40e_asq_cmd_details *cmd_details);
+enum i40e_status_code i40e_aq_set_switch_config(struct i40e_hw *hw,
+						u16 flags,
+						u16 valid_flags,
+				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_request_resource(struct i40e_hw *hw,
 				enum i40e_aq_resources_ids resource,
 				enum i40e_aq_resource_access_type access,
-- 
2.4.11

