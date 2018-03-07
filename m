From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Mar 2018 05:49:50 -0800
Subject: [Intel-wired-lan] [next PATCH S87-V3 1/8] igb: Enable the hardware
 traffic class feature bit for igb models
Message-ID: <20180307134957.61497-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

This will allow functionality depending on the hardware being traffic
class aware to work. In particular the tc-flower offloading checks
verifies that this bit is set.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 0c86a44..1557126 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2807,6 +2807,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->mac.type >= e1000_82576)
 		netdev->features |= NETIF_F_SCTP_CRC;
 
+	if (hw->mac.type >= e1000_i350)
+		netdev->features |= NETIF_F_HW_TC;
+
 #define IGB_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
 				  NETIF_F_GSO_GRE_CSUM | \
 				  NETIF_F_GSO_IPXIP4 | \
-- 
2.9.5

