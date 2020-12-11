From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Fri, 11 Dec 2020 09:54:10 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next] ice,
 xsk: Move Rx allocation out of while-loop
Message-ID: <20201211085410.59350-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

Instead doing the check for allocation in each loop, move it outside
the while loop and do it every NAPI loop.

This change boosts the xdpsock rxdrop scenario with 15% more
packets-per-second.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
v2: Fixed spelling and reworked the commit message. (Maciej)
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 797886524054..39757b4cf8f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -570,12 +570,6 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 		u16 vlan_tag = 0;
 		u8 rx_ptype;
 
-		if (cleaned_count >= ICE_RX_BUF_WRITE) {
-			failure |= ice_alloc_rx_bufs_zc(rx_ring,
-							cleaned_count);
-			cleaned_count = 0;
-		}
-
 		rx_desc = ICE_RX_DESC(rx_ring, rx_ring->next_to_clean);
 
 		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
@@ -642,6 +636,9 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 		ice_receive_skb(rx_ring, skb, vlan_tag);
 	}
 
+	if (cleaned_count >= ICE_RX_BUF_WRITE)
+		failure = !ice_alloc_rx_bufs_zc(rx_ring, cleaned_count);
+
 	ice_finalize_xdp_rx(rx_ring, xdp_xmit);
 	ice_update_rx_ring_stats(rx_ring, total_rx_packets, total_rx_bytes);
 

base-commit: d9838b1d39283c1200c13f9076474c7624b8ec34
-- 
2.27.0

