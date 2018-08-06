From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Date: Mon,  6 Aug 2018 18:25:39 -0500
Subject: [Intel-wired-lan] [PATCH v6 5/9] fm10k: Do not call
 pcie_print_link_status()
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
Message-ID: <20180806232600.25694-5-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 15071e4adb98..079fd3c884ea 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2224,9 +2224,6 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* kick off service timer now, even when interface is down */
 	mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
 
-	/* print warning for non-optimal configurations */
-	pcie_print_link_status(interface->pdev);
-
 	/* report MAC address for logging */
 	dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
 
-- 
2.17.1

