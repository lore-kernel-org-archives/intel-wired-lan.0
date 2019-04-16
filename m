From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:35:01 -0700
Subject: [Intel-wired-lan] [PATCH S21 12/14] ice: Use a different ICE_DBG
 bit for firmware log messages
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace the use of the ICE_DBG_AQ_MSG bit when dumping firmware logging
messages with a separate distinct type ICE_DBG_FW_LOG. This is useful
so that developers may enable ICE_DBG_FW_LOG and get firmware logging
messages, without also dumping AdminQ messages at the same time.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_type.h   | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6d3b863e3302..ba6ad90e8907 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -681,10 +681,10 @@ static enum ice_status ice_cfg_fw_log(struct ice_hw *hw, bool enable)
  */
 void ice_output_fw_log(struct ice_hw *hw, struct ice_aq_desc *desc, void *buf)
 {
-	ice_debug(hw, ICE_DBG_AQ_MSG, "[ FW Log Msg Start ]\n");
-	ice_debug_array(hw, ICE_DBG_AQ_MSG, 16, 1, (u8 *)buf,
+	ice_debug(hw, ICE_DBG_FW_LOG, "[ FW Log Msg Start ]\n");
+	ice_debug_array(hw, ICE_DBG_FW_LOG, 16, 1, (u8 *)buf,
 			le16_to_cpu(desc->datalen));
-	ice_debug(hw, ICE_DBG_AQ_MSG, "[ FW Log Msg End ]\n");
+	ice_debug(hw, ICE_DBG_FW_LOG, "[ FW Log Msg End ]\n");
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b6d0399f49b9..3474bccbab6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -23,6 +23,7 @@ static inline bool ice_is_tc_ena(u8 bitmap, u8 tc)
 
 /* debug masks - set these bits in hw->debug_mask to control output */
 #define ICE_DBG_INIT		BIT_ULL(1)
+#define ICE_DBG_FW_LOG		BIT_ULL(3)
 #define ICE_DBG_LINK		BIT_ULL(4)
 #define ICE_DBG_PHY		BIT_ULL(5)
 #define ICE_DBG_QCTX		BIT_ULL(6)
-- 
2.20.1

