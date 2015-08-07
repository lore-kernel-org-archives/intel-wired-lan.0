From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 7 Aug 2015 23:39:58 +0000
Subject: [Intel-wired-lan] [PATCH] igb: wrap igb_disable_sriov call
In-Reply-To: <20150807205617.20677.81726.stgit@htfujina-fc.jf.intel.com>
References: <20150807205617.20677.81726.stgit@htfujina-fc.jf.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD6535C5DF4@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey Jeff, I screwed this up. I'm going to edit " [Intel-wired-lan] [PATCH] igb: wrap igb_disable_sriov call" so can you delete this and wait for a v2 of the other one?

Sorry for the mess.

Thanks.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Todd Fujinaka
Sent: Friday, August 07, 2015 1:56 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] igb: wrap igb_disable_sriov call

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

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
