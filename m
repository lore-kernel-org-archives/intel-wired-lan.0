From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 13 Dec 2017 12:19:36 +0100
Subject: [Intel-wired-lan] [bpf-next V1-RFC PATCH 03/14] i40e: setup
 xdp_rxq_info
In-Reply-To: <151316391502.14967.13292358380181773729.stgit@firesoul>
References: <151316391502.14967.13292358380181773729.stgit@firesoul>
Message-ID: <151316397618.14967.13648763339440521538.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The i40e driver have a special "FDIR" RX-ring (I40E_VSI_FDIR) which is
a sideband channel for configuring/updating the flow director tables.
This (i40e_vsi_)type does not invoke XDP-ebpf code. Thus, mark this
type as a XDP RX-queue type RXQ_TYPE_SINK.

Driver hook points for xdp_rxq_info:
 * init+reg: i40e_setup_rx_descriptors (via i40e_vsi_setup_rx_resources)
 * unreg   : i40e_free_rx_resources    (via i40e_vsi_free_rx_resources)

Tested on actual hardware with samples/bpf program.

Cc: intel-wired-lan at lists.osuosl.org
Cc: Bj?rn T?pel <bjorn.topel@intel.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |   18 +++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |    3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4566d66ffc7c..d1bfc4232ca9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -27,6 +27,7 @@
 #include <linux/prefetch.h>
 #include <net/busy_poll.h>
 #include <linux/bpf_trace.h>
+#include <net/xdp.h>
 #include "i40e.h"
 #include "i40e_trace.h"
 #include "i40e_prototype.h"
@@ -1236,6 +1237,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 {
 	i40e_clean_rx_ring(rx_ring);
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	rx_ring->xdp_prog = NULL;
 	kfree(rx_ring->rx_bi);
 	rx_ring->rx_bi = NULL;
@@ -1283,6 +1285,18 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
 
+	/* XDP RX-queue info */
+	xdp_rxq_info_init(&rx_ring->xdp_rxq);
+
+	/* Flow director side channel does not invoke XDP/bpf */
+	if (rx_ring->vsi->type == I40E_VSI_FDIR)
+		xdp_rxq_info_type(&rx_ring->xdp_rxq, RXQ_TYPE_SINK);
+	else
+		rx_ring->xdp_rxq.dev = rx_ring->netdev;
+
+	rx_ring->xdp_rxq.queue_index = rx_ring->queue_index;
+	xdp_rxq_info_reg(&rx_ring->xdp_rxq);
+
 	rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
 
 	return 0;
@@ -2068,11 +2082,13 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
 	bool failure = false, xdp_xmit = false;
+	struct xdp_buff xdp;
+
+	xdp.rxq = &rx_ring->xdp_rxq;
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		struct i40e_rx_buffer *rx_buffer;
 		union i40e_rx_desc *rx_desc;
-		struct xdp_buff xdp;
 		unsigned int size;
 		u16 vlan_tag;
 		u8 rx_ptype;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index fbae1182e2ea..2d08760fc4ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -27,6 +27,8 @@
 #ifndef _I40E_TXRX_H_
 #define _I40E_TXRX_H_
 
+#include <net/xdp.h>
+
 /* Interrupt Throttling and Rate Limiting Goodies */
 
 #define I40E_MAX_ITR               0x0FF0  /* reg uses 2 usec resolution */
@@ -428,6 +430,7 @@ struct i40e_ring {
 					 */
 
 	struct i40e_channel *ch;
+	struct xdp_rxq_info xdp_rxq;
 } ____cacheline_internodealigned_in_smp;
 
 static inline bool ring_uses_build_skb(struct i40e_ring *ring)

