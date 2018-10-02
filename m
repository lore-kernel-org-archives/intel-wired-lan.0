From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue,  2 Oct 2018 10:00:31 +0200
Subject: [Intel-wired-lan] [PATCH v2 2/5] ixgbe: move common Rx functions to
 ixgbe_txrx_common.h
In-Reply-To: <20181002080034.11754-1-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
Message-ID: <20181002080034.11754-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This patch prepares for the upcoming zero-copy Rx functionality, by
moving/changing linkage of common functions, used both by the regular
path and zero-copy path.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 29 +++++++------------
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  | 26 +++++++++++++++++
 2 files changed, 37 insertions(+), 18 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6ff886498882..cc655c4e24fd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -40,6 +40,7 @@
 #include "ixgbe_dcb_82599.h"
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
+#include "ixgbe_txrx_common.h"
 
 char ixgbe_driver_name[] = "ixgbe";
 static const char ixgbe_driver_string[] =
@@ -1673,9 +1674,9 @@ static void ixgbe_update_rsc_stats(struct ixgbe_ring *rx_ring,
  * order to populate the hash, checksum, VLAN, timestamp, protocol, and
  * other fields within the skb.
  **/
-static void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
-				     union ixgbe_adv_rx_desc *rx_desc,
-				     struct sk_buff *skb)
+void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
+			      union ixgbe_adv_rx_desc *rx_desc,
+			      struct sk_buff *skb)
 {
 	struct net_device *dev = rx_ring->netdev;
 	u32 flags = rx_ring->q_vector->adapter->flags;
@@ -1708,8 +1709,8 @@ static void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
 	skb->protocol = eth_type_trans(skb, dev);
 }
 
-static void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,
-			 struct sk_buff *skb)
+void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,
+		  struct sk_buff *skb)
 {
 	napi_gro_receive(&q_vector->napi, skb);
 }
@@ -1868,9 +1869,9 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring *rx_ring,
  *
  * Returns true if an error was encountered and skb was freed.
  **/
-static bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
-				  union ixgbe_adv_rx_desc *rx_desc,
-				  struct sk_buff *skb)
+bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
+			   union ixgbe_adv_rx_desc *rx_desc,
+			   struct sk_buff *skb)
 {
 	struct net_device *netdev = rx_ring->netdev;
 
@@ -2186,14 +2187,6 @@ static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
 	return skb;
 }
 
-#define IXGBE_XDP_PASS		0
-#define IXGBE_XDP_CONSUMED	BIT(0)
-#define IXGBE_XDP_TX		BIT(1)
-#define IXGBE_XDP_REDIR		BIT(2)
-
-static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
-			       struct xdp_frame *xdpf);
-
 static struct sk_buff *ixgbe_run_xdp(struct ixgbe_adapter *adapter,
 				     struct ixgbe_ring *rx_ring,
 				     struct xdp_buff *xdp)
@@ -8471,8 +8464,8 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
 }
 
 #endif
-static int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
-			       struct xdp_frame *xdpf)
+int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
+			struct xdp_frame *xdpf)
 {
 	struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
 	struct ixgbe_tx_buffer *tx_buffer;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
new file mode 100644
index 000000000000..3780d315b991
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2018 Intel Corporation. */
+
+#ifndef _IXGBE_TXRX_COMMON_H_
+#define _IXGBE_TXRX_COMMON_H_
+
+#define IXGBE_XDP_PASS		0
+#define IXGBE_XDP_CONSUMED	BIT(0)
+#define IXGBE_XDP_TX		BIT(1)
+#define IXGBE_XDP_REDIR		BIT(2)
+
+int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
+			struct xdp_frame *xdpf);
+bool ixgbe_cleanup_headers(struct ixgbe_ring *rx_ring,
+			   union ixgbe_adv_rx_desc *rx_desc,
+			   struct sk_buff *skb);
+void ixgbe_process_skb_fields(struct ixgbe_ring *rx_ring,
+			      union ixgbe_adv_rx_desc *rx_desc,
+			      struct sk_buff *skb);
+void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,
+		  struct sk_buff *skb);
+
+void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring);
+void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring);
+
+#endif /* #define _IXGBE_TXRX_COMMON_H_ */
-- 
2.17.1

