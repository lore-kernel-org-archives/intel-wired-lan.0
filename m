From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon,  8 Jan 2018 14:47:49 -0800
Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: add unlikely notes
 to tx fastpath expressions
In-Reply-To: <1515451669-927-1-git-send-email-shannon.nelson@oracle.com>
References: <1515451669-927-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1515451669-927-2-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add unlikely() to a few error checking expressions in the Tx
offload handling.

Suggested-by: Yanjun Zhu <yanjun.zhu@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 57c10e6..3d069a2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -749,28 +749,28 @@ int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
 	struct xfrm_state *xs;
 	struct tx_sa *tsa;
 
-	if (!first->skb->sp->len) {
+	if (unlikely(!first->skb->sp->len)) {
 		netdev_err(tx_ring->netdev, "%s: no xfrm state len = %d\n",
 			   __func__, first->skb->sp->len);
 		return 0;
 	}
 
 	xs = xfrm_input_state(first->skb);
-	if (!xs) {
+	if (unlikely(!xs)) {
 		netdev_err(tx_ring->netdev, "%s: no xfrm_input_state() xs = %p\n",
 			   __func__, xs);
 		return 0;
 	}
 
 	itd->sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
-	if (itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT) {
+	if (unlikely(itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT)) {
 		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
 			   __func__, itd->sa_idx, xs->xso.offload_handle);
 		return 0;
 	}
 
 	tsa = &ipsec->tx_tbl[itd->sa_idx];
-	if (!tsa->used) {
+	if (unlikely(!tsa->used)) {
 		netdev_err(tx_ring->netdev, "%s: unused sa_idx=%d\n",
 			   __func__, itd->sa_idx);
 		return 0;
-- 
2.7.4

