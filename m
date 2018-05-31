From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 31 May 2018 14:12:18 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix broken ipsec Rx with proper
 cast on spi
Message-ID: <1527801138-26877-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix up a cast problem introduced by a sparse cleanup patch.  This fixes
a problem where the encrypted packets were not recognized on Rx and
subsequently dropped.

Fixes: 9cfbfa701b55 ("ixgbe: cleanup sparse warnings")
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index e1c9762..344a1f2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -663,7 +663,7 @@ static int ixgbe_ipsec_add_sa(struct xfrm_state *xs)
 
 		/* hash the new entry for faster search in Rx path */
 		hash_add_rcu(ipsec->rx_sa_list, &ipsec->rx_tbl[sa_idx].hlist,
-			     (__force u64)rsa.xs->id.spi);
+			     (__force u32)rsa.xs->id.spi);
 	} else {
 		struct tx_sa tsa;
 
-- 
2.7.4

