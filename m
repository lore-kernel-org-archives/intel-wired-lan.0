From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Mar 2016 09:52:32 -0800
Subject: [Intel-wired-lan] [PATCH v2] fm10k: prevent RCU issues during AER
	events
In-Reply-To: <1457718752-8678-1-git-send-email-jacob.e.keller@intel.com>
References: <1457718752-8678-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1457718752-8678-2-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During an AER action response, we were calling fm10k_close without
holding the rtnl_lock() which could lead to possible RCU warnings being
produced due to 64bit stat updates among other causes. Similarly, we
need rtnl_lock() around fm10k_open during fm10k_io_resume. Follow the
same pattern elsewhere in the driver and protect the entire open/close
sequence.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Notes:
    - v2
    * add rtnl_lock() calls during fm10k_io_resume as well

 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index da38af052519..7dc8292546e1 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2271,6 +2271,8 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	rtnl_lock();
+
 	if (netif_running(netdev))
 		fm10k_close(netdev);
 
@@ -2279,6 +2281,8 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
 	/* free interrupts */
 	fm10k_clear_queueing_scheme(interface);
 
+	rtnl_unlock();
+
 	pci_disable_device(pdev);
 
 	/* Request a slot reset. */
@@ -2349,11 +2353,13 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 	/* reset statistics starting values */
 	hw->mac.ops.rebind_hw_stats(hw, &interface->stats);
 
+	rtnl_lock();
+
 	err = fm10k_init_queueing_scheme(interface);
 	if (err) {
 		dev_err(&interface->pdev->dev,
 			"init_queueing_scheme failed: %d\n", err);
-		return;
+		goto unlock;
 	}
 
 	/* reassociate interrupts */
@@ -2370,6 +2376,9 @@ static void fm10k_io_resume(struct pci_dev *pdev)
 
 	if (!err)
 		netif_device_attach(netdev);
+
+unlock:
+	rtnl_unlock();
 }
 
 static const struct pci_error_handlers fm10k_err_handler = {
-- 
2.8.0.rc1.177.g5628860

