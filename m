From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 31 Oct 2016 13:00:34 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: handle race between close and
	suspend on shutdown
Message-ID: <20161031200034.4729.18959.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When an interface is part of a namespace it is possible that
ixgbevf_close() may be called while ixgbevf_suspend() is running
which ends up in a double free WARN and/or a BUG in free_msi_irqs()

This patch introduces a new adapter->state bit that will allow us
to handle this rate atomically. The idea is that ixgbevf_close() should
not run if ixgbevf_suspend is in session.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 5639fbe..dc4b3b4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -446,6 +446,7 @@ enum ixbgevf_state_t {
 	__IXGBEVF_SERVICE_INITED,
 	__IXGBEVF_RESET_REQUESTED,
 	__IXGBEVF_QUEUE_RESET_REQUESTED,
+	__IXGBEVF_CLEAR_IRQS,
 };
 
 enum ixgbevf_boards {
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d316f50..8ebe797 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3242,12 +3242,17 @@ int ixgbevf_close(struct net_device *netdev)
 {
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 
+	if (test_and_set_bit(__IXGBEVF_CLEAR_IRQS, &adapter->state))
+		return 0;
+
 	ixgbevf_down(adapter);
 	ixgbevf_free_irq(adapter);
 
 	ixgbevf_free_all_tx_resources(adapter);
 	ixgbevf_free_all_rx_resources(adapter);
 
+	clear_bit(__IXGBEVF_CLEAR_IRQS, &adapter->state);
+
 	return 0;
 }
 
@@ -3792,6 +3797,9 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
 	int retval = 0;
 #endif
 
+	while (test_and_set_bit(__IXGBEVF_CLEAR_IRQS, &adapter->state))
+		usleep_range(1000, 2000);
+
 	netif_device_detach(netdev);
 
 	if (netif_running(netdev)) {
@@ -3813,6 +3821,7 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
 	if (!test_and_set_bit(__IXGBEVF_DISABLED, &adapter->state))
 		pci_disable_device(pdev);
 
+	clear_bit(__IXGBEVF_CLEAR_IRQS, &adapter->state);
 	return 0;
 }
 

