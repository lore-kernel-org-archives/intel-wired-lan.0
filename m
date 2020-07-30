From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:13 -0700
Subject: [Intel-wired-lan] [PATCH S51 04/13] ice: remove page_reuse statistic
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The page reuse statistic wasn't even being displayed to the user, even
though the driver counted it. Don't waste the struct space and hot-path
cycles since the driver doesn't display it.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 --
 drivers/net/ethernet/intel/ice/ice_txrx.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a508d4f463e9..53c67eeec2fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -632,7 +632,6 @@ ice_alloc_mapped_page(struct ice_ring *rx_ring, struct ice_rx_buf *bi)
 
 	/* since we are recycling buffers we should seldom need to alloc */
 	if (likely(page)) {
-		rx_ring->rx_stats.page_reuse_count++;
 		return true;
 	}
 
@@ -1033,7 +1032,6 @@ static void ice_put_rx_buf(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
 	if (ice_can_reuse_rx_page(rx_buf)) {
 		/* hand second half of page back to the ring */
 		ice_reuse_rx_page(rx_ring, rx_buf);
-		rx_ring->rx_stats.page_reuse_count++;
 	} else {
 		/* we are not reusing the buffer so unmap it */
 		dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index e70c4619edc3..77c94daeb434 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -193,7 +193,6 @@ struct ice_rxq_stats {
 	u64 non_eop_descs;
 	u64 alloc_page_failed;
 	u64 alloc_buf_failed;
-	u64 page_reuse_count;
 };
 
 /* this enum matches hardware bits and is meant to be used by DYN_CTLN
-- 
2.20.1

