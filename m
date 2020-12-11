From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 11 Dec 2020 15:57:11 +0100
Subject: [Intel-wired-lan] [PATCH net 1/2] ice,
 xsk: clear the status bits for the next_to_use descriptor
In-Reply-To: <20201211145712.72957-1-bjorn.topel@gmail.com>
References: <20201211145712.72957-1-bjorn.topel@gmail.com>
Message-ID: <20201211145712.72957-2-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

On the Rx side, the next_to_use index points to the next item in the
HW ring to be refilled/allocated, and next_to_clean points to the next
item to potentially be processed.

When the HW Rx ring is fully refilled, i.e. no packets has been
processed, the next_to_use will be next_to_clean - 1. When the ring is
fully processed next_to_clean will be equal to next_to_use. The latter
case is where a bug is triggered.

If the next_to_use bits are not cleared, and the "fully processed"
state is entered, a stale descriptor can be processed.

The skb-path correctly clear the status bit for the next_to_use
descriptor, but the AF_XDP zero-copy path did not do that.

This change adds the status bits clearing of the next_to_use
descriptor.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 797886524054..98101a8e2952 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -446,8 +446,11 @@ bool ice_alloc_rx_bufs_zc(struct ice_ring *rx_ring, u16 count)
 		}
 	} while (--count);
 
-	if (rx_ring->next_to_use != ntu)
+	if (rx_ring->next_to_use != ntu) {
+		/* clear the status bits for the next_to_use descriptor */
+		rx_desc->wb.status_error0 = 0;
 		ice_release_rx_desc(rx_ring, ntu);
+	}
 
 	return ret;
 }
-- 
2.27.0

