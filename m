From: Flavio Suligoi <f.suligoi@asem.it>
Date: Thu, 28 Feb 2019 14:38:55 +0100
Subject: [Intel-wired-lan] [PATCH v2] net: e1000e: add MAC address kernel
 cmd line parameter
In-Reply-To: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
References: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
Message-ID: <1551361135-404-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sometimes, in some embedded systems boards (i.e. ARM boards),
the NVM eeprom is not mounted, to save cost and space.

In this case it is necessary to bypass the NVM management
and directly force the MAC address using a kernel command-line
parameter (macaddr).

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

v2: - e1000_probe: remove wrong newline in the middle of the local variable list
v1: - written

---
 drivers/net/ethernet/intel/e1000e/netdev.c | 49 +++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 189f231..34ab560 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,6 +39,10 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+static unsigned char macaddr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+module_param_array(macaddr, byte, NULL, 0);
+MODULE_PARM_DESC(macaddr, "e1000e Ethernet MAC address");
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -7232,27 +7236,38 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	adapter->hw.mac.ops.reset_hw(&adapter->hw);
 
-	/* systems with ASPM and others may see the checksum fail on the first
-	 * attempt. Let's give it a few tries
-	 */
-	for (i = 0;; i++) {
-		if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
-			break;
-		if (i == 2) {
-			dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
-			err = -EIO;
-			goto err_eeprom;
+	/* If the MAC address is supplied by the bootloader, use it! */
+	if (!is_multicast_ether_addr(macaddr)) {
+		dev_info(&pdev->dev,
+			 "MAC address from kernel command line argument\n");
+		memcpy(adapter->hw.mac.addr, macaddr, netdev->addr_len);
+		memcpy(netdev->dev_addr,     macaddr, netdev->addr_len);
+	} else {
+		/* systems with ASPM and others may see the checksum fail on
+		 * the first attempt. Let's give it a few tries
+		 */
+		dev_info(&pdev->dev, "MAC address from NVM\n");
+		for (i = 0;; i++) {
+			if (e1000_validate_nvm_checksum(&adapter->hw) >= 0)
+				break;
+			if (i == 2) {
+				dev_err(&pdev->dev,
+					"The NVM Checksum Is Not Valid\n");
+				err = -EIO;
+				goto err_eeprom;
+			}
 		}
-	}
 
-	e1000_eeprom_checks(adapter);
+		e1000_eeprom_checks(adapter);
 
-	/* copy the MAC address */
-	if (e1000e_read_mac_addr(&adapter->hw))
-		dev_err(&pdev->dev,
-			"NVM Read Error while reading MAC address\n");
+		/* copy the MAC address */
+		if (e1000e_read_mac_addr(&adapter->hw))
+			dev_err(&pdev->dev,
+				"NVM Read Error while reading MAC address\n");
 
-	memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
+		memcpy(netdev->dev_addr, adapter->hw.mac.addr,
+		       netdev->addr_len);
+	}
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
 		dev_err(&pdev->dev, "Invalid MAC Address: %pM\n",
-- 
2.7.4

