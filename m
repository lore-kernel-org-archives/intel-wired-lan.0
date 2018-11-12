From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 12 Nov 2018 11:05:20 +0200
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Remove obsolete IGC_ERR define
Message-ID: <20181112090520.31496-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Address community comment.
Remove obsolete IGC_ERR define and use dev_err method.
Suggested by Joe Perches.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3b00b109b34a..b1039dd3dd13 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -11,8 +11,6 @@
 #include <linux/ethtool.h>
 #include <linux/sctp.h>
 
-#define IGC_ERR(args...) pr_err("igc: " args)
-
 #include "igc_hw.h"
 
 /* main */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb11e8dbf0b2..4024eb1d700f 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3536,7 +3536,7 @@ static int igc_probe(struct pci_dev *pdev,
 			err = dma_set_coherent_mask(&pdev->dev,
 						    DMA_BIT_MASK(32));
 			if (err) {
-				IGC_ERR("Wrong DMA configuration, aborting\n");
+				dev_err(&pdev->dev, "igc: Wrong DMA config\n");
 				goto err_dma;
 			}
 		}
-- 
2.11.0

