From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 28 Oct 2016 10:46:39 -0700
Subject: [Intel-wired-lan] [PATCH V2] ixgbevf: Handle previously-freed
	msix_entries
Message-ID: <147767679915.21196.12625601185481181813.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The msix_entries memory can be freed by a previous suspend or
remove, so don't crash on close when it isn't there. Also only
clear the interrupts when the interface is up, because there
aren't any when it is not up.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Change in V2:
- Only clear interrupt scheme when interface is up
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d2775f032f74..d316f503a727 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1498,6 +1498,9 @@ static void ixgbevf_free_irq(struct ixgbevf_adapter *adapter)
 {
 	int i, q_vectors;
 
+	if (!adapter->msix_entries)
+		return;
+
 	q_vectors = adapter->num_msix_vectors;
 	i = q_vectors - 1;
 
@@ -2552,6 +2555,9 @@ static void ixgbevf_free_q_vectors(struct ixgbevf_adapter *adapter)
  **/
 static void ixgbevf_reset_interrupt_capability(struct ixgbevf_adapter *adapter)
 {
+	if (!adapter->msix_entries)
+		return;
+
 	pci_disable_msix(adapter->pdev);
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
@@ -3794,11 +3800,10 @@ static int ixgbevf_suspend(struct pci_dev *pdev, pm_message_t state)
 		ixgbevf_free_irq(adapter);
 		ixgbevf_free_all_tx_resources(adapter);
 		ixgbevf_free_all_rx_resources(adapter);
+		ixgbevf_clear_interrupt_scheme(adapter);
 		rtnl_unlock();
 	}
 
-	ixgbevf_clear_interrupt_scheme(adapter);
-
 #ifdef CONFIG_PM
 	retval = pci_save_state(pdev);
 	if (retval)

