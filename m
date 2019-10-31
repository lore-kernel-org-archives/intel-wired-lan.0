From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 31 Oct 2019 08:06:07 +0200
Subject: [Intel-wired-lan] [PATCH v2] igc: Add scatter gather support
Message-ID: <20191031060607.23975-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Scatter gather is used to do DMA data transfers of data that is written to
noncontiguous areas of memory.
This patch enables scatter gather support.

v2: fix typo in commit message

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6105c6d1f3c9..c3266645c95e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4434,6 +4434,7 @@ static int igc_probe(struct pci_dev *pdev,
 		goto err_sw_init;
 
 	/* Add supported features to the features list*/
+	netdev->features |= NETIF_F_SG;
 	netdev->features |= NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
-- 
2.11.0

