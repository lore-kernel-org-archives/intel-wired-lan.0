From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Tue, 23 Jan 2018 08:51:04 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 10/12] virtchnl: Add filter
 data structures
In-Reply-To: <20180123165106.28900-1-avinash.dayanand@intel.com>
References: <20180123165106.28900-1-avinash.dayanand@intel.com>
Message-ID: <20180123165106.28900-11-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch adds infrastructure to send virtchnl messages to the
PF to configure filters on the VF. The patch adds a struct
called virtchnl_filter which contains information about the fields
in the user-specified tc filter.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 include/linux/avf/virtchnl.h | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 6fe630e..698c55e 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -138,6 +138,8 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_REQUEST_QUEUES = 29,
 	VIRTCHNL_OP_ENABLE_CHANNELS = 30,
 	VIRTCHNL_OP_DISABLE_CHANNELS = 31,
+	VIRTCHNL_OP_ADD_CLOUD_FILTER = 32,
+	VIRTCHNL_OP_DEL_CLOUD_FILTER = 33,
 };
 
 /* These macros are used to generate compilation errors if a structure/union
@@ -525,6 +527,57 @@ struct virtchnl_tc_info {
 
 VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
 
+/* VIRTCHNL_ADD_CLOUD_FILTER
+ * VIRTCHNL_DEL_CLOUD_FILTER
+ * VF sends these messages to add or delete a cloud filter based on the
+ * user specified match and action filters. These structures encompass
+ * all the information that the PF needs from the VF to add/delete a
+ * cloud filter.
+ */
+
+struct virtchnl_l4_spec {
+	u8	src_mac[ETH_ALEN];
+	u8	dst_mac[ETH_ALEN];
+	__be16	vlan_id;
+	__be16	pad; /* reserved for future use */
+	__be32	src_ip[4];
+	__be32	dst_ip[4];
+	__be16	src_port;
+	__be16	dst_port;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(52, virtchnl_l4_spec);
+
+union virtchnl_flow_spec {
+	struct	virtchnl_l4_spec tcp_spec;
+	u8	buffer[128]; /* reserved for future use */
+};
+
+VIRTCHNL_CHECK_UNION_LEN(128, virtchnl_flow_spec);
+
+enum virtchnl_action {
+	/* action types */
+	VIRTCHNL_ACTION_DROP = 0,
+	VIRTCHNL_ACTION_TC_REDIRECT,
+};
+
+enum virtchnl_flow_type {
+	/* flow types */
+	VIRTCHNL_TCP_V4_FLOW = 0,
+	VIRTCHNL_TCP_V6_FLOW,
+};
+
+struct virtchnl_filter {
+	union	virtchnl_flow_spec data;
+	union	virtchnl_flow_spec mask;
+	enum	virtchnl_flow_type flow_type;
+	enum	virtchnl_action	action;
+	u32	action_meta;
+	__u8	field_flags;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
+
 /* VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
@@ -753,6 +806,12 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_DISABLE_CHANNELS:
 		break;
+	case VIRTCHNL_OP_ADD_CLOUD_FILTER:
+		valid_len = sizeof(struct virtchnl_filter);
+		break;
+	case VIRTCHNL_OP_DEL_CLOUD_FILTER:
+		valid_len = sizeof(struct virtchnl_filter);
+		break;
 	/* These are always errors coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
-- 
2.9.4

