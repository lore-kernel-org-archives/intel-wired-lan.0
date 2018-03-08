From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed,  7 Mar 2018 16:37:08 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v4 3/8] igb: Enable the
 hardware traffic class feature bit for igb models
In-Reply-To: <20180308003713.29195-1-vinicius.gomes@intel.com>
References: <20180308003713.29195-1-vinicius.gomes@intel.com>
Message-ID: <20180308003713.29195-4-vinicius.gomes@intel.com>
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
index eabedc6b6518..8684d5ed56e1 100644
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

