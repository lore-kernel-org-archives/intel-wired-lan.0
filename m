From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 09 Jul 2018 12:19:32 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v2 1/7] net-sysfs:
 Drop support for XPS and traffic_class on single queue device
In-Reply-To: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
References: <20180709161743.8383.97754.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180709161932.8383.5753.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes it so that we do not report the traffic class or allow XPS
configuration on single queue devices. This is mostly to avoid unnecessary
complexity with changes I have planned that will allow us to reuse
the unused tc_to_txq and XPS configuration on a single queue device to
allow it to make use of a subset of queues on an underlying device.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 net/core/net-sysfs.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f25ac5f..dce3ae0 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1047,9 +1047,14 @@ static ssize_t traffic_class_show(struct netdev_queue *queue,
 				  char *buf)
 {
 	struct net_device *dev = queue->dev;
-	int index = get_netdev_queue_index(queue);
-	int tc = netdev_txq_to_tc(dev, index);
+	int index;
+	int tc;
 
+	if (!netif_is_multiqueue(dev))
+		return -ENOENT;
+
+	index = get_netdev_queue_index(queue);
+	tc = netdev_txq_to_tc(dev, index);
 	if (tc < 0)
 		return -EINVAL;
 
@@ -1214,6 +1219,9 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue,
 	cpumask_var_t mask;
 	unsigned long index;
 
+	if (!netif_is_multiqueue(dev))
+		return -ENOENT;
+
 	index = get_netdev_queue_index(queue);
 
 	if (dev->num_tc) {
@@ -1260,6 +1268,9 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 	cpumask_var_t mask;
 	int err;
 
+	if (!netif_is_multiqueue(dev))
+		return -ENOENT;
+
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
 

