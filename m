From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 04 Apr 2018 12:59:55 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue,
 RFC PATCH 1/3] net: Refactor XPS for CPUs and Rx queues
In-Reply-To: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
References: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
Message-ID: <152287199518.5088.5840341893425358836.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Refactor XPS code to support Tx queue selection based on
CPU map or Rx queue map.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/linux/netdevice.h |   82 +++++++++++++++++-
 net/core/dev.c            |  208 ++++++++++++++++++++++++++++++---------------
 net/core/net-sysfs.c      |    4 -
 3 files changed, 218 insertions(+), 76 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cf44503..37dbffe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -730,10 +730,21 @@ struct xps_map {
  */
 struct xps_dev_maps {
 	struct rcu_head rcu;
-	struct xps_map __rcu *cpu_map[0];
+	struct xps_map __rcu *attr_map[0];
 };
-#define XPS_DEV_MAPS_SIZE(_tcs) (sizeof(struct xps_dev_maps) +		\
+
+#define XPS_CPU_DEV_MAPS_SIZE(_tcs) (sizeof(struct xps_dev_maps) +	\
 	(nr_cpu_ids * (_tcs) * sizeof(struct xps_map *)))
+
+#define XPS_RXQ_DEV_MAPS_SIZE(_tcs, _rxqs) (sizeof(struct xps_dev_maps) +\
+	(_rxqs * (_tcs) * sizeof(struct xps_map *)))
+
+enum xps_map_type {
+	XPS_MAP_RXQS,
+	XPS_MAP_CPUS,
+	__XPS_MAP_MAX
+};
+
 #endif /* CONFIG_XPS */
 
 #define TC_MAX_QUEUE	16
@@ -1867,7 +1878,7 @@ struct net_device {
 	int			watchdog_timeo;
 
 #ifdef CONFIG_XPS
-	struct xps_dev_maps __rcu *xps_maps;
+	struct xps_dev_maps __rcu *xps_maps[__XPS_MAP_MAX];
 #endif
 #ifdef CONFIG_NET_CLS_ACT
 	struct mini_Qdisc __rcu	*miniq_egress;
@@ -3204,6 +3215,71 @@ static inline void netif_wake_subqueue(struct net_device *dev, u16 queue_index)
 #ifdef CONFIG_XPS
 int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			u16 index);
