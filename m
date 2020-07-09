From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  9 Jul 2020 09:16:00 -0700
Subject: [Intel-wired-lan] [PATCH S49 01/15] ice: refactor ice_discover_caps
 to avoid need to retry
Message-ID: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_discover_caps function is used to read the device and function
capabilities, updating the hardware capabilities structures with
relevant data.

The exact number of capabilities returned by the hardware is unknown
ahead of time. The AdminQ command will report the total number of
capabilities in the return buffer.

The current implementation involves requesting capabilities once,
reading this returned size, and then re-requested with that size.

This isn't really necessary. The firmware interface has a maximum size
of ICE_AQ_MAX_BUF_LEN. Firmware can never return more than
ICE_AQ_MAX_BUF_LEN / sizeof(struct ice_aqc_list_caps_elem) capabilities.

Avoid the retry loop by simply allocating a buffer of size
ICE_AQ_MAX_BUF_LEN. This is significantly simpler than retrying. The
extra allocation isn't a big deal, as it will be released after we
finish parsing the capabilities.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 43 ++++++---------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 57fd815c41bc..37ea042ece13 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1901,40 +1901,21 @@ ice_discover_caps(struct ice_hw *hw, enum ice_adminq_opc opc)
 {
 	enum ice_status status;
 	u32 cap_count;
-	u16 cbuf_len;
-	u8 retries;
-
-	/* The driver doesn't know how many capabilities the device will return
-	 * so the buffer size required isn't known ahead of time. The driver
-	 * starts with cbuf_len and if this turns out to be insufficient, the
-	 * device returns ICE_AQ_RC_ENOMEM and also the cap_count it needs.
-	 * The driver then allocates the buffer based on the count and retries
-	 * the operation. So it follows that the retry count is 2.
-	 */
-#define ICE_GET_CAP_BUF_COUNT	40
-#define ICE_GET_CAP_RETRY_COUNT	2
-
-	cap_count = ICE_GET_CAP_BUF_COUNT;
-	retries = ICE_GET_CAP_RETRY_COUNT;
-
-	do {
-		void *cbuf;
-
-		cbuf_len = (u16)(cap_count *
-				 sizeof(struct ice_aqc_list_caps_elem));
-		cbuf = devm_kzalloc(ice_hw_to_dev(hw), cbuf_len, GFP_KERNEL);
-		if (!cbuf)
-			return ICE_ERR_NO_MEMORY;
+	void *cbuf;
 
-		status = ice_aq_discover_caps(hw, cbuf, cbuf_len, &cap_count,
-					      opc, NULL);
-		devm_kfree(ice_hw_to_dev(hw), cbuf);
+	cbuf = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!cbuf)
+		return ICE_ERR_NO_MEMORY;
 
-		if (!status || hw->adminq.sq_last_status != ICE_AQ_RC_ENOMEM)
-			break;
+	/* Although the driver doesn't know the number of capabilities the
+	 * device will return, we can simply send a 4KB buffer, the maximum
+	 * possible size that firmware can return.
+	 */
+	cap_count = ICE_AQ_MAX_BUF_LEN / sizeof(struct ice_aqc_list_caps_elem);
 
-		/* If ENOMEM is returned, try again with bigger buffer */
-	} while (--retries);
+	status = ice_aq_discover_caps(hw, cbuf, ICE_AQ_MAX_BUF_LEN, &cap_count,
+				      opc, NULL);
+	kfree(cbuf);
 
 	return status;
 }
-- 
2.20.1

