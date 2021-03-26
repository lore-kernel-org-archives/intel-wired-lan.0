From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 25 Mar 2021 17:38:31 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 08/11] intel: call csum
 functions with well formatted arguments
In-Reply-To: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
References: <20210326003834.3886241-1-jesse.brandeburg@intel.com>
Message-ID: <20210326003834.3886241-9-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The sparse build (C=2) found that there were two drivers
who had not been convered to call the csum_replace_by_diff() function
with sparse clean arguments.  Most if not all drivers force the cast
like this patch does. So these drivers are now joining the party
(a bit late), but with no functional change.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
Warning Detail:
.../igbvf/netdev.c:2059:46: warning: incorrect type in argument 2 (different base types)
.../igbvf/netdev.c:2059:46:    expected restricted __wsum [usertype] diff
.../igbvf/netdev.c:2059:46:    got restricted __be32 [usertype]
.../ixgbevf/ixgbevf_main.c:3817:46: warning: incorrect type in argument 2 (different base types)
.../ixgbevf/ixgbevf_main.c:3817:46:    expected restricted __wsum [usertype] diff
.../ixgbevf/ixgbevf_main.c:3817:46:    got restricted __be32 [usertype]
---
 drivers/net/ethernet/intel/igbvf/netdev.c         | 2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index 630c1155f196..1bbe9862a758 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2056,7 +2056,7 @@ static int igbvf_tso(struct igbvf_ring *tx_ring,
 
 	/* remove payload length from inner checksum */
 	paylen = skb->len - l4_offset;
-	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
+	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
 
 	/* MSS L4LEN IDX */
 	mss_l4len_idx = (*hdr_len - l4_offset) << E1000_ADVTXD_L4LEN_SHIFT;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index ba2ed8a43d2d..588c3aa50d94 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3814,7 +3814,7 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 
 	/* remove payload length from inner checksum */
 	paylen = skb->len - l4_offset;
-	csum_replace_by_diff(&l4.tcp->check, htonl(paylen));
+	csum_replace_by_diff(&l4.tcp->check, (__force __wsum)htonl(paylen));
 
 	/* update gso size and bytecount with header size */
 	first->gso_segs = skb_shinfo(skb)->gso_segs;
-- 
2.30.2

