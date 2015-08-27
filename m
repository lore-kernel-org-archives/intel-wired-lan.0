From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:30 -0400
Subject: [Intel-wired-lan] [next PATCH S12 02/15] i40e: Additional checks
	for CEE APP priority validity
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

The firmware has added additional status information to allow software
to determine if the APP priority for FCoE/iSCSI/FIP is valid or not in
CEE DCBX mode.

This patch adds to support those additional checks and will only add
applications to the software table that have oper and sync bits set
without any error.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Change-ID: I0a76c52427dadf97d4dba4538a3068d05e4eb56b
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.c | 48 ++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
index 90de46a..9aee35d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
@@ -531,37 +531,55 @@ static void i40e_cee_to_dcb_config(
 	dcbcfg->pfc.pfcenable = cee_cfg->oper_pfc_en;
 	dcbcfg->pfc.pfccap = I40E_MAX_TRAFFIC_CLASS;
 
-	status = (tlv_status & I40E_AQC_CEE_APP_STATUS_MASK) >>
-		  I40E_AQC_CEE_APP_STATUS_SHIFT;
+	i = 0;
+	status = (tlv_status & I40E_AQC_CEE_FCOE_STATUS_MASK) >>
+		  I40E_AQC_CEE_FCOE_STATUS_SHIFT;
 	err = (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
 	sync = (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
 	oper = (status & I40E_TLV_STATUS_OPER) ? 1 : 0;
-	/* Add APPs if Error is False and Oper/Sync is True */
+	/* Add FCoE APP if Error is False and Oper/Sync is True */
 	if (!err && sync && oper) {
-		/* CEE operating configuration supports FCoE/iSCSI/FIP only */
-		dcbcfg->numapps = I40E_CEE_OPER_MAX_APPS;
-
 		/* FCoE APP */
-		dcbcfg->app[0].priority =
+		dcbcfg->app[i].priority =
 			(app_prio & I40E_AQC_CEE_APP_FCOE_MASK) >>
 			 I40E_AQC_CEE_APP_FCOE_SHIFT;
-		dcbcfg->app[0].selector = I40E_APP_SEL_ETHTYPE;
-		dcbcfg->app[0].protocolid = I40E_APP_PROTOID_FCOE;
+		dcbcfg->app[i].selector = I40E_APP_SEL_ETHTYPE;
+		dcbcfg->app[i].protocolid = I40E_APP_PROTOID_FCOE;
+		i++;
+	}
 
+	status = (tlv_status & I40E_AQC_CEE_ISCSI_STATUS_MASK) >>
+		  I40E_AQC_CEE_ISCSI_STATUS_SHIFT;
+	err = (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
+	sync = (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
+	oper = (status & I40E_TLV_STATUS_OPER) ? 1 : 0;
+	/* Add iSCSI APP if Error is False and Oper/Sync is True */
+	if (!err && sync && oper) {
 		/* iSCSI APP */
-		dcbcfg->app[1].priority =
+		dcbcfg->app[i].priority =
 			(app_prio & I40E_AQC_CEE_APP_ISCSI_MASK) >>
 			 I40E_AQC_CEE_APP_ISCSI_SHIFT;
-		dcbcfg->app[1].selector = I40E_APP_SEL_TCPIP;
-		dcbcfg->app[1].protocolid = I40E_APP_PROTOID_ISCSI;
+		dcbcfg->app[i].selector = I40E_APP_SEL_TCPIP;
+		dcbcfg->app[i].protocolid = I40E_APP_PROTOID_ISCSI;
+		i++;
+	}
 
+	status = (tlv_status & I40E_AQC_CEE_FIP_STATUS_MASK) >>
+		  I40E_AQC_CEE_FIP_STATUS_SHIFT;
+	err = (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
+	sync = (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
+	oper = (status & I40E_TLV_STATUS_OPER) ? 1 : 0;
+	/* Add FIP APP if Error is False and Oper/Sync is True */
+	if (!err && sync && oper) {
 		/* FIP APP */
-		dcbcfg->app[2].priority =
+		dcbcfg->app[i].priority =
 			(app_prio & I40E_AQC_CEE_APP_FIP_MASK) >>
 			 I40E_AQC_CEE_APP_FIP_SHIFT;
-		dcbcfg->app[2].selector = I40E_APP_SEL_ETHTYPE;
-		dcbcfg->app[2].protocolid = I40E_APP_PROTOID_FIP;
+		dcbcfg->app[i].selector = I40E_APP_SEL_ETHTYPE;
+		dcbcfg->app[i].protocolid = I40E_APP_PROTOID_FIP;
+		i++;
 	}
+	dcbcfg->numapps = i;
 }
 
 /**
-- 
1.9.3

