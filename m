From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 21 Mar 2018 14:46:59 +0100 (CET)
Subject: [Intel-wired-lan] [RFC v3 net-next 13/18] net/sched: Introduce
 the TBS Qdisc
In-Reply-To: <20180307011230.24001-14-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
 <20180307011230.24001-14-jesus.sanchez-palencia@intel.com>
Message-ID: <alpine.DEB.2.21.1803211407520.3754@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 6 Mar 2018, Jesus Sanchez-Palencia wrote:
> +struct tbs_sched_data {
> +	bool sorting;
> +	int clockid;
> +	int queue;
> +	s32 delta; /* in ns */
> +	ktime_t last; /* The txtime of the last skb sent to the netdevice. */
> +	struct rb_root head;

Hmm. You are reimplementing timerqueue open coded. Have you checked whether
you could reuse the timerqueue implementation?

That requires to add a timerqueue node to struct skbuff

@@ -671,7 +671,8 @@ struct sk_buff {
 				unsigned long		dev_scratch;
 			};
 		};
-		struct rb_node	rbnode; /* used in netem & tcp stack */
+		struct rb_node		rbnode; /* used in netem & tcp stack */
+		struct timerqueue_node	tqnode;
 	};
 	struct sock		*sk;

Then you can use timerqueue_head in your scheduler data and all the open
coded rbtree handling goes away.

> +static bool is_packet_valid(struct Qdisc *sch, struct sk_buff *nskb)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +	ktime_t txtime = nskb->tstamp;
> +	struct sock *sk = nskb->sk;
> +	ktime_t now;
> +
> +	if (sk && !sock_flag(sk, SOCK_TXTIME))
> +		return false;
> +
> +	/* We don't perform crosstimestamping.
> +	 * Drop if packet's clockid differs from qdisc's.
> +	 */
> +	if (nskb->txtime_clockid != q->clockid)
> +		return false;
> +
> +	now = get_time_by_clockid(q->clockid);

If you store the time getter function pointer in tbs_sched_data then you
avoid the lookup and just can do

       now = q->get_time();

That applies to lots of other places.

> +	if (ktime_before(txtime, now) || ktime_before(txtime, q->last))
> +		return false;
> +
> +	return true;
> +}
> +
> +static struct sk_buff *tbs_peek(struct Qdisc *sch)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +
> +	return q->peek(sch);
> +}
> +
> +static struct sk_buff *tbs_peek_timesortedlist(struct Qdisc *sch)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +	struct rb_node *p;
> +
> +	p = rb_first(&q->head);

timerqueue gives you direct access to the first expiring entry w/o walking
the rbtree. So that would become:

	p = timerqueue_getnext(&q->tqhead);
	return p ? rb_to_skb(p) : NULL;

> +	if (!p)
> +		return NULL;
> +
> +	return rb_to_skb(p);
> +}

> +static int tbs_enqueue_timesortedlist(struct sk_buff *nskb, struct Qdisc *sch,
> +				      struct sk_buff **to_free)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +	struct rb_node **p = &q->head.rb_node, *parent = NULL;
> +	ktime_t txtime = nskb->tstamp;
> +
> +	if (!is_packet_valid(sch, nskb))
> +		return qdisc_drop(nskb, sch, to_free);
> +
> +	while (*p) {
> +		struct sk_buff *skb;
> +
> +		parent = *p;
> +		skb = rb_to_skb(parent);
> +		if (ktime_after(txtime, skb->tstamp))
> +			p = &parent->rb_right;
> +		else
> +			p = &parent->rb_left;
> +	}
> +	rb_link_node(&nskb->rbnode, parent, p);
> +	rb_insert_color(&nskb->rbnode, &q->head);

That'd become:

       nskb->tknode.expires = txtime;
       timerqueue_add(&d->tqhead, &nskb->tknode);

