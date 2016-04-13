From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:24 -0700
Subject: [Intel-wired-lan] [PATCH v1 13/13] e1000e: remove unused variable
In-Reply-To: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460583084-16900-14-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 74fe486ada67..99288751afcf 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6956,7 +6956,6 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
 	s32 rval = 0;
 	u32 regval;
-	s32 ret_val;
 
 	if (ei->flags2 & FLAG2_DISABLE_ASPM_L0S)
 		aspm_disable_flag = PCIE_LINK_STATE_L0S;
-- 
2.8.1.102.ga49ec4a

