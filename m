From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:26:55 -0700
Subject: [Intel-wired-lan] [net-next 05/25] fm10k: Add netconsole support
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-5-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change adds a function called "fm10k_netpoll" that's used to define
"ndo_poll_controller" in "fm10k_netdev_ops". This is required to enable
support for "netconsole" in fm10k.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h        |  1 +
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 21 +++++++++++++++++++++
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 65e7001..715d0a0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -457,6 +457,7 @@ void fm10k_down(struct fm10k_intfc *interface);
 void fm10k_update_stats(struct fm10k_intfc *interface);
 void fm10k_service_event_schedule(struct fm10k_intfc *interface);
 void fm10k_update_rx_drop_en(struct fm10k_intfc *interface);
+irqreturn_t fm10k_msix_clean_rings(int irq, void *data);
 
 /* Netdev */
 struct net_device *fm10k_alloc_netdev(void);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index a7db5e2..2a61b83 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1350,6 +1350,26 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 	}
 }
 
+/**
+ * fm10k_netpoll - A Polling 'interrupt' handler
+ * @netdev: network interface device structure
+ *
+ * This is used by netconsole to send skbs without having to re-enable
+ * interrupts. It's not called while the normal interrupt routine is executing.
+ **/
+static void fm10k_netpoll(struct net_device *netdev)
+{
+	struct fm10k_intfc *interface = netdev_priv(netdev);
+	int i;
+
+	/* if interface is down do nothing */
+	if (test_bit(__FM10K_DOWN, &interface->state))
+		return;
+
+	for (i = 0; i < interface->num_q_vectors; i++)
+		fm10k_msix_clean_rings(0, interface->q_vector[i]);
+}
+
 static netdev_features_t fm10k_features_check(struct sk_buff *skb,
 					      struct net_device *dev,
 					      netdev_features_t features)
@@ -1382,6 +1402,7 @@ static const struct net_device_ops fm10k_netdev_ops = {
 	.ndo_do_ioctl		= fm10k_ioctl,
 	.ndo_dfwd_add_station	= fm10k_dfwd_add_station,
 	.ndo_dfwd_del_station	= fm10k_dfwd_del_station,
+	.ndo_poll_controller	= fm10k_netpoll,
 	.ndo_features_check	= fm10k_features_check,
 };
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 6fc9965..c11e2c9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -807,7 +807,7 @@ static void fm10k_napi_enable_all(struct fm10k_intfc *interface)
 	}
 }
 
-static irqreturn_t fm10k_msix_clean_rings(int irq, void *data)
+irqreturn_t fm10k_msix_clean_rings(int irq, void *data)
 {
 	struct fm10k_q_vector *q_vector = data;
 
-- 
1.9.3

