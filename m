From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 06 Nov 2015 16:36:22 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Handle extended IPv6 headers in
	tx path
Message-ID: <20151107003621.85794.6437.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Check for and handle IPv6 extended headers so that tx checksum
offload can be done. Thanks to Tom Herbert for noticing this
problem. Note that the goto back to process the final protocol
value can never result in a loop, because it cannot be yet
another extended header. Handling them in this manner avoids
adding further checks to the non-extended header hot path.

Reported-by: Tom Herbert <tom@herbertland.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 3d257279e770..06d29e11aaf4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3367,6 +3367,7 @@ static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
 			break;
 		}
 
+again:
 		switch (l4_hdr) {
 		case IPPROTO_TCP:
 			type_tucmd |= IXGBE_ADVTXD_TUCMD_L4T_TCP;
@@ -3383,7 +3384,23 @@ static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
 					IXGBE_ADVTXD_L4LEN_SHIFT;
 			break;
 		default:
-			if (unlikely(net_ratelimit())) {
+			if (first->protocol == htons(ETH_P_IPV6) &&
+			    ipv6_ext_hdr(l4_hdr)) {
+				unsigned int offset = 0;
+				int ret;
+
+				ret = ipv6_find_hdr(skb, &offset, -1, NULL,
+						    NULL);
+				if (ret > 0) {
+					l4_hdr = ret;
+					goto again;
+				}
+				if (unlikely(net_ratelimit())) {
+					dev_warn(tx_ring->dev,
+						 "ipv6_find_hdr returned %d\n",
+						 ret);
+				}
+			} else if (unlikely(net_ratelimit())) {
 				dev_warn(tx_ring->dev,
 					 "partial checksum but l4 proto=%x!\n",
 					 l4_hdr);

