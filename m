From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue,  2 Oct 2018 10:00:32 +0200
Subject: [Intel-wired-lan] [PATCH v2 3/5] ixgbe: add AF_XDP zero-copy Rx
 support
In-Reply-To: <20181002080034.11754-1-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
Message-ID: <20181002080034.11754-4-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This patch adds zero-copy Rx support for AF_XDP sockets. Instead of
allocating buffers of type MEM_TYPE_PAGE_SHARED, the Rx frames are
allocated as MEM_TYPE_ZERO_COPY when AF_XDP is enabled for a certain
queue.

All AF_XDP specific functions are added to a new file, ixgbe_xsk.c.

Note that when AF_XDP zero-copy is enabled, the XDP action XDP_PASS
will allocate a new buffer and copy the zero-copy frame prior passing
it to the kernel stack.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/Makefile     |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  27 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  17 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  78 ++-
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  15 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 628 ++++++++++++++++++
 6 files changed, 747 insertions(+), 21 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c

diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index 5414685189ce..ca6b0c458e4a 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_IXGBE) += ixgbe.o
 
 ixgbe-objs := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
               ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
-              ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o
+              ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
+              ixgbe_xsk.o
 
 ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 265db172042a..7a7679e7be84 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -228,13 +228,17 @@ struct ixgbe_tx_buffer {
 struct ixgbe_rx_buffer {
 	struct sk_buff *skb;
 	dma_addr_t dma;
-	struct page *page;
-#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
-	__u32 page_offset;
-#else
-	__u16 page_offset;
-#endif
-	__u16 pagecnt_bias;
+	union {
+		struct {
+			struct page *page;
+			__u32 page_offset;
+			__u16 pagecnt_bias;
+		};
+		struct {
+			void *addr;
+			u64 handle;
+		};
+	};
 };
 
 struct ixgbe_queue_stats {
@@ -348,6 +352,10 @@ struct ixgbe_ring {
 		struct ixgbe_rx_queue_stats rx_stats;
 	};
 	struct xdp_rxq_info xdp_rxq;
+	struct xdp_umem *xsk_umem;
+	struct zero_copy_allocator zca; /* ZC allocator anchor */
+	u16 ring_idx;		/* {rx,tx,xdp}_ring back reference idx */
+	u16 rx_buf_len;
 } ____cacheline_internodealigned_in_smp;
 
 enum ixgbe_ring_f_enum {
@@ -765,6 +773,11 @@ struct ixgbe_adapter {
 #ifdef CONFIG_XFRM_OFFLOAD
 	struct ixgbe_ipsec *ipsec;
 #endif /* CONFIG_XFRM_OFFLOAD */
+
+	/* AF_XDP zero-copy */
+	struct xdp_umem **xsk_umems;
+	u16 num_xsk_umems_used;
+	u16 num_xsk_umems;
 };
 
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index d361f570ca37..62e6499e4146 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1055,7 +1055,7 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
 	int txr_remaining = adapter->num_tx_queues;
 	int xdp_remaining = adapter->num_xdp_queues;
 	int rxr_idx = 0, txr_idx = 0, xdp_idx = 0, v_idx = 0;
-	int err;
+	int err, i;
 
 	/* only one q_vector if MSI-X is disabled. */
 	if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED))
@@ -1097,6 +1097,21 @@ static int ixgbe_alloc_q_vectors(struct ixgbe_adapter *adapter)
 		xdp_idx += xqpv;
 	}
 
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		if (adapter->rx_ring[i])
+			adapter->rx_ring[i]->ring_idx = i;
+	}
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		if (adapter->tx_ring[i])
+			adapter->tx_ring[i]->ring_idx = i;
+	}
+
+	for (i = 0; i < adapter->num_xdp_queues; i++) {
+		if (adapter->xdp_ring[i])
+			adapter->xdp_ring[i]->ring_idx = i;
+	}
+
 	return 0;
 
 err_out:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cc655c4e24fd..547092b8fe54 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -34,6 +34,7 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/vxlan.h>
 #include <net/mpls.h>
+#include <net/xdp_sock.h>
 
 #include "ixgbe.h"
 #include "ixgbe_common.h"
