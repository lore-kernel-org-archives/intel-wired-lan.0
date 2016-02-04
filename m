From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  4 Feb 2016 10:47:59 -0800
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: prevent RCU issues during AER
	events
In-Reply-To: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
References: <1454611679-17424-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1454611679-17424-6-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During an AER action response, we were calling fm10k_close without
holding the rtnl_lock() which could lead to possible RCU warnings being
produced due to 64bit stat updates among other causes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index da38af052519..a10b98025c69 100644
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
-- 
2.7.0.236.gda096a0.dirty

