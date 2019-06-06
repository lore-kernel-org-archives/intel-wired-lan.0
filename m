From: Vedang Patel <vedang.patel@intel.com>
Date: Thu,  6 Jun 2019 10:50:57 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 5/6] taprio: make clock
 reference conversions easier
In-Reply-To: <1559843458-12517-1-git-send-email-vedang.patel@intel.com>
References: <1559843458-12517-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1559843458-12517-6-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Later in this series we will need to transform from
CLOCK_MONOTONIC (used in TCP) to the clock reference used in TAPRIO.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 net/sched/sch_taprio.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a5676fb2b2dd..9f621e6c2503 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -62,6 +62,7 @@ struct taprio_sched {
 	struct Qdisc **qdiscs;
 	struct Qdisc *root;
 	u32 flags;
+	enum tk_offsets tk_offset;
 	int clockid;
 	atomic64_t picos_per_byte; /* Using picoseconds because for 10Gbps+
 				    * speeds it's sub-nanoseconds per byte
@@ -72,7 +73,6 @@ struct taprio_sched {
 	struct sched_entry __rcu *current_entry;
 	struct sched_gate_list __rcu *oper_sched;
 	struct sched_gate_list __rcu *admin_sched;
-	ktime_t (*get_time)(void);
 	struct hrtimer advance_timer;
 	struct list_head taprio_list;
 	int txtime_delay;
@@ -86,6 +86,20 @@ static ktime_t sched_base_time(const struct sched_gate_list *sched)
 	return ns_to_ktime(sched->base_time);
 }
 
+static inline ktime_t taprio_get_time(struct taprio_sched *q)
+{
+	ktime_t mono = ktime_get();
+
+	switch (q->tk_offset) {
+	case TK_OFFS_MAX:
+		return mono;
+	default:
+		return ktime_mono_to_any(mono, q->tk_offset);
+	}
+
+	return KTIME_MAX;
+}
+
 static void taprio_free_sched_cb(struct rcu_head *head)
 {
 	struct sched_gate_list *sched = container_of(head, struct sched_gate_list, rcu);
@@ -289,7 +303,7 @@ static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 	struct sched_entry *entry;
 	bool sched_changed;
 
-	now = q->get_time();
+	now = taprio_get_time(q);
 	minimum_time = ktime_add_ns(now, q->txtime_delay);
 
 	rcu_read_lock();
@@ -480,7 +494,7 @@ static struct sk_buff *taprio_dequeue(struct Qdisc *sch)
 			continue;
 
 		len = qdisc_pkt_len(skb);
-		guard = ktime_add_ns(q->get_time(),
+		guard = ktime_add_ns(taprio_get_time(q),
 				     length_to_duration(q, len));
 
 		/* In the case that there's no gate entry, there's no
@@ -849,7 +863,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
 	s64 n;
 
 	base = sched_base_time(sched);
-	now = q->get_time();
+	now = taprio_get_time(q);
 
 	if (ktime_after(base, now)) {
 		*start = base;
@@ -1088,16 +1102,16 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 	switch (q->clockid) {
 	case CLOCK_REALTIME:
-		q->get_time = ktime_get_real;
+		q->tk_offset = TK_OFFS_REAL;
 		break;
 	case CLOCK_MONOTONIC:
-		q->get_time = ktime_get;
+		q->tk_offset = TK_OFFS_MAX;
 		break;
 	case CLOCK_BOOTTIME:
-		q->get_time = ktime_get_boottime;
+		q->tk_offset = TK_OFFS_BOOT;
 		break;
 	case CLOCK_TAI:
-		q->get_time = ktime_get_clocktai;
+		q->tk_offset = TK_OFFS_TAI;
 		break;
 	default:
 		NL_SET_ERR_MSG(extack, "Invalid 'clockid'");
-- 
2.7.3