@@ -3176,7 +3177,10 @@ int ixgbe_poll(struct napi_struct *napi, int budget)
 		per_ring_budget = budget;
 
 	ixgbe_for_each_ring(ring, q_vector->rx) {
-		int cleaned = ixgbe_clean_rx_irq(q_vector, ring,
+		int cleaned = ring->xsk_umem ?
+			      ixgbe_clean_rx_irq_zc(q_vector, ring,
+						    per_ring_budget) :
+			      ixgbe_clean_rx_irq(q_vector, ring,
 						 per_ring_budget);
 
 		work_done += cleaned;
@@ -3706,10 +3710,27 @@ static void ixgbe_configure_srrctl(struct ixgbe_adapter *adapter,
 	srrctl = IXGBE_RX_HDR_SIZE << IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT;
 
 	/* configure the packet buffer length */
-	if (test_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state))
+	if (rx_ring->xsk_umem) {
+		u32 xsk_buf_len = rx_ring->xsk_umem->chunk_size_nohr -
+				  XDP_PACKET_HEADROOM;
+
+		/* If the MAC support setting RXDCTL.RLPML, the
+		 * SRRCTL[n].BSIZEPKT is set to PAGE_SIZE and
+		 * RXDCTL.RLPML is set to the actual UMEM buffer
+		 * size. If not, then we are stuck with a 1k buffer
+		 * size resolution. In this case frames larger than
+		 * the UMEM buffer size viewed in a 1k resolution will
+		 * be dropped.
+		 */
+		if (hw->mac.type != ixgbe_mac_82599EB)
+			srrctl |= PAGE_SIZE >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
+		else
+			srrctl |= xsk_buf_len >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
+	} else if (test_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state)) {
 		srrctl |= IXGBE_RXBUFFER_3K >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
-	else
+	} else {
 		srrctl |= IXGBE_RXBUFFER_2K >> IXGBE_SRRCTL_BSIZEPKT_SHIFT;
+	}
 
 	/* configure descriptor type */
 	srrctl |= IXGBE_SRRCTL_DESCTYPE_ADV_ONEBUF;
@@ -4032,6 +4053,19 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 	u32 rxdctl;
 	u8 reg_idx = ring->reg_idx;
 
+	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+	ring->xsk_umem = ixgbe_xsk_umem(adapter, ring);
+	if (ring->xsk_umem) {
+		ring->zca.free = ixgbe_zca_free;
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_ZERO_COPY,
+						   &ring->zca));
+
+	} else {
+		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						   MEM_TYPE_PAGE_SHARED, NULL));
+	}
+
 	/* disable queue to avoid use of these values while updating state */
 	rxdctl = IXGBE_READ_REG(hw, IXGBE_RXDCTL(reg_idx));
 	rxdctl &= ~IXGBE_RXDCTL_ENABLE;
@@ -4081,6 +4115,17 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 #endif
 	}
 
+	if (ring->xsk_umem && hw->mac.type != ixgbe_mac_82599EB) {
+		u32 xsk_buf_len = ring->xsk_umem->chunk_size_nohr -
+				  XDP_PACKET_HEADROOM;
+
+		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
+			    IXGBE_RXDCTL_RLPML_EN);
+		rxdctl |= xsk_buf_len | IXGBE_RXDCTL_RLPML_EN;
+
+		ring->rx_buf_len = xsk_buf_len;
+	}
+
 	/* initialize rx_buffer_info */
 	memset(ring->rx_buffer_info, 0,
 	       sizeof(struct ixgbe_rx_buffer) * ring->count);
@@ -4094,7 +4139,10 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_RXDCTL(reg_idx), rxdctl);
 
 	ixgbe_rx_desc_queue_enable(adapter, ring);
-	ixgbe_alloc_rx_buffers(ring, ixgbe_desc_unused(ring));
+	if (ring->xsk_umem)
+		ixgbe_alloc_rx_buffers_zc(ring, ixgbe_desc_unused(ring));
+	else
+		ixgbe_alloc_rx_buffers(ring, ixgbe_desc_unused(ring));
 }
 
 static void ixgbe_setup_psrtype(struct ixgbe_adapter *adapter)
@@ -5208,6 +5256,11 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 	u16 i = rx_ring->next_to_clean;
 	struct ixgbe_rx_buffer *rx_buffer = &rx_ring->rx_buffer_info[i];
 
