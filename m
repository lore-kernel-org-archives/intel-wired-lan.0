From: lixue liang <lianglixue@greatwall.com.cn>
Date: Wed, 11 May 2022 08:07:16 +0000
Subject: [Intel-wired-lan] =?utf-8?b?W1BBVENIXSBpZ2JfbWFpbu+8mkFkZGVkIGlu?=
 =?utf-8?q?valid_mac_address_handling_in_igb=5Fprobe?=
Message-ID: <20220511080716.10054-1-lianglixue@greatwall.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In some cases, when the user uses igb_set_eeprom to modify
the mac address to be invalid, the igb driver will fail to load.
If there is no network card device, the user must modify it to
a valid mac address by other means. It is only the invalid
mac address that causes the driver The fatal problem of
loading failure will cause most users no choice but to trouble.

Since the mac address may be changed to be invalid, it must
also be changed to a valid mac address, then add a random
valid mac address to replace the invalid mac address in the
driver, continue to load the igb network card driver,
and output the relevant log reminder. vital to the user.

Signed-off-by: lixue liang <lianglixue@greatwall.com.cn>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 34b33b21e0dc..a513570c2ad6 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3359,9 +3359,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	eth_hw_addr_set(netdev, hw->mac.addr);
 
 	if (!is_valid_ether_addr(netdev->dev_addr)) {
-		dev_err(&pdev->dev, "Invalid MAC Address\n");
-		err = -EIO;
-		goto err_eeprom;
+		eth_random_addr(netdev->dev_addr);
+		memcpy(hw->mac.addr, netdev->dev_addr, netdev->addr_len);
+		dev_info(&pdev->dev,
+			 "Invalid Mac Address, already got random Mac Address\n");
 	}
 
 	igb_set_default_mac_filter(adapter);
-- 
2.27.0

