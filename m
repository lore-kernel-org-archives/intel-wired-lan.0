From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 17 Jan 2018 15:06:17 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 06/10] net/sched: Introduce the
 TBS Qdisc
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180117230621.26074-7-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

TBS (Time Based Scheduler) uses the information added earlier in this
series (the socket option SO_TXTIME and the new role of
sk_buff->tstamp) to schedule traffic transmission based on absolute
time.

For some workloads, just bandwidth enforcement is not enough, and
precise control of the transmission of packets is necessary.

Example:

$ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
           map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

$ tc qdisc add dev enp2s0 parent 100:1 tbs delta 60000 clockid 11 offload 1

In this example, the Qdisc will try to enable offloading (offload 1)
the control of the transmission time to the network adapter, the
time stamp in socket are in reference to the clockid '11' (CLOCK_TAI)
and packets leave the Qdisc "delta" (60000) nanoseconds before its
transmission time.

When offloading is disabled, the network adapter will ignore the
sk_buff time stamp, and so, the transmission time will be only "best
effort" from the Qdisc.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 include/linux/netdevice.h      |   1 +
 include/net/pkt_sched.h        |   5 +
 include/uapi/linux/pkt_sched.h |  17 ++
 net/sched/Kconfig              |  11 ++
 net/sched/Makefile             |   1 +
 net/sched/sch_tbs.c            | 392 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 427 insertions(+)
 create mode 100644 net/sched/sch_tbs.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ed0799a12bf2..e87031bd108e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -781,6 +781,7 @@ enum tc_setup_type {
 	TC_SETUP_QDISC_CBS,
 	TC_SETUP_QDISC_RED,
 	TC_SETUP_QDISC_PRIO,
+	TC_SETUP_QDISC_TBS,
 };
 
 /* These structures hold the attributes of bpf state that are being passed
diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 2466ea143d01..d042ffda7f21 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -155,4 +155,9 @@ struct tc_cbs_qopt_offload {
 	s32 sendslope;
 };
 
+struct tc_tbs_qopt_offload {
+	u8 enable;
+	s32 queue;
+};
+
 #endif
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 37b5096ae97b..6bb39944ba32 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -934,4 +934,21 @@ enum {
 
 #define TCA_CBS_MAX (__TCA_CBS_MAX - 1)
 
+
+/* TBS */
+struct tc_tbs_qopt {
+	__u8 offload;
+	__u8 _pad[3];
+	__s32 delta;
+	__s32 clockid;
+};
+
+enum {
+	TCA_TBS_UNSPEC,
+	TCA_TBS_PARMS,
+	__TCA_TBS_MAX,
+};
+
+#define TCA_TBS_MAX (__TCA_TBS_MAX - 1)
+
 #endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index c03d86a7775e..7d54045995a3 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -183,6 +183,17 @@ config NET_SCH_CBS
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_cbs.
 
+config NET_SCH_TBS
+	tristate "Time Based Scheduler (TBS)"
+	---help---
+	  Say Y here if you want to use the Time Based Scheduler (TBS) packet
+	  scheduling algorithm.
+
+	  See the top of <file:net/sched/sch_tbs.c> for more details.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called sch_tbs.
+
 config NET_SCH_GRED
 	tristate "Generic Random Early Detection (GRED)"
 	---help---
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 5b635447e3f8..0f7f29505c89 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_NET_SCH_FQ)	+= sch_fq.o
 obj-$(CONFIG_NET_SCH_HHF)	+= sch_hhf.o
 obj-$(CONFIG_NET_SCH_PIE)	+= sch_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
