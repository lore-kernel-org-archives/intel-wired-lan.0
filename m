From: Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Date: Mon,  7 Dec 2020 09:14:15 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] ice: fix array overflow on receiving
 too many fragments for a packet
Message-ID: <20201207011415.463-1-ruc_zhangxiaohui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

If the hardware receives an oversized packet with too many rx fragments,
skb_shinfo(skb)->frags can overflow and corrupt memory of adjacent pages.
This becomes especially visible if it corrupts the freelist pointer of
a slab page.

Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index eae75260f..f0f034fa5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -823,8 +823,12 @@ ice_add_rx_frag(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf,
 
 	if (!size)
 		return;
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buf->page,
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (shinfo->nr_frags < ARRAY_SIZE(shinfo->frags)) {
+		skb_add_rx_frag(skb, shinfo, rx_buf->page,
 			rx_buf->page_offset, size, truesize);
+	}
 
 	/* page is being used so we must update the page offset */
 	ice_rx_buf_adjust_pg_offset(rx_buf, truesize);
-- 
2.17.1

