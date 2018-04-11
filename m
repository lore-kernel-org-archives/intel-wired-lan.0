From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 11 Apr 2018 10:41:47 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix incorrect comment for action type
Message-ID: <20180411174147.14941-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Action type 5 defines large action generic values. Fix comment to
reflect that better.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 5b13ca1bd85f..7dc5f045e969 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -586,7 +586,7 @@ struct ice_sw_rule_lg_act {
 #define ICE_LG_ACT_MIRROR_VSI_ID_S	3
 #define ICE_LG_ACT_MIRROR_VSI_ID_M	(0x3FF << ICE_LG_ACT_MIRROR_VSI_ID_S)
 
-	/* Action type = 5 - Large Action */
+	/* Action type = 5 - Generic Value */
 #define ICE_LG_ACT_GENERIC		0x5
 #define ICE_LG_ACT_GENERIC_VALUE_S	3
 #define ICE_LG_ACT_GENERIC_VALUE_M	(0xFFFF << ICE_LG_ACT_GENERIC_VALUE_S)
-- 
2.14.3

