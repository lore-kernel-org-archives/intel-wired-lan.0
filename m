From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Date: Mon,  6 Aug 2018 18:25:38 -0500
Subject: [Intel-wired-lan] [PATCH v6 4/9] cxgb4: Do not call
 pcie_print_link_status()
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
Message-ID: <20180806232600.25694-4-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index a8926e97935e..049958898c17 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5726,9 +5726,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			free_msix_info(adapter);
 	}
 
-	/* check for PCI Express bandwidth capabiltites */
-	pcie_print_link_status(pdev);
-
 	err = init_rss(adapter);
 	if (err)
 		goto out_free_dev;
-- 
2.17.1