+obj-$(CONFIG_NET_SCH_TBS)	+= sch_tbs.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_tbs.c b/net/sched/sch_tbs.c
new file mode 100644
index 000000000000..300456063ac9
--- /dev/null
+++ b/net/sched/sch_tbs.c
@@ -0,0 +1,392 @@
+/*
+ * net/sched/sch_tbs.c	Time Based Shaper
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ * Authors:	Vinicius Costa Gomes <vinicius.gomes@intel.com>
+ *		Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/rbtree.h>
+#include <linux/skbuff.h>
+#include <net/netlink.h>
+#include <net/sch_generic.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_sched.h>
+#include <net/sock.h>
+
+struct tbs_sched_data {
+	bool offload;
+	int clockid;
+	int queue;
+	s32 delta; /* in ns */
+	ktime_t last; /* The txtime of the last skb sent to the netdevice. */
+	struct rb_root head;
+	struct qdisc_watchdog watchdog;
+	struct Qdisc *qdisc;
+};
+
+static const struct nla_policy tbs_policy[TCA_TBS_MAX + 1] = {
+	[TCA_TBS_PARMS]	= { .len = sizeof(struct tc_tbs_qopt) },
+};
+
+typedef ktime_t (*get_time_func_t)(void);
+
+static const get_time_func_t clockid_to_get_time[MAX_CLOCKS] = {
+	[CLOCK_MONOTONIC] = ktime_get,
+	[CLOCK_REALTIME] = ktime_get_real,
+	[CLOCK_BOOTTIME] = ktime_get_boottime,
+	[CLOCK_TAI] = ktime_get_clocktai,
+};
+
+static ktime_t get_time_by_clockid(clockid_t clockid)
+{
+	get_time_func_t func = clockid_to_get_time[clockid];
+
+	if (!func)
+		return 0;
+
+	return func();
+}
+
+static struct sk_buff *tbs_peek(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct rb_node *p;
+
+	p = rb_first(&q->head);
+	if (!p)
+		return NULL;
+
+	return rb_to_skb(p);
+}
+
+static void reset_watchdog(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb = tbs_peek(sch);
+	ktime_t next;
+
+	if (!skb)
+		return;
+
+	next = ktime_sub_ns(skb->tstamp, q->delta);
+	qdisc_watchdog_schedule_ns(&q->watchdog, ktime_to_ns(next));
+}
+
+static int tbs_enqueue(struct sk_buff *nskb, struct Qdisc *sch,
+		       struct sk_buff **to_free)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct rb_node **p = &q->head.rb_node, *parent = NULL;
+	ktime_t txtime = nskb->tstamp;
+	struct sock *sk = nskb->sk;
+	ktime_t now;
+
+	if (sk && !sock_flag(sk, SOCK_TXTIME))
+		goto drop;
+
+	now = get_time_by_clockid(q->clockid);
+
+	if (ktime_before(txtime, now) || ktime_before(txtime, q->last))
+		goto drop;
+
+	while (*p) {
+		struct sk_buff *skb;
+
+		parent = *p;
+		skb = rb_to_skb(parent);
+		if (ktime_after(txtime, skb->tstamp))
+			p = &parent->rb_right;
+		else
+			p = &parent->rb_left;
+	}
+	rb_link_node(&nskb->rbnode, parent, p);
+	rb_insert_color(&nskb->rbnode, &q->head);
+
+	qdisc_qstats_backlog_inc(sch, nskb);
+	sch->q.qlen++;
+
+	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
+	reset_watchdog(sch);
+
+	return NET_XMIT_SUCCESS;
+
+drop:
+	return qdisc_drop(nskb, sch, to_free);
+}
+
+static struct sk_buff *timerqueue_erase(struct Qdisc *sch,
+					struct sk_buff *skb, bool drop)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+
+	rb_erase(&skb->rbnode, &q->head);
+
+	if (drop) {
+		struct sk_buff *to_free = NULL;
+
+		qdisc_drop(skb, sch, &to_free);
+		kfree_skb_list(to_free);
+	} else {
+		qdisc_qstats_backlog_dec(sch, skb);
+		qdisc_bstats_update(sch, skb);
+
+		q->last = skb->tstamp;
+	}
+
+	sch->q.qlen--;
+
+	/* The rbnode field in the skb re-uses these fields, now that
+	 * we are done with the rbnode, reset them.
+	 */
+	skb->next = NULL;
+	skb->prev = NULL;
+	skb->dev = qdisc_dev(sch);
+
+	return skb;
+}
+
+static struct sk_buff *tbs_dequeue(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	ktime_t now, next;
+
+	skb = tbs_peek(sch);
+	if (!skb)
+		return NULL;
+
+	now = get_time_by_clockid(q->clockid);
+
+	/* If packet has expired while in queue, drop it. */
+	if (ktime_before(skb->tstamp, now)) {
+		timerqueue_erase(sch, skb, true);
+		skb = NULL;
+		goto out;
+	}
+
+	next = ktime_sub_ns(skb->tstamp, q->delta);
+
+	/* Dequeue only if now is within the [txtime - delta, txtime] range. */
+	if (ktime_after(now, next))
+		timerqueue_erase(sch, skb, false);
+	else
+		skb = NULL;
+
+out:
+	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
+	reset_watchdog(sch);
+
+	return skb;
+}
+
+static void tbs_disable_offload(struct net_device *dev,
+				struct tbs_sched_data *q)
+{
+	struct tc_tbs_qopt_offload tbs = { };
+	const struct net_device_ops *ops;
+	int err;
+
+	if (!q->offload)
+		return;
+
+	ops = dev->netdev_ops;
+	if (!ops->ndo_setup_tc)
+		return;
+
+	tbs.queue = q->queue;
+	tbs.enable = 0;
+
+	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBS, &tbs);
+	if (err < 0)
+		pr_warn("Couldn't disable TBS offload for queue %d\n",
+			tbs.queue);
+}
+
+static int tbs_enable_offload(struct net_device *dev, struct tbs_sched_data *q,
+			      struct netlink_ext_ack *extack)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	struct tc_tbs_qopt_offload tbs = { };
+	int err;
+
+	if (q->offload)
+		return 0;
+
+	if (!ops->ndo_setup_tc) {
+		NL_SET_ERR_MSG(extack, "Specified device does not support TBS offload");
+		return -EOPNOTSUPP;
+	}
+
+	tbs.queue = q->queue;
+	tbs.enable = 1;
+
+	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBS, &tbs);
+	if (err < 0) {
+		NL_SET_ERR_MSG(extack, "Specified device failed to setup TBS hardware offload");
+		return err;
+	}
+
+	return 0;
+}
+
+static int tbs_change(struct Qdisc *sch, struct nlattr *opt,
+		      struct netlink_ext_ack *extack)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct nlattr *tb[TCA_CBS_MAX + 1];
+	struct tc_tbs_qopt *qopt;
+	int err;
+
+	err = nla_parse_nested(tb, TCA_TBS_MAX, opt, tbs_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[TCA_TBS_PARMS]) {
+		NL_SET_ERR_MSG(extack, "Missing mandatory TBS parameters");
+		return -EINVAL;
+	}
+
+	qopt = nla_data(tb[TCA_TBS_PARMS]);
+
+	if (qopt->clockid < 0 || qopt->clockid >= MAX_CLOCKS ||
+	    !clockid_to_get_time[qopt->clockid]) {
+		NL_SET_ERR_MSG(extack, "Invalid clockid");
+		return -EINVAL;
+	}
+
+	pr_debug("delta %d clockid %d offload %d\n",
+		 qopt->delta, qopt->clockid, qopt->offload);
+
+	if (!qopt->offload) {
+		tbs_disable_offload(dev, q);
+	} else {
+		err = tbs_enable_offload(dev, q, extack);
+		if (err < 0)
+			return err;
+	}
+
+	/* Everything went OK, save the parameters used. */
+	q->delta = qopt->delta;
+	q->clockid = qopt->clockid;
+	q->offload = qopt->offload;
+
+	qdisc_watchdog_init_clockid(&q->watchdog, sch, q->clockid);
+
+	return 0;
+}
+
+static int tbs_init(struct Qdisc *sch, struct nlattr *opt,
+		    struct netlink_ext_ack *extack)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+
+	if (!opt) {
+		NL_SET_ERR_MSG(extack, "Missing TBS qdisc options which are mandatory");
+		return -EINVAL;
+	}
+
+	q->queue = sch->dev_queue - netdev_get_tx_queue(dev, 0);
+
+	return tbs_change(sch, opt, extack);
+}
+
+static void timerqueue_clear(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct rb_node *p = rb_first(&q->head);
+
+	while (p) {
+		struct sk_buff *skb = rb_to_skb(p);
+
+		p = rb_next(p);
+		rb_erase(&skb->rbnode, &q->head);
+		rtnl_kfree_skbs(skb, skb);
+	}
+}
+
+static void tbs_reset(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+	timerqueue_clear(sch);
+
+	sch->qstats.backlog = 0;
+	sch->q.qlen = 0;
+
+	q->last = 0;
+}
+
+static void tbs_destroy(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+
+	qdisc_watchdog_cancel(&q->watchdog);
+	timerqueue_clear(sch);
+	tbs_disable_offload(dev, q);
+}
+
+static int tbs_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct tc_tbs_qopt opt = { };
+	struct nlattr *nest;
+
+	nest = nla_nest_start(skb, TCA_OPTIONS);
+	if (!nest)
+		goto nla_put_failure;
+
+	opt.delta = q->delta;
+	opt.clockid = q->clockid;
+	opt.offload = q->offload;
+
+	if (nla_put(skb, TCA_TBS_PARMS, sizeof(opt), &opt))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, nest);
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	return -1;
+}
+
+static struct Qdisc_ops tbs_qdisc_ops __read_mostly = {
+	.id		=	"tbs",
+	.priv_size	=	sizeof(struct tbs_sched_data),
+	.enqueue	=	tbs_enqueue,
+	.dequeue	=	tbs_dequeue,
+	.peek		=	tbs_peek,
+	.init		=	tbs_init,
+	.reset		=	tbs_reset,
+	.destroy	=	tbs_destroy,
+	.change		=	tbs_change,
+	.dump		=	tbs_dump,
+	.owner		=	THIS_MODULE,
+};
+
+static int __init tbs_module_init(void)
+{
+	return register_qdisc(&tbs_qdisc_ops);
+}
+
+static void __exit tbs_module_exit(void)
+{
+	unregister_qdisc(&tbs_qdisc_ops);
+}
+module_init(tbs_module_init)
+module_exit(tbs_module_exit)
+MODULE_LICENSE("GPL");
-- 
2.15.1

