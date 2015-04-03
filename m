From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:05 -0700
Subject: [Intel-wired-lan] [net-next 15/25] fm10k: use separate workqueue
	for fm10k driver
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-15-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since we run the watchdog periodically, which might take a while and
potentially monopolize the system default workqueue, create our own
separate work queue. This also helps reduce and stabilize latency
between scheduling the work in our interrupt and actually performing
the work. Still use a timer for the regular scheduled interval but
queue the work onto its own work queue.

It seemed overkill to create a single workqueue per interface, so we
just spawn a single work queue for all interfaces upon driver load. For
this reason, use a multi-threaded workqueue with one thread per
processor, rather than single threaded queue.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  3 +++
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 12 ++++++++++++
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index 715d0a0..cc7f442e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -235,6 +235,9 @@ struct fm10k_vxlan_port {
 	__be16			port;
 };
 
+/* one work queue for entire driver */
+extern struct workqueue_struct *fm10k_workqueue;
+
 struct fm10k_intfc {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	struct net_device *netdev;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 5022a45..1e08832 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -41,6 +41,9 @@ MODULE_DESCRIPTION("Intel(R) Ethernet Switch Host Interface Driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
 
+/* single workqueue for entire fm10k driver */
+struct workqueue_struct *fm10k_workqueue = NULL;
+
 /**
  * fm10k_init_module - Driver Registration Routine
  *
@@ -52,6 +55,10 @@ static int __init fm10k_init_module(void)
 	pr_info("%s - version %s\n", fm10k_driver_string, fm10k_driver_version);
 	pr_info("%s\n", fm10k_copyright);
 
+	/* create driver workqueue */
+	if (!fm10k_workqueue)
+		fm10k_workqueue = create_workqueue("fm10k");
+
 	fm10k_dbg_init();
 
 	return fm10k_register_pci_driver();
@@ -69,6 +76,11 @@ static void __exit fm10k_exit_module(void)
 	fm10k_unregister_pci_driver();
 
 	fm10k_dbg_exit();
+
+	/* destroy driver workqueue */
+	flush_workqueue(fm10k_workqueue);
+	destroy_workqueue(fm10k_workqueue);
+	fm10k_workqueue = NULL;
 }
 module_exit(fm10k_exit_module);
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index d7af466..fcf0d5a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -94,7 +94,7 @@ void fm10k_service_event_schedule(struct fm10k_intfc *interface)
 {
 	if (!test_bit(__FM10K_SERVICE_DISABLE, &interface->state) &&
 	    !test_and_set_bit(__FM10K_SERVICE_SCHED, &interface->state))
-		schedule_work(&interface->service_task);
+		queue_work(fm10k_workqueue, &interface->service_task);
 }
 
 static void fm10k_service_event_complete(struct fm10k_intfc *interface)
-- 
1.9.3

