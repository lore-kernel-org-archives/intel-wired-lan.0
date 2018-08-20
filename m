From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:29 -0700
Subject: [Intel-wired-lan] [next PATCH S95 08/12] i40evf: Validate the
 number of queues a PF sends
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

A PF can send any number of queues to the VF and the VF may not
be able to support that many. Check to see that the number of
queues is less than or equal to the max number of queues the
VF can have.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 79b7be8..6579dab 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -154,6 +154,32 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 }
 
 /**
+ * i40evf_validate_num_queues
+ * @adapter: adapter structure
+ *
+ * Validate that the number of queues the PF has sent in
+ * VIRTCHNL_OP_GET_VF_RESOURCES is not larger than the VF can handle.
+ **/
+static void i40evf_validate_num_queues(struct i40evf_adapter *adapter)
+{
+	if (adapter->vf_res->num_queue_pairs > I40EVF_MAX_REQ_QUEUES) {
+		struct virtchnl_vsi_resource *vsi_res;
+		int i;
+
+		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a max of %d\n",
+			 adapter->vf_res->num_queue_pairs,
+			 I40EVF_MAX_REQ_QUEUES);
+		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
+			 I40EVF_MAX_REQ_QUEUES);
+		adapter->vf_res->num_queue_pairs = I40EVF_MAX_REQ_QUEUES;
+		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
+			vsi_res = &adapter->vf_res->vsi_res[i];
+			vsi_res->num_queue_pairs = I40EVF_MAX_REQ_QUEUES;
+		}
+	}
+}
+
+/**
  * i40evf_get_vf_config
  * @adapter: private adapter structure
  *
@@ -195,6 +221,11 @@ int i40evf_get_vf_config(struct i40evf_adapter *adapter)
 	err = (i40e_status)le32_to_cpu(event.desc.cookie_low);
 	memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));
 
+	/* some PFs send more queues than we should have so validate that
+	 * we aren't getting too many queues
+	 */
+	if (!err)
+		i40evf_validate_num_queues(adapter);
 	i40e_vf_parse_hw_config(hw, adapter->vf_res);
 out_alloc:
 	kfree(event.msg_buf);
@@ -1329,6 +1360,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			  I40E_MAX_VF_VSI *
 			  sizeof(struct virtchnl_vsi_resource);
 		memcpy(adapter->vf_res, msg, min(msglen, len));
+		i40evf_validate_num_queues(adapter);
 		i40e_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
 		if (is_zero_ether_addr(adapter->hw.mac.addr)) {
 			/* restore current mac address */
-- 
2.9.5

