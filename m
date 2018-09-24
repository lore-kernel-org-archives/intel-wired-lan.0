From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Mon, 24 Sep 2018 18:35:56 +0200
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: move common Tx functions to
 ixgbe_txrx_common.h
In-Reply-To: <20180924163557.1187-1-bjorn.topel@gmail.com>
References: <20180924163557.1187-1-bjorn.topel@gmail.com>
Message-ID: <20180924163557.1187-5-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This patch prepares for the upcoming zero-copy Tx functionality by
moving common functions used both by the regular path and zero-copy
path.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c        | 9 +++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h | 5 +++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 4e6726c623a8..4e9b28894a5b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -895,8 +895,8 @@ static void ixgbe_set_ivar(struct ixgbe_adapter *adapter, s8 direction,
 	}
 }
 
-static inline void ixgbe_irq_rearm_queues(struct ixgbe_adapter *adapter,
-					  u64 qmask)
+void ixgbe_irq_rearm_queues(struct ixgbe_adapter *adapter,
+			    u64 qmask)
 {
 	u32 mask;
 
@@ -8150,9 +8150,6 @@ static inline int ixgbe_maybe_stop_tx(struct ixgbe_ring *tx_ring, u16 size)
 	return __ixgbe_maybe_stop_tx(tx_ring, size);
 }
 
-#define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
-		       IXGBE_TXD_CMD_RS)
-
 static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 			struct ixgbe_tx_buffer *first,
 			const u8 hdr_len)
@@ -10275,7 +10272,7 @@ static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	}
 }
 
-static void ixgbe_xdp_ring_update_tail(struct ixgbe_ring *ring)
+void ixgbe_xdp_ring_update_tail(struct ixgbe_ring *ring)
 {
 	/* Force memory writes to complete before letting h/w know there
 	 * are new descriptors to fetch.
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index cf219f4e009d..56afb685c648 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -9,6 +9,9 @@
 #define IXGBE_XDP_TX		BIT(1)
 #define IXGBE_XDP_REDIR		BIT(2)
 
+#define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
+		       IXGBE_TXD_CMD_RS)
+
 int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
 			struct xdp_frame *xdpf);
 bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
@@ -19,6 +22,8 @@ void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
 			      struct sk_buff *skb);
 void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,
 		  struct sk_buff *skb);
+void ixgbe_xdp_ring_update_tail(struct ixgbe_ring *ring);
+void ixgbe_irq_rearm_queues(struct ixgbe_adapter *adapter, u64 qmask);
 
 void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring);
 void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring);
-- 
2.17.1

