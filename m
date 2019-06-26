From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 26 Jun 2019 02:20:23 -0700
Subject: [Intel-wired-lan] [PATCH S22 12/16] ice: Remove duplicate code in
 ice_alloc_rx_bufs
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <20190626092027.52845-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the call to ice_alloc_mapped_page() fails we jump to the
no_buf label, possibly call ice_release_rx_desc(), and return true
indicating that there is more work to do. In the success case we just
fall out of the while loop, possibly call ice_alloc_mapped_page(), and
return false saying we exhausted cleaned_count. This flow can be
improved by breaking if ice_alloc_mapped_page() fails and then the flow
outside of the while loop is the same for the failure and success case.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index c604b2d192b1..99e453fbdb9d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -730,8 +730,9 @@ bool ice_alloc_rx_bufs(struct ice_ring *rx_ring, u16 cleaned_count)
 	bi = &rx_ring->rx_buf[ntu];
 
 	do {
+		/* if we fail here, we have work remaining */
 		if (!ice_alloc_mapped_page(rx_ring, bi))
-			goto no_bufs;
+			break;
 
 		/* sync the buffer for use by the device */
 		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
@@ -762,16 +763,7 @@ bool ice_alloc_rx_bufs(struct ice_ring *rx_ring, u16 cleaned_count)
 	if (rx_ring->next_to_use != ntu)
 		ice_release_rx_desc(rx_ring, ntu);
 
-	return false;
-
-no_bufs:
-	if (rx_ring->next_to_use != ntu)
-		ice_release_rx_desc(rx_ring, ntu);
-
-	/* make sure to come back via polling to try again after
-	 * allocation failure
-	 */
-	return true;
+	return !!cleaned_count;
 }
 
 /**
-- 
2.20.1

