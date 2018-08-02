From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:26 -0700
Subject: [Intel-wired-lan] [next PATCH S94 03/13] i40e: Don't read MAC
 address in recovery mode
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch removes reading MAC address via AQC
"Manage MAC address read command" in recovery mode
since it's not supported.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c9b1d0c..0a1ecdf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13591,21 +13591,6 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 		goto err_sw_init;
 	}
 
-	/* allow a platform config to override the HW addr */
-	i40e_get_platform_mac_addr(pf->pdev, pf);
-
-	if (!is_valid_ether_addr(hw->mac.addr)) {
-		/* normally we would return -EIO here */
-		dev_info(&pf->pdev->dev, "invalid MAC address %pM\n",
-			 hw->mac.addr);
-	} else {
-		dev_info(&pf->pdev->dev, "MAC address: %pM\n", hw->mac.addr);
-	}
-	ether_addr_copy(hw->mac.perm_addr, hw->mac.addr);
-	i40e_get_port_mac_addr(hw, hw->mac.port_addr);
-	if (is_valid_ether_addr(hw->mac.port_addr))
-		pf->hw_features |= I40E_HW_PORT_ID_VALID;
-
 	pci_save_state(pf->pdev);
 
 	/* set up periodic task facility */
-- 
2.9.5

