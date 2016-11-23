From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 23 Nov 2016 11:24:08 -0800
Subject: [Intel-wired-lan] [PATCH v3] ixgbevf: restore hw_addr on resume or
	error
Message-ID: <20161123192408.12895.85255.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Restore adapter->hw.hw_addr after handling an error, or a resume
operation to make sure we can access the registers.

v2 - restore hw_addr only if pci_enable_device_mem() succeeds
in ixgbevf_io_slot_reset()

v3 - restore hw_addr after pci_enable_device_mem() in ixgbevf_resume()

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 88c5352..5531347 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3851,6 +3851,8 @@ static int ixgbevf_resume(struct pci_dev *pdev)
 		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
 		return err;
 	}
+
+	adapter->hw.hw_addr = adapter->io_addr;
 	smp_mb__before_atomic();
 	clear_bit(__IXGBEVF_DISABLED, &adapter->state);
 	pci_set_master(pdev);
@@ -4289,6 +4291,7 @@ static pci_ers_result_t ixgbevf_io_slot_reset(struct pci_dev *pdev)
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
+	adapter->hw.hw_addr = adapter->io_addr;
 	smp_mb__before_atomic();
 	clear_bit(__IXGBEVF_DISABLED, &adapter->state);
 	pci_set_master(pdev);

