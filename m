From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 30 Nov 2021 19:36:49 +0100
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ice: remove dead store on
 XSK hotpath
In-Reply-To: <20211130183649.1166842-1-alexandr.lobakin@intel.com>
References: <20211130183649.1166842-1-alexandr.lobakin@intel.com>
Message-ID: <20211130183649.1166842-2-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 'if (ntu == rx_ring->count)' block in ice_alloc_rx_buffers_zc()
was previously residing in the loop, but after introducing the
batched interface it is used only to wrap-around the NTU descriptor,
thus no more need to assign 'xdp'.

Fixes: db804cfc21e9 ("ice: Use the xsk batched rx allocation interface")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index ff55cb415b11..8573d2a3d873 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -391,7 +391,6 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
 	ntu += nb_buffs;
 	if (ntu == rx_ring->count) {
 		rx_desc = ICE_RX_DESC(rx_ring, 0);
-		xdp = rx_ring->xdp_buf;
 		ntu = 0;
 	}
 
-- 
2.33.1

