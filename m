From: Brian Walsh <brian@walsh.ws>
Date: Tue, 12 Apr 2016 23:22:30 -0400
Subject: [Intel-wired-lan] [PATCH v2 1/2] e1000e: Cleanup consistency in
	ret_val variable usage
In-Reply-To: <1455662685-7231-1-git-send-email-brian@walsh.ws>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
Message-ID: <a17942d94a295a0db7ef205060b97313289b1640.1460517387.git.brian@walsh.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixed the file to use a consistent ret_val for return value checking.

Signed-off-by: Brian Walsh <brian@walsh.ws>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9b4ec13..370b0dc 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3368,12 +3368,12 @@ static int e1000e_write_uc_addr_list(struct net_device *netdev)
 		 * combining
 		 */
 		netdev_for_each_uc_addr(ha, netdev) {
-			int rval;
+			int ret_val;
 
 			if (!rar_entries)
 				break;
-			rval = hw->mac.ops.rar_set(hw, ha->addr, rar_entries--);
-			if (rval < 0)
+			ret_val = hw->mac.ops.rar_set(hw, ha->addr, rar_entries--);
+			if (ret_val < 0)
 				return -ENOMEM;
 			count++;
 		}
@@ -6965,7 +6965,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int bars, i, err, pci_using_dac;
 	u16 eeprom_data = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
-	s32 rval = 0;
+	s32 ret_val = 0;
 
 	if (ei->flags2 & FLAG2_DISABLE_ASPM_L0S)
 		aspm_disable_flag = PCIE_LINK_STATE_L0S;
@@ -7200,18 +7200,18 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	} else if (adapter->flags & FLAG_APME_IN_CTRL3) {
 		if (adapter->flags & FLAG_APME_CHECK_PORT_B &&
 		    (adapter->hw.bus.func == 1))
-			rval = e1000_read_nvm(&adapter->hw,
+			ret_val = e1000_read_nvm(&adapter->hw,
 					      NVM_INIT_CONTROL3_PORT_B,
 					      1, &eeprom_data);
 		else
-			rval = e1000_read_nvm(&adapter->hw,
+			ret_val = e1000_read_nvm(&adapter->hw,
 					      NVM_INIT_CONTROL3_PORT_A,
 					      1, &eeprom_data);
 	}
 
 	/* fetch WoL from EEPROM */
-	if (rval)
-		e_dbg("NVM read error getting WoL initial values: %d\n", rval);
+	if (ret_val)
+		e_dbg("NVM read error getting WoL initial values: %d\n", ret_val);
 	else if (eeprom_data & eeprom_apme_mask)
 		adapter->eeprom_wol |= E1000_WUFC_MAG;
 
@@ -7231,10 +7231,10 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		device_wakeup_enable(&pdev->dev);
 
 	/* save off EEPROM version number */
-	rval = e1000_read_nvm(&adapter->hw, 5, 1, &adapter->eeprom_vers);
+	ret_val = e1000_read_nvm(&adapter->hw, 5, 1, &adapter->eeprom_vers);
 
-	if (rval) {
-		e_dbg("NVM read error getting EEPROM version: %d\n", rval);
+	if (ret_val) {
+		e_dbg("NVM read error getting EEPROM version: %d\n", ret_val);
 		adapter->eeprom_vers = 0;
 	}
 
-- 
2.1.4

