From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Date: Fri, 11 Dec 2015 10:24:06 +0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: on recv increment
	rx.ring->stats.yields instead of tx
Message-ID: <1449818646-29348-1-git-send-email-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It seem to be non intentionaly changed to tx in
ms commit: adc810900a703ee78fe88fd65e086d359fec04b2
ixgbe: Refactor busy poll socket code to address multiple issues

Lock is taken from ixgbe_low_latency_recv, and there under this
lock we use ixgbe_clean_rx_irq so it looks wrong for me to increment
tx counter.

Yield stats can be shown through ethtool:
ethtool -S enp129s0 | grep yield

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 1d21745..7656d46 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -451,7 +451,7 @@ static inline bool ixgbe_qv_lock_poll(struct ixgbe_q_vector *q_vector)
 				IXGBE_QV_STATE_POLL);
 #ifdef BP_EXTENDED_STATS
 	if (rc != IXGBE_QV_STATE_IDLE)
-		q_vector->tx.ring->stats.yields++;
+		q_vector->rx.ring->stats.yields++;
 #endif
 	return rc == IXGBE_QV_STATE_IDLE;
 }
-- 
1.9.3

