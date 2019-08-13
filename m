From: Tom Herbert <tom@herbertland.com>
Date: Mon, 12 Aug 2019 17:47:39 -0700
Subject: [Intel-wired-lan] [PATCH net-next 5/7] ip6tlvs: Add TX parameters
In-Reply-To: <1565657261-15979-1-git-send-email-tom@quantonium.net>
References: <1565657261-15979-1-git-send-email-tom@quantonium.net>
Message-ID: <1565657261-15979-6-git-send-email-tom@quantonium.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Define a number of transmit parameters for TLV Parameter table
definitions. These will be used for validating TLVs that are set
on a socket.

Signed-off-by: Tom Herbert <tom@quantonium.net>
---
 include/net/ipeh.h         | 18 ++++++++++++++++
 include/uapi/linux/ipeh.h  |  8 +++++++
 net/ipv6/exthdrs_common.c  | 53 +++++++++++++++++++++++++++++++++++++++++++++-
 net/ipv6/exthdrs_options.c | 45 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/net/ipeh.h b/include/net/ipeh.h
index 816fe36..7d91558 100644
--- a/include/net/ipeh.h
+++ b/include/net/ipeh.h
@@ -18,6 +18,17 @@ struct tlv_rx_params {
 };
 
 struct tlv_tx_params {
+	unsigned char admin_perm : 2;
+	unsigned char user_perm : 2;
+	unsigned char class : 3;
+	unsigned char rsvd : 1;
+	unsigned char align_mult : 4;
+	unsigned char align_off : 4;
+	unsigned char data_len_mult : 4;
+	unsigned char data_len_off : 4;
+	unsigned char min_data_len;
+	unsigned char max_data_len;
+	unsigned short preferred_order;
 };
 
 struct tlv_params {
@@ -52,6 +63,13 @@ struct tlv_param_table {
 
 extern struct tlv_param_table ipv6_tlv_param_table;
 
+/* Preferred TLV ordering for HBH and Dest options (placed by increasing order)
+ */
+#define IPEH_TLV_PREF_ORDER_HAO			10
+#define IPEH_TLV_PREF_ORDER_ROUTERALERT		20
+#define IPEH_TLV_PREF_ORDER_JUMBO		30
+#define IPEH_TLV_PREF_ORDER_CALIPSO		40
+
 int __ipeh_tlv_set(struct tlv_param_table *tlv_param_table,
 		   unsigned char type, const struct tlv_params *params,
 		   const struct tlv_ops *ops);
diff --git a/include/uapi/linux/ipeh.h b/include/uapi/linux/ipeh.h
index c4302b7..dbf0728 100644
--- a/include/uapi/linux/ipeh.h
+++ b/include/uapi/linux/ipeh.h
@@ -13,4 +13,12 @@
 				  IPEH_TLV_CLASS_FLAG_RTRDSTOPT |	\
 				  IPEH_TLV_CLASS_FLAG_DSTOPT)
 
+/* TLV permissions values */
+enum {
+	IPEH_TLV_PERM_NONE,
+	IPEH_TLV_PERM_WITH_CHECK,
+	IPEH_TLV_PERM_NO_CHECK,
+	IPEH_TLV_PERM_MAX = IPEH_TLV_PERM_NO_CHECK
+};
+
 #endif /* _UAPI_LINUX_IPEH_H */
diff --git a/net/ipv6/exthdrs_common.c b/net/ipv6/exthdrs_common.c
index cc8db9e..791f6e4 100644
--- a/net/ipv6/exthdrs_common.c
+++ b/net/ipv6/exthdrs_common.c
@@ -3,6 +3,7 @@
 /* Extension header and TLV library code that is not specific to IPv6. */
 #include <linux/export.h>
 #include <net/ipv6.h>
+#include <uapi/linux/ipeh.h>
 
 struct ipv6_txoptions *
 ipeh_dup_options(struct sock *sk, struct ipv6_txoptions *opt)
@@ -265,6 +266,13 @@ EXPORT_SYMBOL(ipeh_parse_tlv);
 
 /* Default (unset) values for TLV parameters */
 static const struct tlv_proc tlv_default_proc = {
+	.params.t = {
+		.admin_perm = IPEH_TLV_PERM_NO_CHECK,
+		.user_perm = IPEH_TLV_PERM_NONE,
+		.align_mult = (4 - 1), /* Default alignment: 4n + 2 */
+		.align_off = 2,
+		.max_data_len = 255,
+	},
 };
 
 static DEFINE_MUTEX(tlv_mutex);
@@ -284,16 +292,45 @@ static void tlv_param_table_release(struct rcu_head *rcu)
 }
 
 /* mutex held */
