From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:26 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 14/18] net/sched: Add HW
 offloading capability to TBS
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-15-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new queueing modes to tbs qdisc so HW offload is supported.

For hw offload, if sorting is on, then the time sorted list will still
be used, but when sorting is disabled the enqueue / dequeue flow will
be based on a 'raw' FIFO through the usage of qdisc_enqueue_tail() and
qdisc_dequeue_head(). For the 'raw hw offload' mode, the drop_if_late
flag from skbuffs is not used by the Qdisc since this mode implicitly
assumes the PHC clock is being used by applications.

Example 1:

$ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
           map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

$ tc qdisc add dev enp2s0 parent 100:1 tbs offload

In this example, the Qdisc will use HW offload for the control of the
transmission time through the network adapter. It's assumed the timestamp
in skbuffs are in reference to the interface's PHC and setting any other
valid clockid would be treated as an error. Because there is no
scheduling being performed in the qdisc, setting a delta != 0 would also
be considered an error.

Example 2:

$ tc qdisc replace dev enp2s0 parent root handle 100 mqprio num_tc 3 \
           map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1 at 0 1 at 1 2 at 2 hw 0

$ tc qdisc add dev enp2s0 parent 100:1 tbs offload delta 100000 \
	   clockid CLOCK_REALTIME sorting

