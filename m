From: alardam@gmail.com <alardam@gmail.com>
Date: Fri,  4 Dec 2020 11:29:01 +0100
Subject: [Intel-wired-lan] [PATCH v2 bpf 5/5] ethtool: provide xdp info with
 XDP_PROPERTIES_GET
In-Reply-To: <20201204102901.109709-1-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
Message-ID: <20201204102901.109709-6-marekx.majtyka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marek Majtyka <marekx.majtyka@intel.com>

Implement XDP_PROPERTIES_GET request to get network device
information about supported xdp functionalities.

Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 include/uapi/linux/ethtool_netlink.h | 14 +++++
 net/ethtool/Makefile                 |  2 +-
 net/ethtool/netlink.c                | 38 +++++++++-----
 net/ethtool/netlink.h                |  2 +
 net/ethtool/xdp.c                    | 76 ++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 15 deletions(-)
 create mode 100644 net/ethtool/xdp.c

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index e2bf36e6964b..764d6edc2862 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -42,6 +42,7 @@ enum {
 	ETHTOOL_MSG_CABLE_TEST_ACT,
 	ETHTOOL_MSG_CABLE_TEST_TDR_ACT,
 	ETHTOOL_MSG_TUNNEL_INFO_GET,
+	ETHTOOL_MSG_XDP_PROPERTIES_GET,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -80,6 +81,7 @@ enum {
 	ETHTOOL_MSG_CABLE_TEST_NTF,
 	ETHTOOL_MSG_CABLE_TEST_TDR_NTF,
 	ETHTOOL_MSG_TUNNEL_INFO_GET_REPLY,
+	ETHTOOL_MSG_XDP_PROPERTIES_GET_REPLY,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -628,6 +630,18 @@ enum {
 	ETHTOOL_A_TUNNEL_INFO_MAX = (__ETHTOOL_A_TUNNEL_INFO_CNT - 1)
 };
 
+/* XDP_PROPERTIES */
+
+enum {
+	ETHTOOL_A_XDP_PROPERTIES_UNSPEC,
+	ETHTOOL_A_XDP_PROPERTIES_HEADER,			/* nest - _A_HEADER_* */
+	ETHTOOL_A_XDP_PROPERTIES_DATA,				/* bitset */
+
+	/* add new constants above here */
+	__ETHTOOL_A_XDP_PROPERTIES_CNT,
+	ETHTOOL_A_XDP_PROPERTIES_MAX = __ETHTOOL_A_XDP_PROPERTIES_CNT - 1
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 7a849ff22dad..23d49eb07a7f 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_ETHTOOL_NETLINK)	+= ethtool_nl.o
 ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
-		   tunnels.o
+		   tunnels.o xdp.o
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 50d3c8896f91..06c943c78a11 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -231,20 +231,21 @@ struct ethnl_dump_ctx {
 
 static const struct ethnl_request_ops *
 ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
-	[ETHTOOL_MSG_STRSET_GET]	= &ethnl_strset_request_ops,
-	[ETHTOOL_MSG_LINKINFO_GET]	= &ethnl_linkinfo_request_ops,
-	[ETHTOOL_MSG_LINKMODES_GET]	= &ethnl_linkmodes_request_ops,
-	[ETHTOOL_MSG_LINKSTATE_GET]	= &ethnl_linkstate_request_ops,
-	[ETHTOOL_MSG_DEBUG_GET]		= &ethnl_debug_request_ops,
-	[ETHTOOL_MSG_WOL_GET]		= &ethnl_wol_request_ops,
-	[ETHTOOL_MSG_FEATURES_GET]	= &ethnl_features_request_ops,
-	[ETHTOOL_MSG_PRIVFLAGS_GET]	= &ethnl_privflags_request_ops,
-	[ETHTOOL_MSG_RINGS_GET]		= &ethnl_rings_request_ops,
-	[ETHTOOL_MSG_CHANNELS_GET]	= &ethnl_channels_request_ops,
-	[ETHTOOL_MSG_COALESCE_GET]	= &ethnl_coalesce_request_ops,
-	[ETHTOOL_MSG_PAUSE_GET]		= &ethnl_pause_request_ops,
-	[ETHTOOL_MSG_EEE_GET]		= &ethnl_eee_request_ops,
-	[ETHTOOL_MSG_TSINFO_GET]	= &ethnl_tsinfo_request_ops,
+	[ETHTOOL_MSG_STRSET_GET]		= &ethnl_strset_request_ops,
+	[ETHTOOL_MSG_LINKINFO_GET]		= &ethnl_linkinfo_request_ops,
+	[ETHTOOL_MSG_LINKMODES_GET]		= &ethnl_linkmodes_request_ops,
+	[ETHTOOL_MSG_LINKSTATE_GET]		= &ethnl_linkstate_request_ops,
+	[ETHTOOL_MSG_DEBUG_GET]			= &ethnl_debug_request_ops,
+	[ETHTOOL_MSG_WOL_GET]			= &ethnl_wol_request_ops,
+	[ETHTOOL_MSG_FEATURES_GET]		= &ethnl_features_request_ops,
+	[ETHTOOL_MSG_PRIVFLAGS_GET]		= &ethnl_privflags_request_ops,
+	[ETHTOOL_MSG_RINGS_GET]			= &ethnl_rings_request_ops,
+	[ETHTOOL_MSG_CHANNELS_GET]		= &ethnl_channels_request_ops,
+	[ETHTOOL_MSG_COALESCE_GET]		= &ethnl_coalesce_request_ops,
+	[ETHTOOL_MSG_PAUSE_GET]			= &ethnl_pause_request_ops,
+	[ETHTOOL_MSG_EEE_GET]			= &ethnl_eee_request_ops,
+	[ETHTOOL_MSG_TSINFO_GET]		= &ethnl_tsinfo_request_ops,
+	[ETHTOOL_MSG_XDP_PROPERTIES_GET]	= &ethnl_xdp_request_ops,
 };
 
 static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
@@ -912,6 +913,15 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_tunnel_info_get_policy,
 		.maxattr = ARRAY_SIZE(ethnl_tunnel_info_get_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_XDP_PROPERTIES_GET,
+		.doit	= ethnl_default_doit,
+		.start	= ethnl_default_start,
+		.dumpit	= ethnl_default_dumpit,
+		.done	= ethnl_default_done,
+		.policy = ethnl_properties_get_policy,
+		.maxattr = ARRAY_SIZE(ethnl_properties_get_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index d8efec516d86..c5875e97b707 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -344,6 +344,7 @@ extern const struct ethnl_request_ops ethnl_coalesce_request_ops;
 extern const struct ethnl_request_ops ethnl_pause_request_ops;
 extern const struct ethnl_request_ops ethnl_eee_request_ops;
 extern const struct ethnl_request_ops ethnl_tsinfo_request_ops;
+extern const struct ethnl_request_ops ethnl_xdp_request_ops;
 
 extern const struct nla_policy ethnl_header_policy[ETHTOOL_A_HEADER_FLAGS + 1];
 extern const struct nla_policy ethnl_header_policy_stats[ETHTOOL_A_HEADER_FLAGS + 1];
@@ -375,6 +376,7 @@ extern const struct nla_policy ethnl_tsinfo_get_policy[ETHTOOL_A_TSINFO_HEADER +
 extern const struct nla_policy ethnl_cable_test_act_policy[ETHTOOL_A_CABLE_TEST_HEADER + 1];
 extern const struct nla_policy ethnl_cable_test_tdr_act_policy[ETHTOOL_A_CABLE_TEST_TDR_CFG + 1];
 extern const struct nla_policy ethnl_tunnel_info_get_policy[ETHTOOL_A_TUNNEL_INFO_HEADER + 1];
+extern const struct nla_policy ethnl_properties_get_policy[ETHTOOL_A_XDP_PROPERTIES_HEADER + 1];
 
 int ethnl_set_linkinfo(struct sk_buff *skb, struct genl_info *info);
 int ethnl_set_linkmodes(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ethtool/xdp.c b/net/ethtool/xdp.c
new file mode 100644
index 000000000000..fc0e87b6ed80
--- /dev/null
+++ b/net/ethtool/xdp.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "netlink.h"
+#include "common.h"
+#include "bitset.h"
+
+struct properties_req_info {
+	struct ethnl_req_info	base;
+};
+
+struct properties_reply_data {
+	struct ethnl_reply_data	base;
+	u32			properties[ETHTOOL_XDP_PROPERTIES_WORDS];
+};
+
+const struct nla_policy ethnl_properties_get_policy[] = {
+	[ETHTOOL_A_XDP_PROPERTIES_HEADER]	=
+		NLA_POLICY_NESTED(ethnl_header_policy),
+};
+
+#define PROPERTIES_REPDATA(__reply_base) \
+	container_of(__reply_base, struct properties_reply_data, base)
+
+static void ethnl_properties_to_bitmap32(u32 *dest, xdp_properties_t src)
+{
+	unsigned int i;
+
+	for (i = 0; i < ETHTOOL_XDP_PROPERTIES_WORDS; i++)
+		dest[i] = src >> (32 * i);
+}
+
+static int properties_prepare_data(const struct ethnl_req_info *req_base,
+				   struct ethnl_reply_data *reply_base,
+				   struct genl_info *info)
+{
+	struct properties_reply_data *data = PROPERTIES_REPDATA(reply_base);
+	struct net_device *dev = reply_base->dev;
+
+	ethnl_properties_to_bitmap32(data->properties, dev->xdp_properties);
+
+	return 0;
+}
+
+static int properties_reply_size(const struct ethnl_req_info *req_base,
+				 const struct ethnl_reply_data *reply_base)
+{
+	const struct properties_reply_data *data = PROPERTIES_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+
+	return ethnl_bitset32_size(data->properties, NULL, XDP_PROPERTIES_COUNT,
+				   xdp_properties_strings, compact);
+}
+
+static int properties_fill_reply(struct sk_buff *skb,
+				 const struct ethnl_req_info *req_base,
+				 const struct ethnl_reply_data *reply_base)
+{
+	const struct properties_reply_data *data = PROPERTIES_REPDATA(reply_base);
+	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+
+	return ethnl_put_bitset32(skb, ETHTOOL_A_XDP_PROPERTIES_DATA, data->properties,
+				  NULL, XDP_PROPERTIES_COUNT,
+				  xdp_properties_strings, compact);
+}
+
+const struct ethnl_request_ops ethnl_xdp_request_ops = {
+	.request_cmd		= ETHTOOL_MSG_XDP_PROPERTIES_GET,
+	.reply_cmd		= ETHTOOL_MSG_XDP_PROPERTIES_GET_REPLY,
+	.hdr_attr		= ETHTOOL_A_XDP_PROPERTIES_HEADER,
+	.req_info_size		= sizeof(struct properties_req_info),
+	.reply_data_size	= sizeof(struct properties_reply_data),
+
+	.prepare_data		= properties_prepare_data,
+	.reply_size		= properties_reply_size,
+	.fill_reply		= properties_fill_reply,
+};
-- 
2.27.0

