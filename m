From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue, 23 Nov 2021 18:18:35 +0100
Subject: [Intel-wired-lan] [PATCH net-next 4/9] iavf: switch to
 napi_build_skb()
In-Reply-To: <20211123171840.157471-1-alexandr.lobakin@intel.com>
References: <20211123171840.157471-1-alexandr.lobakin@intel.com>
Message-ID: <20211123171840.157471-5-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

napi_build_skb() reuses per-cpu NAPI skbuff_head cache in order
to save some cycles on freeing/allocating skbuff_heads on every
new Rx or completed Tx.
iavf driver runs Tx completion polling cycle right before the Rx
one and uses napi_consume_skb() to feed the cache with skbuff_heads
of completed entries, so it's never empty and always warm at that
moment. Switch to the napi_build_skb() to relax mm pressure on
heavy Rx.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 3525eab8e9f9..90fdd828e5d8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1363,7 +1363,7 @@ static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
 	net_prefetch(va);

 	/* build an skb around the page buffer */
-	skb = build_skb(va - IAVF_SKB_PAD, truesize);
+	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
 	if (unlikely(!skb))
 		return NULL;

--
2.33.1

