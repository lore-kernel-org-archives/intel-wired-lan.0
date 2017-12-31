From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Sun, 31 Dec 2017 12:01:14 +0100
Subject: [Intel-wired-lan] [bpf-next V3 PATCH 04/14] ixgbe: setup
 xdp_rxq_info
In-Reply-To: <151471801977.30703.3258796879718706203.stgit@firesoul>
References: <151471801977.30703.3258796879718706203.stgit@firesoul>
Message-ID: <151471807446.30703.4168486082134598062.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Driver hook points for xdp_rxq_info:
 * reg  : ixgbe_setup_rx_resources()
 * unreg: ixgbe_free_rx_resources()

Tested on actual hardware.

V2: Fix ixgbe_set_ringparam, clear xdp_rxq_info in temp_ring

Cc: intel-wired-lan at lists.osuosl.org
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   10 +++++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

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
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0aad1c2a3667..0aaf70b3cfcd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1156,6 +1156,10 @@ static int ixgbe_set_ringparam(struct net_device *netdev,
 			memcpy(&temp_ring[i], adapter->rx_ring[i],
 			       sizeof(struct ixgbe_ring));
 
+			/* Clear copied XDP RX-queue info */
+			memset(&temp_ring[i].xdp_rxq, 0,
+			       sizeof(temp_ring[i].xdp_rxq));
+
 			temp_ring[i].count = new_rx_count;
 			err = ixgbe_setup_rx_resources(adapter, &temp_ring[i]);
 			if (err) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7737a05c717c..95aba975b391 100644
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
@@ -6444,6 +6446,11 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
+	/* XDP RX-queue info */
+	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
+			     rx_ring->queue_index) < 0)
+		goto err;
+
 	rx_ring->xdp_prog = adapter->xdp_prog;
 
 	return 0;
@@ -6541,6 +6548,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
 	ixgbe_clean_rx_ring(rx_ring);
 
 	rx_ring->xdp_prog = NULL;
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 

