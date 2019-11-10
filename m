From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 10 Nov 2019 16:05:20 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Prefer to use the
 pci_release_mem_regions method
Message-ID: <20191110140520.26531-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the pci_release_mem_regions method istead of the
pci_release_selected_regions method

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 648aee679cb6..0cf3b5a82416 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4528,8 +4528,7 @@ static int igc_probe(struct pci_dev *pdev,
 err_ioremap:
 	free_netdev(netdev);
 err_alloc_etherdev:
-	pci_release_selected_regions(pdev,
-				     pci_select_bars(pdev, IORESOURCE_MEM));
+	pci_release_mem_regions(pdev);
 err_pci_reg:
 err_dma:
 	pci_disable_device(pdev);
-- 
2.11.0

