From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 09:37:49 -0600
Subject: [Intel-wired-lan] [PATCH 1/7] ixgbe: Fix skb list corruption on
 Power systems
In-Reply-To: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
References: <1510846675-15169-1-git-send-email-brking@linux.vnet.ibm.com>
Message-ID: <1510846675-15169-2-git-send-email-brking@linux.vnet.ibm.com>
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
a stale skb pointer, since we aren't zeroing it, like is done in other
similar code in other networking drivers. This patch addresses both of these
issues, replacing the read_barrier_depends with an smp_rmb, which will ensure
the load of tx_buffer->skb will not occur until after the load from
tx_buffer->next_to_watch. Secondly, it zeroes tx_buffer->skb to make this
consistent with other Intel ethernet drivers and elso ensure we don't leave
a stale skb pointer sitting around.

Cc: stable<stable@vger.kernel.org>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6d5f31e..4d8c7bb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1192,7 +1192,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
@@ -1218,6 +1218,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 				 DMA_TO_DEVICE);
 
 		/* clear tx_buffer data */
+		tx_buffer->skb = NULL;
 		dma_unmap_len_set(tx_buffer, len, 0);
 
 		/* unmap remaining buffers */
-- 
1.8.3.1

