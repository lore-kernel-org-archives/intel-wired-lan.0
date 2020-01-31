From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 31 Jan 2020 05:39:00 -0800
Subject: [Intel-wired-lan] [PATCH S37 v2 10/15] ice: Remove possible null
 dereference
In-Reply-To: <20200131133905.42518-1-anthony.l.nguyen@intel.com>
References: <20200131133905.42518-1-anthony.l.nguyen@intel.com>
Message-ID: <20200131133905.42518-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 1f45ebe0d8fb ("ice: add extra check for null Rx descriptor") moved
the call to ice_construct_skb() under a null check as Coverity reported a
possible use of null skb. However, the original call was not deleted, do so
now.

Fixes: 1f45ebe0d8fb ("ice: add extra check for null Rx descriptor")
Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index fd17ace6b226..1d4755acca3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1078,8 +1078,6 @@ static int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 				skb = ice_build_skb(rx_ring, rx_buf, &xdp);
 			else
 				skb = ice_construct_skb(rx_ring, rx_buf, &xdp);
-		} else {
-			skb = ice_construct_skb(rx_ring, rx_buf, &xdp);
 		}
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-- 
2.20.1

