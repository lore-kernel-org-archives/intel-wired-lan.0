From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 20 Jul 2018 13:53:42 -0700
Subject: [Intel-wired-lan] [RFC 02/13] ice: Get both device and function
 capabilities
In-Reply-To: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
References: <20180720205353.13296-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180720205353.13296-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Phani R Burra <phani.r.burra@intel.com>

Expand ice_get_caps to also get device capabilities along with function
capabilities.

Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 71d032cc5fa7..730c0e77d655 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1200,10 +1200,12 @@ ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u16 *data_size,
 }
 
 /**
- * ice_get_caps - get info about the HW
+ * ice_discover_caps - get info about the HW
  * @hw: pointer to the hardware structure
+ * @opc: capabilities type to discover - pass in the command opcode
  */
-enum ice_status ice_get_caps(struct ice_hw *hw)
+static enum ice_status ice_discover_caps(struct ice_hw *hw,
+					 enum ice_adminq_opc opc)
 {
 	enum ice_status status;
 	u16 data_size = 0;
@@ -1233,7 +1235,7 @@ enum ice_status ice_get_caps(struct ice_hw *hw)
 			return ICE_ERR_NO_MEMORY;
 
 		status = ice_aq_discover_caps(hw, cbuf, cbuf_len, &data_size,
-					      ice_aqc_opc_list_func_caps, NULL);
+					      opc, NULL);
 		devm_kfree(ice_hw_to_dev(hw), cbuf);
 
 		if (!status || hw->adminq.sq_last_status != ICE_AQ_RC_ENOMEM)
@@ -1246,6 +1248,21 @@ enum ice_status ice_get_caps(struct ice_hw *hw)
 	return status;
 }
 
+/**
+ * ice_get_caps - get info about the HW
+ * @hw: pointer to the hardware structure
+ */
+enum ice_status ice_get_caps(struct ice_hw *hw)
+{
+	enum ice_status status;
+
+	status = ice_discover_caps(hw, ice_aqc_opc_list_dev_caps);
+	if (!status)
+		status = ice_discover_caps(hw, ice_aqc_opc_list_func_caps);
+
+	return status;
+}
+
 /**
  * ice_aq_manage_mac_write - manage MAC address write command
  * @hw: pointer to the hw struct
-- 
2.14.3

