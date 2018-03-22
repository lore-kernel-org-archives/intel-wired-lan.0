From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Mar 2018 17:33:47 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v5 3/9] igb: Enable the
 hardware traffic class feature bit for igb models
In-Reply-To: <20180322003353.29970-1-vinicius.gomes@intel.com>
References: <20180322003353.29970-1-vinicius.gomes@intel.com>
Message-ID: <20180322003353.29970-4-vinicius.gomes@intel.com>
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
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d0e8e796c6fa..9ce29b8bb7da 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2806,6 +2806,9 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->mac.type >= e1000_82576)
 		netdev->features |= NETIF_F_SCTP_CRC;
 
+	if (hw->mac.type >= e1000_i350)
+		netdev->features |= NETIF_F_HW_TC;
+
 #define IGB_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
 				  NETIF_F_GSO_GRE_CSUM | \
 				  NETIF_F_GSO_IPXIP4 | \
-- 
2.16.2

