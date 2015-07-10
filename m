From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:09 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 14/15]
	i40e/i40evf: Cache the CEE TLV status returned from firmware
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

Store the CEE TLV status returned by firmware to allow drivers to dump that
for debug purposes.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: Ie3c4cf8cebabee4f15e1e3fdc4fc8a68bbca40ee
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 4 ++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 2547aa2..90de46a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -588,6 +588,8 @@ i40e_status i40e_get_dcb_config(struct i40e_hw *hw)
 		if (!ret) {
 			/* CEE mode */
 			hw->local_dcbx_config.dcbx_mode = I40E_DCBX_MODE_CEE;
+			hw->local_dcbx_config.tlv_status =
+					le16_to_cpu(cee_v1_cfg.tlv_status);
 			i40e_cee_to_dcb_v1_config(&cee_v1_cfg,
 						  &hw->local_dcbx_config);
 		}
@@ -597,6 +599,8 @@ i40e_status i40e_get_dcb_config(struct i40e_hw *hw)
 		if (!ret) {
 			/* CEE mode */
 			hw->local_dcbx_config.dcbx_mode = I40E_DCBX_MODE_CEE;
+			hw->local_dcbx_config.tlv_status =
+					le32_to_cpu(cee_cfg.tlv_status);
 			i40e_cee_to_dcb_config(&cee_cfg,
 					       &hw->local_dcbx_config);
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index acb2aad..4842239 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -440,6 +440,7 @@ struct i40e_dcbx_config {
 #define I40E_DCBX_MODE_CEE	0x1
 #define I40E_DCBX_MODE_IEEE	0x2
 	u32 numapps;
+	u32 tlv_status; /* CEE mode TLV status */
 	struct i40e_dcb_ets_config etscfg;
 	struct i40e_dcb_ets_config etsrec;
 	struct i40e_dcb_pfc_config pfc;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 1ab2498..24a2693 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -434,6 +434,7 @@ struct i40e_ieee_app_priority_table {
 
 struct i40e_dcbx_config {
 	u32 numapps;
+	u32 tlv_status; /* CEE mode TLV status */
 	struct i40e_ieee_ets_config etscfg;
 	struct i40e_ieee_ets_recommend etsrec;
 	struct i40e_ieee_pfc_config pfc;
-- 
1.9.3

