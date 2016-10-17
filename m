From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 17 Oct 2016 14:12:38 -0700
Subject: [Intel-wired-lan] [PATCH V3 RFC 1/2] ixgbe: ixgbe_atr() should
	access udp_hdr(skb) only for UDP packets
In-Reply-To: <cover.1476737917.git.sowmini.varadhan@oracle.com>
References: <cover.1476737917.git.sowmini.varadhan@oracle.com>
Message-ID: <0f20149c8dfb8601dcc7a63f1de95e2ab57c6328.1476737917.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit 9f12df906cd8 ("ixgbe: Store VXLAN port number in network order")
incorrectly checks for hdr.ipv4->protocol != IPPROTO_UDP
in ixgbe_atr(). This check should be for "==" instead.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a244d9a..eceb47b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7653,7 +7653,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 	hdr.network = skb_network_header(skb);
 	if (skb->encapsulation &&
 	    first->protocol == htons(ETH_P_IP) &&
-	    hdr.ipv4->protocol != IPPROTO_UDP) {
+	    hdr.ipv4->protocol == IPPROTO_UDP) {
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		/* verify the port is recognized as VXLAN */
-- 
1.7.1

