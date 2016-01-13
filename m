From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 12 Jan 2016 19:32:31 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: use
	eth_platform_get_mac_address()
In-Reply-To: <cover.1452655483.git.sowmini.varadhan@oracle.com>
References: <cover.1452655483.git.sowmini.varadhan@oracle.com>
Message-ID: <2da591718f08ebe8285b6bf9376893ec73ac98bb.1452655484.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This commit converts commit b499ffb0a22c ("i40e: Look up MAC address in
Open Firmware or IDPROM") to use eth_platform_get_mac_address()
added by commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
helper.")

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bb4612c..65220aa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -28,11 +28,6 @@
 #include <linux/of_net.h>
 #include <linux/pci.h>
 
-#ifdef CONFIG_SPARC
-#include <asm/idprom.h>
-#include <asm/prom.h>
-#endif
-
 /* Local includes */
 #include "i40e.h"
 #include "i40e_diag.h"
@@ -10543,21 +10538,9 @@ static void i40e_print_features(struct i40e_pf *pf)
  **/
 static void i40e_get_platform_mac_addr(struct pci_dev *pdev, struct i40e_pf *pf)
 {
-	struct device_node *dp = pci_device_to_OF_node(pdev);
-	const unsigned char *addr;
-	u8 *mac_addr = pf->hw.mac.addr;
-
 	pf->flags &= ~I40E_FLAG_PF_MAC;
-	addr = of_get_mac_address(dp);
-	if (addr) {
-		ether_addr_copy(mac_addr, addr);
+	if (!eth_platform_get_mac_address(&pdev->dev, pf->hw.mac.addr))
 		pf->flags |= I40E_FLAG_PF_MAC;
-#ifdef CONFIG_SPARC
-	} else {
-		ether_addr_copy(mac_addr, idprom->id_ethaddr);
-		pf->flags |= I40E_FLAG_PF_MAC;
-#endif /* CONFIG_SPARC */
-	}
 }
 
 /**
-- 
1.7.1

