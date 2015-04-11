From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 19:14:31 -0700
Subject: [Intel-wired-lan] [net-next v2 05/25] fm10k: Add netconsole support
Message-ID: <20150411021116.27829.56207.stgit@gmw-smvitp108.amr.corp.intel.com>
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
v2: based on feedback from Alex, moved fm10k_netpoll() to fm10k_pci.c
    since it is technically a interrupt handler and wrapped the
    fm10k_netpoll() references with CONFIG_NET_POLL_CONTROLLER
---
 drivers/net/ethernet/intel/fm10k/fm10k.h        |    3 +++
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    3 +++
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c    |   22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 65e7001..b45f797 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -457,6 +457,9 @@ void fm10k_down(struct fm10k_intfc *interface);
 void fm10k_update_stats(struct fm10k_intfc *interface);
 void fm10k_service_event_schedule(struct fm10k_intfc *interface);
 void fm10k_update_rx_drop_en(struct fm10k_intfc *interface);
+#ifdef CONFIG_NET_POLL_CONTROLLER
+void fm10k_netpoll(struct net_device *netdev);
+#endif
 
 /* Netdev */
 struct net_device *fm10k_alloc_netdev(void);
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index a7db5e2..702d845 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1382,6 +1382,9 @@ static const struct net_device_ops fm10k_netdev_ops = {
 	.ndo_do_ioctl		= fm10k_ioctl,
 	.ndo_dfwd_add_station	= fm10k_dfwd_add_station,
 	.ndo_dfwd_del_station	= fm10k_dfwd_del_station,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fm10k_netpoll,
+#endif
 	.ndo_features_check	= fm10k_features_check,
 };
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 6fc9965..90d6fae 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -839,6 +839,28 @@ static irqreturn_t fm10k_msix_mbx_vf(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/**
+ *  fm10k_netpoll - A Polling 'interrupt' handler
+ *  @netdev: network interface device structure
+ *
+ *  This is used by netconsole to send skbs without having to re-enable
+ *  interrupts. It's not called while the normal interrupt routine is executing.
+ **/
+void fm10k_netpoll(struct net_device *netdev)
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
+#endif
 #define FM10K_ERR_MSG(type) case (type): error = #type; break
 static void fm10k_print_fault(struct fm10k_intfc *interface, int type,
 			      struct fm10k_fault *fault)

