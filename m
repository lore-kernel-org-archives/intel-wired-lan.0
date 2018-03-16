From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 16 Mar 2018 11:09:04 -0700
Subject: [Intel-wired-lan] [next-queue v2 1/4] ixgbe: no need for ipsec csum
 feature check
In-Reply-To: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
References: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1521223747-12018-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the patch
commit f8aa2696b4af ("esp: check the NETIF_F_HW_ESP_TX_CSUM bit before segmenting")
we no longer need to protect ourself from checksum
offload requests on IPsec packets, so we can remove
the check in our .ndo_features_check callback.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8536942..153cd9e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9908,12 +9908,6 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
 	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
 		features &= ~NETIF_F_TSO;
 
-#ifdef CONFIG_XFRM_OFFLOAD
-	/* IPsec offload doesn't get along well with others *yet* */
-	if (skb->sp)
-		features &= ~(NETIF_F_TSO | NETIF_F_HW_CSUM);
-#endif
-
 	return features;
 }
 
-- 
2.7.4

