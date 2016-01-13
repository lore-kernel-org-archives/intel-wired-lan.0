From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 12 Jan 2016 19:32:30 -0800
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: use
	eth_platform_get_mac_address()
In-Reply-To: <cover.1452655483.git.sowmini.varadhan@oracle.com>
References: <cover.1452655483.git.sowmini.varadhan@oracle.com>
Message-ID: <1328c02108145ebd083cc6f1480dc90147f068f0.1452655483.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This commit converts commit c762dff24c06 ("ixgbe: Look up MAC address in
Open Firmware or IDPROM") to use eth_platform_get_mac_address()
added by commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
helper.")

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   35 +-----------------------
 1 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c4003a8..fedaa50 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -52,15 +52,6 @@
 #include <scsi/fc/fc_fcoe.h>
 #include <net/vxlan.h>
 
-#ifdef CONFIG_OF
-#include <linux/of_net.h>
-#endif
-
-#ifdef CONFIG_SPARC
-#include <asm/idprom.h>
-#include <asm/prom.h>
-#endif
-
 #include "ixgbe.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb_82599.h"
@@ -8801,29 +8792,6 @@ int ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 }
 
 /**
- * ixgbe_get_platform_mac_addr - Look up MAC address in Open Firmware / IDPROM
- * @adapter: Pointer to adapter struct
- */
-static void ixgbe_get_platform_mac_addr(struct ixgbe_adapter *adapter)
-{
-#ifdef CONFIG_OF
-	struct device_node *dp = pci_device_to_OF_node(adapter->pdev);
-	struct ixgbe_hw *hw = &adapter->hw;
-	const unsigned char *addr;
-
-	addr = of_get_mac_address(dp);
-	if (addr) {
-		ether_addr_copy(hw->mac.perm_addr, addr);
-		return;
-	}
-#endif /* CONFIG_OF */
-
-#ifdef CONFIG_SPARC
-	ether_addr_copy(hw->mac.perm_addr, idprom->id_ethaddr);
-#endif /* CONFIG_SPARC */
-}
-
-/**
  * ixgbe_probe - Device Initialization Routine
  * @pdev: PCI device information struct
  * @ent: entry in ixgbe_pci_tbl
@@ -9104,7 +9072,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_sw_init;
 	}
 
-	ixgbe_get_platform_mac_addr(adapter);
+	eth_platform_get_mac_address(&adapter->pdev->dev,
+				     adapter->hw.mac.perm_addr);
 
 	memcpy(netdev->dev_addr, hw->mac.perm_addr, netdev->addr_len);
 
-- 
1.7.1

