From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 13 Dec 2017 12:19:41 +0100
Subject: [Intel-wired-lan] [bpf-next V1-RFC PATCH 04/14] ixgbe: setup
 xdp_rxq_info
In-Reply-To: <151316391502.14967.13292358380181773729.stgit@firesoul>
References: <151316391502.14967.13292358380181773729.stgit@firesoul>
Message-ID: <151316398126.14967.887673126253612847.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Driver hook points for xdp_rxq_info:
 * init+reg: ixgbe_setup_rx_resources()
 * unreg   : ixgbe_free_rx_resources()

Cc: intel-wired-lan at lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 468c3555a629..8611763d6129 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -53,6 +53,7 @@
 #include <linux/dca.h>
 #endif
 
+#include <net/xdp.h>
 #include <net/busy_poll.h>
 
 /* common prefix used by pr_<> macros */
@@ -371,6 +372,7 @@ struct ixgbe_ring {
 		struct ixgbe_tx_queue_stats tx_stats;
 		struct ixgbe_rx_queue_stats rx_stats;
 	};
+	struct xdp_rxq_info xdp_rxq;
 } ____cacheline_internodealigned_in_smp;
 
 enum ixgbe_ring_f_enum {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7737a05c717c..2a8196427776 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2318,12 +2318,14 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 #endif /* IXGBE_FCOE */
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
 	bool xdp_xmit = false;
+	struct xdp_buff xdp;
+
+	xdp.rxq = &rx_ring->xdp_rxq;
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
 		struct ixgbe_rx_buffer *rx_buffer;
 		struct sk_buff *skb;
-		struct xdp_buff xdp;
 		unsigned int size;
 
 		/* return some buffers to hardware, one@a time is too slow */
@@ -6444,6 +6446,12 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
+	/* XDP RX-queue info */
+	xdp_rxq_info_init(&rx_ring->xdp_rxq);
+	rx_ring->xdp_rxq.dev         = adapter->netdev;
+	rx_ring->xdp_rxq.queue_index = rx_ring->queue_index;
+	xdp_rxq_info_reg(&rx_ring->xdp_rxq);
+
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
@@ -6541,6 +6549,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
 	ixgbe_clean_rx_ring(rx_ring);
 
 	rx_ring->xdp_prog = NULL;
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 

