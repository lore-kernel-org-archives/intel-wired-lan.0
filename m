From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 16 Oct 2017 18:01:23 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v9 1/6] net/sched: Check for
	null dev_queue on create flow
In-Reply-To: <20171017010128.22141-1-vinicius.gomes@intel.com>
References: <20171017010128.22141-1-vinicius.gomes@intel.com>
Message-ID: <20171017010128.22141-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>

In qdisc_alloc() the dev_queue pointer was used without any checks
being performed. If qdisc_create() gets a null dev_queue pointer, it
just passes it along to qdisc_alloc(), leading to a crash. That
happens if a root qdisc implements select_queue() and returns a null
dev_queue pointer for an "invalid handle", for example, or if the
dev_queue associated with the parent qdisc is null.

This patch is in preparation for the next in this series, where
select_queue() is being added to mqprio and as it may return a null
dev_queue.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 net/sched/sch_generic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a0a198768aad..de2408f1ccd3 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -603,8 +603,14 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	struct Qdisc *sch;
 	unsigned int size = QDISC_ALIGN(sizeof(*sch)) + ops->priv_size;
 	int err = -ENOBUFS;
-	struct net_device *dev = dev_queue->dev;
+	struct net_device *dev;
+
+	if (!dev_queue) {
+		err = -EINVAL;
+		goto errout;
+	}
 
+	dev = dev_queue->dev;
 	p = kzalloc_node(size, GFP_KERNEL,
 			 netdev_queue_numa_node_read(dev_queue));
 
-- 
2.14.2

