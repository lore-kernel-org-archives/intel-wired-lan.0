From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:55:58 -0700
Subject: [Intel-wired-lan] [RFC PATCH 04/30] net/netpolicy: get driver
	information
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-5-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

Net policy needs to know device information. Currently, it's enough to
only get irq information of rx and tx queues. This patch
introduces ndo_get_irq_info to do so.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 include/linux/netdevice.h |  5 +++++
 include/linux/netpolicy.h |  7 +++++++
 net/core/netpolicy.c      | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ef45dfe..3470943 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1091,6 +1091,9 @@ struct tc_to_netdev {
  * int (*ndo_netpolicy_init)(struct net_device *dev,
  * 			     struct netpolicy_info *info);
  * 	This function is used to init and get supported policy.
+ * int (*ndo_get_irq_info)(struct net_device *dev,
+ * 			   struct netpolicy_dev_info *info);
+ * 	This function is used to get irq information of rx and tx queues
  *
  */
 struct net_device_ops {
@@ -1278,6 +1281,8 @@ struct net_device_ops {
 #ifdef CONFIG_NETPOLICY
 	int			(*ndo_netpolicy_init)(struct net_device *dev,
 						      struct netpolicy_info *info);
+	int			(*ndo_get_irq_info)(struct net_device *dev,
+						    struct netpolicy_dev_info *info);
 #endif /* CONFIG_NETPOLICY */
 };
 
diff --git a/include/linux/netpolicy.h b/include/linux/netpolicy.h
index ca1f131..fc87d9b 100644
--- a/include/linux/netpolicy.h
+++ b/include/linux/netpolicy.h
@@ -23,6 +23,13 @@ enum netpolicy_name {
 
 extern const char *policy_name[];
 
+struct netpolicy_dev_info {
+	u32	rx_num;
+	u32	tx_num;
+	u32	*rx_irq;
+	u32	*tx_irq;
+};
+
 struct netpolicy_info {
 	enum netpolicy_name	cur_policy;
 	unsigned long avail_policy[BITS_TO_LONGS(NET_POLICY_MAX)];
diff --git a/net/core/netpolicy.c b/net/core/netpolicy.c
index 5f304d5..7c34c8a 100644
--- a/net/core/netpolicy.c
+++ b/net/core/netpolicy.c
@@ -35,6 +35,20 @@
 #include <linux/netdevice.h>
 #include <net/net_namespace.h>
 
+static int netpolicy_get_dev_info(struct net_device *dev,
+				  struct netpolicy_dev_info *d_info)
+{
+	if (!dev->netdev_ops->ndo_get_irq_info)
+		return -ENOTSUPP;
+	return dev->netdev_ops->ndo_get_irq_info(dev, d_info);
+}
+
+static void netpolicy_free_dev_info(struct netpolicy_dev_info *d_info)
+{
+	kfree(d_info->rx_irq);
+	kfree(d_info->tx_irq);
+}
+
 const char *policy_name[NET_POLICY_MAX] = {
 	"NONE"
 };
-- 
2.5.5

