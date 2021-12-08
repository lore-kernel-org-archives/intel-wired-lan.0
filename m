From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed,  8 Dec 2021 15:06:54 +0100
Subject: [Intel-wired-lan] [PATCH v4 net-next 1/9] i40e: don't reserve
 excessive XDP_PACKET_HEADROOM on XSK Rx to skb
In-Reply-To: <20211208140702.642741-1-alexandr.lobakin@intel.com>
References: <20211208140702.642741-1-alexandr.lobakin@intel.com>
Message-ID: <20211208140702.642741-2-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

{__,}napi_alloc_skb() allocates and reserves additional NET_SKB_PAD
+ NET_IP_ALIGN for any skb.
OTOH, i40e_construct_skb_zc() currently allocates and reserves
additional `xdp->data - xdp->data_hard_start`, which is
XDP_PACKET_HEADROOM for XSK frames.
There's no need for that at all as the frame is post-XDP and will
go only to the networking stack core.
Pass the size of the actual data only to __napi_alloc_skb() and
don't reserve anything. This will give enough headroom for stack
processing.

Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index f08d19b8c554..9564906b7da8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -245,13 +245,11 @@ static struct sk_buff *i40e_construct_skb_zc(struct i40e_ring *rx_ring,
 	struct sk_buff *skb;
 
 	/* allocate a skb to store the frags */
-	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
-			       xdp->data_end - xdp->data_hard_start,
+	skb = __napi_alloc_skb(&rx_ring->q_vector->napi, datasize,
 			       GFP_ATOMIC | __GFP_NOWARN);
 	if (unlikely(!skb))
 		goto out;
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
 	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
 	if (metasize)
 		skb_metadata_set(skb, metasize);
-- 
2.33.1

