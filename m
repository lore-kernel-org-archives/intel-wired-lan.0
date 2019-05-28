From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 28 May 2019 10:46:45 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 4/7] taprio: calculate
 cycle_time when schedule is installed
In-Reply-To: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
References: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1559065608-27888-5-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

cycle time for a particular schedule is calculated only when it is first
installed. So, it makes sense to just calculate it once right after the
'cycle_time' parameter has been parsed and store it in cycle_time.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 net/sched/sch_taprio.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cee6b7a3dd85..8d87ba099130 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -116,22 +116,6 @@ static void switch_schedules(struct taprio_sched *q,
 	*admin = NULL;
 }
 
-static ktime_t get_cycle_time(struct sched_gate_list *sched)
-{
-	struct sched_entry *entry;
-	ktime_t cycle = 0;
-
-	if (sched->cycle_time != 0)
-		return sched->cycle_time;
-
-	list_for_each_entry(entry, &sched->entries, list)
-		cycle = ktime_add_ns(cycle, entry->interval);
-
-	sched->cycle_time = cycle;
-
-	return cycle;
-}
-
 static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			  struct sk_buff **to_free)
 {
@@ -596,6 +580,15 @@ static int parse_taprio_schedule(struct nlattr **tb,
 	if (err < 0)
 		return err;
 
+	if (!new->cycle_time) {
+		struct sched_entry *entry;
+		ktime_t cycle = 0;
+
+		list_for_each_entry(entry, &new->entries, list)
+			cycle = ktime_add_ns(cycle, entry->interval);
+		new->cycle_time = cycle;
+	}
+
 	return 0;
 }
 
@@ -677,7 +670,7 @@ static int taprio_get_start_time(struct Qdisc *sch,
 		return 0;
 	}
 
-	cycle = get_cycle_time(sched);
+	cycle = sched->cycle_time;
 
 	/* The qdisc is expected to have at least one sched_entry.  Moreover,
 	 * any entry must have 'interval' > 0. Thus if the cycle time is zero,
@@ -704,7 +697,7 @@ static void setup_first_close_time(struct taprio_sched *q,
 	first = list_first_entry(&sched->entries,
 				 struct sched_entry, list);
 
-	cycle = get_cycle_time(sched);
+	cycle = sched->cycle_time;
 
 	/* FIXME: find a better place to do this */
 	sched->cycle_close_time = ktime_add_ns(base, cycle);
-- 
2.17.0

