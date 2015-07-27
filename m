From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Mon, 27 Jul 2015 14:34:22 -0700
Subject: [Intel-wired-lan] [PATCH] igb: make sure SR-IOV init uses the right
	number of queues
Message-ID: <20150727213422.28219.59391.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recent changes to igb_probe_vfs() could lead to the PF holding onto all
of the queues. Reorder igb_probe_vfs() to be before
gb_init_queue_configuration() and add some more error checking.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 517746f..18c16ca 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -179,6 +179,8 @@ static void igb_check_vf_rate_limit(struct igb_adapter *);
 #ifdef CONFIG_PCI_IOV
 static int igb_vf_configure(struct igb_adapter *adapter, int vf);
 static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs);
+static int igb_disable_sriov(struct pci_dev *dev);
+static int igb_pci_disable_sriov(struct pci_dev *dev);
 #endif
 
 #ifdef CONFIG_PM
@@ -2646,6 +2648,7 @@ err_eeprom:
 		iounmap(hw->flash_address);
 err_sw_init:
 	igb_clear_interrupt_scheme(adapter);
+	igb_disable_sriov(pdev);
 	pci_iounmap(pdev, hw->hw_addr);
 err_ioremap:
 	free_netdev(netdev);
@@ -2968,6 +2971,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	}
 #endif /* CONFIG_PCI_IOV */
 
+	igb_probe_vfs(adapter);
+
 	igb_init_queue_configuration(adapter);
 
 	/* Setup and initialize a copy of the hw vlan table array */
@@ -2980,8 +2985,6 @@ static int igb_sw_init(struct igb_adapter *adapter)
 		return -ENOMEM;
 	}
 
-	igb_probe_vfs(adapter);
-
 	/* Explicitly disable IRQ since the NIC can be in any state. */
 	igb_irq_disable(adapter);
 

