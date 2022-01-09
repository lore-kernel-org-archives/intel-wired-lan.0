From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun,  9 Jan 2022 18:19:22 +0100
Subject: [Intel-wired-lan] [PATCH] ixgb: Remove useless DMA-32 fallback
 configuration
Message-ID: <a56f72c090866c11a0c091e561dbfc69d826cd0e.1641748751.git.christophe.jaillet@wanadoo.fr>
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
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 99d481904ce6..affdefcca7e3 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -361,7 +361,6 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct net_device *netdev = NULL;
 	struct ixgb_adapter *adapter;
 	static int cards_found = 0;
-	int pci_using_dac;
 	u8 addr[ETH_ALEN];
 	int i;
 	int err;
@@ -370,16 +369,10 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		return err;
 
-	pci_using_dac = 0;
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (!err) {
-		pci_using_dac = 1;
-	} else {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			pr_err("No usable DMA configuration, aborting\n");
-			goto err_dma_mask;
-		}
+	if (err) {
+		pr_err("No usable DMA configuration, aborting\n");
+		goto err_dma_mask;
 	}
 
 	err = pci_request_regions(pdev, ixgb_driver_name);
@@ -444,10 +437,8 @@ ixgb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features |= NETIF_F_RXCSUM;
 
-	if (pci_using_dac) {
-		netdev->features |= NETIF_F_HIGHDMA;
-		netdev->vlan_features |= NETIF_F_HIGHDMA;
-	}
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->vlan_features |= NETIF_F_HIGHDMA;
 
 	/* MTU range: 68 - 16114 */
 	netdev->min_mtu = ETH_MIN_MTU;
-- 
2.32.0

