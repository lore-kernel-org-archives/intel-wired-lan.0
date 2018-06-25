From: Marcel Ziswiler <marcel@ziswiler.com>
Date: Mon, 25 Jun 2018 10:00:42 +0200
Subject: [Intel-wired-lan] [PATCH] igb: allow optionally getting mac address
 from device tree
Message-ID: <20180625080042.32286-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

For Embedded use where e.g. i210/i211 chips may be used without
external EEPROMs but regardless of whether or not the MAC address is
actually programmed into the iNVM the boot loader may choose to pass
the MAC address to be used via device tree. Therefore, allow for
optionally getting the MAC address from device tree data e.g. as
follows (excerpt from a TK1 based board, local-mac-address to be
filled in by boot loader):

pcie at 1003000 {
	...

	/* I210 Gigabit Ethernet Controller */
	pci at 2,0 {
		...
		status = "okay";
		pcie at 0 {
			reg = <0 0 0 0 0>;
			local-mac-address = [00 00 00 00 00 00];
		};
	};
};

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/net/ethernet/intel/igb/igb_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f707709969ac..0abf3698b05c 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -37,6 +37,7 @@
 #include <linux/dca.h>
 #endif
 #include <linux/i2c.h>
+#include <linux/of_net.h>
 #include "igb.h"
 
 #define MAJ 5
@@ -2931,6 +2932,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct e1000_info *ei = igb_info_tbl[ent->driver_data];
 	int err, pci_using_dac;
 	u8 part_str[E1000_PBANUM_LENGTH];
+	const void *iap;
 
 	/* Catch broken hardware that put the wrong VF device ID in
 	 * the PCIe SR-IOV capability.
@@ -3122,7 +3124,11 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		break;
 	}
 
-	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
+	/* try to get the MAC address from device tree data */
+	iap = of_get_mac_address(pdev->dev.of_node);
+	if (iap)
+		memcpy(hw->mac.addr, iap, ETH_ALEN);
+	else if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
 		/* copy the MAC address out of the NVM */
 		if (hw->mac.ops.read_mac_addr(hw))
 			dev_err(&pdev->dev, "NVM Read Error\n");
-- 
2.14.4

