From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:50:01 -0700
Subject: [Intel-wired-lan] [PATCH v1] e1000e: fix misuse of ret_val variable
	and error handling
Message-ID: <1460584201-30699-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A patch introduced the use of ret_val variable but only assigned it once
and didn't use it. e1000_probe already has a rval variable, which is
what was checked, so remove use of ret_val in favor of rval.

Fixes: 7739e79c2ff7 ("e1000e: Fix ptp time reset on network interruption", 2016-04-12)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 74fe486ada67..9c4673930e8d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6956,7 +6956,6 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
 	s32 rval = 0;
 	u32 regval;
-	s32 ret_val;
 
 	if (ei->flags2 & FLAG2_DISABLE_ASPM_L0S)
 		aspm_disable_flag = PCIE_LINK_STATE_L0S;
@@ -7248,7 +7247,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netif_carrier_off(netdev);
 
 	/* Get and set the System Time Register SYSTIM base frequency */
-	ret_val = e1000e_get_base_timinca(adapter, &regval);
+	rval = e1000e_get_base_timinca(adapter, &regval);
 	if (rval)
 		goto err_register;
 	ew32(TIMINCA, regval);
-- 
2.8.1.102.ga49ec4a

