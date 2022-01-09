From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun,  9 Jan 2022 18:29:51 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
 configuration
Message-ID: <869bbf806431086683c64ad32594ff96e85b6aa2.1641749374.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2a3d8aef7f4e..0f11d3f5c98a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15324,12 +15324,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* set up for high or low dma */
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev,
-				"DMA configuration failed: 0x%x\n", err);
-			goto err_dma;
-		}
+		dev_err(&pdev->dev,
+			"DMA configuration failed: 0x%x\n", err);
+		goto err_dma;
 	}
 
 	/* set up pci connections */
-- 
2.32.0

