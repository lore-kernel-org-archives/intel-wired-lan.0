From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 05 Feb 2017 20:30:40 -0800
Subject: [Intel-wired-lan] [next PATCH v4 06/12] igb: Only sync size of
 expected frame in ethtool testing
In-Reply-To: <20170206042508.14635.44702.stgit@localhost.localdomain>
References: <20170206042508.14635.44702.stgit@localhost.localdomain>
Message-ID: <20170206043024.14635.2681.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We only need to sync the size of the frame that is read to test.  We don't
need to sync the entire Rx buffer.  This way the testing is more consistent
with how we handle things in the receive path.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
v4: Split this code out of patch 6 of the original series.

 drivers/net/ethernet/intel/igb/igb_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 612cf13b7a3a..d5966feb7b96 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1818,7 +1818,7 @@ static int igb_clean_test_rings(struct igb_ring *rx_ring,
 		/* sync Rx buffer for CPU read */
 		dma_sync_single_for_cpu(rx_ring->dev,
 					rx_buffer_info->dma,
-					IGB_RX_BUFSZ,
+					size,
 					DMA_FROM_DEVICE);
 
 		/* verify contents of skb */
@@ -1828,7 +1828,7 @@ static int igb_clean_test_rings(struct igb_ring *rx_ring,
 		/* sync Rx buffer for device write */
 		dma_sync_single_for_device(rx_ring->dev,
 					   rx_buffer_info->dma,
-					   IGB_RX_BUFSZ,
+					   size,
 					   DMA_FROM_DEVICE);
 
 		/* unmap buffer on Tx side */

