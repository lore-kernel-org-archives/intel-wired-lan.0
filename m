From: Colin King <colin.king@canonical.com>
Date: Thu, 19 Dec 2019 23:45:35 +0000
Subject: [Intel-wired-lan] [PATCH] ice: remove redundant assignment to
 variable xmit_done
Message-ID: <20191219234535.37103-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

The variable xmit_done is being initialized with a value that is never
read and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index cf9b8b22d24f..03c1e9bcf790 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -1019,8 +1019,8 @@ bool ice_clean_tx_irq_zc(struct ice_ring *xdp_ring, int budget)
 	s16 ntc = xdp_ring->next_to_clean;
 	struct ice_tx_desc *tx_desc;
 	struct ice_tx_buf *tx_buf;
-	bool xmit_done = true;
 	u32 xsk_frames = 0;
+	bool xmit_done;
 
 	tx_desc = ICE_TX_DESC(xdp_ring, ntc);
 	tx_buf = &xdp_ring->tx_buf[ntc];
-- 
2.24.0

