From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 13 Apr 2016 03:08:24 -0700
Subject: [Intel-wired-lan] [next PATCH S34 04/12] i40e: Remove HMC AQ API
	implementation
In-Reply-To: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460542112-20166-5-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Remove the code that implements the HMC AQ APIs and call these APIs.
This is done because these are obsolete APIs and are not supported
by firmware.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: I5d771d8f37c3e16e7b0a972ff9b27e75aa2d05d4
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c      |  4 ---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 25 ------------------
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 30 ----------------------
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  4 ---
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 25 ------------------
 5 files changed, 88 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 43bb413..738b42a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -617,10 +617,6 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 	hw->nvm_release_on_done = false;
 	hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
 
-	ret_code = i40e_aq_set_hmc_resource_profile(hw,
-						    I40E_HMC_PROFILE_DEFAULT,
-						    0,
-						    NULL);
 	ret_code = 0;
 
 	/* success! */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 5179b3b..48c0c00 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -205,10 +205,6 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_resume_port_tx				= 0x041C,
 	i40e_aqc_opc_configure_partition_bw			= 0x041D,
 
-	/* hmc */
-	i40e_aqc_opc_query_hmc_resource_profile	= 0x0500,
-	i40e_aqc_opc_set_hmc_resource_profile	= 0x0501,
-
 	/* phy commands*/
 	i40e_aqc_opc_get_phy_abilities		= 0x0600,
 	i40e_aqc_opc_set_phy_config		= 0x0601,
@@ -1586,27 +1582,6 @@ struct i40e_aqc_configure_partition_bw_data {
 
 I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
 
-/* Get and set the active HMC resource profile and status.
- * (direct 0x0500) and (direct 0x0501)
- */
-struct i40e_aq_get_set_hmc_resource_profile {
-	u8	pm_profile;
-	u8	pe_vf_enabled;
-	u8	reserved[14];
-};
-
-I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
-
-enum i40e_aq_hmc_profile {
-	/* I40E_HMC_PROFILE_NO_CHANGE    = 0, reserved */
-	I40E_HMC_PROFILE_DEFAULT	= 1,
-	I40E_HMC_PROFILE_FAVOR_VF	= 2,
-	I40E_HMC_PROFILE_EQUAL		= 3,
-};
-
-#define I40E_AQ_GET_HMC_RESOURCE_PROFILE_PM_MASK	0xF
-#define I40E_AQ_GET_HMC_RESOURCE_PROFILE_COUNT_MASK	0x3F
-
 /* Get PHY Abilities (indirect 0x0600) uses the generic indirect struct */
 
 /* set in param0 for get phy abilities to report qualified modules */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 0e8552b..4a934e1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2855,36 +2855,6 @@ i40e_status i40e_aq_debug_write_register(struct i40e_hw *hw,
 }
 
 /**
- * i40e_aq_set_hmc_resource_profile
- * @hw: pointer to the hw struct
- * @profile: type of profile the HMC is to be set as
- * @pe_vf_enabled_count: the number of PE enabled VFs the system has
- * @cmd_details: pointer to command details structure or NULL
- *
- * set the HMC profile of the device.
- **/
-i40e_status i40e_aq_set_hmc_resource_profile(struct i40e_hw *hw,
-				enum i40e_aq_hmc_profile profile,
-				u8 pe_vf_enabled_count,
-				struct i40e_asq_cmd_details *cmd_details)
-{
-	struct i40e_aq_desc desc;
-	struct i40e_aq_get_set_hmc_resource_profile *cmd =
-		(struct i40e_aq_get_set_hmc_resource_profile *)&desc.params.raw;
-	i40e_status status;
-
-	i40e_fill_default_direct_cmd_desc(&desc,
-					i40e_aqc_opc_set_hmc_resource_profile);
-
-	cmd->pm_profile = (u8)profile;
-	cmd->pe_vf_enabled = pe_vf_enabled_count;
-
-	status = i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
-
-	return status;
-}
-
-/**
  * i40e_aq_request_resource
  * @hw: pointer to the hw struct
  * @resource: resource id
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 8afb237..4c8977c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -236,10 +236,6 @@ i40e_status i40e_aq_config_vsi_bw_limit(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_dcb_updated(struct i40e_hw *hw,
 				struct i40e_asq_cmd_details *cmd_details);
-i40e_status i40e_aq_set_hmc_resource_profile(struct i40e_hw *hw,
-				enum i40e_aq_hmc_profile profile,
-				u8 pe_vf_enabled_count,
-				struct i40e_asq_cmd_details *cmd_details);
 i40e_status i40e_aq_config_switch_comp_bw_limit(struct i40e_hw *hw,
 				u16 seid, u16 credit, u8 max_bw,
 				struct i40e_asq_cmd_details *cmd_details);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 1bcb8cf..180ae57 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -205,10 +205,6 @@ enum i40e_admin_queue_opc {
 	i40e_aqc_opc_resume_port_tx				= 0x041C,
 	i40e_aqc_opc_configure_partition_bw			= 0x041D,
 
-	/* hmc */
-	i40e_aqc_opc_query_hmc_resource_profile	= 0x0500,
-	i40e_aqc_opc_set_hmc_resource_profile	= 0x0501,
-
 	/* phy commands*/
 	i40e_aqc_opc_get_phy_abilities		= 0x0600,
 	i40e_aqc_opc_set_phy_config		= 0x0601,
@@ -1583,27 +1579,6 @@ struct i40e_aqc_configure_partition_bw_data {
 
 I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
 
-/* Get and set the active HMC resource profile and status.
- * (direct 0x0500) and (direct 0x0501)
- */
-struct i40e_aq_get_set_hmc_resource_profile {
-	u8	pm_profile;
-	u8	pe_vf_enabled;
-	u8	reserved[14];
-};
-
-I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
-
-enum i40e_aq_hmc_profile {
-	/* I40E_HMC_PROFILE_NO_CHANGE    = 0, reserved */
-	I40E_HMC_PROFILE_DEFAULT	= 1,
-	I40E_HMC_PROFILE_FAVOR_VF	= 2,
-	I40E_HMC_PROFILE_EQUAL		= 3,
-};
-
-#define I40E_AQ_GET_HMC_RESOURCE_PROFILE_PM_MASK	0xF
-#define I40E_AQ_GET_HMC_RESOURCE_PROFILE_COUNT_MASK	0x3F
-
 /* Get PHY Abilities (indirect 0x0600) uses the generic indirect struct */
 
 /* set in param0 for get phy abilities to report qualified modules */
-- 
2.4.3

