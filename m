From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 13 Nov 2019 11:27:29 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Add 64 bit DMA access support
Message-ID: <20191113092729.42829-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On relevant platforms ndo_start_xmit can handle socket buffer
fragments in high memory

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 9e888f9c0217..2ad07a5cf55e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4446,6 +4446,9 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->hw_features |= NETIF_F_NTUPLE;
 	netdev->hw_features |= netdev->features;
 
+	if (pci_using_dac)
+		netdev->features |= NETIF_F_HIGHDMA;
+
 	/* MTU range: 68 - 9216 */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = MAX_STD_JUMBO_FRAME_SIZE;
-- 
2.11.0

