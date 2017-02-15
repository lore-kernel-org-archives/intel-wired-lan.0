From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Feb 2017 09:15:59 -0800
Subject: [Intel-wired-lan] [next PATCH] igb/ixgbe: Fix typo in igb_build_skb
 and/or ixgbe_build_skb code comment
Message-ID: <20170215171559.4456.38581.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

There was a typo that I had left in the code comments for the igb and ixgbe
functions that enabled build_skb support.  This patch is meant to clean
that up since it didn't seem like something worth respinning both series
for.  If I end up having to respin the series I will pull this change into
the patch and at that time we can drop this one.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c     |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2796e9a2361e..c62513f348e8 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7043,7 +7043,7 @@ static struct sk_buff *igb_build_skb(struct igb_ring *rx_ring,
 	prefetch(va + L1_CACHE_BYTES);
 #endif
 
-	/* build an skb to around the page buffer */
+	/* build an skb around the page buffer */
 	skb = build_skb(va - IGB_SKB_PAD, truesize);
 	if (unlikely(!skb))
 		return NULL;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index bfcdc2fdeae4..25059fed3c72 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2139,7 +2139,7 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 	prefetch(va + L1_CACHE_BYTES);
 #endif
 
-	/* build an skb to around the page buffer */
+	/* build an skb around the page buffer */
 	skb = build_skb(va - IXGBE_SKB_PAD, truesize);
 	if (unlikely(!skb))
 		return NULL;

