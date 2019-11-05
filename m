From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  5 Nov 2019 11:44:13 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Improve the DMA mapping flow
Message-ID: <20191105094413.1405-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Improve the probe flow and set both the DMA mask and the coherent
to the same thing. Make the flow optimized and cleared.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c3266645c95e..648aee679cb6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4346,32 +4346,26 @@ static int igc_probe(struct pci_dev *pdev,
 	struct net_device *netdev;
 	struct igc_hw *hw;
 	const struct igc_info *ei = igc_info_tbl[ent->driver_data];
-	int err;
+	int err, pci_using_dac;
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return err;
 
-	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	pci_using_dac = 0;
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (!err) {
-		err = dma_set_coherent_mask(&pdev->dev,
-					    DMA_BIT_MASK(64));
+		pci_using_dac = 1;
 	} else {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 		if (err) {
-			err = dma_set_coherent_mask(&pdev->dev,
-						    DMA_BIT_MASK(32));
-			if (err) {
-				dev_err(&pdev->dev, "igc: Wrong DMA config\n");
-				goto err_dma;
-			}
+			dev_err(&pdev->dev,
+				"No usable DMA configuration, aborting\n");
+			goto err_dma;
 		}
 	}
 
-	err = pci_request_selected_regions(pdev,
-					   pci_select_bars(pdev,
-							   IORESOURCE_MEM),
-					   igc_driver_name);
+	err = pci_request_mem_regions(pdev, igc_driver_name);
 	if (err)
 		goto err_pci_reg;
 
-- 
2.11.0

