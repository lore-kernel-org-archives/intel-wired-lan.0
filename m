From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 Mar 2018 16:08:11 +0100
Subject: [Intel-wired-lan] [RFC PATCH 1/2] net: introduce netif_set_xps()
In-Reply-To: <cover.1521124830.git.pabeni@redhat.com>
References: <cover.1521124830.git.pabeni@redhat.com>
Message-ID: <1add7d2952a1b86129c4a7c1f46cf382d6107cb7.1521124830.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

netif_set_xps() configures XPS on the given netdevice so
that XPS mapping exists for each online CPU. Also, factor out an
unlocked version of netif_set_xps_queue() to allow configuring
all the netdev queues acquiring the xps lock only once.

Netdevice can leverage such helper replacing all the per queue call
to netif_set_xps_queue() with a single netif_set_xps().

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h |  6 +++++
 net/core/dev.c            | 58 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5fbb9f1da7fd..95727ccf0865 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3193,6 +3193,7 @@ static inline void netif_wake_subqueue(struct net_device *dev, u16 queue_index)
 #ifdef CONFIG_XPS
 int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			u16 index);
+int netif_set_xps(struct net_device *dev);
 #else
 static inline int netif_set_xps_queue(struct net_device *dev,
 				      const struct cpumask *mask,
@@ -3200,6 +3201,11 @@ static inline int netif_set_xps_queue(struct net_device *dev,
 {
 	return 0;
 }
+
+int netif_set_xps(struct net_device *dev)
+{
+	return 0;
+}
 #endif
 
 u16 __skb_tx_hash(const struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 12a9aad0b057..5a8d3d9ef9b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2177,8 +2177,8 @@ static struct xps_map *expand_xps_map(struct xps_map *map,
 	return new_map;
 }
 
-int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
-			u16 index)
+int __netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
+			  u16 index)
 {
 	struct xps_dev_maps *dev_maps, *new_dev_maps = NULL;
 	int i, cpu, tci, numa_node_id = -2;
@@ -2197,18 +2197,14 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 	if (maps_sz < L1_CACHE_BYTES)
 		maps_sz = L1_CACHE_BYTES;
 
-	mutex_lock(&xps_map_mutex);
-
 	dev_maps = xmap_dereference(dev->xps_maps);
 
 	/* allocate memory for queue storage */
 	for_each_cpu_and(cpu, cpu_online_mask, mask) {
 		if (!new_dev_maps)
 			new_dev_maps = kzalloc(maps_sz, GFP_KERNEL);
-		if (!new_dev_maps) {
-			mutex_unlock(&xps_map_mutex);
+		if (!new_dev_maps)
 			return -ENOMEM;
-		}
 
 		tci = cpu * num_tc + tc;
 		map = dev_maps ? xmap_dereference(dev_maps->cpu_map[tci]) :
@@ -2295,7 +2291,7 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 				     NUMA_NO_NODE);
 
 	if (!dev_maps)
-		goto out_no_maps;
+		return 0;
 
 	/* removes queue from unused CPUs */
 	for_each_possible_cpu(cpu) {
@@ -2312,11 +2308,8 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 		RCU_INIT_POINTER(dev->xps_maps, NULL);
 		kfree_rcu(dev_maps, rcu);
 	}
-
-out_no_maps:
-	mutex_unlock(&xps_map_mutex);
-
 	return 0;
+
 error:
 	/* remove any maps that we added */
 	for_each_possible_cpu(cpu) {
@@ -2330,13 +2323,50 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 		}
 	}
 
-	mutex_unlock(&xps_map_mutex);
-
 	kfree(new_dev_maps);
 	return -ENOMEM;
 }
+
+int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
+			u16 index)
+{
+	int ret;
+
+	mutex_lock(&xps_map_mutex);
+	ret = __netif_set_xps_queue(dev, mask, index);
+	mutex_unlock(&xps_map_mutex);
+	return ret;
+}
 EXPORT_SYMBOL(netif_set_xps_queue);
 
+int netif_set_xps(struct net_device *dev)
+{
+	cpumask_var_t queuemask;
+	int cpu, queue, err = 0;
+
+	if (!alloc_cpumask_var(&queuemask, GFP_KERNEL))
+		return -ENOMEM;
+
+	mutex_lock(&xps_map_mutex);
+	for (queue = 0; queue < dev->real_num_tx_queues; ++queue) {
+		cpumask_clear(queuemask);
+		for (cpu = queue; cpu < nr_cpu_ids;
+		     cpu += dev->real_num_tx_queues)
+			cpumask_set_cpu(cpu, queuemask);
+
+		err = __netif_set_xps_queue(dev, queuemask, queue);
+		if (err)
+			goto out;
+	}
+
+out:
+	mutex_unlock(&xps_map_mutex);
+
+	free_cpumask_var(queuemask);
+	return err;
+}
+EXPORT_SYMBOL(netif_set_xps);
+
 #endif
 void netdev_reset_tc(struct net_device *dev)
 {
-- 
2.14.3

