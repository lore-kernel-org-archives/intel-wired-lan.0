From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Fri, 07 Aug 2015 17:27:39 -0700
Subject: [Intel-wired-lan] [PATCH V2] igb: make sure SR-IOV init uses the
 right number of queues
Message-ID: <20150808002714.23033.34530.stgit@htfujina-fc.jf.intel.com>
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
 drivers/net/ethernet/intel/igb/igb_main.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 338d146..1362f7b 100644
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
@@ -2647,6 +2649,9 @@ err_eeprom:
 err_sw_init:
 	kfree(adapter->shadow_vfta);
 	igb_clear_interrupt_scheme(adapter);
+#ifdef CONFIG_PCI_IOV
+	igb_disable_sriov(pdev);
+#endif
 	pci_iounmap(pdev, hw->hw_addr);
 err_ioremap:
 	free_netdev(netdev);
@@ -2969,6 +2974,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	}
 #endif /* CONFIG_PCI_IOV */
 
+	igb_probe_vfs(adapter);
+
 	igb_init_queue_configuration(adapter);
 
 	/* Setup and initialize a copy of the hw vlan table array */
@@ -2981,8 +2988,6 @@ static int igb_sw_init(struct igb_adapter *adapter)
 		return -ENOMEM;
 	}
 
-	igb_probe_vfs(adapter);
-
 	/* Explicitly disable IRQ since the NIC can be in any state. */
 	igb_irq_disable(adapter);
 

