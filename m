From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Thu, 19 Oct 2017 20:07:36 +0100
Subject: [Intel-wired-lan] [PATCH] igb: Fix TX map failure path
Message-ID: <20171019190736.2770-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the driver cannot map a TX buffer, instead of rolling back
gracefully and retrying later, we currently get a panic:

[  159.885994] igb 0000:00:00.0: TX DMA map failed
[  159.886588] Unable to handle kernel paging request at virtual address ffff00000a08c7a8
               ...
[  159.897031] PC is at igb_xmit_frame_ring+0x9c8/0xcb8

Fix the erroneous test that leads to this situation.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index fd4a46b03cc8..ea69af267d63 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5326,7 +5326,7 @@ static int igb_tx_map(struct igb_ring *tx_ring,
 				       DMA_TO_DEVICE);
 		dma_unmap_len_set(tx_buffer, len, 0);
 
-		if (i--)
+		if (i-- == 0)
 			i += tx_ring->count;
 		tx_buffer = &tx_ring->tx_buffer_info[i];
 	}
-- 
2.13.3

