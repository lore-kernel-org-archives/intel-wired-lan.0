From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 26 Feb 2018 13:37:41 -0800
Subject: [Intel-wired-lan] [RFC PATCH 1/5] ixgbevf: Add XDP support for pass
 and drop actions
In-Reply-To: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
References: <20180226213745.14508-1-anthony.l.nguyen@intel.com>
Message-ID: <20180226213745.14508-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Implement XDP_PASS and XDP_DROP based on the ixgbe implementation.

Based largely on commit 924708081629 ("ixgbe: add XDP support for pass and
drop actions").

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |   9 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  10 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 201 ++++++++++++++++++----
 3 files changed, 178 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index e7623fed42da..4946a62c70a4 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
-  Copyright(c) 1999 - 2015 Intel Corporation.
+  Copyright(c) 1999 - 2018 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -336,8 +336,13 @@ static int ixgbevf_set_ringparam(struct net_device *netdev,
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			/* clone ring and setup updated count */
 			rx_ring[i] = *adapter->rx_ring[i];
+
+			/* Clear copied XDP RX-queue info */
+			memset(&rx_ring[i].xdp_rxq, 0,
+			       sizeof(rx_ring[i].xdp_rxq));
+
 			rx_ring[i].count = new_rx_count;
-			err = ixgbevf_setup_rx_resources(&rx_ring[i]);
+			err = ixgbevf_setup_rx_resources(adapter, &rx_ring[i]);
 			if (err) {
 				while (i) {
 					i--;
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index d27369ce893a..cf846143e886 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -2,7 +2,7 @@
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
-  Copyright(c) 1999 - 2015 Intel Corporation.
+  Copyright(c) 1999 - 2018 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -35,6 +35,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/u64_stats_sync.h>
+#include <net/xdp.h>
 
 #include "vf.h"
 
@@ -100,6 +101,7 @@ struct ixgbevf_ring {
 	struct ixgbevf_ring *next;
 	struct ixgbevf_q_vector *q_vector;	/* backpointer to q_vector */
 	struct net_device *netdev;
+	struct bpf_prog *xdp_prog;
 	struct device *dev;
 	void *desc;			/* descriptor ring memory */
 	dma_addr_t dma;			/* phys. address of descriptor ring */
@@ -120,7 +122,7 @@ struct ixgbevf_ring {
 		struct ixgbevf_tx_queue_stats tx_stats;
 		struct ixgbevf_rx_queue_stats rx_stats;
 	};
-
+	struct xdp_rxq_info xdp_rxq;
 	u64 hw_csum_rx_error;
 	u8 __iomem *tail;
 	struct sk_buff *skb;
@@ -357,6 +359,7 @@ struct ixgbevf_adapter {
 
 	/* OS defined structs */
 	struct net_device *netdev;
+	struct bpf_prog *xdp_prog;
 	struct pci_dev *pdev;
 
 	/* structs defined in ixgbe_vf.h */
@@ -443,7 +446,8 @@ void ixgbevf_down(struct ixgbevf_adapter *adapter);
 void ixgbevf_reinit_locked(struct ixgbevf_adapter *adapter);
 void ixgbevf_reset(struct ixgbevf_adapter *adapter);
 void ixgbevf_set_ethtool_ops(struct net_device *netdev);
-int ixgbevf_setup_rx_resources(struct ixgbevf_ring *);
+int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
+			       struct ixgbevf_ring *rx_ring);
 int ixgbevf_setup_tx_resources(struct ixgbevf_ring *);
 void ixgbevf_free_rx_resources(struct ixgbevf_ring *);
 void ixgbevf_free_tx_resources(struct ixgbevf_ring *);
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 4c7264ff1919..3e09add02ce8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 82599 Virtual Function driver
-  Copyright(c) 1999 - 2015 Intel Corporation.
+  Copyright(c) 1999 - 2018 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -50,6 +50,9 @@
 #include <linux/if_vlan.h>
 #include <linux/prefetch.h>
 #include <net/mpls.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
+#include <linux/atomic.h>
 
 #include "ixgbevf.h"
 
@@ -552,19 +555,21 @@ struct ixgbevf_rx_buffer *ixgbevf_get_rx_buffer(struct ixgbevf_ring *rx_ring,
 }
 
 static void ixgbevf_put_rx_buffer(struct ixgbevf_ring *rx_ring,
-				  struct ixgbevf_rx_buffer *rx_buffer)
+				  struct ixgbevf_rx_buffer *rx_buffer,
+				  struct sk_buff *skb)
 {
 	if (ixgbevf_can_reuse_rx_page(rx_buffer)) {
 		/* hand second half of page back to the ring */
 		ixgbevf_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		/* We are not reusing the buffer so unmap it and free
-		 * any references we are holding to it
-		 */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
-				     ixgbevf_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE,
-				     IXGBEVF_RX_DMA_ATTR);
+		if (IS_ERR(skb))
+			/* We are not reusing the buffer so unmap it and free
+			 * any references we are holding to it
+			 */
+			dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
+					     ixgbevf_rx_pg_size(rx_ring),
+					     DMA_FROM_DEVICE,
+					     IXGBEVF_RX_DMA_ATTR);
 		__page_frag_cache_drain(rx_buffer->page,
 					rx_buffer->pagecnt_bias);
 	}
@@ -737,6 +742,10 @@ static bool ixgbevf_cleanup_headers(struct ixgbevf_ring *rx_ring,
 				    union ixgbe_adv_rx_desc *rx_desc,
 				    struct sk_buff *skb)
 {
+	/* XDP packets use error pointer so abort at this point */
+	if (IS_ERR(skb))
+		return true;
+
 	/* verify that the packet does not have any known errors */
 	if (unlikely(ixgbevf_test_staterr(rx_desc,
 					  IXGBE_RXDADV_ERR_FRAME_ERR_MASK))) {
@@ -853,22 +862,23 @@ static void ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 static
 struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 				      struct ixgbevf_rx_buffer *rx_buffer,
-				      union ixgbe_adv_rx_desc *rx_desc,
-				      unsigned int size)
+				      struct xdp_buff *xdp,
+				      union ixgbe_adv_rx_desc *rx_desc)
 {
-	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	unsigned int size = xdp->data_end - xdp->data;
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = SKB_DATA_ALIGN(size);
+	unsigned int truesize = SKB_DATA_ALIGN(xdp->data_end -
+					       xdp->data_hard_start);
 #endif
 	unsigned int headlen;
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
-	prefetch(va);
+	prefetch(xdp->data);
 #if L1_CACHE_BYTES < 128
-	prefetch(va + L1_CACHE_BYTES);
+	prefetch(xdp->data + L1_CACHE_BYTES);
 #endif
 
 	/* allocate a skb to store the frags */
@@ -879,16 +889,18 @@ struct sk_buff *ixgbevf_construct_skb(struct ixgbevf_ring *rx_ring,
 	/* Determine available headroom for copy */
 	headlen = size;
 	if (headlen > IXGBEVF_RX_HDR_SIZE)
-		headlen = eth_get_headlen(va, IXGBEVF_RX_HDR_SIZE);
+		headlen = eth_get_headlen(xdp->data, IXGBEVF_RX_HDR_SIZE);
 
 	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen), va, ALIGN(headlen, sizeof(long)));
+	memcpy(__skb_put(skb, headlen), xdp->data,
+	       ALIGN(headlen, sizeof(long)));
 
 	/* update all of the pointers */
 	size -= headlen;
 	if (size) {
 		skb_add_rx_frag(skb, 0, rx_buffer->page,
-				(va + headlen) - page_address(rx_buffer->page),
+				(xdp->data + headlen) -
+					page_address(rx_buffer->page),
 				size, truesize);
 #if (PAGE_SIZE < 8192)
 		rx_buffer->page_offset ^= truesize;
@@ -912,32 +924,32 @@ static inline void ixgbevf_irq_enable_queues(struct ixgbevf_adapter *adapter,
 
 static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 					 struct ixgbevf_rx_buffer *rx_buffer,
-					 union ixgbe_adv_rx_desc *rx_desc,
-					 unsigned int size)
+					 struct xdp_buff *xdp,
+					 union ixgbe_adv_rx_desc *rx_desc)
 {
-	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
 #else
 	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
-				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size);
+				SKB_DATA_ALIGN(xdp->data_end -
+					       xdp->data_hard_start);
 #endif
 	struct sk_buff *skb;
 
 	/* prefetch first cache line of first page */
-	prefetch(va);
+	prefetch(xdp->data);
 #if L1_CACHE_BYTES < 128
-	prefetch(va + L1_CACHE_BYTES);
+	prefetch(xdp->data + L1_CACHE_BYTES);
 #endif
 
-	/* build an skb to around the page buffer */
-	skb = build_skb(va - IXGBEVF_SKB_PAD, truesize);
+	/* build an skb around the page buffer */
+	skb = build_skb(xdp->data_hard_start, truesize);
 	if (unlikely(!skb))
 		return NULL;
 
 	/* update pointers within the skb to store the data */
-	skb_reserve(skb, IXGBEVF_SKB_PAD);
-	__skb_put(skb, size);
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
 
 	/* update buffer offset */
 #if (PAGE_SIZE < 8192)
@@ -948,6 +960,43 @@ static struct sk_buff *ixgbevf_build_skb(struct ixgbevf_ring *rx_ring,
 
 	return skb;
 }
+
+#define IXGBEVF_XDP_PASS 0
+#define IXGBEVF_XDP_CONSUMED 1
+
+static struct sk_buff *ixgbevf_run_xdp(struct ixgbevf_ring  *rx_ring,
+				       struct xdp_buff *xdp)
+{
+	int result = IXGBEVF_XDP_PASS;
+	struct bpf_prog *xdp_prog;
+	u32 act;
+
+	rcu_read_lock();
+	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
+
+	if (!xdp_prog)
+		goto xdp_out;
+
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	switch (act) {
+	case XDP_PASS:
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(act);
+		/* fallthrough */
+	case XDP_TX:
+	case XDP_ABORTED:
+		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
+		/* fallthrough -- handle aborts by dropping packet */
+	case XDP_DROP:
+		result = IXGBEVF_XDP_CONSUMED;
+		break;
+	}
+xdp_out:
+	rcu_read_unlock();
+	return ERR_PTR(-result);
+}
+
 static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 				struct ixgbevf_ring *rx_ring,
 				int budget)
@@ -955,10 +1004,13 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = ixgbevf_desc_unused(rx_ring);
 	struct sk_buff *skb = rx_ring->skb;
+	struct xdp_buff xdp;
+
+	xdp.rxq = &rx_ring->xdp_rxq;
 
 	while (likely(total_rx_packets < budget)) {
-		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbevf_rx_buffer *rx_buffer;
+		union ixgbe_adv_rx_desc *rx_desc;
 		unsigned int size;
 
 		/* return some buffers to hardware, one@a time is too slow */
@@ -981,14 +1033,30 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 		rx_buffer = ixgbevf_get_rx_buffer(rx_ring, size);
 
 		/* retrieve a buffer from the ring */
-		if (skb)
+		if (!skb) {
+			xdp.data = page_address(rx_buffer->page) +
+				   rx_buffer->page_offset;
+			xdp_set_data_meta_invalid(&xdp);
+			xdp.data_hard_start = xdp.data -
+					      ixgbevf_rx_offset(rx_ring);
+			xdp.data_end = xdp.data + size;
+
+			skb = ixgbevf_run_xdp(rx_ring, &xdp);
+		}
+
+		if (IS_ERR(skb)) {
+			total_rx_packets++;
+			total_rx_bytes += size;
+			rx_buffer->pagecnt_bias++;
+		} else if (skb) {
 			ixgbevf_add_rx_frag(rx_ring, rx_buffer, skb, size);
-		else if (ring_uses_build_skb(rx_ring))
+		} else if (ring_uses_build_skb(rx_ring)) {
 			skb = ixgbevf_build_skb(rx_ring, rx_buffer,
-						rx_desc, size);
-		else
+						&xdp, rx_desc);
+		} else {
 			skb = ixgbevf_construct_skb(rx_ring, rx_buffer,
-						    rx_desc, size);
+						    &xdp, rx_desc);
+		}
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
@@ -997,7 +1065,7 @@ static int ixgbevf_clean_rx_irq(struct ixgbevf_q_vector *q_vector,
 			break;
 		}
 
-		ixgbevf_put_rx_buffer(rx_ring, rx_buffer);
+		ixgbevf_put_rx_buffer(rx_ring, rx_buffer, skb);
 		cleaned_count++;
 
 		/* fetch next buffer in frame if non-eop */
@@ -3159,11 +3227,13 @@ static int ixgbevf_setup_all_tx_resources(struct ixgbevf_adapter *adapter)
 
 /**
  * ixgbevf_setup_rx_resources - allocate Rx resources (Descriptors)
+ * @adapter: board private structure
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
  *
  * Returns 0 on success, negative on failure
  **/
-int ixgbevf_setup_rx_resources(struct ixgbevf_ring *rx_ring)
+int ixgbevf_setup_rx_resources(struct ixgbevf_adapter *adapter,
+			       struct ixgbevf_ring *rx_ring)
 {
 	int size;
 
@@ -3184,6 +3254,13 @@ int ixgbevf_setup_rx_resources(struct ixgbevf_ring *rx_ring)
 	if (!rx_ring->desc)
 		goto err;
 
+	/* XDP RX-queue info */
+	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
+			     rx_ring->queue_index) < 0)
+		goto err;
+
+	rx_ring->xdp_prog = adapter->xdp_prog;
+
 	return 0;
 err:
 	vfree(rx_ring->rx_buffer_info);
