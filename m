From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:06 -0800
Subject: [Intel-wired-lan] [PATCH S55 07/14] ice: use kernel definitions for
 IANA protocol ports and ether-types
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The well-known IANA protocol port 3260 (iscsi-target 0x0cbc) and the
ether-types 0x8906 (ETH_P_FCOE) and 0x8914 (ETH_P_FIP) are already defined
in kernel header files.  Use those definitions instead of open-coding the
same.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 3 +++
 drivers/net/ethernet/intel/ice/ice_dcb.c     | 8 ++++----
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_type.h    | 3 ---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ca94b01626d2..a0233962a672 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -44,6 +44,9 @@
 #include <net/gre.h>
 #include <net/udp_tunnel.h>
 #include <net/vxlan.h>
+#if IS_ENABLED(CONFIG_DCB)
+#include <scsi/iscsi_proto.h>
+#endif /* CONFIG_DCB */
 #include "ice_devids.h"
 #include "ice_type.h"
 #include "ice_txrx.h"
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 211ac6f907ad..356fc0f025a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -804,7 +804,7 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 			ice_aqc_cee_app_mask = ICE_AQC_CEE_APP_FCOE_M;
 			ice_aqc_cee_app_shift = ICE_AQC_CEE_APP_FCOE_S;
 			ice_app_sel_type = ICE_APP_SEL_ETHTYPE;
-			ice_app_prot_id_type = ICE_APP_PROT_ID_FCOE;
+			ice_app_prot_id_type = ETH_P_FCOE;
 		} else if (i == 1) {
 			/* iSCSI APP */
 			ice_aqc_cee_status_mask = ICE_AQC_CEE_ISCSI_STATUS_M;
@@ -812,14 +812,14 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 			ice_aqc_cee_app_mask = ICE_AQC_CEE_APP_ISCSI_M;
 			ice_aqc_cee_app_shift = ICE_AQC_CEE_APP_ISCSI_S;
 			ice_app_sel_type = ICE_APP_SEL_TCPIP;
-			ice_app_prot_id_type = ICE_APP_PROT_ID_ISCSI;
+			ice_app_prot_id_type = ISCSI_LISTEN_PORT;
 
 			for (j = 0; j < cmp_dcbcfg->numapps; j++) {
 				u16 prot_id = cmp_dcbcfg->app[j].prot_id;
 				u8 sel = cmp_dcbcfg->app[j].selector;
 
 				if  (sel == ICE_APP_SEL_TCPIP &&
-				     (prot_id == ICE_APP_PROT_ID_ISCSI ||
+				     (prot_id == ISCSI_LISTEN_PORT ||
 				      prot_id == ICE_APP_PROT_ID_ISCSI_860)) {
 					ice_app_prot_id_type = prot_id;
 					break;
@@ -832,7 +832,7 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 			ice_aqc_cee_app_mask = ICE_AQC_CEE_APP_FIP_M;
 			ice_aqc_cee_app_shift = ICE_AQC_CEE_APP_FIP_S;
 			ice_app_sel_type = ICE_APP_SEL_ETHTYPE;
-			ice_app_prot_id_type = ICE_APP_PROT_ID_FIP;
+			ice_app_prot_id_type = ETH_P_FIP;
 		}
 
 		status = (tlv_status & ice_aqc_cee_status_mask) >>
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 1e8f71ffc8ce..df02cffdf209 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -563,7 +563,7 @@ static int ice_dcb_sw_dflt_cfg(struct ice_pf *pf, bool ets_willing, bool locked)
 	dcbcfg->numapps = 1;
 	dcbcfg->app[0].selector = ICE_APP_SEL_ETHTYPE;
 	dcbcfg->app[0].priority = 3;
-	dcbcfg->app[0].prot_id = ICE_APP_PROT_ID_FCOE;
+	dcbcfg->app[0].prot_id = ETH_P_FCOE;
 
 	ret = ice_pf_dcb_cfg(pf, dcbcfg, locked);
 	kfree(dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 8545cba987b1..208989b5629d 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -561,10 +561,7 @@ struct ice_dcb_app_priority_table {
 #define ICE_TLV_STATUS_OPER	0x1
 #define ICE_TLV_STATUS_SYNC	0x2
 #define ICE_TLV_STATUS_ERR	0x4
-#define ICE_APP_PROT_ID_FCOE	0x8906
-#define ICE_APP_PROT_ID_ISCSI	0x0cbc
 #define ICE_APP_PROT_ID_ISCSI_860 0x035c
-#define ICE_APP_PROT_ID_FIP	0x8914
 #define ICE_APP_SEL_ETHTYPE	0x1
 #define ICE_APP_SEL_TCPIP	0x2
 #define ICE_CEE_APP_SEL_ETHTYPE	0x0
-- 
2.20.1

