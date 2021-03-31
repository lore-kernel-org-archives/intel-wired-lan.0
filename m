From: Colin King <colin.king@canonical.com>
Date: Wed, 31 Mar 2021 15:46:28 +0100
Subject: [Intel-wired-lan] [PATCH][next] ice: Fix potential infinite loop
 when using u8 loop counter
Message-ID: <20210331144628.1423252-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

A for-loop is using a u8 loop counter that is being compared to
a u32 cmp_dcbcfg->numapp to check for the end of the loop. If
cmp_dcbcfg->numapp is larger than 255 then the counter j will wrap
around to zero and hence an infinite loop occurs. Fix this by making
counter j the same type as cmp_dcbcfg->numapp.

Addresses-Coverity: ("Infinite loop")
Fixes: aeac8ce864d9 ("ice: Recognize 860 as iSCSI port in CEE mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 43c6af42de8a..ee4f320d4823 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -747,8 +747,8 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 		   struct ice_port_info *pi)
 {
 	u32 status, tlv_status = le32_to_cpu(cee_cfg->tlv_status);
-	u32 ice_aqc_cee_status_mask, ice_aqc_cee_status_shift;
-	u8 i, j, err, sync, oper, app_index, ice_app_sel_type;
+	u32 ice_aqc_cee_status_mask, ice_aqc_cee_status_shift, j;
+	u8 i, err, sync, oper, app_index, ice_app_sel_type;
 	u16 app_prio = le16_to_cpu(cee_cfg->oper_app_prio);
 	u16 ice_aqc_cee_app_mask, ice_aqc_cee_app_shift;
 	struct ice_dcbx_cfg *cmp_dcbcfg, *dcbcfg;
-- 
2.30.2

