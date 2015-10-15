From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 15 Oct 2015 14:24:45 -0700
Subject: [Intel-wired-lan] [next-queue v3 05/17] fm10k: reinitialize queuing
	scheme after calling init_hw
In-Reply-To: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
References: <1444944297-9733-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1444944297-9733-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The init_hw function may fail, and in the case of VFs, it might change
the number of maximum queues available. Thus, for every flow which
checks init_hw, we need to ensure that we clear the queue scheme before,
and initialize it after. The fm10k_io_slot_reset path will end up
triggering a reset so fm10k_reinit needs this change. The
fm10k_io_error_detected and fm10k_io_resume also need to properly clear
and reinitialize the queue scheme.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 65e2ea10b890..9ad9f9164d91 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -159,6 +159,9 @@ static void fm10k_reinit(struct fm10k_intfc *interface)
 
 	fm10k_mbx_free_irq(interface);
 
+	/* free interrupts */
+	fm10k_clear_queueing_scheme(interface);
+
 	/* delay any future reset requests */
 	interface->last_reset = jiffies + (10 * HZ);
 
@@ -175,6 +178,12 @@ static void fm10k_reinit(struct fm10k_intfc *interface)
 		goto reinit_err;
 	}
 
+	err = fm10k_init_queueing_scheme(interface);
+	if (err) {
+		dev_err(&interface->pdev->dev, "init_queueing_scheme failed: %d\n", err);
+		goto reinit_err;
+	}
+
 	/* reassociate interrupts */
 	fm10k_mbx_request_irq(interface);
 
@@ -2202,6 +2211,9 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
 	if (netif_running(netdev))
 		fm10k_close(netdev);
 
+	/* free interrupts */
+	fm10k_clear_queueing_scheme(interface);
+
 	fm10k_mbx_free_irq(interface);
 
 	pci_disable_device(pdev);
@@ -2274,6 +2286,12 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 	/* reset statistics starting values */
 	hw->mac.ops.rebind_hw_stats(hw, &interface->stats);
 
+	err = fm10k_init_queueing_scheme(interface);
+	if (err) {
+		dev_err(&interface->pdev->dev, "init_queueing_scheme failed: %d\n", err);
+		return;
+	}
+
 	/* reassociate interrupts */
 	fm10k_mbx_request_irq(interface);
 
-- 
2.6.1.264.gbab76a9

