From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 25 Jun 2021 17:33:05 -0700
Subject: [Intel-wired-lan] [PATCH net-next v4 03/12] core: Introduce
 netdev_tc_map_to_queue_mask()
In-Reply-To: <20210626003314.3159402-1-vinicius.gomes@intel.com>
References: <20210626003314.3159402-1-vinicius.gomes@intel.com>
Message-ID: <20210626003314.3159402-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Converts from a bitmask specifying traffic classes (bit 0 for traffic
class (TC) 0, bit 1 for TC 1, and so on) to a bitmask for queues. The
conversion is done using the netdev.tc_to_txq map.

netdev_tc_map_to_queue_mask() first users will be the mqprio and
taprio qdiscs.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index af5d4c5b0ad5..dcff0b9a55ab 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2279,6 +2279,7 @@ int netdev_txq_to_tc(struct net_device *dev, unsigned int txq);
 void netdev_reset_tc(struct net_device *dev);
 int netdev_set_tc_queue(struct net_device *dev, u8 tc, u16 count, u16 offset);
 int netdev_set_num_tc(struct net_device *dev, u8 num_tc);
+u32 netdev_tc_map_to_queue_mask(struct net_device *dev, u32 tc_mask);
 
 static inline
 int netdev_get_num_tc(struct net_device *dev)
diff --git a/net/core/dev.c b/net/core/dev.c
index 991d09b67bd9..4b25dbd26243 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2956,6 +2956,26 @@ int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
 }
 EXPORT_SYMBOL(netdev_set_num_tc);
 
+u32 netdev_tc_map_to_queue_mask(struct net_device *dev, u32 tc_mask)
+{
+	u32 i, queue_mask = 0;
+
+	for (i = 0; i < dev->num_tc; i++) {
+		u32 offset, count;
+
+		if (!(tc_mask & BIT(i)))
+			continue;
+
+		offset = dev->tc_to_txq[i].offset;
+		count = dev->tc_to_txq[i].count;
+
+		queue_mask |= GENMASK(offset + count - 1, offset);
+	}
+
+	return queue_mask;
+}
+EXPORT_SYMBOL(netdev_tc_map_to_queue_mask);
+
 void netdev_unbind_sb_channel(struct net_device *dev,
 			      struct net_device *sb_dev)
 {
-- 
2.32.0

