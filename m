From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 28 May 2019 10:46:44 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 3/7] taprio: Add the skeleton
 to enable hardware offloading
In-Reply-To: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1559065608-27888-4-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

This adds the UAPI and the core bits necessary for userspace to
request hardware offloading to be enabled.

The future commits will enable hybrid or full offloading for taprio. This
commit sets up the infrastructure to enable it via the netlink interface.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 include/uapi/linux/pkt_sched.h |   4 +
 net/sched/sch_taprio.c         | 156 ++++++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 69fc52e4d6bd..3319255ffa25 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1159,6 +1159,9 @@ enum {
  *       [TCA_TAPRIO_ATTR_SCHED_ENTRY_INTERVAL]
  */
 
+#define TCA_TAPRIO_ATTR_OFFLOAD_FLAG_FULL_OFFLOAD 0x1
+#define TCA_TAPRIO_ATTR_OFFLOAD_FLAG_TXTIME_OFFLOAD 0x2
+
 enum {
 	TCA_TAPRIO_ATTR_UNSPEC,
 	TCA_TAPRIO_ATTR_PRIOMAP, /* struct tc_mqprio_qopt */
@@ -1170,6 +1173,7 @@ enum {
 	TCA_TAPRIO_ATTR_ADMIN_SCHED, /* The admin sched, only used in dump */
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME, /* s64 */
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION, /* s64 */
+	TCA_TAPRIO_ATTR_OFFLOAD_FLAGS, /* u32 */
 	__TCA_TAPRIO_ATTR_MAX,
 };
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 9ecfb8f5902a..cee6b7a3dd85 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -26,6 +26,11 @@ static LIST_HEAD(taprio_list);
 static DEFINE_SPINLOCK(taprio_list_lock);
 
 #define TAPRIO_ALL_GATES_OPEN -1
+#define VALID_OFFLOAD(flags) ((flags) != U32_MAX)
+#define FULL_OFFLOAD_IS_ON(flags) (VALID_OFFLOAD((flags)) && \
+				   ((flags) & TCA_TAPRIO_ATTR_OFFLOAD_FLAG_FULL_OFFLOAD))
+#define TXTIME_OFFLOAD_IS_ON(flags) (VALID_OFFLOAD((flags)) && \
+				     ((flags) & TCA_TAPRIO_ATTR_OFFLOAD_FLAG_TXTIME_OFFLOAD))
 
 struct sched_entry {
 	struct list_head list;
@@ -55,6 +60,7 @@ struct sched_gate_list {
 struct taprio_sched {
 	struct Qdisc **qdiscs;
 	struct Qdisc *root;
+	u32 offload_flags;
 	int clockid;
 	atomic64_t picos_per_byte; /* Using picoseconds because for 10Gbps+
 				    * speeds it's sub-nanoseconds per byte
@@ -66,6 +72,8 @@ struct taprio_sched {
 	struct sched_gate_list __rcu *oper_sched;
 	struct sched_gate_list __rcu *admin_sched;
 	ktime_t (*get_time)(void);
+	struct sk_buff *(*dequeue)(struct Qdisc *sch);
+	struct sk_buff *(*peek)(struct Qdisc *sch);
 	struct hrtimer advance_timer;
 	struct list_head taprio_list;
 };
@@ -143,7 +151,30 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return qdisc_enqueue(skb, child, to_free);
 }
 
-static struct sk_buff *taprio_peek(struct Qdisc *sch)
+static struct sk_buff *taprio_peek_offload(struct Qdisc *sch)
+{
+	struct taprio_sched *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		struct Qdisc *child = q->qdiscs[i];
+
+		if (unlikely(!child))
+			continue;
+
+		skb = child->ops->peek(child);
+		if (!skb)
+			continue;
+
+		return skb;
+	}
+
+	return NULL;
+}
+
+static struct sk_buff *taprio_peek_soft(struct Qdisc *sch)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -184,6 +215,13 @@ static struct sk_buff *taprio_peek(struct Qdisc *sch)
 	return NULL;
 }
 
+static struct sk_buff *taprio_peek(struct Qdisc *sch)
+{
+	struct taprio_sched *q = qdisc_priv(sch);
+
+	return q->peek(sch);
+}
+
 static inline int length_to_duration(struct taprio_sched *q, int len)
 {
 	return div_u64(len * atomic64_read(&q->picos_per_byte), 1000);
@@ -196,7 +234,7 @@ static void taprio_set_budget(struct taprio_sched *q, struct sched_entry *entry)
 			     atomic64_read(&q->picos_per_byte)));
 }
 
-static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
+static struct sk_buff *taprio_dequeue_soft(struct Qdisc *sch)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -275,6 +313,40 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 	return skb;
 }
 
+static struct sk_buff *taprio_dequeue_offload(struct Qdisc *sch)
+{
+	struct taprio_sched *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct sk_buff *skb;
+	int i;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		struct Qdisc *child = q->qdiscs[i];
+
+		if (unlikely(!child))
+			continue;
+
+		skb = child->ops->dequeue(child);
+		if (unlikely(!skb))
+			continue;
+
+		qdisc_bstats_update(sch, skb);
+		qdisc_qstats_backlog_dec(sch, skb);
+		sch->q.qlen--;
+
+		return skb;
+	}
+
+	return NULL;
+}
+
+static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
+{
+	struct taprio_sched *q = qdisc_priv(sch);
+
+	return q->dequeue(sch);
+}
+
 static bool should_restart_cycle(const struct sched_gate_list *oper,
 				 const struct sched_entry *entry)
 {
@@ -707,6 +779,59 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_DONE;
 }
 
+static void taprio_disable_offload(struct net_device *dev,
+				   struct taprio_sched *q)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!q->offload_flags)
+		return;
+
+	if (!ops->ndo_setup_tc)
+		return;
+
+	/* FIXME: disable offloading */
+
+	/* Just to be sure to keep the function pointers in a
+	 * consistent state always.
+	 */
+	q->dequeue = taprio_dequeue_soft;
+	q->peek = taprio_peek_soft;
+
+	q->offload_flags = 0;
+}
+
+static int taprio_enable_offload(struct net_device *dev,
+				 struct tc_mqprio_qopt *mqprio,
+				 struct taprio_sched *q,
+				 struct sched_gate_list *sched,
+				 struct netlink_ext_ack *extack,
+				 u32 offload_flags)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int err = 0;
+
+	if (!FULL_OFFLOAD_IS_ON(offload_flags)) {
+		NL_SET_ERR_MSG(extack, "Offload mode is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!ops->ndo_setup_tc) {
+		NL_SET_ERR_MSG(extack, "Specified device does not support taprio offload");
+		return -EOPNOTSUPP;
+	}
+
+	/* FIXME: enable offloading */
+
+	q->dequeue = taprio_dequeue_offload;
+	q->peek = taprio_peek_offload;
+
+	if (err == 0)
+		q->offload_flags = offload_flags;
+
+	return err;
+}
+
 static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
@@ -715,6 +840,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_mqprio_qopt *mqprio = NULL;
+	u32 offload_flags = U32_MAX;
 	int i, err, clockid;
 	unsigned long flags;
 	ktime_t start;
@@ -731,6 +857,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (err < 0)
 		return err;
 
+	if (tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS])
+		offload_flags = nla_get_u32(tb[TCA_TAPRIO_ATTR_OFFLOAD_FLAGS]);
+
 	new_admin = kzalloc(sizeof(*new_admin), GFP_KERNEL);
 	if (!new_admin) {
 		NL_SET_ERR_MSG(extack, "Not enough memory for a new schedule");
@@ -749,6 +878,12 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		goto free_sched;
 	}
 
+	if (offload_flags != U32_MAX && (oper || admin)) {
+		NL_SET_ERR_MSG(extack, "Changing 'offload' of a running schedule is not supported");
+		err = -ENOTSUPP;
+		goto free_sched;
+	}
+
 	err = parse_taprio_schedule(tb, new_admin, extack);
 	if (err < 0)
 		goto free_sched;
@@ -823,6 +958,15 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 		goto unlock;
 	}
 
