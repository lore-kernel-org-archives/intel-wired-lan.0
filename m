From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:31:06 -0700
Subject: [Intel-wired-lan] [rc2 09/15] fm10k: use dma_set_mask_and_coherent
	in fm10k_probe
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-10-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch cleans up the use of dma_get_required_mask and uses the
simpler dma_set_mask_and_coherent function instead of doing these as
separate steps.

I removed the dma_get_required_mask call because based on some minimal
testing it appears that either (a) we're not doing the right thing with
the call or (b) we don't need it anyways. If the value returned is
<48bits, we'll end up trying with 48 bits anyways. If it's over 48bits,
fm10k can't support that anyways, and we should try 48bits. If 48bits
fails, we'll fallback to 32bits. This cleans up some very funky code.

-rc2
* add back goto err_dma

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 5269b1628ca6..0381c8d192aa 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1741,30 +1741,18 @@ static int fm10k_probe(struct pci_dev *pdev,
 	struct fm10k_intfc *interface;
 	struct fm10k_hw *hw;
 	int err;
-	u64 dma_mask;
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return err;
 
-	/* By default fm10k only supports a 48 bit DMA mask */
-	dma_mask = DMA_BIT_MASK(48) | dma_get_required_mask(&pdev->dev);
-
-	if ((dma_mask <= DMA_BIT_MASK(32)) ||
-	    dma_set_mask_and_coherent(&pdev->dev, dma_mask)) {
-		dma_mask &= DMA_BIT_MASK(32);
-
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
+	if (err)
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			err = dma_set_coherent_mask(&pdev->dev,
-						    DMA_BIT_MASK(32));
-			if (err) {
-				dev_err(&pdev->dev,
-					"No usable DMA configuration, aborting\n");
-				goto err_dma;
-			}
-		}
+	if (err) {
+		dev_err(&pdev->dev,
+			"DMA configuration failed: 0x%x\n", err);
+		goto err_dma;
 	}
 
 	err = pci_request_selected_regions(pdev,
-- 
2.1.0

