From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun,  9 Jan 2022 18:14:40 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Remove useless DMA-32 fallback
 configuration
Message-ID: <5549ec8837b3a6fab83e92c5206cc100ffd23d85.1641748468.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

So, if dma_set_mask_and_coherent() succeeds, 'pci_using_dac' is known to be
1.

Simplify code and remove some dead code accordingly.

[1]: https://lkml.org/lkml/2021/6/7/398

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 635a95927e93..4f6ee5c44f75 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7385,9 +7385,9 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	resource_size_t flash_start, flash_len;
 	static int cards_found;
 	u16 aspm_disable_flag = 0;
-	int bars, i, err, pci_using_dac;
 	u16 eeprom_data = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
+	int bars, i, err;
 	s32 ret_val = 0;
 
 	if (ei->flags2 & FLAG2_DISABLE_ASPM_L0S)
@@ -7401,17 +7401,11 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	pci_using_dac = 0;
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (!err) {
-		pci_using_dac = 1;
-	} else {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev,
-				"No usable DMA configuration, aborting\n");
-			goto err_dma;
-		}
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting\n");
+		goto err_dma;
 	}
 
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
@@ -7547,10 +7541,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
-	if (pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->vlan_features |= NETIF_F_HIGHDMA;
 
 	/* MTU range: 68 - max_hw_frame_size */
 	netdev->min_mtu = ETH_MIN_MTU;
-- 
2.32.0