+	if (!offload_flags) {
+		taprio_disable_offload(dev, q);
+	} else if (VALID_OFFLOAD(offload_flags) || q->offload_flags) {
+		err = taprio_enable_offload(dev, mqprio, q,
+					    new_admin, extack, offload_flags);
+		if (err)
+			goto unlock;
+	}
+
 	err = taprio_get_start_time(sch, new_admin, &start);
 	if (err < 0) {
 		NL_SET_ERR_MSG(extack, "Internal error: failed get start time");
@@ -866,6 +1010,8 @@ static void taprio_destroy(struct Qdisc *sch)
 
 	hrtimer_cancel(&q->advance_timer);
 
+	taprio_disable_offload(dev, q);
+
 	if (q->qdiscs) {
 		for (i = 0; i < dev->num_tx_queues && q->qdiscs[i]; i++)
 			qdisc_put(q->qdiscs[i]);
@@ -895,6 +1041,9 @@ static int taprio_init(struct Qdisc *sch, struct nlattr *opt,
 	hrtimer_init(&q->advance_timer, CLOCK_TAI, HRTIMER_MODE_ABS);
 	q->advance_timer.function = advance_sched;
 
+	q->dequeue = taprio_dequeue_soft;
+	q->peek = taprio_peek_soft;
+
 	q->root = sch;
 
 	/* We only support static clockids. Use an invalid value as default
@@ -1080,6 +1229,9 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (nla_put_s32(skb, TCA_TAPRIO_ATTR_SCHED_CLOCKID, q->clockid))
 		goto options_error;
 
+	if (nla_put_u32(skb, TCA_TAPRIO_ATTR_OFFLOAD_FLAGS, q->offload_flags))
+		goto options_error;
+
 	if (oper && dump_schedule(skb, oper))
 		goto options_error;
 
-- 
2.17.0

