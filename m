From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:12 -0800
Subject: [Intel-wired-lan] [next PATCH S24 10/12] i40e: AQ Geneve cloud
	tunnel type
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-11-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Fix the name of the new cloud tunnel type from the place-holder NGE
name to the official Geneve.  Also fix the spelling of the VXLAN type.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
Testing-Hints:
Apply and compile cleanly.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 ++--
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 9e340ca..eab55ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1260,9 +1260,9 @@ struct i40e_aqc_add_remove_cloud_filters_element_data {
 
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT		9
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK		0x1E00
-#define I40E_AQC_ADD_CLOUD_TNL_TYPE_XVLAN		0
+#define I40E_AQC_ADD_CLOUD_TNL_TYPE_VXLAN		0
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_NVGRE_OMAC		1
-#define I40E_AQC_ADD_CLOUD_TNL_TYPE_NGE			2
+#define I40E_AQC_ADD_CLOUD_TNL_TYPE_GENEVE		2
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_IP			3
 
 	__le32	tenant_id;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 51d83c6..30b5a33 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1257,9 +1257,9 @@ struct i40e_aqc_add_remove_cloud_filters_element_data {
 
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT		9
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK		0x1E00
-#define I40E_AQC_ADD_CLOUD_TNL_TYPE_XVLAN		0
+#define I40E_AQC_ADD_CLOUD_TNL_TYPE_VXLAN		0
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_NVGRE_OMAC		1
-#define I40E_AQC_ADD_CLOUD_TNL_TYPE_NGE			2
+#define I40E_AQC_ADD_CLOUD_TNL_TYPE_GENEVE		2
 #define I40E_AQC_ADD_CLOUD_TNL_TYPE_IP			3
 
 	__le32	tenant_id;
-- 
2.1.0

