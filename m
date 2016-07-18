From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:56:02 -0700
Subject: [Intel-wired-lan] [RFC PATCH 08/30] net/netpolicy: set and remove
	irq affinity
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-9-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

This patches introduces functions to set and remove irq affinity
according to cpu and queue mapping.
The functions will not record the previous affinity status. After a
set/remove cycles, it will set the affinity on all online cpu with irq
balance enabling.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 net/core/netpolicy.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/core/netpolicy.c b/net/core/netpolicy.c
index ff7fc04..c44818d 100644
--- a/net/core/netpolicy.c
+++ b/net/core/netpolicy.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/uaccess.h>
@@ -128,6 +129,38 @@ err:
 	return -ENOMEM;
 }
 
+static void netpolicy_clear_affinity(struct net_device *dev)
+{
+	struct netpolicy_sys_info *s_info = &dev->netpolicy->sys_info;
+	u32 i;
+
+	for (i = 0; i < s_info->avail_rx_num; i++) {
+		irq_clear_status_flags(s_info->rx[i].irq, IRQ_NO_BALANCING);
+		irq_set_affinity_hint(s_info->rx[i].irq, cpu_online_mask);
+	}
+
+	for (i = 0; i < s_info->avail_tx_num; i++) {
+		irq_clear_status_flags(s_info->tx[i].irq, IRQ_NO_BALANCING);
+		irq_set_affinity_hint(s_info->tx[i].irq, cpu_online_mask);
+	}
+}
+
+static void netpolicy_set_affinity(struct net_device *dev)
+{
+	struct netpolicy_sys_info *s_info = &dev->netpolicy->sys_info;
+	u32 i;
+
+	for (i = 0; i < s_info->avail_rx_num; i++) {
+		irq_set_status_flags(s_info->rx[i].irq, IRQ_NO_BALANCING);
+		irq_set_affinity_hint(s_info->rx[i].irq, cpumask_of(s_info->rx[i].cpu));
+	}
+
+	for (i = 0; i < s_info->avail_tx_num; i++) {
+		irq_set_status_flags(s_info->tx[i].irq, IRQ_NO_BALANCING);
+		irq_set_affinity_hint(s_info->tx[i].irq, cpumask_of(s_info->tx[i].cpu));
+	}
+}
+
 const char *policy_name[NET_POLICY_MAX] = {
 	"NONE"
 };
-- 
2.5.5

