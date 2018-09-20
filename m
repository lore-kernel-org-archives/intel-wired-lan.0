From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:10 -0700
Subject: [Intel-wired-lan] [PATCH 7/8] ice: Update to capabilities admin
 queue command
In-Reply-To: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002311.10891-8-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes a couple of changes in the way the driver uses the
"get capabilities" command.

1. Get device capabilities in addition to function capabilities

2. Align to latest spec by using cap_count to determine size of the
   buffer in case of length error.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 50 ++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0847dbf9d42f..decfdb065a20 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1451,7 +1451,7 @@ ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
  * @hw: pointer to the hw struct
  * @buf: a virtual buffer to hold the capabilities
  * @buf_size: Size of the virtual buffer
- * @data_size: Size of the returned data, or buf size needed if AQ err==ENOMEM
+ * @cap_count: cap count needed if AQ err==ENOMEM
  * @opc: capabilities type to discover - pass in the command opcode
  * @cd: pointer to command details structure or NULL
  *
@@ -1459,7 +1459,7 @@ ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
  * the firmware.
  */
 static enum ice_status
-ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u16 *data_size,
+ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u32 *cap_count,
 		     enum ice_adminq_opc opc, struct ice_sq_cd *cd)
 {
 	struct ice_aqc_list_caps *cmd;
@@ -1477,58 +1477,76 @@ ice_aq_discover_caps(struct ice_hw *hw, void *buf, u16 buf_size, u16 *data_size,
 	status = ice_aq_send_cmd(hw, &desc, buf, buf_size, cd);
 	if (!status)
 		ice_parse_caps(hw, buf, le32_to_cpu(cmd->count), opc);
-	*data_size = le16_to_cpu(desc.datalen);
-
+	else if (hw->adminq.sq_last_status == ICE_AQ_RC_ENOMEM)
+		*cap_count =
+			DIV_ROUND_UP(le16_to_cpu(desc.datalen),
+				     sizeof(struct ice_aqc_list_caps_elem));
 	return status;
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
-	u16 data_size = 0;
+	u32 cap_count;
 	u16 cbuf_len;
 	u8 retries;
 
 	/* The driver doesn't know how many capabilities the device will return
 	 * so the buffer size required isn't known ahead of time. The driver
 	 * starts with cbuf_len and if this turns out to be insufficient, the
-	 * device returns ICE_AQ_RC_ENOMEM and also the buffer size it needs.
-	 * The driver then allocates the buffer of this size and retries the
-	 * operation. So it follows that the retry count is 2.
+	 * device returns ICE_AQ_RC_ENOMEM and also the cap_count it needs.
+	 * The driver then allocates the buffer based on the count and retries
+	 * the operation. So it follows that the retry count is 2.
 	 */
 #define ICE_GET_CAP_BUF_COUNT	40
 #define ICE_GET_CAP_RETRY_COUNT	2
 
-	cbuf_len = ICE_GET_CAP_BUF_COUNT *
-		sizeof(struct ice_aqc_list_caps_elem);
-
+	cap_count = ICE_GET_CAP_BUF_COUNT;
 	retries = ICE_GET_CAP_RETRY_COUNT;
 
 	do {
 		void *cbuf;
 
+		cbuf_len = (u16)(cap_count *
+				 sizeof(struct ice_aqc_list_caps_elem));
 		cbuf = devm_kzalloc(ice_hw_to_dev(hw), cbuf_len, GFP_KERNEL);
 		if (!cbuf)
 			return ICE_ERR_NO_MEMORY;
 
-		status = ice_aq_discover_caps(hw, cbuf, cbuf_len, &data_size,
-					      ice_aqc_opc_list_func_caps, NULL);
+		status = ice_aq_discover_caps(hw, cbuf, cbuf_len, &cap_count,
+					      opc, NULL);
 		devm_kfree(ice_hw_to_dev(hw), cbuf);
 
 		if (!status || hw->adminq.sq_last_status != ICE_AQ_RC_ENOMEM)
 			break;
 
 		/* If ENOMEM is returned, try again with bigger buffer */
-		cbuf_len = data_size;
 	} while (--retries);
 
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

