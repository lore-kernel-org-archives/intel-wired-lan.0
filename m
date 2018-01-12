From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 12 Jan 2018 11:32:41 -0800
Subject: [Intel-wired-lan] [PATCH 02/12] virtchnl: Add virtchl structures to
 support queue channels
In-Reply-To: <20180112193251.11739-1-jeffrey.t.kirsher@intel.com>
References: <20180112193251.11739-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180112193251.11739-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch defines new structs in support of the virtchannel message
that the VF sends to the PF to create a queue channel specified by the
user via tc tool.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 include/linux/avf/virtchnl.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 3ce61342fa31..b6aaecd82c70 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -136,6 +136,8 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_ENABLE_VLAN_STRIPPING = 27,
 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING = 28,
 	VIRTCHNL_OP_REQUEST_QUEUES = 29,
+	VIRTCHNL_OP_ENABLE_CHANNELS = 30,
+	VIRTCHNL_OP_DISABLE_CHANNELS = 31,
 };
 
 /* This macro is used to generate a compilation error if a structure
@@ -244,6 +246,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_ENCAP		0X00100000
 #define VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM		0X00200000
 #define VIRTCHNL_VF_OFFLOAD_RX_ENCAP_CSUM	0X00400000
+#define VIRTCHNL_VF_OFFLOAD_ADQ			0X00800000
 
 #define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
 			       VIRTCHNL_VF_OFFLOAD_VLAN | \
@@ -496,6 +499,29 @@ struct virtchnl_rss_hena {
 
 VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_rss_hena);
 
+/* VIRTCHNL_OP_ENABLE_CHANNELS
+ * VIRTCHNL_OP_DISABLE_CHANNELS
+ * VF sends these messages to enable or disable channels based on
+ * the user specified queue count and queue offset for each traffic class.
+ * This struct encompasses all the information that the PF needs from
+ * VF to create a channel.
+ */
+struct virtchnl_channel_info {
+	u16 count; /* number of queues in a channel */
+	u16 offset; /* queues in a channel start from 'offset' */
+	u32 pad;
+	u64 max_tx_rate;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_channel_info);
+
+struct virtchnl_tc_info {
+	u32	num_tc;
+	struct	virtchnl_channel_info list[1];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
+
 /* VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
@@ -711,6 +737,19 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_REQUEST_QUEUES:
 		valid_len = sizeof(struct virtchnl_vf_res_request);
 		break;
+	case VIRTCHNL_OP_ENABLE_CHANNELS:
+		valid_len = sizeof(struct virtchnl_tc_info);
+		if (msglen >= valid_len) {
+			struct virtchnl_tc_info *vti =
+				(struct virtchnl_tc_info *)msg;
+			valid_len += vti->num_tc *
+				sizeof(struct virtchnl_channel_info);
+			if (vti->num_tc == 0)
+				err_msg_format = true;
+		}
+		break;
+	case VIRTCHNL_OP_DISABLE_CHANNELS:
+		break;
 	/* These are always errors coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
-- 
2.14.3

