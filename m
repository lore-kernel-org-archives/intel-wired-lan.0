From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 17 Jan 2018 15:06:16 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 05/10] net/sched: Allow creating
 a Qdisc watchdog with other clocks
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180117230621.26074-6-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

This adds 'qdisc_watchdog_init_clockid()' that allows a clockid to be
passed, this allows other time references to be used when scheduling
the Qdisc to run.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/net/pkt_sched.h |  2 ++
 net/sched/sch_api.c     | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 815b92a23936..2466ea143d01 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -72,6 +72,8 @@ struct qdisc_watchdog {
 	struct Qdisc	*qdisc;
 };
 
+void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qdisc,
+				 clockid_t clockid);
 void qdisc_watchdog_init(struct qdisc_watchdog *wd, struct Qdisc *qdisc);
 void qdisc_watchdog_schedule_ns(struct qdisc_watchdog *wd, u64 expires);
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index d512f49ee83c..d6136920b5c1 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -596,12 +596,19 @@ static enum hrtimer_restart qdisc_watchdog(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void qdisc_watchdog_init(struct qdisc_watchdog *wd, struct Qdisc *qdisc)
+void qdisc_watchdog_init_clockid(struct qdisc_watchdog *wd, struct Qdisc *qdisc,
+				 clockid_t clockid)
 {
-	hrtimer_init(&wd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	hrtimer_init(&wd->timer, clockid, HRTIMER_MODE_ABS_PINNED);
 	wd->timer.function = qdisc_watchdog;
 	wd->qdisc = qdisc;
 }
+EXPORT_SYMBOL(qdisc_watchdog_init_clockid);
+
+void qdisc_watchdog_init(struct qdisc_watchdog *wd, struct Qdisc *qdisc)
+{
+	qdisc_watchdog_init_clockid(wd, qdisc, CLOCK_MONOTONIC);
+}
 EXPORT_SYMBOL(qdisc_watchdog_init);
 
 void qdisc_watchdog_schedule_ns(struct qdisc_watchdog *wd, u64 expires)
-- 
2.15.1