@@ -3207,7 +3284,7 @@ static int ixgbevf_setup_all_rx_resources(struct ixgbevf_adapter *adapter)
 	int i, err = 0;
 
 	for (i = 0; i < adapter->num_rx_queues; i++) {
-		err = ixgbevf_setup_rx_resources(adapter->rx_ring[i]);
+		err = ixgbevf_setup_rx_resources(adapter, adapter->rx_ring[i]);
 		if (!err)
 			continue;
 		hw_dbg(&adapter->hw, "Allocation for Rx Queue %u failed\n", i);
@@ -3232,6 +3309,8 @@ void ixgbevf_free_rx_resources(struct ixgbevf_ring *rx_ring)
 {
 	ixgbevf_clean_rx_ring(rx_ring);
 
+	rx_ring->xdp_prog = NULL;
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 
@@ -3918,6 +3997,12 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN;
 	int ret;
 
+	/* prevent MTU being changed to a size unsupported by XDP */
+	if (adapter->xdp_prog) {
+		dev_warn(&adapter->pdev->dev, "MTU cannot be changed while XDP program is loaded\n");
+		return -EPERM;
+	}
+
 	spin_lock_bh(&adapter->mbx_lock);
 	/* notify the PF of our intent to use this size of frame */
 	ret = hw->mac.ops.set_rlpml(hw, max_frame);
@@ -4101,6 +4186,47 @@ ixgbevf_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
+static int ixgbevf_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
+{
+	int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	struct ixgbevf_adapter *adapter = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+
+	/* verify ixgbevf ring attributes are sufficient for XDP */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct ixgbevf_ring *ring = adapter->rx_ring[i];
+
+		if (frame_size > ixgbevf_rx_bufsz(ring))
+			return -EINVAL;
+	}
+
+	old_prog = xchg(&adapter->xdp_prog, prog);
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+
+static int ixgbevf_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct ixgbevf_adapter *adapter = netdev_priv(dev);
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return ixgbevf_xdp_setup(dev, xdp->prog);
+	case XDP_QUERY_PROG:
+		xdp->prog_attached = !!(adapter->xdp_prog);
+		xdp->prog_id = adapter->xdp_prog ?
+			       adapter->xdp_prog->aux->id : 0;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops ixgbevf_netdev_ops = {
 	.ndo_open		= ixgbevf_open,
 	.ndo_stop		= ixgbevf_close,
@@ -4117,6 +4243,7 @@ static const struct net_device_ops ixgbevf_netdev_ops = {
 	.ndo_poll_controller	= ixgbevf_netpoll,
 #endif
 	.ndo_features_check	= ixgbevf_features_check,
+	.ndo_bpf		= ixgbevf_xdp,
 };
 
 static void ixgbevf_assign_netdev_ops(struct net_device *dev)
-- 
2.13.6

