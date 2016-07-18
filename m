From: kan.liang@intel.com <kan.liang@intel.com>
Date: Sun, 17 Jul 2016 23:55:59 -0700
Subject: [Intel-wired-lan] [RFC PATCH 05/30] i40e/netpolicy: implement
	ndo_get_irq_info
In-Reply-To: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
Message-ID: <1468824984-65318-6-git-send-email-kan.liang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kan Liang <kan.liang@intel.com>

Implement ndo_get_irq_info in i40e driver to get irq information of rx
and tx queues.

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 40 +++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ee1f0b2..8a919e44 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8996,6 +8996,45 @@ static int i40e_ndo_netpolicy_init(struct net_device *dev,
 
 	return 0;
 }
+
+/**
+ * i40e_ndo_get_irq_info
+ * @dev: the net device pointer
+ * @info: irq information which need to be updated
+ *
+ * Update irq information of tx and rx queues
+ * Returns 0 on success, negative on failure
+ */
+static int i40e_ndo_get_irq_info(struct net_device *dev,
+				 struct netpolicy_dev_info *info)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
+	int i;
+
+	info->rx_num = vsi->num_queue_pairs;
+	info->rx_irq = kmalloc_array(info->rx_num, sizeof(u32), GFP_KERNEL);
+	if (!info->rx_irq) {
+		info->rx_num = 0;
+		return -ENOMEM;
+	}
+
+	info->tx_num = vsi->num_queue_pairs;
+	info->tx_irq = kmalloc_array(info->tx_num, sizeof(u32), GFP_KERNEL);
+	if (!info->tx_irq) {
+		info->tx_num = 0;
+		kfree(info->rx_irq);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < vsi->num_queue_pairs; i++) {
+		info->rx_irq[i] = pf->msix_entries[vsi->base_vector + i].vector;
+		info->tx_irq[i] = pf->msix_entries[vsi->base_vector + i].vector;
+	}
+
+	return 0;
+}
 #endif /* CONFIG_NETPOLICY */
 
 static const struct net_device_ops i40e_netdev_ops = {
@@ -9036,6 +9075,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
 #ifdef CONFIG_NETPOLICY
 	.ndo_netpolicy_init	= i40e_ndo_netpolicy_init,
+	.ndo_get_irq_info	= i40e_ndo_get_irq_info,
 #endif /* CONFIG_NETPOLICY */
 };
 
-- 
2.5.5

