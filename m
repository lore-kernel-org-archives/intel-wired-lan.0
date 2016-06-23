From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 23 Jun 2016 13:31:00 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: print error code when
	pci_enable_device_mem fails during probe
Message-ID: <20160623203103.30528-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 5f4f27337003..552268292ac8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1951,8 +1951,11 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int err;
 
 	err = pci_enable_device_mem(pdev);
-	if (err)
+	if (err) {
+		dev_err(&pdev->dev,
+			"PCI enable device failed: %d\n", err);
 		return err;
+	}
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
 	if (err)
-- 
2.9.0.rc1.405.g81f467e

