From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Fri, 2 Dec 2016 00:34:27 +0530
Subject: [Intel-wired-lan] [PATCH v2] ethernet: intel: Replace
	pci_pool_alloc by pci_pool_zalloc
Message-ID: <20161201190427.GA3357@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In e100_alloc_cbs(), pci_pool_alloc() followed by memset will be
replaced by pci_pool_zalloc()

Signed-off-by: Souptick joarder <jrdr.linux@gmail.com>
---
v2:
  - Alignment changes

 drivers/net/ethernet/intel/e100.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 068789e..0cf338f 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1910,11 +1910,10 @@ static int e100_alloc_cbs(struct nic *nic)
 	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
 	nic->cbs_avail = 0;

-	nic->cbs = pci_pool_alloc(nic->cbs_pool, GFP_KERNEL,
-				  &nic->cbs_dma_addr);
+	nic->cbs = pci_pool_zalloc(nic->cbs_pool, GFP_KERNEL,
+				   &nic->cbs_dma_addr);
 	if (!nic->cbs)
 		return -ENOMEM;
-	memset(nic->cbs, 0, count * sizeof(struct cb));

 	for (cb = nic->cbs, i = 0; i < count; cb++, i++) {
 		cb->next = (i + 1 < count) ? cb + 1 : nic->cbs;
--
1.9.1

