From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 10 Feb 2020 09:04:15 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add GSO partial support
Message-ID: <20200210070415.23679-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Partial generic segmentation offload is a hybrid between TSO and GSO.
What is effectively does is take advantage of certain traits of TCP and
tunnels so that instead of having to rewrite the packet headers for each
segment only in the inner-most transport header and possible the outer-most
network header need to be updated.
This allows devices that do not support tunnel offload or tunnels
offloads with checksum to still make use of segmentation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 660b14abce1d..0c2d4f8d9904 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4905,6 +4905,16 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
 
+#define IGC_GSO_PARTIAL_FEATURES (NETIF_F_GSO_GRE | \
+				  NETIF_F_GSO_GRE_CSUM | \
+				  NETIF_F_GSO_IPXIP4 | \
+				  NETIF_F_GSO_IPXIP6 | \
+				  NETIF_F_GSO_UDP_TUNNEL | \
+				  NETIF_F_GSO_UDP_TUNNEL_CSUM)
+
+	netdev->gso_partial_features = IGC_GSO_PARTIAL_FEATURES;
+	netdev->features |= NETIF_F_GSO_PARTIAL | IGC_GSO_PARTIAL_FEATURES;
+
 	/* setup the private structure */
 	err = igc_sw_init(adapter);
 	if (err)
-- 
2.11.0

