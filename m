From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 16 Jul 2019 12:52:18 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1] fix: taprio: Change type of
 txtime-delay parameter to u32
Message-ID: <1563306738-2779-1-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During the review of the iproute2 patches for txtime-assist mode, it was
pointed out that it does not make sense for the txtime-delay parameter to
be negative. So, change the type of the parameter from s32 to u32.

Fixes: 4cfd5779bd6e ("taprio: Add support for txtime-assist mode")
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 include/uapi/linux/pkt_sched.h | 2 +-
 net/sched/sch_taprio.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 1f623252abe8..18f185299f47 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1174,7 +1174,7 @@ enum {
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME, /* s64 */
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION, /* s64 */
 	TCA_TAPRIO_ATTR_FLAGS, /* u32 */
-	TCA_TAPRIO_ATTR_TXTIME_DELAY, /* s32 */
+	TCA_TAPRIO_ATTR_TXTIME_DELAY, /* u32 */
 	__TCA_TAPRIO_ATTR_MAX,
 };
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 388750ddc57a..c39db507ba3f 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -75,7 +75,7 @@ struct taprio_sched {
 	struct sched_gate_list __rcu *admin_sched;
 	struct hrtimer advance_timer;
 	struct list_head taprio_list;
-	int txtime_delay;
+	u32 txtime_delay;
 };
 
 static ktime_t sched_base_time(const struct sched_gate_list *sched)
@@ -1113,7 +1113,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		q->txtime_delay = nla_get_s32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]);
+		q->txtime_delay = nla_get_u32(tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]);
 	}
 
 	if (!TXTIME_ASSIST_IS_ENABLED(taprio_flags) &&
@@ -1430,7 +1430,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto options_error;
 
 	if (q->txtime_delay &&
-	    nla_put_s32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
+	    nla_put_u32(skb, TCA_TAPRIO_ATTR_TXTIME_DELAY, q->txtime_delay))
 		goto options_error;
 
 	if (oper && dump_schedule(skb, oper))
-- 
2.7.3

