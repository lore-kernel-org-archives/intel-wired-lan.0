From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 24 Oct 2016 15:36:38 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: ixgbe_atr() should access
	udp_hdr(skb) only for UDP packets
Message-ID: <1477348599-30723-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

Commit 9f12df906cd8 ("ixgbe: Store VXLAN port number in network order")
incorrectly checks for hdr.ipv4->protocol != IPPROTO_UDP
in ixgbe_atr(). This check should be for "==" instead.

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a582bea..e4a3227 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7662,7 +7662,7 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 	hdr.network = skb_network_header(skb);
 	if (skb->encapsulation &&
 	    first->protocol == htons(ETH_P_IP) &&
-	    hdr.ipv4->protocol != IPPROTO_UDP) {
+	    hdr.ipv4->protocol == IPPROTO_UDP) {
 		struct ixgbe_adapter *adapter = q_vector->adapter;
 
 		/* verify the port is recognized as VXLAN */
-- 
2.7.4

