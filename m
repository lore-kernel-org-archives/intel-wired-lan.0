From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 26 Jan 2022 16:03:20 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 2/2] iavf: Fix incorrect use
 of assigning iavf_status to int
Message-ID: <20220126150320.28079-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently there are functions in iavf_virtchnl.c for polling specific
virtchnl receive events. These are all assigning iavf_status values to
int values. Fix this and explicitly assign int values if iavf_status
is not IAVF_SUCCESS.

Also, refactor a small amount of duplicated code that can be reused by
all of the previously mentioned functions.

Finally, fix some spacing errors for variable assignment and get rid of
all the goto statements in the refactored functions for clarity.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Submit this with additional patch introducing iavf_status_to_errno function
---
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 160 ++++++++----------
 2 files changed, 69 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 4fd2a47..a6d7259 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1551,7 +1551,7 @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 	}
 
 	status = iavf_aq_set_rss_lut(hw, adapter->vsi.id, false,
-				  adapter->rss_lut, adapter->rss_lut_size);
+				     adapter->rss_lut, adapter->rss_lut_size);
 	if (status) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS lut, err %s aq_err %s\n",
 			iavf_stat_str(hw, status),
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 2545336..2bac7a9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -54,6 +54,41 @@ int iavf_send_api_ver(struct iavf_adapter *adapter)
 				sizeof(vvi));
 }
 
