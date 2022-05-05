From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:38 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 1/8] xfrm: free not used
 XFRM_ESP_NO_TRAILER flag
In-Reply-To: <cover.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
Message-ID: <a8b37f45df031108d6b191916570a1005d645d38.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

After removal of Innova IPsec support from mlx5 driver, the last user
of this XFRM_ESP_NO_TRAILER was gone too. This means that we can safely
remove it as no other hardware is capable (or need) to remove ESP trailer.

Reviewed-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h | 2 +-
 net/ipv4/esp4.c    | 6 ------
 net/ipv6/esp6.c    | 6 ------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 6fb899ff5afc..b41278abeeaa 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1006,7 +1006,7 @@ struct xfrm_offload {
 #define	CRYPTO_FALLBACK		8
 #define	XFRM_GSO_SEGMENT	16
 #define	XFRM_GRO		32
-#define	XFRM_ESP_NO_TRAILER	64
+/* 64 is free */
 #define	XFRM_DEV_RESUME		128
 #define	XFRM_XMIT		256
 
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d747166bb291..b21238df3301 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -705,7 +705,6 @@ static int esp_output(struct xfrm_state *x, struct sk_buff *skb)
 static inline int esp_remove_trailer(struct sk_buff *skb)
 {
 	struct xfrm_state *x = xfrm_input_state(skb);
-	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct crypto_aead *aead = x->data;
 	int alen, hlen, elen;
 	int padlen, trimlen;
@@ -717,11 +716,6 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 	hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead);
 	elen = skb->len - hlen;
 
-	if (xo && (xo->flags & XFRM_ESP_NO_TRAILER)) {
-		ret = xo->proto;
-		goto out;
-	}
-
 	if (skb_copy_bits(skb, skb->len - alen - 2, nexthdr, 2))
 		BUG();
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index f2120e92caf1..36e1d0f8dd06 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -741,7 +741,6 @@ static int esp6_output(struct xfrm_state *x, struct sk_buff *skb)
 static inline int esp_remove_trailer(struct sk_buff *skb)
 {
 	struct xfrm_state *x = xfrm_input_state(skb);
-	struct xfrm_offload *xo = xfrm_offload(skb);
 	struct crypto_aead *aead = x->data;
 	int alen, hlen, elen;
 	int padlen, trimlen;
@@ -753,11 +752,6 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 	hlen = sizeof(struct ip_esp_hdr) + crypto_aead_ivsize(aead);
 	elen = skb->len - hlen;
 
-	if (xo && (xo->flags & XFRM_ESP_NO_TRAILER)) {
-		ret = xo->proto;
-		goto out;
-	}
-
 	ret = skb_copy_bits(skb, skb->len - alen - 2, nexthdr, 2);
 	BUG_ON(ret);
 
-- 
2.35.1

