From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 11 Sep 2019 11:17:58 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Add SCTP CRC checksumming
 functionality
Message-ID: <20190911081758.42233-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add stream control transmission protocol CRC checksum.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 37d98a6eea56..f1aab22819e6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4476,6 +4476,7 @@ static int igc_probe(struct pci_dev *pdev,
 
 	/* Add supported features to the features list*/
 	netdev->features |= NETIF_F_HW_CSUM;
+	netdev->features |= NETIF_F_SCTP_CRC;
 
 	/* setup the private structure */
 	err = igc_sw_init(adapter);
-- 
2.11.0

