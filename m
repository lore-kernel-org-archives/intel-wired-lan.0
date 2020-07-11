From: Yahui Chen <goodluckwillcomesoon@gmail.com>
Date: Sat, 11 Jul 2020 18:10:38 +0800
Subject: [Intel-wired-lan] [PATCH] xsk: ixgbe: solve the soft interrupt 100%
 CPU usage when xdp rx traffic congestion
Message-ID: <1594462239-19596-1-git-send-email-goodluckwillcomesoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the user mode APP of drv-mode xsk does not process packets fast enough,
the packet receiving speed is lower than the flow rate. For example, the
flow rate is 1Mpps, and the APP processing speed is 10Kpss only, this will
cause a series of problems:

1. If the APP doesn't use wakeup mechanism, in other world, the
`XDP_UMEM_USES_NEED_WAKEUP` flag is not set. Then the CPU usage of the
soft interrupt corresponding to the network card queue using xsk has
always been 100%. The reason is that the APP is slow to receive packets,
the packet desc can not return to the fill queue in time, resulting in
`ixgbe_alloc_rx_buffers_zc` fail to obtain the desc, so
`ixgbe_clean_rx_irq_zc` returns 64, which further causes its corresponding
NAPI to be always running status, so the CPU has been busy performing soft
interrupts.

2. If the wakeup mechanism is used, that is, use the
`XDP_UMEM_USES_NEED_WAKEUP` flag. This method takes advantage of the
interrupt delay function of ixgbe skillfully, thus solving the problem
that the si CPU is always 100%. However, it will cause other problems.
The port-level flow control will be triggered on 82599, and the pause
frame will be sent to the upstream sender. This will affect the other
packet receiving queues of the network card, resulting in the packet
receiving rate of all queues dropping to 10Kpps.

This situation can be understood as rx traffic congestion. The reason of
congestion is that XSK queue cannot get DMA address in time, so packet
cannot be delivered to the host memory which result in packets congestion
happening on the hardware FIFO. If the number of packets exceeds the FIFO
waterline, the network card will send pause frames.

This patch design another way. When the queue corresponding to xsk is
initializing, a piece of DMA memory, named congestion memory, is applied
for traffic congestion. If failing to obtain the desc from the fill queue,
point the xsk ring packet DMA address to the congestion memory. Let the
network card hardware DMA the packet to the congetion memory, and the APP
will not receive packet from the congestion memory. This way can solve the
two problems mentioned above. However, the wakeup mechanism should also be
retained. When the network card has only one queue, the wakeup mechanism
will have advantages.

TODO:
Apply this modification to all drivers that support xsk drv mode

Signed-off-by: Yahui Chen <goodluckwillcomesoon@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h     |  3 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 61 ++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5ddfc83..33601c1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -351,6 +351,9 @@ struct ixgbe_ring {
 	};
 	struct xdp_rxq_info xdp_rxq;
 	struct xdp_umem *xsk_umem;
+#define XDP_CONGESTION_MEM_SIZE	(4096)
+	void *congestion_addr;		/* address of buffer when traffic congestion */
+	dma_addr_t congestion_dma;	/* dma address of packet when traffic congestion */
 	u16 ring_idx;		/* {rx,tx,xdp}_ring back reference idx */
 	u16 rx_buf_len;
 } ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index be9d2a8..f4a8237 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -27,6 +27,8 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 	struct net_device *netdev = adapter->netdev;
 	bool if_running;
 	int err;
+	int size = XDP_CONGESTION_MEM_SIZE;
+	struct ixgbe_ring *rx_ring;
 
 	if (qid >= adapter->num_rx_queues)
 		return -EINVAL;
