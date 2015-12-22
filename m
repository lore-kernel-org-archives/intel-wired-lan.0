From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:09 -0800
Subject: [Intel-wired-lan] [next PATCH S24 07/12] i40e: add new proxy-wol
	bit for X722
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-8-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the new proxy-wake-on-lan capability bit available with the
new X722 device.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
Testing-Hints:
Apply and compile cleanly.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 256ce65..bff0995 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -402,6 +402,7 @@ struct i40e_aqc_list_capabilities_element_resp {
 #define I40E_AQ_CAP_ID_OS2BMC_CAP	0x0004
 #define I40E_AQ_CAP_ID_FUNCTIONS_VALID	0x0005
 #define I40E_AQ_CAP_ID_ALTERNATE_RAM	0x0006
+#define I40E_AQ_CAP_ID_WOL_AND_PROXY	0x0008
 #define I40E_AQ_CAP_ID_SRIOV		0x0012
 #define I40E_AQ_CAP_ID_VF		0x0013
 #define I40E_AQ_CAP_ID_VMDQ		0x0014
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index 0d3bc3b..365a7d6 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -399,6 +399,7 @@ struct i40e_aqc_list_capabilities_element_resp {
 #define I40E_AQ_CAP_ID_OS2BMC_CAP	0x0004
 #define I40E_AQ_CAP_ID_FUNCTIONS_VALID	0x0005
 #define I40E_AQ_CAP_ID_ALTERNATE_RAM	0x0006
+#define I40E_AQ_CAP_ID_WOL_AND_PROXY	0x0008
 #define I40E_AQ_CAP_ID_SRIOV		0x0012
 #define I40E_AQ_CAP_ID_VF		0x0013
 #define I40E_AQ_CAP_ID_VMDQ		0x0014
-- 
2.1.0