+	if (rx_ring->xsk_umem) {
+		ixgbe_xsk_clean_rx_ring(rx_ring);
+		goto skip_free;
+	}
+
 	/* Free all the Rx ring sk_buffs */
 	while (i != rx_ring->next_to_alloc) {
 		if (rx_buffer->skb) {
@@ -5246,6 +5299,7 @@ static void ixgbe_clean_rx_ring(struct ixgbe_ring *rx_ring)
 		}
 	}
 
+skip_free:
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
@@ -6441,7 +6495,7 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 	struct device *dev = rx_ring->dev;
 	int orig_node = dev_to_node(dev);
 	int ring_node = -1;
-	int size, err;
+	int size;
 
 	size = sizeof(struct ixgbe_rx_buffer) * rx_ring->count;
 
@@ -6478,13 +6532,6 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 			     rx_ring->queue_index) < 0)
 		goto err;
 
-	err = xdp_rxq_info_reg_mem_model(&rx_ring->xdp_rxq,
-					 MEM_TYPE_PAGE_SHARED, NULL);
-	if (err) {
-		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-		goto err;
-	}
-
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
@@ -10200,6 +10247,13 @@ static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 		xdp->prog_id = adapter->xdp_prog ?
 			adapter->xdp_prog->aux->id : 0;
 		return 0;
+	case XDP_QUERY_XSK_UMEM:
+		return ixgbe_xsk_umem_query(adapter, &xdp->xsk.umem,
+					    xdp->xsk.queue_id);
+	case XDP_SETUP_XSK_UMEM:
+		return ixgbe_xsk_umem_setup(adapter, xdp->xsk.umem,
+					    xdp->xsk.queue_id);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index 3780d315b991..cf219f4e009d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -23,4 +23,19 @@ void ixgbe_rx_skb(struct ixgbe_q_vector *q_vector,
 void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring);
 void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring);
 
+struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
+				struct ixgbe_ring *ring);
+int ixgbe_xsk_umem_query(struct ixgbe_adapter *adapter, struct xdp_umem **umem,
+			 u16 qid);
+int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
+			 u16 qid);
+
+void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
+
+void ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 cleaned_count);
+int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
+			  struct ixgbe_ring *rx_ring,
+			  const int budget);
+void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring);
+
 #endif /* #define _IXGBE_TXRX_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
