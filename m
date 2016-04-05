From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue,  5 Apr 2016 10:39:06 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/2] net_sched: act_mirred: add
	helper inlines to access tcf_mirred info
Message-ID: <1459877947-8241-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/net/tc_act/tc_mirred.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/tc_act/tc_mirred.h b/include/net/tc_act/tc_mirred.h
index dae96ba..e891835 100644
--- a/include/net/tc_act/tc_mirred.h
+++ b/include/net/tc_act/tc_mirred.h
@@ -2,6 +2,7 @@
 #define __NET_TC_MIR_H
 
 #include <net/act_api.h>
+#include <linux/tc_act/tc_mirred.h>
 
 struct tcf_mirred {
 	struct tcf_common	common;
@@ -14,4 +15,18 @@ struct tcf_mirred {
 #define to_mirred(a) \
 	container_of(a->priv, struct tcf_mirred, common)
 
+static inline bool is_tcf_mirred_redirect(const struct tc_action *a)
+{
+#ifdef CONFIG_NET_CLS_ACT
+	if (a->ops && a->ops->type == TCA_ACT_MIRRED)
+		return to_mirred(a)->tcfm_eaction == TCA_EGRESS_REDIR;
+#endif
+	return false;
+}
+
+static inline int tcf_mirred_ifindex(const struct tc_action *a)
+{
+	return to_mirred(a)->tcfm_ifindex;
+}
+
 #endif /* __NET_TC_MIR_H */
-- 
2.1.0

