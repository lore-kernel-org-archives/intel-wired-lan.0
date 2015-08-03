From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Mon,  3 Aug 2015 10:40:48 +0800
Subject: [Intel-wired-lan] [PATCH] e100: Release skb when DMA mapping is
	failed in e100_xmit_prepare
Message-ID: <1438569648-20469-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When pci_dma_mapping_error in e100_xmit_prepare is failed, the skb buffer
allocated by netdev_alloc_skb_ip_align in e100_rx_alloc_skb is not
released, which causes a possible resource leak.
This patch adds error handling code to fix it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/net/ethernet/intel/e100.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index d2657a4..cc90616 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1770,8 +1770,11 @@ static int e100_xmit_prepare(struct nic *nic, struct cb *cb,
 	dma_addr = pci_map_single(nic->pdev,
 				  skb->data, skb->len, PCI_DMA_TODEVICE);
 	/* If we can't map the skb, have the upper layer try later */
-	if (pci_dma_mapping_error(nic->pdev, dma_addr))
+	if (pci_dma_mapping_error(nic->pdev, dma_addr)) {
+		dev_kfree_skb_any(skb);
+		skb = NULL;
 		return -ENOMEM;
+	}
 
 	/*
 	 * Use the last 4 bytes of the SKB payload packet as the CRC, used for
-- 
1.7.9.5


