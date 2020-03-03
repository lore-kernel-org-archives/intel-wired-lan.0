From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue,  3 Mar 2020 02:28:08 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Enable NETIF_F_HW_TC flag
Message-ID: <20200303002808.14210-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This assignment of the feature NETIF_F_HW_TC
occurs prior to the initial setup of the local
hw_features variable.

This ensures that NETIF_F_HW_TC are marked
as user changeable, and also enables it by
default when the driver loads.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 47009fe0cbde..025f2e439aef 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4898,6 +4898,7 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
 	netdev->features |= NETIF_F_GSO_UDP_L4;
+	netdev->features |= NETIF_F_HW_TC;
 
 #define IGC_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
 				  NETIF_F_GSO_GRE_CSUM | \
-- 
2.11.0