@@ -49,6 +51,21 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 
 	if (if_running) {
 		ixgbe_txrx_ring_enable(adapter, qid);
+		rx_ring->congestion_addr = kmalloc(size, GFP_DMA | GFP_KERNEL);
+		if (!rx_ring->congestion_addr) {
+			rx_ring->congestion_addr = kmalloc(size, GFP_DMA | GFP_KERNEL);
+			if (!rx_ring->congestion_addr)
+				return -ENOMEM;
+		}
+		rx_ring = adapter->rx_ring[qid];
+		rx_ring->congestion_dma = dma_map_single(rx_ring->dev, rx_ring->congestion_addr,
+							 size,
+							 DMA_FROM_DEVICE);
+		/* sync the buffer for use by the device */
+		dma_sync_single_range_for_device(rx_ring->dev, rx_ring->congestion_dma,
+						 0,
+						 size,
+						 DMA_FROM_DEVICE);
 
 		/* Kick start the NAPI context so that receiving will start */
 		err = ixgbe_xsk_wakeup(adapter->netdev, qid, XDP_WAKEUP_RX);
@@ -63,6 +80,8 @@ static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 {
 	struct xdp_umem *umem;
 	bool if_running;
+	int size = XDP_CONGESTION_MEM_SIZE;
+	struct ixgbe_ring *rx_ring;
 
 	umem = xdp_get_umem_from_qid(adapter->netdev, qid);
 	if (!umem)
@@ -71,9 +90,18 @@ static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 	if_running = netif_running(adapter->netdev) &&
 		     ixgbe_enabled_xdp_adapter(adapter);
 
-	if (if_running)
+	if (if_running) {
 		ixgbe_txrx_ring_disable(adapter, qid);
 
+		rx_ring = adapter->rx_ring[qid];
+		dma_sync_single_range_for_cpu(rx_ring->dev, rx_ring->congestion_dma,
+					      0,
+					      size,
+					      DMA_FROM_DEVICE);
+		dma_unmap_single(rx_ring->dev, rx_ring->congestion_addr, size, DMA_FROM_DEVICE);
+		kfree(rx_ring->congestion_addr);
+	}
+
 	clear_bit(qid, adapter->af_xdp_zc_qps);
 	xsk_buff_dma_unmap(umem, IXGBE_RX_DMA_ATTR);
 
@@ -152,10 +180,12 @@ bool ixgbe_alloc_rx_buffers_zc(struct ixgbe_ring *rx_ring, u16 count)
 		bi->xdp = xsk_buff_alloc(rx_ring->xsk_umem);
 		if (!bi->xdp) {
 			ok = false;
-			break;
+			/* rx traffic congestion, we do not use umem DMA address */
+			dma = rx_ring->congestion_dma;
+		} else {
+			dma = xsk_buff_xdp_get_dma(bi->xdp);
 		}
 
-		dma = xsk_buff_xdp_get_dma(bi->xdp);
 
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
@@ -231,14 +261,15 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 			  struct ixgbe_ring *rx_ring,
 			  const int budget)
 {
-	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0,
+			handled_bytes = 0, handled_packets = 0;
 	struct ixgbe_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
 	unsigned int xdp_res, xdp_xmit = 0;
 	bool failure = false;
 	struct sk_buff *skb;
 
-	while (likely(total_rx_packets < budget)) {
+	while (likely(handled_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *bi;
 		unsigned int size;
@@ -263,6 +294,16 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		dma_rmb();
 
 		bi = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+		/* rx traffic congestion, ignore this packet */
+		if (unlikely(!bi->xdp)) {
+			handled_packets++;
+			handled_bytes += size;
+
+			cleaned_count++;
+			ixgbe_inc_ntc(rx_ring);
+			continue;
+		}
+
 
 		if (unlikely(!ixgbe_test_staterr(rx_desc,
 						 IXGBE_RXD_STAT_EOP))) {
@@ -296,6 +337,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 				xsk_buff_free(bi->xdp);
 
 			bi->xdp = NULL;
+			handled_packets++;
+			handled_bytes += size;
 			total_rx_packets++;
 			total_rx_bytes += size;
 
@@ -317,6 +360,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 		if (eth_skb_pad(skb))
 			continue;
 
+		handled_packets++;
+		handled_bytes += size;
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
 
@@ -341,8 +386,8 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 	rx_ring->stats.packets += total_rx_packets;
 	rx_ring->stats.bytes += total_rx_bytes;
 	u64_stats_update_end(&rx_ring->syncp);
-	q_vector->rx.total_packets += total_rx_packets;
-	q_vector->rx.total_bytes += total_rx_bytes;
+	q_vector->rx.total_packets += handled_packets;
+	q_vector->rx.total_bytes += handled_bytes;
 
 	if (xsk_umem_uses_need_wakeup(rx_ring->xsk_umem)) {
 		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
@@ -352,7 +397,7 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 
 		return (int)total_rx_packets;
 	}
-	return failure ? budget : (int)total_rx_packets;
+	return (int)handled_packets;
 }
 
 void ixgbe_xsk_clean_rx_ring(struct ixgbe_ring *rx_ring)
-- 
1.8.3.1

