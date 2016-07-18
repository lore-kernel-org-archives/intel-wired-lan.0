From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:56:03 -0700
Subject: [Intel-wired-lan] [RFC PATCH 09/30] net/netpolicy: enable and
	disable net policy
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-10-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

This patch introduces functions to enable and disable net policy.
For enabling, it collects device and cpu information, setup cpu/queue
mapping, and set irq affinity accordingly.
For disabling, it removes the irq affinity and mapping information.
np_lock should protect the enable and disable state. It will be done
later in this series.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 net/core/netpolicy.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/core/netpolicy.c b/net/core/netpolicy.c
index c44818d..7d4a49d 100644
--- a/net/core/netpolicy.c
+++ b/net/core/netpolicy.c
@@ -161,6 +161,45 @@ static void netpolicy_set_affinity(struct net_device *dev)
 	}
 }
 
+static int netpolicy_disable(struct net_device *dev)
+{
+	netpolicy_clear_affinity(dev);
+	netpolicy_free_sys_map(dev);
+
+	return 0;
+}
+
+static int netpolicy_enable(struct net_device *dev)
+{
+	int ret;
+	struct netpolicy_dev_info d_info;
+	u32 cpu;
+
+	if (WARN_ON(!dev->netpolicy))
+		return -EINVAL;
+
+	/* get driver information */
+	ret = netpolicy_get_dev_info(dev, &d_info);
+	if (ret)
+		return ret;
+
+	/* get cpu information */
+	cpu = netpolicy_get_cpu_information();
+
+	/* create sys map */
+	ret = netpolicy_update_sys_map(dev, &d_info, cpu);
+	if (ret) {
+		netpolicy_free_dev_info(&d_info);
+		return ret;
+	}
+
+	/* set irq affinity */
+	netpolicy_set_affinity(dev);
+
+	netpolicy_free_dev_info(&d_info);
+	return 0;
+}
+
 const char *policy_name[NET_POLICY_MAX] = {
 	"NONE"
 };
-- 
2.5.5