> +	qdisc_qstats_backlog_inc(sch, nskb);
> +	sch->q.qlen++;
> +
> +	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
> +	reset_watchdog(sch);
> +
> +	return NET_XMIT_SUCCESS;
> +}
> +
> +static void timesortedlist_erase(struct Qdisc *sch, struct sk_buff *skb,
> +				 bool drop)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +
> +	rb_erase(&skb->rbnode, &q->head);
> +
> +	qdisc_qstats_backlog_dec(sch, skb);
> +
> +	if (drop) {
> +		struct sk_buff *to_free = NULL;
> +
> +		qdisc_drop(skb, sch, &to_free);
> +		kfree_skb_list(to_free);
> +		qdisc_qstats_overlimit(sch);
> +	} else {
> +		qdisc_bstats_update(sch, skb);
> +
> +		q->last = skb->tstamp;
> +	}
> +
> +	sch->q.qlen--;
> +
> +	/* The rbnode field in the skb re-uses these fields, now that
> +	 * we are done with the rbnode, reset them.
> +	 */
> +	skb->next = NULL;
> +	skb->prev = NULL;
> +	skb->dev = qdisc_dev(sch);
> +}
> +
> +static struct sk_buff *tbs_dequeue(struct Qdisc *sch)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +
> +	return q->dequeue(sch);
> +}
> +
> +static struct sk_buff *tbs_dequeue_scheduledfifo(struct Qdisc *sch)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +	struct sk_buff *skb = tbs_peek(sch);
> +	ktime_t now, next;
> +
> +	if (!skb)
> +		return NULL;
> +
> +	now = get_time_by_clockid(q->clockid);
> +
> +	/* Drop if packet has expired while in queue and the drop_if_late
> +	 * flag is set.
> +	 */
> +	if (skb->tc_drop_if_late && ktime_before(skb->tstamp, now)) {
> +		struct sk_buff *to_free = NULL;
> +
> +		qdisc_queue_drop_head(sch, &to_free);
> +		kfree_skb_list(to_free);
> +		qdisc_qstats_overlimit(sch);
> +
> +		skb = NULL;
> +		goto out;

Instead of going out immediately you should check the next skb whether its
due for sending already.

> +	}
> +
> +	next = ktime_sub_ns(skb->tstamp, q->delta);
> +
> +	/* Dequeue only if now is within the [txtime - delta, txtime] range. */
> +	if (ktime_after(now, next))
> +		skb = qdisc_dequeue_head(sch);
> +	else
> +		skb = NULL;
> +
> +out:
> +	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
> +	reset_watchdog(sch);
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *tbs_dequeue_timesortedlist(struct Qdisc *sch)
> +{
> +	struct tbs_sched_data *q = qdisc_priv(sch);
> +	struct sk_buff *skb;
> +	ktime_t now, next;
> +
> +	skb = tbs_peek(sch);
> +	if (!skb)
> +		return NULL;
> +
> +	now = get_time_by_clockid(q->clockid);
> +
> +	/* Drop if packet has expired while in queue and the drop_if_late
> +	 * flag is set.
> +	 */
> +	if (skb->tc_drop_if_late && ktime_before(skb->tstamp, now)) {
> +		timesortedlist_erase(sch, skb, true);
> +		skb = NULL;
> +		goto out;

Same as above.

> +	}
> +
> +	next = ktime_sub_ns(skb->tstamp, q->delta);
> +
> +	/* Dequeue only if now is within the [txtime - delta, txtime] range. */
> +	if (ktime_after(now, next))
> +		timesortedlist_erase(sch, skb, false);
> +	else
> +		skb = NULL;
> +
> +out:
> +	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
> +	reset_watchdog(sch);
> +
> +	return skb;
> +}
> +
> +static inline void setup_queueing_mode(struct tbs_sched_data *q)
> +{
> +	if (q->sorting) {
> +		q->enqueue = tbs_enqueue_timesortedlist;
> +		q->dequeue = tbs_dequeue_timesortedlist;
> +		q->peek = tbs_peek_timesortedlist;
> +	} else {
> +		q->enqueue = tbs_enqueue_scheduledfifo;
> +		q->dequeue = tbs_dequeue_scheduledfifo;
> +		q->peek = qdisc_peek_head;

I don't see the point of these two modes and all the duplicated code it
involves.

FIFO mode limits usage to a single thread which has to guarantee that the
packets are queued in time order.

If you look at the use cases of TDM in various fields then FIFO mode is
pretty much useless. In industrial/automotive fieldbus applications the
various time slices are filled by different threads or even processes.

Sure, the rbtree queue/dequeue has overhead compared to a simple linked
list, but you pay for that with more indirections and lots of mostly
duplicated code. And in the worst case one of these code pathes is going to
be rarely used and prone to bitrot.

Thanks,

	tglx