+static int check_order(struct tlv_param_table_data *tpt, unsigned char type,
+		       unsigned short order)
+{
+	int i;
+
+	if (!order)
+		return -EINVAL;
+
+	for (i = 2; i < 256; i++) {
+		struct tlv_type *ttype = &tpt->types[tpt->entries[i]];
+
+		if (!tpt->entries[i])
+			continue;
+
+		if (order == ttype->proc.params.t.preferred_order &&
+		    i != type)
+			return -EALREADY;
+	}
+
+	return 0;
+}
+
+/* mutex held */
 static int __tlv_set_one(struct tlv_param_table *tlv_param_table,
 			 unsigned char type, const struct tlv_params *params,
 			 const struct tlv_ops *ops)
 {
 	struct tlv_param_table_data *tpt, *told;
 	struct tlv_type *ttype;
+	int retv;
 
 	told = rcu_dereference_protected(tlv_param_table->data,
 					 lockdep_is_held(&tlv_mutex));
 
+	/* Check preferred order */
+	retv = check_order(told, type, params->t.preferred_order);
+	if (retv)
+		return retv;
+
 	/* Create new TLV table. If there is no exsiting entry then we are
 	 * adding a new one to the table, else we're modifying an entry.
 	 */
@@ -422,7 +459,7 @@ int ipeh_exthdrs_init(struct tlv_param_table *tlv_param_table,
 		      int num_init_params)
 {
 	struct tlv_param_table_data *tpt;
-	int pos = 0, i;
+	int pos = 0, i, j;
 	size_t tsize;
 
 	tsize = tlv_param_table_size(num_init_params + 1);
@@ -448,6 +485,20 @@ int ipeh_exthdrs_init(struct tlv_param_table *tlv_param_table,
 			goto err_inval;
 		}
 
+		if (WARN_ON(!tpi->proc.params.t.preferred_order)) {
+			/* Preferred order must be non-zero */
+			goto err_inval;
+		}
+
+		for (j = 0; j < i; j++) {
+			const struct tlv_proc_init *tpix = &tlv_init_params[j];
+
+			if (WARN_ON(tpi->proc.params.t.preferred_order ==
+				    tpix->proc.params.t.preferred_order)) {
+				/* Preferred order must be unique */
+				goto err_inval;
+			}
+		}
 		tpt->types[pos].proc = tpi->proc;
 		tpt->entries[tpi->type] = pos;
 	}
diff --git a/net/ipv6/exthdrs_options.c b/net/ipv6/exthdrs_options.c
index d4b373e..3b50b58 100644
--- a/net/ipv6/exthdrs_options.c
+++ b/net/ipv6/exthdrs_options.c
@@ -183,6 +183,17 @@ static const struct tlv_proc_init tlv_ipv6_init_params[] __initconst = {
 
 		.proc.ops.func = ipv6_dest_hao,
 		.proc.params.r.class = IPEH_TLV_CLASS_FLAG_DSTOPT,
+
+		.proc.params.t = {
+			.preferred_order = IPEH_TLV_PREF_ORDER_HAO,
+			.admin_perm = IPEH_TLV_PERM_NO_CHECK,
+			.user_perm = IPEH_TLV_PERM_NONE,
+			.class = IPEH_TLV_CLASS_FLAG_DSTOPT,
+			.align_mult = (8 - 1), /* Align to 8n + 6 */
+			.align_off = 6,
+			.min_data_len = 16,
+			.max_data_len = 16,
+		},
 	},
 #endif
 	{
@@ -190,18 +201,52 @@ static const struct tlv_proc_init tlv_ipv6_init_params[] __initconst = {
 
 		.proc.ops.func = ipv6_hop_ra,
 		.proc.params.r.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+
+		.proc.params.t = {
+			.preferred_order = IPEH_TLV_PREF_ORDER_ROUTERALERT,
+			.admin_perm = IPEH_TLV_PERM_NO_CHECK,
+			.user_perm = IPEH_TLV_PERM_NONE,
+			.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+			.align_mult = (2 - 1), /* Align to 2n */
+			.min_data_len = 2,
+			.max_data_len = 2,
+		},
 	},
 	{
 		.type = IPV6_TLV_JUMBO,
 
 		.proc.ops.func	= ipv6_hop_jumbo,
 		.proc.params.r.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+
+		.proc.params.t = {
+			.preferred_order = IPEH_TLV_PREF_ORDER_JUMBO,
+			.admin_perm = IPEH_TLV_PERM_NO_CHECK,
+			.user_perm = IPEH_TLV_PERM_NONE,
+			.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+			.align_mult = (4 - 1), /* Align to 4n + 2 */
+			.align_off = 2,
+			.min_data_len = 4,
+			.max_data_len = 4,
+		},
 	},
 	{
 		.type = IPV6_TLV_CALIPSO,
 
 		.proc.ops.func = ipv6_hop_calipso,
 		.proc.params.r.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+
+		.proc.params.t = {
+			.preferred_order = IPEH_TLV_PREF_ORDER_CALIPSO,
+			.admin_perm = IPEH_TLV_PERM_NO_CHECK,
+			.user_perm = IPEH_TLV_PERM_NONE,
+			.class = IPEH_TLV_CLASS_FLAG_HOPOPT,
+			.align_mult = (4 - 1), /* Align to 4n + 2 */
+			.align_off = 2,
+			.min_data_len = 8,
+			.max_data_len = 252,
+			.data_len_mult = (4 - 1),
+					/* Length is multiple of 4 */
+		},
 	},
 };
 
-- 
2.7.4