new file mode 100644
index 000000000000..61259036ff4b
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2018 Intel Corporation. */
+
+#include <linux/bpf_trace.h>
+#include <net/xdp_sock.h>
+#include <net/xdp.h>
+
+#include "ixgbe.h"
+#include "ixgbe_txrx_common.h"
+
+struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
+				struct ixgbe_ring *ring)
+{
+	bool xdp_on = READ_ONCE(adapter->xdp_prog);
+	int qid = ring->ring_idx;
+
+	if (!adapter->xsk_umems || !adapter->xsk_umems[qid] ||
+	    qid >= adapter->num_xsk_umems || !xdp_on)
+		return NULL;
+
+	return adapter->xsk_umems[qid];
+}
+
+static int ixgbe_alloc_xsk_umems(struct ixgbe_adapter *adapter)
+{
+	if (adapter->xsk_umems)
+		return 0;
+
+	adapter->num_xsk_umems_used = 0;
+	adapter->num_xsk_umems = adapter->num_rx_queues;
+	adapter->xsk_umems = kcalloc(adapter->num_xsk_umems,
+				     sizeof(*adapter->xsk_umems),
+				     GFP_KERNEL);
+	if (!adapter->xsk_umems) {
+		adapter->num_xsk_umems = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int ixgbe_add_xsk_umem(struct ixgbe_adapter *adapter,
+			      struct xdp_umem *umem,
+			      u16 qid)
+{
+	int err;
+
+	err = ixgbe_alloc_xsk_umems(adapter);
+	if (err)
+		return err;
+
+	adapter->xsk_umems[qid] = umem;
+	adapter->num_xsk_umems_used++;
+
+	return 0;
+}
+
+static void ixgbe_remove_xsk_umem(struct ixgbe_adapter *adapter, u16 qid)
+{
+	adapter->xsk_umems[qid] = NULL;
+	adapter->num_xsk_umems_used--;
+
+	if (adapter->num_xsk_umems == 0) {
+		kfree(adapter->xsk_umems);
+		adapter->xsk_umems = NULL;
+		adapter->num_xsk_umems = 0;
+	}
+}
+
+static int ixgbe_xsk_umem_dma_map(struct ixgbe_adapter *adapter,
+				  struct xdp_umem *umem)
+{
+	struct device *dev = &adapter->pdev->dev;
+	unsigned int i, j;
+	dma_addr_t dma;
+
+	for (i = 0; i < umem->npgs; i++) {
+		dma = dma_map_page_attrs(dev, umem->pgs[i], 0, PAGE_SIZE,
+					 DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
+		if (dma_mapping_error(dev, dma))
+			goto out_unmap;
+
+		umem->pages[i].dma = dma;
+	}
+
+	return 0;
+
+out_unmap:
+	for (j = 0; j < i; j++) {
+		dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
+				     DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
+		umem->pages[i].dma = 0;
+	}
+
+	return -1;
+}
+
+static void ixgbe_xsk_umem_dma_unmap(struct ixgbe_adapter *adapter,
+				     struct xdp_umem *umem)
+{
+	struct device *dev = &adapter->pdev->dev;
+	unsigned int i;
+
+	for (i = 0; i < umem->npgs; i++) {
+		dma_unmap_page_attrs(dev, umem->pages[i].dma, PAGE_SIZE,
+				     DMA_BIDIRECTIONAL, IXGBE_RX_DMA_ATTR);
+
+		umem->pages[i].dma = 0;
+	}
+}
+
+static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
+				 struct xdp_umem *umem,
+				 u16 qid)
+{
+	struct xdp_umem_fq_reuse *reuseq;
+	bool if_running;
+	int err;
+
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (adapter->xsk_umems) {
+		if (qid >= adapter->num_xsk_umems)
+			return -EINVAL;
+		if (adapter->xsk_umems[qid])
+			return -EBUSY;
+	}
+
+	reuseq = xsk_reuseq_prepare(adapter->rx_ring[0]->count);
+	if (!reuseq)
+		return -ENOMEM;
+
+	xsk_reuseq_free(xsk_reuseq_swap(umem, reuseq));
+
+	err = ixgbe_xsk_umem_dma_map(adapter, umem);
+	if (err)
+		return err;
+
+	if_running = netif_running(adapter->netdev) &&
+		     READ_ONCE(adapter->xdp_prog);
+
+	if (if_running)
+		ixgbe_txrx_ring_disable(adapter, qid);
+
+	err = ixgbe_add_xsk_umem(adapter, umem, qid);
+
+	if (if_running)
+		ixgbe_txrx_ring_enable(adapter, qid);
+
+	return err;
+}
+
+static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
+{
+	bool if_running;
+
+	if (!adapter->xsk_umems || qid >= adapter->num_xsk_umems ||
+	    !adapter->xsk_umems[qid])
+		return -EINVAL;
+
+	if_running = netif_running(adapter->netdev) &&
+		     READ_ONCE(adapter->xdp_prog);
+
+	if (if_running)
+		ixgbe_txrx_ring_disable(adapter, qid);
+
+	ixgbe_xsk_umem_dma_unmap(adapter, adapter->xsk_umems[qid]);
+	ixgbe_remove_xsk_umem(adapter, qid);
+
+	if (if_running)
+		ixgbe_txrx_ring_enable(adapter, qid);
+
+	return 0;
+}
+
+int ixgbe_xsk_umem_query(struct ixgbe_adapter *adapter, struct xdp_umem **umem,
+			 u16 qid)
+{
+	if (qid >= adapter->num_rx_queues)
+		return -EINVAL;
+
+	if (adapter->xsk_umems) {
+		if (qid >= adapter->num_xsk_umems)
+			return -EINVAL;
+		*umem = adapter->xsk_umems[qid];
+		return 0;
+	}
+
+	*umem = NULL;
+	return 0;
+}
+
+int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
+			 u16 qid)
+{
+	return umem ? ixgbe_xsk_umem_enable(adapter, umem, qid) :
+		ixgbe_xsk_umem_disable(adapter, qid);
+}
+
+static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
+			    struct ixgbe_ring *rx_ring,
+			    struct xdp_buff *xdp)
+{
+	int err, result = IXGBE_XDP_PASS;
+	struct bpf_prog *xdp_prog;
+	struct xdp_frame *xdpf;
+	u32 act;
+
+	rcu_read_lock();
+	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	xdp->handle += xdp->data - xdp->data_hard_start;
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		xdpf = convert_to_xdp_frame(xdp);
+		if (unlikely(!xdpf)) {
+			result = IXGBE_XDP_CONSUMED;
+			break;
+		}
+		result = ixgbe_xmit_xdp_ring(adapter, xdpf);
+		break;
+	case XDP_REDIRECT:
+		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
+		result = !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		/* fallthrough */
+	case XDP_ABORTED:
+		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		/* fallthrough -- handle aborts by dropping packet */
+	case XDP_DROP:
+		result = IXGBE_XDP_CONSUMED;
+		break;
+	}
+	rcu_read_unlock();
+	return result;
+}
+
+static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer_zc(
+	struct ixgbe_ring *rx_ring,
+	unsigned int size)
+{
+	struct ixgbe_rx_buffer *bi;
+
+	bi = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+
+	/* we are reusing so sync this buffer for CPU use */
+	dma_sync_single_range_for_cpu(rx_ring->dev,
+				      bi->dma, 0,
+				      size,
+				      DMA_BIDIRECTIONAL);
+
+	return bi;
+}
+
+static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
+				     struct ixgbe_rx_buffer *obi)
+{
+	unsigned long mask = (unsigned long)rx_ring->xsk_umem->chunk_mask;
+	u64 hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
+	u16 nta = rx_ring->next_to_alloc;
+	struct ixgbe_rx_buffer *nbi;
+
+	nbi = &rx_ring->rx_buffer_info[rx_ring->next_to_alloc];
+	/* update, and store next to alloc */
+	nta++;
+	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
+
+	/* transfer page from old buffer to new buffer */
+	nbi->dma = obi->dma & mask;
+	nbi->dma += hr;
+
+	nbi->addr = (void *)((unsigned long)obi->addr & mask);
+	nbi->addr += hr;
+
+	nbi->handle = obi->handle & mask;
+	nbi->handle += rx_ring->xsk_umem->headroom;
+
+	obi->addr = NULL;
+	obi->skb = NULL;
+}
+
+void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
+{
+	struct ixgbe_rx_buffer *bi;
+	struct ixgbe_ring *rx_ring;
+	u64 hr, mask;
+	u16 nta;
+
+	rx_ring = container_of(alloc, struct ixgbe_ring, zca);
+	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
+	mask = rx_ring->xsk_umem->chunk_mask;
+
+	nta = rx_ring->next_to_alloc;
+	bi = rx_ring->rx_buffer_info;
+
+	nta++;
+	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
+
+	handle &= mask;
+
+	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
+	bi->dma += hr;
+
+	bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
+	bi->addr += hr;
+
+	bi->handle = (u64)handle + rx_ring->xsk_umem->headroom;
+}
+
+static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
+				  struct ixgbe_rx_buffer *bi)
+{
+	struct xdp_umem *umem = rx_ring->xsk_umem;
+	void *addr = bi->addr;
+	u64 handle, hr;
+
+	if (addr)
+		return true;
+
+	if (!xsk_umem_peek_addr(umem, &handle)) {
+		rx_ring->rx_stats.alloc_rx_page_failed++;
+		return false;
+	}
+
+	hr = umem->headroom + XDP_PACKET_HEADROOM;
+
+	bi->dma = xdp_umem_get_dma(umem, handle);
+	bi->dma += hr;
+
+	bi->addr = xdp_umem_get_data(umem, handle);
+	bi->addr += hr;
+
+	bi->handle = handle + umem->headroom;
+
+	xsk_umem_discard_addr(umem);
+	return true;
+}
+
+static bool ixgbe_alloc_buffer_slow_zc(struct ixgbe_ring *rx_ring,
+				       struct ixgbe_rx_buffer *bi)
+{
+	struct xdp_umem *umem = rx_ring->xsk_umem;
+	u64 handle, hr;
+
+	if (!xsk_umem_peek_addr_rq(umem, &handle)) {
+		rx_ring->rx_stats.alloc_rx_page_failed++;
+		return false;
+	}
+
+	handle &= rx_ring->xsk_umem->chunk_mask;
+
+	hr = umem->headroom + XDP_PACKET_HEADROOM;
+
+	bi->dma = xdp_umem_get_dma(umem, handle);
+	bi->dma += hr;
+
+	bi->addr = xdp_umem_get_data(umem, handle);
+	bi->addr += hr;
+
+	bi->handle = handle + umem->headroom;
+
+	xsk_umem_discard_addr_rq(umem);
+	return true;
+}
+
+static __always_inline bool __ixgbe_alloc_rx_buffers_zc(
+	struct ixgbe_ring *rx_ring,
+	u16 cleaned_count,
+	bool alloc(struct ixgbe_ring *rx_ring,
+		   struct ixgbe_rx_buffer *bi))
+{
+	union ixgbe_adv_rx_desc *rx_desc;
+	struct ixgbe_rx_buffer *bi;
+	u16 i = rx_ring->next_to_use;
+	bool ok = true;
+
+	/* nothing to do */
+	if (!cleaned_count)
+		return true;
+
+	rx_desc = IXGBE_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		if (!alloc(rx_ring, bi)) {
+			ok = false;
+			break;
+		}
+
+		/* sync the buffer for use by the device */
+		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
+						 bi->page_offset,
+						 rx_ring->rx_buf_len,
+						 DMA_BIDIRECTIONAL);
+
+		/* Refresh the desc even if buffer_addrs didn't change
+		 * because each write-back erases this info.
+		 */
+		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma);
+
+		rx_desc++;
+		bi++;
+		i++;
+		if (unlikely(!i)) {
+			rx_desc = IXGBE_RX_DESC(rx_ring, 0);
+			bi = rx_ring->rx_buffer_info;
+			i -= rx_ring->count;
+		}
+
+		/* clear the length for the next_to_use descriptor */
+		rx_desc->wb.upper.length = 0;
+
+		cleaned_count--;
+	} while (cleaned_count);
+
+	i += rx_ring->count;
+
+	if (rx_ring->next_to_use != i) {
+		rx_ring->next_to_use = i;
+
+		/* update next to alloc since we have filled the ring */
+		rx_ring->next_to_alloc = i;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(i, rx_ring->tail);
+	}
+
+	return ok;
+}
+
+void ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 count)
+{
+	__ixgbe_alloc_rx_buffers_zc(rx_ring, count,
+				    ixgbe_alloc_buffer_slow_zc);
+}
+
+static bool ixgbe_alloc_rx_buffers_fast_zc(struct ixgbe_ring *rx_ring,
+					   u16 count)
+{
+	return __ixgbe_alloc_rx_buffers_zc(rx_ring, count,
+					   ixgbe_alloc_buffer_zc);
+}
+
+static struct sk_buff *ixgbe_construct_skb_zc(struct ixgbe_ring *rx_ring,
+					      struct ixgbe_rx_buffer *bi,
+					      struct xdp_buff *xdp)
+{
+	unsigned int metasize = xdp->data - xdp->data_meta;
+	unsigned int datasize = xdp->data_end - xdp->data;
+	struct sk_buff *skb;
+
+	/* allocate a skb to store the frags */
+	skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
+			       xdp->data_end - xdp->data_hard_start,
+			       GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	memcpy(__skb_put(skb, datasize), xdp->data, datasize);
+	if (metasize)
+		skb_metadata_set(skb, metasize);
+
+	ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+	return skb;
+}
+
+static void ixgbe_inc_ntc(struct ixgbe_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+	prefetch(IXGBE_RX_DESC(rx_ring, ntc));
+}
+
+int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
+			  struct ixgbe_ring *rx_ring,
+			  const int budget)
+{
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	struct ixgbe_adapter *adapter = q_vector->adapter;
+	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
+	unsigned int xdp_res, xdp_xmit = 0;
+	bool failure = false;
+	struct sk_buff *skb;
+	struct xdp_buff xdp;
+
+	xdp.rxq = &rx_ring->xdp_rxq;
+
+	while (likely(total_rx_packets < budget)) {
+		union ixgbe_adv_rx_desc *rx_desc;
+		struct ixgbe_rx_buffer *bi;
+		unsigned int size;
+
+		/* return some buffers to hardware, one@a time is too slow */
+		if (cleaned_count >= IXGBE_RX_BUFFER_WRITE) {
+			failure = failure ||
+				  !ixgbe_alloc_rx_buffers_fast_zc(
+					  rx_ring,
+					  cleaned_count);
+			cleaned_count = 0;
+		}
+
+		rx_desc = IXGBE_RX_DESC(rx_ring, rx_ring->next_to_clean);
+		size = le16_to_cpu(rx_desc->wb.upper.length);
+		if (!size)
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		dma_rmb();
+
+		bi = ixgbe_get_rx_buffer_zc(rx_ring, size);
+
+		if (unlikely(!ixgbe_test_staterr(rx_desc,
+						 IXGBE_RXD_STAT_EOP))) {
+			struct ixgbe_rx_buffer *next_bi;
+
+			ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+			ixgbe_inc_ntc(rx_ring);
+			next_bi = &rx_ring->rx_buffer_info[
+				rx_ring->next_to_clean];
+			next_bi->skb = ERR_PTR(-EINVAL);
+			continue;
+		}
+
+		if (unlikely(bi->skb)) {
+			ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+			ixgbe_inc_ntc(rx_ring);
+			continue;
+		}
+
+		xdp.data = bi->addr;
+		xdp.data_meta = xdp.data;
+		xdp.data_hard_start = xdp.data - XDP_PACKET_HEADROOM;
+		xdp.data_end = xdp.data + size;
+		xdp.handle = bi->handle;
+
+		xdp_res = ixgbe_run_xdp_zc(adapter, rx_ring, &xdp);
+
+		if (xdp_res) {
+			if (xdp_res & (IXGBE_XDP_TX | IXGBE_XDP_REDIR)) {
+				xdp_xmit |= xdp_res;
+				bi->addr = NULL;
+				bi->skb = NULL;
+			} else {
+				ixgbe_reuse_rx_buffer_zc(rx_ring, bi);
+			}
+			total_rx_packets++;
+			total_rx_bytes += size;
+
+			cleaned_count++;
+			ixgbe_inc_ntc(rx_ring);
+			continue;
+		}
+
+		/* XDP_PASS path */
+		skb = ixgbe_construct_skb_zc(rx_ring, bi, &xdp);
+		if (!skb) {
+			rx_ring->rx_stats.alloc_rx_buff_failed++;
+			break;
+		}
+
+		cleaned_count++;
+		ixgbe_inc_ntc(rx_ring);
+
+		if (eth_skb_pad(skb))
+			continue;
+
+		total_rx_bytes += skb->len;
+		total_rx_packets++;
+
+		ixgbe_process_skb_fields(rx_ring, rx_desc, skb);
+		ixgbe_rx_skb(q_vector, skb);
+	}
+
+	if (xdp_xmit & IXGBE_XDP_REDIR)
+		xdp_do_flush_map();
+
+	if (xdp_xmit & IXGBE_XDP_TX) {
+		struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.
+		 */
+		wmb();
+		writel(ring->next_to_use, ring->tail);
+	}
+
+	u64_stats_update_begin(&rx_ring->syncp);
+	rx_ring->stats.packets += total_rx_packets;
+	rx_ring->stats.bytes += total_rx_bytes;
+	u64_stats_update_end(&rx_ring->syncp);
+	q_vector->rx.total_packets += total_rx_packets;
+	q_vector->rx.total_bytes += total_rx_bytes;
+
+	return failure ? budget : (int)total_rx_packets;
+}
+
+void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
+{
+	u16 i = rx_ring->next_to_clean;
+	struct ixgbe_rx_buffer *bi = &rx_ring->rx_buffer_info[i];
+
+	while (i != rx_ring->next_to_alloc) {
+		xsk_umem_fq_reuse(rx_ring->xsk_umem, bi->handle);
+		i++;
+		bi++;
+		if (i == rx_ring->count) {
+			i = 0;
+			bi = rx_ring->rx_buffer_info;
+		}
+	}
+}
-- 
2.17.1

