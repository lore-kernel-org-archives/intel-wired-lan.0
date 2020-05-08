From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:12 -0700
Subject: [Intel-wired-lan] [PATCH S41 14/15] ice: remove unnecessary
 backslash
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Self-explanatory.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 214c8f1c699f..6988727ce82c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -542,7 +542,7 @@ struct ice_sw_rule_lkup_rx_tx {
 #define ICE_SINGLE_ACT_OTHER_ACTS		0x3
 #define ICE_SINGLE_OTHER_ACT_IDENTIFIER_S	17
 #define ICE_SINGLE_OTHER_ACT_IDENTIFIER_M	\
-				(0x3 << \ ICE_SINGLE_OTHER_ACT_IDENTIFIER_S)
+				(0x3 << ICE_SINGLE_OTHER_ACT_IDENTIFIER_S)
 
 	/* Bit 17:18 - Defines other actions */
 	/* Other action = 0 - Mirror VSI */
-- 
2.20.1

