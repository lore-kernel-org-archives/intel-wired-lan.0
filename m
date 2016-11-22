From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 22 Nov 2016 15:30:59 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: restore hw_addr on resume or
	error
Message-ID: <20161122233059.31775.78519.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Restore adapter->hw.hw_addr after handling an error, or a resume
operation to make sure we can access the registers.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 88c5352..d94ab8c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3840,6 +3840,7 @@ static int ixgbevf_resume(struct pci_dev *pdev)
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 	u32 err;
 
+	adapter->hw.hw_addr = adapter->io_addr;
 	pci_restore_state(pdev);
 	/* pci_restore_state clears dev->state_saved so call
 	 * pci_save_state to restore it.
@@ -4283,6 +4284,7 @@ static pci_ers_result_t ixgbevf_io_slot_reset(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct ixgbevf_adapter *adapter = netdev_priv(netdev);
 
+	adapter->hw.hw_addr = adapter->io_addr;
 	if (pci_enable_device_mem(pdev)) {
 		dev_err(&pdev->dev,
 			"Cannot re-enable PCI device after reset.\n");