+/**
+ * iavf_poll_virtchnl_msg
+ * @hw: HW configuration structure
+ * @event: event to populate on success
+ * @op_to_poll: requested virtchnl op to poll for
+ *
+ * Initialize poll for virtchnl msg matching the requested_op. Returns 0
+ * if a message of the correct opcode is in the queue or an error code
+ * if no message matching the op code is waiting and other failures.
+ */
+static enum iavf_status
+iavf_poll_virtchnl_msg(struct iavf_hw *hw, struct iavf_arq_event_info *event,
+		       enum virtchnl_ops op_to_poll)
+{
+	enum virtchnl_ops received_op;
+	enum iavf_status status;
+	u32 v_retval;
+
+	while (1) {
+		/* When the AQ is empty, iavf_clean_arq_element will return
+		 * nonzero and this loop will terminate.
+		 */
+		status = iavf_clean_arq_element(hw, event, NULL);
+		if (status != IAVF_SUCCESS)
+			return iavf_status_to_errno(status);
+		received_op =
+		    (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
+		if (op_to_poll == received_op)
+			break;
+	}
+
+	v_retval = le32_to_cpu(event->desc.cookie_low);
+	return virtchnl_status_to_errno((enum virtchnl_status_code)v_retval);
+}
+
 /**
  * iavf_verify_api_ver
  * @adapter: adapter structure
@@ -65,55 +100,28 @@ int iavf_send_api_ver(struct iavf_adapter *adapter)
  **/
 int iavf_verify_api_ver(struct iavf_adapter *adapter)
 {
-	struct virtchnl_version_info *pf_vvi;
-	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_arq_event_info event;
-	enum virtchnl_ops op;
-	enum iavf_status err;
+	int err;
 
 	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
-	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
-	if (!event.msg_buf) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	while (1) {
-		err = iavf_clean_arq_element(hw, &event, NULL);
-		/* When the AQ is empty, iavf_clean_arq_element will return
-		 * nonzero and this loop will terminate.
-		 */
-		if (err)
-			goto out_alloc;
-		op =
-		    (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
-		if (op == VIRTCHNL_OP_VERSION)
-			break;
-	}
-
+	event.msg_buf = kzalloc(IAVF_MAX_AQ_BUF_SIZE, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
 
-	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
-	if (err)
-		goto out_alloc;
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event, VIRTCHNL_OP_VERSION);
+	if (!err) {
+		struct virtchnl_version_info *pf_vvi =
+			(struct virtchnl_version_info *)event.msg_buf;
+		adapter->pf_version = *pf_vvi;
 
-	if (op != VIRTCHNL_OP_VERSION) {
-		dev_info(&adapter->pdev->dev, "Invalid reply type %d from PF\n",
-			op);
-		err = -EIO;
-		goto out_alloc;
+		if (pf_vvi->major > VIRTCHNL_VERSION_MAJOR ||
+		    (pf_vvi->major == VIRTCHNL_VERSION_MAJOR &&
+		     pf_vvi->minor > VIRTCHNL_VERSION_MINOR))
+			err = -EIO;
 	}
 
-	pf_vvi = (struct virtchnl_version_info *)event.msg_buf;
-	adapter->pf_version = *pf_vvi;
-
-	if ((pf_vvi->major > VIRTCHNL_VERSION_MAJOR) ||
-	    ((pf_vvi->major == VIRTCHNL_VERSION_MAJOR) &&
-	     (pf_vvi->minor > VIRTCHNL_VERSION_MINOR)))
-		err = -EIO;
-
-out_alloc:
 	kfree(event.msg_buf);
-out:
+
 	return err;
 }
 
@@ -208,33 +216,17 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_arq_event_info event;
-	enum virtchnl_ops op;
-	enum iavf_status err;
 	u16 len;
+	int err;
 
-	len =  sizeof(struct virtchnl_vf_resource) +
+	len = sizeof(struct virtchnl_vf_resource) +
 		IAVF_MAX_VF_VSI * sizeof(struct virtchnl_vsi_resource);
 	event.buf_len = len;
-	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
-	if (!event.msg_buf) {
-		err = -ENOMEM;
-		goto out;
-	}
+	event.msg_buf = kzalloc(len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
 
-	while (1) {
-		/* When the AQ is empty, iavf_clean_arq_element will return
-		 * nonzero and this loop will terminate.
-		 */
-		err = iavf_clean_arq_element(hw, &event, NULL);
-		if (err)
-			goto out_alloc;
-		op =
-		    (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
-		if (op == VIRTCHNL_OP_GET_VF_RESOURCES)
-			break;
-	}
-
-	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
+	err = iavf_poll_virtchnl_msg(hw, &event, VIRTCHNL_OP_GET_VF_RESOURCES);
 	memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));
 
 	/* some PFs send more queues than we should have so validate that
@@ -243,48 +235,32 @@ int iavf_get_vf_config(struct iavf_adapter *adapter)
 	if (!err)
 		iavf_validate_num_queues(adapter);
 	iavf_vf_parse_hw_config(hw, adapter->vf_res);
-out_alloc:
+
 	kfree(event.msg_buf);
-out:
+
 	return err;
 }
 
 int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
 {
-	struct iavf_hw *hw = &adapter->hw;
 	struct iavf_arq_event_info event;
-	enum virtchnl_ops op;
-	enum iavf_status err;
+	int err;
 	u16 len;
 
-	len =  sizeof(struct virtchnl_vlan_caps);
+	len = sizeof(struct virtchnl_vlan_caps);
 	event.buf_len = len;
-	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
-	if (!event.msg_buf) {
-		err = -ENOMEM;
-		goto out;
-	}
+	event.msg_buf = kzalloc(len, GFP_KERNEL);
+	if (!event.msg_buf)
+		return -ENOMEM;
 
-	while (1) {
-		/* When the AQ is empty, iavf_clean_arq_element will return
-		 * nonzero and this loop will terminate.
-		 */
-		err = iavf_clean_arq_element(hw, &event, NULL);
-		if (err)
-			goto out_alloc;
-		op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
-		if (op == VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS)
-			break;
-	}
-
-	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
-	if (err)
-		goto out_alloc;
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
+				     VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS);
+	if (!err)
+		memcpy(&adapter->vlan_v2_caps, event.msg_buf,
+		       min(event.msg_len, len));
 
-	memcpy(&adapter->vlan_v2_caps, event.msg_buf, min(event.msg_len, len));
-out_alloc:
 	kfree(event.msg_buf);
-out:
+
 	return err;
 }
 
-- 
2.27.0

