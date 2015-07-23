From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:32 -0400
Subject: [Intel-wired-lan] [next PATCH S9 03/15] i40e: fixup padding issue
	in get_cee_dcb_cfg_v1_resp
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The struct i40e_aqc_get_cee_dcb_cfg_v1_resp was originally defined with
word boundary layout issues, which most compilers deal with by silently
adding padding, making the actual struct larger than designed.
This patch adds an extra byte in fields reserved3 and reserved4 to directly
acknowledge that padding.

Because the struct doesn't actually change in size or layout, this doesn't
constitute a change in the API.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I53fa4741b73fa255621232a85fba000b0e223015
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 95d23bf..b840fab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2074,6 +2074,15 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
 #define I40E_AQC_CEE_ISCSI_STATUS_MASK	(0x7 << I40E_AQC_CEE_ISCSI_STATUS_SHIFT)
 #define I40E_AQC_CEE_FIP_STATUS_SHIFT	0x10
 #define I40E_AQC_CEE_FIP_STATUS_MASK	(0x7 << I40E_AQC_CEE_FIP_STATUS_SHIFT)
+
+/* struct i40e_aqc_get_cee_dcb_cfg_v1_resp was originally defined with
+ * word boundary layout issues, which the Linux compilers silently deal
+ * with by adding padding, making the actual struct larger than designed.
+ * However, the FW compiler for the NIC is less lenient and complains
+ * about the struct.  Hence, the struct defined here has an extra byte in
+ * fields reserved3 and reserved4 to directly acknowledge that padding,
+ * and the new length is used in the length check macro.
+ */
 struct i40e_aqc_get_cee_dcb_cfg_v1_resp {
 	u8	reserved1;
 	u8	oper_num_tc;
@@ -2081,9 +2090,9 @@ struct i40e_aqc_get_cee_dcb_cfg_v1_resp {
 	u8	reserved2;
 	u8	oper_tc_bw[8];
 	u8	oper_pfc_en;
-	u8	reserved3;
+	u8	reserved3[2];
 	__le16	oper_app_prio;
-	u8	reserved4;
+	u8	reserved4[2];
 	__le16	tlv_status;
 };
 
-- 
1.9.3

