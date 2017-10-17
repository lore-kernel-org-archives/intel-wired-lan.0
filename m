From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 16 Oct 2017 18:01:24 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v9 2/6] net/sched: Change
	behavior of mq select_queue()
In-Reply-To: <20171017010128.22141-1-vinicius.gomes@intel.com>
References: <20171017010128.22141-1-vinicius.gomes@intel.com>
Message-ID: <20171017010128.22141-3-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>

Currently, the class_ops select_queue() implementation on sch_mq
returns a pointer to netdev_queue #0 when it receives and invalid
qdisc id. That can be misleading since all of mq's inner qdiscs are
attached to a valid netdev_queue.

Here we fix that by returning NULL when a qdisc id is invalid. This is
aligned with how select_queue() is implemented for sch_mqprio in the
next patch on this series, keeping a consistent behavior between these
two qdiscs.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/sched/sch_mq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index f3a3e507422b..213b586a06a0 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -130,15 +130,7 @@ static struct netdev_queue *mq_queue_get(struct Qdisc *sch, unsigned long cl)
 static struct netdev_queue *mq_select_queue(struct Qdisc *sch,
 					    struct tcmsg *tcm)
 {
-	unsigned int ntx = TC_H_MIN(tcm->tcm_parent);
-	struct netdev_queue *dev_queue = mq_queue_get(sch, ntx);
-
-	if (!dev_queue) {
-		struct net_device *dev = qdisc_dev(sch);
-
-		return netdev_get_tx_queue(dev, 0);
-	}
-	return dev_queue;
+	return mq_queue_get(sch, TC_H_MIN(tcm->tcm_parent));
 }
 
 static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
-- 
2.14.2

