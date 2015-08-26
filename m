From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:12 -0400
Subject: [Intel-wired-lan] [next PATCH S11 06/15] i40e: fix bad CEE status
	shift value
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Fix a shift value that was wrong, ending up with a bad bitmask.  Also add
a blank line between two sets of #defines for better readability.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I3e41fa2a2ab904d3a4e6cbf13972ab0036a10601
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index b840fab..785b3db 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -2062,6 +2062,7 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
 #define I40E_AQC_CEE_APP_ISCSI_MASK	(0x7 << I40E_AQC_CEE_APP_ISCSI_SHIFT)
 #define I40E_AQC_CEE_APP_FIP_SHIFT	0x8
 #define I40E_AQC_CEE_APP_FIP_MASK	(0x7 << I40E_AQC_CEE_APP_FIP_SHIFT)
+
 #define I40E_AQC_CEE_PG_STATUS_SHIFT	0x0
 #define I40E_AQC_CEE_PG_STATUS_MASK	(0x7 << I40E_AQC_CEE_PG_STATUS_SHIFT)
 #define I40E_AQC_CEE_PFC_STATUS_SHIFT	0x3
@@ -2070,7 +2071,7 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
 #define I40E_AQC_CEE_APP_STATUS_MASK	(0x7 << I40E_AQC_CEE_APP_STATUS_SHIFT)
 #define I40E_AQC_CEE_FCOE_STATUS_SHIFT	0x8
 #define I40E_AQC_CEE_FCOE_STATUS_MASK	(0x7 << I40E_AQC_CEE_FCOE_STATUS_SHIFT)
-#define I40E_AQC_CEE_ISCSI_STATUS_SHIFT	0xA
+#define I40E_AQC_CEE_ISCSI_STATUS_SHIFT	0xB
 #define I40E_AQC_CEE_ISCSI_STATUS_MASK	(0x7 << I40E_AQC_CEE_ISCSI_STATUS_SHIFT)
 #define I40E_AQC_CEE_FIP_STATUS_SHIFT	0x10
 #define I40E_AQC_CEE_FIP_STATUS_MASK	(0x7 << I40E_AQC_CEE_FIP_STATUS_SHIFT)
-- 
1.9.3

