From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Wed, 13 Jun 2018 17:08:30 +0900
Subject: [Intel-wired-lan] [PATCH net-queue] i40e: Fix incorrect skb
 reserved size on rx
Message-ID: <1528877310-2574-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e_build_skb() reserves I40E_SKB_PAD + (xdp->data -
xdp->data_hard_start) but obviously I40E_SKB_PAD is unnecessary here
and mac_header/data feilds in skb becomes incorrect, and breaks normal
skb receive path as well as XDP receive path.

Fixes: cc5b114dcf98 ("bpf, i40e: add meta data support")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 8ffb7454e67c..6d59f51f1730 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2124,7 +2124,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
 		return NULL;
 
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp->data_hard_start));
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	__skb_put(skb, xdp->data_end - xdp->data);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
-- 
2.14.2


