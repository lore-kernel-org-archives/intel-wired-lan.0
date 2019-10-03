From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  3 Oct 2019 14:47:01 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Clean up unused shadow_vfta
 pointer
Message-ID: <20191003114701.33966-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

VLAN filter table array not implemented yet and shadow_vfta pointer
not used. Clean up the code and remove the unused shadow_vfta pointer.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      | 1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 7e16345d836e..0868677d43ed 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -411,7 +411,6 @@ struct igc_adapter {
 	u32 tx_hwtstamp_timeouts;
 	u32 tx_hwtstamp_skipped;
 	u32 rx_hwtstamp_cleared;
-	u32 *shadow_vfta;
 
 	u32 rss_queues;
 	u32 rss_indir_tbl_init;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 52521a0bbf48..0a4bcd2d3b85 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4574,7 +4574,6 @@ static void igc_remove(struct pci_dev *pdev)
 	pci_release_mem_regions(pdev);
 
 	kfree(adapter->mac_table);
-	kfree(adapter->shadow_vfta);
 	free_netdev(netdev);
 
 	pci_disable_pcie_error_reporting(pdev);
-- 
2.11.0

