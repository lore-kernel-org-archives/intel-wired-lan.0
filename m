From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 14 Sep 2016 16:24:32 -0700
Subject: [Intel-wired-lan] [next PATCH S47 2/9] i40e: Rewrite Flow Director
	busy wait loop
In-Reply-To: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473895479-23035-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We can reorder the busy wait loop at the start of the Flow Director
transmit function to reduce the overall code size while still retaining the
same functionality.  As such I am taking advantage of the opportunity to do
so.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: I34c403ca001953c6ac9816e65d5305e73d869026
---
Testing Hints:
        Verify Flow Director still functional for adding/deleting rules.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 9b82240..d1c3a3a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -122,7 +122,6 @@ static int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data,
 	struct device *dev;
 	dma_addr_t dma;
 	u32 td_cmd = 0;
-	u16 delay = 0;
 	u16 i;
 
 	/* find existing FDIR VSI */
@@ -137,15 +136,11 @@ static int i40e_program_fdir_filter(struct i40e_fdir_filter *fdir_data,
 	dev = tx_ring->dev;
 
 	/* we need two descriptors to add/del a filter and we can wait */
-	do {
-		if (I40E_DESC_UNUSED(tx_ring) > 1)
-			break;
+	for (i = I40E_FD_CLEAN_DELAY; I40E_DESC_UNUSED(tx_ring) < 2; i--) {
+		if (!i)
+			return -EAGAIN;
 		msleep_interruptible(1);
-		delay++;
-	} while (delay < I40E_FD_CLEAN_DELAY);
-
-	if (!(I40E_DESC_UNUSED(tx_ring) > 1))
-		return -EAGAIN;
+	}
 
 	dma = dma_map_single(dev, raw_packet,
 			     I40E_FDIR_MAX_RAW_PACKET_SIZE, DMA_TO_DEVICE);
-- 
2.4.11

