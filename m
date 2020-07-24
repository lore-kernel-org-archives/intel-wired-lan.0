From: Li RongQing <lirongqing@baidu.com>
Date: Fri, 24 Jul 2020 17:57:59 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ice/xdp: not adjust rx buffer for
 copy mode xdp
In-Reply-To: <1595584679-30652-1-git-send-email-lirongqing@baidu.com>
References: <1595584679-30652-1-git-send-email-lirongqing@baidu.com>
Message-ID: <1595584679-30652-2-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_rx_buf_adjust_pg_offset in copy mode xdp can lead to data
corruption, like the following flow:

   1. first skb is not for xsk, and forwarded to another device
      or socket queue
   2. seconds skb is for xsk, copy data to xsk memory, and page
      of skb->data is released
   3. rx_buff is reusable since only first skb is in it, but
      ice_rx_buf_adjust_pg_offset will make that page_offset
      is set to first skb data
   4. then reuse rx buffer, first skb which still is living
      will be corrupted.

so adjust rx buffer page offset when xdp memory type is
MEM_TYPE_XSK_BUFF_POOL, or map type is not BPF_MAP_TYPE_XSKMAP
which means that memory will be released immediately

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index abdb137c8bb7..6ceb1a0c33ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1169,7 +1169,10 @@ int ice_clean_rx_irq(struct ice_ring *rx_ring, int budget)
 			goto construct_skb;
 		if (xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR)) {
 			xdp_xmit |= xdp_res;
-			ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
+
+			if (xdp.rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL ||
+			    xdp_get_map_type_no_direct() != BPF_MAP_TYPE_XSKMAP)
+				ice_rx_buf_adjust_pg_offset(rx_buf, xdp.frame_sz);
 		} else {
 			rx_buf->pagecnt_bias++;
 		}
-- 
2.16.2

