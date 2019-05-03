From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri,  3 May 2019 22:28:23 +0800
Subject: [Intel-wired-lan] [PATCH] net: e1000: Fix some bugs in error
 handling code of e1000_probe()
Message-ID: <20190503142823.15319-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When "hw->ce4100_gbe_mdio_base_virt = ioremap(...)" fails, the driver
does not free the memory allocated in e1000_sw_init(), and also calls
"iounmap(hw->ce4100_gbe_mido_base_virt)" that is unnecessary.

Besides, when e1000_sw_init() fails, the driver also calls 
"iounmap(hw->ce4100_gbe_mido_base_virt)" but 
hw->ce4100_gbe_mido_base_virt has not been assigned.

These bugs are found by a runtime fuzzing tool named FIZZER written by us.

To fix these bugs, the error handling code of e1000_probe() is adjusted.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 8fe9af0e2ab7..7743c4d9723f 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,12 +1227,12 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (hw->flash_address)
 		iounmap(hw->flash_address);
+	iounmap(hw->ce4100_gbe_mdio_base_virt);
+err_mdio_ioremap:
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
-err_dma:
 err_sw_init:
-err_mdio_ioremap:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+err_dma:
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.17.0

