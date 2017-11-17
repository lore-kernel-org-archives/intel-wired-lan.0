From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 17 Nov 2017 11:05:43 -0600
Subject: [Intel-wired-lan] [PATCH v2 1/7] ixgbe: Fix skb list corruption on
 Power systems
In-Reply-To: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
References: <1510938349-17608-1-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <1510938349-17608-2-git-send-email-brking@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes an issue seen on Power systems with ixgbe which results
in skb list corruption and an eventual kernel oops. The following is what
was observed:

CPU 1                                   CPU2
============================            ============================
1: ixgbe_xmit_frame_ring                ixgbe_clean_tx_irq
2:  first->skb = skb                     eop_desc = tx_buffer->next_to_watch
3:  ixgbe_tx_map                         read_barrier_depends()
4:   wmb                                 check adapter written status bit
5:   first->next_to_watch = tx_desc      napi_consume_skb(tx_buffer->skb ..);
6:   writel(i, tx_ring->tail);

The read_barrier_depends is insufficient to ensure that tx_buffer->skb does not
get loaded prior to tx_buffer->next_to_watch, which then results in loading
a stale skb pointer. This patch replaces the read_barrier_depends with
smp_rmb to ensure loads are ordered with respect to the load of
tx_buffer->next_to_watch.

Cc: stable<stable@vger.kernel.org>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6d5f31e..879a9c4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1192,7 +1192,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
-- 
1.8.3.1

