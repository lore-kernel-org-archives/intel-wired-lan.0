From: Colin King <colin.king@canonical.com>
Date: Fri, 24 Aug 2018 17:52:32 +0100
Subject: [Intel-wired-lan] [PATCH] ixgb: replace dma_alloc_coherent + memset
 with dma_zalloc_coherent
Message-ID: <20180824165232.21585-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Use dma_zalloc_coherent rather than dam_alloc_coherent and memset.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgb/ixgb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgb/ixgb_main.c b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
index 43664adf7a3c..c71bc0237108 100644
--- a/drivers/net/ethernet/intel/ixgb/ixgb_main.c
+++ b/drivers/net/ethernet/intel/ixgb/ixgb_main.c
@@ -771,14 +771,12 @@ ixgb_setup_rx_resources(struct ixgb_adapter *adapter)
 	rxdr->size = rxdr->count * sizeof(struct ixgb_rx_desc);
 	rxdr->size = ALIGN(rxdr->size, 4096);
 
-	rxdr->desc = dma_alloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
-					GFP_KERNEL);
-
+	rxdr->desc = dma_zalloc_coherent(&pdev->dev, rxdr->size, &rxdr->dma,
+					 GFP_KERNEL);
 	if (!rxdr->desc) {
 		vfree(rxdr->buffer_info);
 		return -ENOMEM;
 	}
-	memset(rxdr->desc, 0, rxdr->size);
 
 	rxdr->next_to_clean = 0;
 	rxdr->next_to_use = 0;
-- 
2.17.1

