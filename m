From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  4 Feb 2016 10:47:58 -0800
Subject: [Intel-wired-lan] [PATCH 5/6] fm10k: free mbx irq before clearing
	interrupt scheme
In-Reply-To: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1454611679-17424-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During fm10k_io_error_detected we were clearing the interrupt scheme
before we freed the mbx IRQ. This causes a kernel panic because the mbx
IRQ are assigned after MSI-X initialization. Clearing the interrupt
scheme results in removing the MSI-X entry table. Fix this by freeing
the mbx IRQ before we clear the interrupt scheme, as we do elsewhere in
the driver.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 3c7c819ac8d9..da38af052519 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2274,11 +2274,11 @@ static pci_ers_result_t fm10k_io_error_detected(struct pci_dev *pdev,
 	if (netif_running(netdev))
 		fm10k_close(netdev);
 
+	fm10k_mbx_free_irq(interface);
+
 	/* free interrupts */
 	fm10k_clear_queueing_scheme(interface);
 
-	fm10k_mbx_free_irq(interface);
-
 	pci_disable_device(pdev);
 
 	/* Request a slot reset. */
-- 
2.7.0.236.gda096a0.dirty