+int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
+			  u16 index, enum xps_map_type type);
+
+static inline bool attr_test_mask(unsigned long j, const unsigned long *mask,
+				  unsigned int nr_bits)
+{
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+	WARN_ON_ONCE(j >= nr_bits);
+#endif /* CONFIG_DEBUG_PER_CPU_MAPS */
+	return test_bit(j, mask);
+}
+
+static inline bool attr_test_online(unsigned long j,
+				    const unsigned long *online_mask,
+				    unsigned int nr_bits)
+{
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+	WARN_ON_ONCE(j >= nr_bits);
+#endif /* CONFIG_DEBUG_PER_CPU_MAPS */
+
+	if (online_mask)
+		return test_bit(j, online_mask);
+
+	if (j >= 0 && j < nr_bits)
+		return true;
+
+	return false;
+}
+
+static inline unsigned int attrmask_next(int n, const unsigned long *srcp,
+					 unsigned int nr_bits)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1) {
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+		WARN_ON_ONCE(n >= nr_bits);
+#endif /* CONFIG_DEBUG_PER_CPU_MAPS */
+	}
+
+	if (srcp)
+		return find_next_bit(srcp, nr_bits, n + 1);
+
+	return n + 1;
+}
+
+static inline int attrmask_next_and(int n, const unsigned long *src1p,
+				    const unsigned long *src2p,
+				    unsigned int nr_bits)
+{
+	/* -1 is a legal arg here. */
+	if (n != -1) {
+#ifdef CONFIG_DEBUG_PER_CPU_MAPS
+		WARN_ON_ONCE(n >= nr_bits);
+#endif /* CONFIG_DEBUG_PER_CPU_MAPS */
+	}
+
+	if (src1p && src2p)
+		return find_next_and_bit(src1p, src2p, nr_bits, n + 1);
+	else if (src1p)
+		return find_next_bit(src1p, nr_bits, n + 1);
+	else if (src2p)
+		return find_next_bit(src2p, nr_bits, n + 1);
+
+	return n + 1;
+}
 #else
 static inline int netif_set_xps_queue(struct net_device *dev,
 				      const struct cpumask *mask,
diff --git a/net/core/dev.c b/net/core/dev.c
index 9b04a9f..4cfc179 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2091,7 +2091,7 @@ static bool remove_xps_queue(struct xps_dev_maps *dev_maps,
 	int pos;
 
 	if (dev_maps)
-		map = xmap_dereference(dev_maps->cpu_map[tci]);
+		map = xmap_dereference(dev_maps->attr_map[tci]);
 	if (!map)
 		return false;
 
@@ -2104,7 +2104,7 @@ static bool remove_xps_queue(struct xps_dev_maps *dev_maps,
 			break;
 		}
 
-		RCU_INIT_POINTER(dev_maps->cpu_map[tci], NULL);
+		RCU_INIT_POINTER(dev_maps->attr_map[tci], NULL);
 		kfree_rcu(map, rcu);
 		return false;
 	}
@@ -2137,30 +2137,49 @@ static bool remove_xps_queue_cpu(struct net_device *dev,
 static void netif_reset_xps_queues(struct net_device *dev, u16 offset,
 				   u16 count)
 {
+	const unsigned long *possible_mask = NULL;
+	enum xps_map_type type = XPS_MAP_RXQS;
 	struct xps_dev_maps *dev_maps;
-	int cpu, i;
 	bool active = false;
+	unsigned int nr_ids;
+	int i, j;
 
 	mutex_lock(&xps_map_mutex);
-	dev_maps = xmap_dereference(dev->xps_maps);
 
-	if (!dev_maps)
-		goto out_no_maps;
-
-	for_each_possible_cpu(cpu)
-		active |= remove_xps_queue_cpu(dev, dev_maps, cpu,
-					       offset, count);
+	while (type < __XPS_MAP_MAX) {
+		dev_maps = xmap_dereference(dev->xps_maps[type]);
+		if (!dev_maps)
+			goto out_no_maps;
+
+		if (type == XPS_MAP_CPUS) {
+			if (num_possible_cpus() > 1)
+				possible_mask = cpumask_bits(cpu_possible_mask);
+			nr_ids = nr_cpu_ids;
+		} else if (type == XPS_MAP_RXQS) {
+			nr_ids = dev->num_rx_queues;
+		}
 
-	if (!active) {
-		RCU_INIT_POINTER(dev->xps_maps, NULL);
-		kfree_rcu(dev_maps, rcu);
-	}
+		for (j = -1; j = attrmask_next(j, possible_mask, nr_ids),
+		     j < nr_ids;){
+			active |= remove_xps_queue_cpu(dev, dev_maps, j, offset,
+						       count);
+		}
 
-	for (i = offset + (count - 1); count--; i--)
-		netdev_queue_numa_node_write(netdev_get_tx_queue(dev, i),
-					     NUMA_NO_NODE);
+		if (!active) {
+			RCU_INIT_POINTER(dev->xps_maps[type], NULL);
+			kfree_rcu(dev_maps, rcu);
+		}
 
+		if (type == XPS_MAP_CPUS) {
+			for (i = offset + (count - 1); count--; i--)
+				netdev_queue_numa_node_write(
+					netdev_get_tx_queue(dev, i),
+							    NUMA_NO_NODE);
+		}
 out_no_maps:
+		type++;
+	}
+
 	mutex_unlock(&xps_map_mutex);
 }
 
@@ -2169,11 +2188,11 @@ static void netif_reset_xps_queues_gt(struct net_device *dev, u16 index)
 	netif_reset_xps_queues(dev, index, dev->num_tx_queues - index);
 }
 
-static struct xps_map *expand_xps_map(struct xps_map *map,
-				      int cpu, u16 index)
+static struct xps_map *expand_xps_map(struct xps_map *map, int attr_index,
+				      u16 index, enum xps_map_type type)
 {
-	struct xps_map *new_map;
 	int alloc_len = XPS_MIN_MAP_ALLOC;
+	struct xps_map *new_map = NULL;
 	int i, pos;
 
 	for (pos = 0; map && pos < map->len; pos++) {
@@ -2182,7 +2201,7 @@ static struct xps_map *expand_xps_map(struct xps_map *map,
 		return map;
 	}
 
-	/* Need to add queue to this CPU's existing map */
+	/* Need to add tx-queue to this CPU's/rx-queue's existing map */
 	if (map) {
 		if (pos < map->alloc_len)
 			return map;
@@ -2190,9 +2209,14 @@ static struct xps_map *expand_xps_map(struct xps_map *map,
 		alloc_len = map->alloc_len * 2;
 	}
 
-	/* Need to allocate new map to store queue on this CPU's map */
-	new_map = kzalloc_node(XPS_MAP_SIZE(alloc_len), GFP_KERNEL,
-			       cpu_to_node(cpu));
+	/* Need to allocate new map to store tx-queue on this CPU's/rx-queue's
+	 *  map
+	 */
+	if (type == XPS_MAP_RXQS)
+		new_map = kzalloc(XPS_MAP_SIZE(alloc_len), GFP_KERNEL);
+	else if (type == XPS_MAP_CPUS)
+		new_map = kzalloc_node(XPS_MAP_SIZE(alloc_len), GFP_KERNEL,
+				       cpu_to_node(attr_index));
 	if (!new_map)
 		return NULL;
 
@@ -2204,14 +2228,16 @@ static struct xps_map *expand_xps_map(struct xps_map *map,
 	return new_map;
 }
 
-int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
-			u16 index)
+int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
+			  u16 index, enum xps_map_type type)
 {
+	const unsigned long *online_mask = NULL, *possible_mask = NULL;
 	struct xps_dev_maps *dev_maps, *new_dev_maps = NULL;
-	int i, cpu, tci, numa_node_id = -2;
+	int i, j, tci, numa_node_id = -2;
 	int maps_sz, num_tc = 1, tc = 0;
 	struct xps_map *map, *new_map;
 	bool active = false;
+	unsigned int nr_ids;
 
 	if (dev->num_tc) {
 		num_tc = dev->num_tc;
@@ -2220,16 +2246,33 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			return -EINVAL;
 	}
 
-	maps_sz = XPS_DEV_MAPS_SIZE(num_tc);
+	switch (type) {
+	case XPS_MAP_RXQS:
+		maps_sz = XPS_RXQ_DEV_MAPS_SIZE(num_tc, dev->num_rx_queues);
+		dev_maps = xmap_dereference(dev->xps_maps[XPS_MAP_RXQS]);
+		nr_ids = dev->num_rx_queues;
+		break;
+	case XPS_MAP_CPUS:
+		maps_sz = XPS_CPU_DEV_MAPS_SIZE(num_tc);
+		if (num_possible_cpus() > 1) {
+			online_mask = cpumask_bits(cpu_online_mask);
+			possible_mask = cpumask_bits(cpu_possible_mask);
+		}
+		dev_maps = xmap_dereference(dev->xps_maps[XPS_MAP_CPUS]);
+		nr_ids = nr_cpu_ids;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (maps_sz < L1_CACHE_BYTES)
 		maps_sz = L1_CACHE_BYTES;
 
 	mutex_lock(&xps_map_mutex);
 
-	dev_maps = xmap_dereference(dev->xps_maps);
-
 	/* allocate memory for queue storage */
-	for_each_cpu_and(cpu, cpu_online_mask, mask) {
+	for (j = -1; j = attrmask_next_and(j, online_mask, mask, nr_ids),
+	     j < nr_ids;) {
 		if (!new_dev_maps)
 			new_dev_maps = kzalloc(maps_sz, GFP_KERNEL);
 		if (!new_dev_maps) {
@@ -2237,73 +2280,81 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 			return -ENOMEM;
 		}
 
-		tci = cpu * num_tc + tc;
-		map = dev_maps ? xmap_dereference(dev_maps->cpu_map[tci]) :
+		tci = j * num_tc + tc;
+		map = dev_maps ? xmap_dereference(dev_maps->attr_map[tci]) :
 				 NULL;
 
-		map = expand_xps_map(map, cpu, index);
+		map = expand_xps_map(map, j, index, type);
 		if (!map)
 			goto error;
 
-		RCU_INIT_POINTER(new_dev_maps->cpu_map[tci], map);
+		RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
 	}
 
 	if (!new_dev_maps)
 		goto out_no_new_maps;
 
-	for_each_possible_cpu(cpu) {
+	for (j = -1; j = attrmask_next(j, possible_mask, nr_ids),
+	     j < nr_ids;) {
 		/* copy maps belonging to foreign traffic classes */
-		for (i = tc, tci = cpu * num_tc; dev_maps && i--; tci++) {
+		for (i = tc, tci = j * num_tc; dev_maps && i--; tci++) {
 			/* fill in the new device map from the old device map */
-			map = xmap_dereference(dev_maps->cpu_map[tci]);
-			RCU_INIT_POINTER(new_dev_maps->cpu_map[tci], map);
+			map = xmap_dereference(dev_maps->attr_map[tci]);
+			RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
 		}
 
 		/* We need to explicitly update tci as prevous loop
 		 * could break out early if dev_maps is NULL.
 		 */
-		tci = cpu * num_tc + tc;
+		tci = j * num_tc + tc;
 
-		if (cpumask_test_cpu(cpu, mask) && cpu_online(cpu)) {
-			/* add queue to CPU maps */
+		if (attr_test_mask(j, mask, nr_ids) &&
+		    attr_test_online(j, online_mask, nr_ids)) {
+			/* add tx-queue to CPU/rx-queue maps */
 			int pos = 0;
 
-			map = xmap_dereference(new_dev_maps->cpu_map[tci]);
+			map = xmap_dereference(new_dev_maps->attr_map[tci]);
 			while ((pos < map->len) && (map->queues[pos] != index))
 				pos++;
 
 			if (pos == map->len)
 				map->queues[map->len++] = index;
 #ifdef CONFIG_NUMA
-			if (numa_node_id == -2)
-				numa_node_id = cpu_to_node(cpu);
-			else if (numa_node_id != cpu_to_node(cpu))
-				numa_node_id = -1;
+			if (type == XPS_MAP_CPUS) {
+				if (numa_node_id == -2)
+					numa_node_id = cpu_to_node(j);
+				else if (numa_node_id != cpu_to_node(j))
+					numa_node_id = -1;
+			}
 #endif
 		} else if (dev_maps) {
 			/* fill in the new device map from the old device map */
-			map = xmap_dereference(dev_maps->cpu_map[tci]);
-			RCU_INIT_POINTER(new_dev_maps->cpu_map[tci], map);
+			map = xmap_dereference(dev_maps->attr_map[tci]);
+			RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
 		}
 
 		/* copy maps belonging to foreign traffic classes */
 		for (i = num_tc - tc, tci++; dev_maps && --i; tci++) {
 			/* fill in the new device map from the old device map */
-			map = xmap_dereference(dev_maps->cpu_map[tci]);
-			RCU_INIT_POINTER(new_dev_maps->cpu_map[tci], map);
+			map = xmap_dereference(dev_maps->attr_map[tci]);
+			RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);
 		}
 	}
 
-	rcu_assign_pointer(dev->xps_maps, new_dev_maps);
+	if (type == XPS_MAP_RXQS)
+		rcu_assign_pointer(dev->xps_maps[XPS_MAP_RXQS], new_dev_maps);
+	else if (type == XPS_MAP_CPUS)
+		rcu_assign_pointer(dev->xps_maps[XPS_MAP_CPUS], new_dev_maps);
 
 	/* Cleanup old maps */
 	if (!dev_maps)
 		goto out_no_old_maps;
 
-	for_each_possible_cpu(cpu) {
-		for (i = num_tc, tci = cpu * num_tc; i--; tci++) {
-			new_map = xmap_dereference(new_dev_maps->cpu_map[tci]);
-			map = xmap_dereference(dev_maps->cpu_map[tci]);
+	for (j = -1; j = attrmask_next(j, possible_mask, nr_ids),
+	     j < nr_ids;) {
+		for (i = num_tc, tci = j * num_tc; i--; tci++) {
+			new_map = xmap_dereference(new_dev_maps->attr_map[tci]);
+			map = xmap_dereference(dev_maps->attr_map[tci]);
 			if (map && map != new_map)
 				kfree_rcu(map, rcu);
 		}
@@ -2316,19 +2367,23 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 	active = true;
 
 out_no_new_maps:
-	/* update Tx queue numa node */
-	netdev_queue_numa_node_write(netdev_get_tx_queue(dev, index),
-				     (numa_node_id >= 0) ? numa_node_id :
-				     NUMA_NO_NODE);
+	if (type == XPS_MAP_CPUS) {
+		/* update Tx queue numa node */
+		netdev_queue_numa_node_write(netdev_get_tx_queue(dev, index),
+					     (numa_node_id >= 0) ?
+					     numa_node_id : NUMA_NO_NODE);
+	}
 
 	if (!dev_maps)
 		goto out_no_maps;
 
-	/* removes queue from unused CPUs */
-	for_each_possible_cpu(cpu) {
-		for (i = tc, tci = cpu * num_tc; i--; tci++)
+	/* removes tx-queue from unused CPUs/rx-queues */
+	for (j = -1; j = attrmask_next(j, possible_mask, nr_ids),
+	     j < nr_ids;) {
+		for (i = tc, tci = j * num_tc; i--; tci++)
 			active |= remove_xps_queue(dev_maps, tci, index);
-		if (!cpumask_test_cpu(cpu, mask) || !cpu_online(cpu))
+		if (!attr_test_mask(j, mask, nr_ids) ||
+		    !attr_test_online(j, online_mask, nr_ids))
 			active |= remove_xps_queue(dev_maps, tci, index);
 		for (i = num_tc - tc, tci++; --i; tci++)
 			active |= remove_xps_queue(dev_maps, tci, index);
@@ -2336,7 +2391,10 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 
 	/* free map if not active */
 	if (!active) {
-		RCU_INIT_POINTER(dev->xps_maps, NULL);
+		if (type == XPS_MAP_RXQS)
+			RCU_INIT_POINTER(dev->xps_maps[XPS_MAP_RXQS], NULL);
+		else if (type == XPS_MAP_CPUS)
+			RCU_INIT_POINTER(dev->xps_maps[XPS_MAP_CPUS], NULL);
 		kfree_rcu(dev_maps, rcu);
 	}
 
@@ -2346,11 +2404,12 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 	return 0;
 error:
 	/* remove any maps that we added */
-	for_each_possible_cpu(cpu) {
-		for (i = num_tc, tci = cpu * num_tc; i--; tci++) {
-			new_map = xmap_dereference(new_dev_maps->cpu_map[tci]);
+	for (j = -1; j = attrmask_next(j, possible_mask, nr_ids),
+	     j < nr_ids;) {
+		for (i = num_tc, tci = j * num_tc; i--; tci++) {
+			new_map = xmap_dereference(new_dev_maps->attr_map[tci]);
 			map = dev_maps ?
-			      xmap_dereference(dev_maps->cpu_map[tci]) :
+			      xmap_dereference(dev_maps->attr_map[tci]) :
 			      NULL;
 			if (new_map && new_map != map)
 				kfree(new_map);
@@ -2362,6 +2421,13 @@ int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
 	kfree(new_dev_maps);
 	return -ENOMEM;
 }
+
+int netif_set_xps_queue(struct net_device *dev, const struct cpumask *mask,
+			u16 index)
+{
+	return __netif_set_xps_queue(dev, cpumask_bits(mask), index,
+				     XPS_MAP_CPUS);
+}
 EXPORT_SYMBOL(netif_set_xps_queue);
 
 #endif
@@ -3399,7 +3465,7 @@ static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 	int queue_index = -1;
 
 	rcu_read_lock();
-	dev_maps = rcu_dereference(dev->xps_maps);
+	dev_maps = rcu_dereference(dev->xps_maps[XPS_MAP_CPUS]);
 	if (dev_maps) {
 		unsigned int tci = skb->sender_cpu - 1;
 
@@ -3408,7 +3474,7 @@ static inline int get_xps_queue(struct net_device *dev, struct sk_buff *skb)
 			tci += netdev_get_prio_tc_map(dev, skb->priority);
 		}
 
-		map = rcu_dereference(dev_maps->cpu_map[tci]);
+		map = rcu_dereference(dev_maps->attr_map[tci]);
 		if (map) {
 			if (map->len == 1)
 				queue_index = map->queues[0];
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c476f07..d7abd33 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1227,13 +1227,13 @@ static ssize_t xps_cpus_show(struct netdev_queue *queue,
 	}
 
 	rcu_read_lock();
-	dev_maps = rcu_dereference(dev->xps_maps);
+	dev_maps = rcu_dereference(dev->xps_maps[XPS_MAP_CPUS]);
 	if (dev_maps) {
 		for_each_possible_cpu(cpu) {
 			int i, tci = cpu * num_tc + tc;
 			struct xps_map *map;
 
-			map = rcu_dereference(dev_maps->cpu_map[tci]);
+			map = rcu_dereference(dev_maps->attr_map[tci]);
 			if (!map)
 				continue;
 

