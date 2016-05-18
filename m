From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 18 May 2016 10:44:47 -0700
Subject: [Intel-wired-lan] [net-next PATCH 1/2] ip6_gre: Do not allow
 segmentation offloads GRE_CSUM is enabled with FOU/GUE
In-Reply-To: <20160518173605.2608.42484.stgit@localhost.localdomain>
References: <20160518173605.2608.42484.stgit@localhost.localdomain>
Message-ID: <20160518174447.2608.2234.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch addresses the same issue we had for IPv4 where enabling GRE with
an inner checksum cannot be supported with FOU/GUE due to the fact that
they will jump past the GRE header at it is treated like a tunnel header.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 net/ipv6/ip6_gre.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 6fb1b89d0178..af503f518278 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1355,11 +1355,15 @@ static int ip6gre_newlink(struct net *src_net, struct net_device *dev,
 	dev->hw_features	|= GRE6_FEATURES;
 
 	if (!(nt->parms.o_flags & TUNNEL_SEQ)) {
-		/* TCP segmentation offload is not supported when we
-		 * generate output sequences.
+		/* TCP offload with GRE SEQ is not supported, nor
+		 * can we support 2 levels of outer headers requiring
+		 * an update.
 		 */
-		dev->features    |= NETIF_F_GSO_SOFTWARE;
-		dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+		if (!(nt->parms.o_flags & TUNNEL_CSUM) ||
+		    (nt->encap.type == TUNNEL_ENCAP_NONE)) {
+			dev->features    |= NETIF_F_GSO_SOFTWARE;
+			dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+		}
 
 		/* Can use a lockless transmit, unless we generate
 		 * output sequences

