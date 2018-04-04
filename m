From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 04 Apr 2018 13:00:05 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue,
 RFC PATCH 3/3] net-sysfs: Add interface for Rx queue map per Tx
 queue
In-Reply-To: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
References: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
Message-ID: <152287200541.5088.8794096982083775483.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend transmit queue sysfs attribute to configure Rx queue map
per Tx queue. By default no receive queues are configured for the
Tx queue.

- /sys/class/net/eth0/queues/tx-*/xps_rxqs

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 net/core/net-sysfs.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index d7abd33..0654243 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1283,6 +1283,86 @@ static ssize_t xps_cpus_store(struct netdev_queue *queue,
 
 static struct netdev_queue_attribute xps_cpus_attribute __ro_after_init
 	= __ATTR_RW(xps_cpus);
+
+static ssize_t xps_rxqs_show(struct netdev_queue *queue, char *buf)
+{
+	struct net_device *dev = queue->dev;
+	struct xps_dev_maps *dev_maps;
+	unsigned long *mask, index;
+	int j, len, num_tc = 1, tc = 0;
+
+	mask = kcalloc(BITS_TO_LONGS(dev->num_rx_queues), sizeof(long),
+		       GFP_KERNEL);
+	if (!mask)
+		return -ENOMEM;
+
+	index = get_netdev_queue_index(queue);
+
+	if (dev->num_tc) {
+		num_tc = dev->num_tc;
+		tc = netdev_txq_to_tc(dev, index);
+		if (tc < 0)
+			return -EINVAL;
+	}
+
+	rcu_read_lock();
+	dev_maps = rcu_dereference(dev->xps_maps[XPS_MAP_RXQS]);
+	if (dev_maps) {
+		for (j = -1; j = attrmask_next(j, NULL, dev->num_rx_queues),
+		     j < dev->num_rx_queues;) {
+			int i, tci = j * num_tc + tc;
+			struct xps_map *map;
+
+			map = rcu_dereference(dev_maps->attr_map[tci]);
+			if (!map)
+				continue;
+
+			for (i = map->len; i--;) {
+				if (map->queues[i] == index) {
+					set_bit(j, mask);
+					break;
+				}
+			}
+		}
+	}
+
+	len = bitmap_print_to_pagebuf(false, buf, mask, dev->num_rx_queues);
+	rcu_read_unlock();
+	kfree(mask);
+
+	return len < PAGE_SIZE ? len : -EINVAL;
+}
+
+static ssize_t xps_rxqs_store(struct netdev_queue *queue, const char *buf,
+			      size_t len)
+{
+	struct net_device *dev = queue->dev;
+	unsigned long *mask, index;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	mask = kcalloc(BITS_TO_LONGS(dev->num_rx_queues), sizeof(long),
+		       GFP_KERNEL);
+	if (!mask)
+		return -ENOMEM;
+
+	index = get_netdev_queue_index(queue);
+
+	err = bitmap_parse(buf, len, mask, dev->num_rx_queues);
+	if (err) {
+		kfree(mask);
+		return err;
+	}
+
+	err = __netif_set_xps_queue(dev, mask, index, XPS_MAP_RXQS);
+	kfree(mask);
+	return err ? : len;
+}
+
+static struct netdev_queue_attribute xps_rxqs_attribute __ro_after_init
+	= __ATTR_RW(xps_rxqs);
 #endif /* CONFIG_XPS */
 
 static struct attribute *netdev_queue_default_attrs[] __ro_after_init = {
@@ -1290,6 +1370,7 @@ static struct attribute *netdev_queue_default_attrs[] __ro_after_init = {
 	&queue_traffic_class.attr,
 #ifdef CONFIG_XPS
 	&xps_cpus_attribute.attr,
+	&xps_rxqs_attribute.attr,
 	&queue_tx_maxrate.attr,
 #endif
 	NULL

