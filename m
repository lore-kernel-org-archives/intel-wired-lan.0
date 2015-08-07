From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Fri, 07 Aug 2015 13:56:17 -0700
Subject: [Intel-wired-lan] [PATCH] igb: wrap igb_disable_sriov call
Message-ID: <20150807205617.20677.81726.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wrap igb_disable_sriov with #ifdef CONFIG_SRIOV

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4b491d..1362f7b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2649,7 +2649,9 @@ err_eeprom:
 err_sw_init:
 	kfree(adapter->shadow_vfta);
 	igb_clear_interrupt_scheme(adapter);
+#ifdef CONFIG_PCI_IOV
 	igb_disable_sriov(pdev);
+#endif
 	pci_iounmap(pdev, hw->hw_addr);
 err_ioremap:
 	free_netdev(netdev);