Here, the Qdisc will use HW offload for the txtime control again,
but now sorting will be enabled, and thus there will be scheduling being
performed by the qdisc. That is done based on the clockid CLOCK_REALTIME
reference and packets leave the Qdisc "delta" (100000) nanoseconds before
their transmission time. Because this will be using HW offload and
since dynamic clocks are not supported by the hrtimer, the system clock
and the PHC clock must be synchronized for this mode to behave as expected.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 include/net/pkt_sched.h        |   5 ++
 include/uapi/linux/pkt_sched.h |   1 +
 net/sched/sch_tbs.c            | 159 +++++++++++++++++++++++++++++++++++------
 3 files changed, 144 insertions(+), 21 deletions(-)

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
index a33b5b9da81a..92af9fa4dee4 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -941,6 +941,7 @@ struct tc_tbs_qopt {
 	__s32 clockid;
 	__u32 flags;
 #define TC_TBS_SORTING_ON BIT(0)
+#define TC_TBS_OFFLOAD_ON BIT(1)
 };
 
 enum {
diff --git a/net/sched/sch_tbs.c b/net/sched/sch_tbs.c
index c19eedda9bc5..2aafa55de42c 100644
--- a/net/sched/sch_tbs.c
+++ b/net/sched/sch_tbs.c
@@ -25,8 +25,10 @@
 #include <net/sock.h>
 
 #define SORTING_IS_ON(x) (x->flags & TC_TBS_SORTING_ON)
+#define OFFLOAD_IS_ON(x) (x->flags & TC_TBS_OFFLOAD_ON)
 
 struct tbs_sched_data {
+	bool offload;
 	bool sorting;
 	int clockid;
 	int queue;
@@ -68,25 +70,42 @@ static inline int validate_input_params(struct tc_tbs_qopt *qopt,
 					struct netlink_ext_ack *extack)
 {
 	/* Check if params comply to the following rules:
-	 *	* If SW best-effort, then clockid and delta must be valid
-	 *	  regardless of sorting enabled or not.
+	 *	* If SW best-effort, then clockid and delta must be valid.
+	 *
+	 *	* If HW offload is ON and sorting is ON, then clockid and delta
+	 *	  must be valid.
+	 *
+	 *	* If HW offload is ON and sorting is OFF, then clockid and
+	 *	  delta must not have been set. The netdevice PHC will be used
+	 *	  implictly.
 	 *
 	 *	* Dynamic clockids are not supported.
 	 *	* Delta must be a positive integer.
 	 */
-	if ((qopt->clockid & CLOCKID_INVALID) == CLOCKID_INVALID ||
-	    qopt->clockid >= MAX_CLOCKS) {
-		NL_SET_ERR_MSG(extack, "Invalid clockid");
-		return -EINVAL;
-	} else if (qopt->clockid < 0 ||
-		   !clockid_to_get_time[qopt->clockid]) {
-		NL_SET_ERR_MSG(extack, "Clockid is not supported");
-		return -ENOTSUPP;
-	}
-
-	if (qopt->delta < 0) {
-		NL_SET_ERR_MSG(extack, "Delta must be positive");
-		return -EINVAL;
+	if (!OFFLOAD_IS_ON(qopt) || SORTING_IS_ON(qopt)) {
+		if ((qopt->clockid & CLOCKID_INVALID) == CLOCKID_INVALID ||
+		    qopt->clockid >= MAX_CLOCKS) {
+			NL_SET_ERR_MSG(extack, "Invalid clockid");
+			return -EINVAL;
+		} else if (qopt->clockid < 0 ||
+			   !clockid_to_get_time[qopt->clockid]) {
+			NL_SET_ERR_MSG(extack, "Clockid is not supported");
+			return -ENOTSUPP;
+		}
+
+		if (qopt->delta < 0) {
+			NL_SET_ERR_MSG(extack, "Delta must be positive");
+			return -EINVAL;
+		}
+	} else {
+		if (qopt->delta != 0) {
+			NL_SET_ERR_MSG(extack, "Cannot set delta for this mode");
+			return -EINVAL;
+		}
+		if ((qopt->clockid & CLOCKID_INVALID) != CLOCKID_INVALID) {
+			NL_SET_ERR_MSG(extack, "Cannot set clockid for this mode");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -155,6 +174,15 @@ static int tbs_enqueue(struct sk_buff *nskb, struct Qdisc *sch,
 	return q->enqueue(nskb, sch, to_free);
 }
 
+static int tbs_enqueue_fifo(struct sk_buff *nskb, struct Qdisc *sch,
+			    struct sk_buff **to_free)
+{
+	if (!is_packet_valid(sch, nskb))
+		return qdisc_drop(nskb, sch, to_free);
+
+	return qdisc_enqueue_tail(nskb, sch);
+}
+
 static int tbs_enqueue_scheduledfifo(struct sk_buff *nskb, struct Qdisc *sch,
 				     struct sk_buff **to_free)
 {
@@ -242,6 +270,21 @@ static struct sk_buff *tbs_dequeue(struct Qdisc *sch)
 	return q->dequeue(sch);
 }
 
+static struct sk_buff *tbs_dequeue_fifo(struct Qdisc *sch)
+{
+	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb = qdisc_dequeue_head(sch);
+
+	/* XXX: The drop_if_late bit is not checked here because that would
+	 *      require the PHC time to be read directly.
+	 */
+
+	if (skb)
+		q->last = skb->tstamp;
+
+	return skb;
+}
+
 static struct sk_buff *tbs_dequeue_scheduledfifo(struct Qdisc *sch)
 {
 	struct tbs_sched_data *q = qdisc_priv(sch);
@@ -318,6 +361,56 @@ static struct sk_buff *tbs_dequeue_timesortedlist(struct Qdisc *sch)
 	return skb;
 }
 
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
 static inline void setup_queueing_mode(struct tbs_sched_data *q)
 {
 	if (q->sorting) {
@@ -325,9 +418,15 @@ static inline void setup_queueing_mode(struct tbs_sched_data *q)
 		q->dequeue = tbs_dequeue_timesortedlist;
 		q->peek = tbs_peek_timesortedlist;
 	} else {
-		q->enqueue = tbs_enqueue_scheduledfifo;
-		q->dequeue = tbs_dequeue_scheduledfifo;
-		q->peek = qdisc_peek_head;
+		if (q->offload) {
+			q->enqueue = tbs_enqueue_fifo;
+			q->dequeue = tbs_dequeue_fifo;
+			q->peek = qdisc_peek_head;
+		} else {
+			q->enqueue = tbs_enqueue_scheduledfifo;
+			q->dequeue = tbs_dequeue_scheduledfifo;
+			q->peek = qdisc_peek_head;
+		}
 	}
 }
 
@@ -356,8 +455,9 @@ static int tbs_init(struct Qdisc *sch, struct nlattr *opt,
 
 	qopt = nla_data(tb[TCA_TBS_PARMS]);
 
-	pr_debug("delta %d clockid %d sorting %s\n",
+	pr_debug("delta %d clockid %d offload %s sorting %s\n",
 		 qopt->delta, qopt->clockid,
+		 OFFLOAD_IS_ON(qopt) ? "on" : "off",
 		 SORTING_IS_ON(qopt) ? "on" : "off");
 
 	err = validate_input_params(qopt, extack);
@@ -366,15 +466,26 @@ static int tbs_init(struct Qdisc *sch, struct nlattr *opt,
 
 	q->queue = sch->dev_queue - netdev_get_tx_queue(dev, 0);
 
+	if (OFFLOAD_IS_ON(qopt)) {
+		err = tbs_enable_offload(dev, q, extack);
+		if (err < 0)
+			return err;
+	}
+
 	/* Everything went OK, save the parameters used. */
 	q->delta = qopt->delta;
 	q->clockid = qopt->clockid;
+	q->offload = OFFLOAD_IS_ON(qopt);
 	q->sorting = SORTING_IS_ON(qopt);
 
-	/* Select queueing mode based on parameters. */
+	/* Select queueing mode based on offload and sorting parameters. */
 	setup_queueing_mode(q);
 
-	qdisc_watchdog_init_clockid(&q->watchdog, sch, q->clockid);
+	/* The watchdog will be needed for SW best-effort or if TxTime
+	 * based sorting is on.
+	 */
+	if (!q->offload || q->sorting)
+		qdisc_watchdog_init_clockid(&q->watchdog, sch, q->clockid);
 
 	return 0;
 }
@@ -416,10 +527,13 @@ static void tbs_reset(struct Qdisc *sch)
 static void tbs_destroy(struct Qdisc *sch)
 {
 	struct tbs_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
 
 	/* Only cancel watchdog if it's been initialized. */
 	if (q->watchdog.qdisc == sch)
 		qdisc_watchdog_cancel(&q->watchdog);
+
+	tbs_disable_offload(dev, q);
 }
 
 static int tbs_dump(struct Qdisc *sch, struct sk_buff *skb)
@@ -434,6 +548,9 @@ static int tbs_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 	opt.delta = q->delta;
 	opt.clockid = q->clockid;
+	if (q->offload)
+		opt.flags |= TC_TBS_OFFLOAD_ON;
+
 	if (q->sorting)
 		opt.flags |= TC_TBS_SORTING_ON;
 
-- 
2.16.2

