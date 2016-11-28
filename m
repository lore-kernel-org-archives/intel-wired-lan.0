From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 28 Nov 2016 18:32:45 +0530
Subject: [Intel-wired-lan] [PATCH] ethernet: intel: Replace pci_pool_alloc
	by pci_pool_zalloc
Message-ID: <20161128130244.GA32585@gnr743-HP-ZBook-15>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In e100_alloc_cbs(), pci_pool_alloc() followed by memset will be
replaced by pci_pool_zalloc()

Signed-off-by: Souptick joarder <jrdr.linux@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 068789e..ba6b2de 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1910,11 +1910,10 @@ static int e100_alloc_cbs(struct nic *nic)
 	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
 	nic->cbs_avail = 0;
 
-	nic->cbs = pci_pool_alloc(nic->cbs_pool, GFP_KERNEL,
+	nic->cbs = pci_pool_zalloc(nic->cbs_pool, GFP_KERNEL,
 				  &nic->cbs_dma_addr);
 	if (!nic->cbs)
 		return -ENOMEM;
-	memset(nic->cbs, 0, count * sizeof(struct cb));
 
 	for (cb = nic->cbs, i = 0; i < count; cb++, i++) {
 		cb->next = (i + 1 < count) ? cb + 1 : nic->cbs;
-- 
1.9.1

