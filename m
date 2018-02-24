From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:31 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 3/8] igb: Enable the hardware
 traffic class feature bit for igb models
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-4-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This will allow functionality depending on the hardware being traffic
class aware to work. In particular the tc-flower offloading checks
verifies that this bit is set.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0ea32be07d71..543aa99892eb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2820,8 +2820,10 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			       NETIF_F_HW_VLAN_CTAG_TX |
 			       NETIF_F_RXALL;
 
-	if (hw->mac.type >= e1000_i350)
-		netdev->hw_features |= NETIF_F_NTUPLE;
+	if (hw->mac.type >= e1000_i350) {
+		netdev->hw_features |= (NETIF_F_NTUPLE | NETIF_F_HW_TC);
+		netdev->features |= NETIF_F_HW_TC;
+	}
 
 	if (pci_using_dac)
 		netdev->features |= NETIF_F_HIGHDMA;
-- 
2.16.2

