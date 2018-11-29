From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Thu, 29 Nov 2018 15:00:46 +0100
Subject: [Intel-wired-lan] [PATCH net v2 1/2] i40e: fix VLAN.TCI == 0 RX HW
 offload
Message-ID: <3a2cea2209c06825a29f6a1ef457e2882cb0e935.1543499947.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes two bugs in hardware VLAN offload:
 1. VLAN.TCI == 0 was being dropped
 2. there was a race between disabling of VLAN RX feature in hardware
    and processing RX queue, where packets processed in this window
    could have their VLAN information dropped

Fix moves the VLAN handling into i40e_process_skb_fields() to save on
duplicated code. i40e_receive_skb() becomes trivial and so is removed.

Signed-off-by: Micha? Miros?aw <michal.miroslaw@atendesoftware.pl>
Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
v2:
 * no changes
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 30 +++++--------------
 .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  6 +---
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index aef3c89ee79c..2cd69c65d722 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1558,24 +1558,6 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
 	return true;
 }
 
-/**
- * i40e_receive_skb - Send a completed packet up the stack
- * @rx_ring:  rx ring in play
- * @skb: packet to send up
- * @vlan_tag: vlan tag for packet
- **/
-void i40e_receive_skb(struct i40e_ring *rx_ring,
-		      struct sk_buff *skb, u16 vlan_tag)
-{
-	struct i40e_q_vector *q_vector = rx_ring->q_vector;
-
-	if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
-	    (vlan_tag & VLAN_VID_MASK))
-		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
-
-	napi_gro_receive(&q_vector->napi, skb);
-}
-
 /**
  * i40e_alloc_rx_buffers - Replace used receive buffers
  * @rx_ring: ring to place buffers on
@@ -1812,6 +1794,12 @@ void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 
 	skb_record_rx_queue(skb, rx_ring->queue_index);
 
+	if (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) {
+		u16 vlan_tag = rx_desc->wb.qword0.lo_dword.l2tag1;
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+		                       le16_to_cpu(vlan_tag));
+	}
+
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 }
@@ -2350,7 +2338,6 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		struct i40e_rx_buffer *rx_buffer;
 		union i40e_rx_desc *rx_desc;
 		unsigned int size;
-		u16 vlan_tag;
 		u8 rx_ptype;
 		u64 qword;
 
@@ -2451,11 +2438,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		/* populate checksum, VLAN, and protocol */
 		i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
 
-		vlan_tag = (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
-			   le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1) : 0;
-
 		i40e_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
-		i40e_receive_skb(rx_ring, skb, vlan_tag);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 		skb = NULL;
 
 		/* update budget accounting */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
index 09809dffe399..2c077f1c4eca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx_common.h
@@ -14,8 +14,6 @@ struct i40e_rx_buffer *i40e_clean_programming_status(
 void i40e_process_skb_fields(struct i40e_ring *rx_ring,
 			     union i40e_rx_desc *rx_desc, struct sk_buff *skb,
 			     u8 rx_ptype);
-void i40e_receive_skb(struct i40e_ring *rx_ring,
-		      struct sk_buff *skb, u16 vlan_tag);
 void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring);
 void i40e_update_rx_stats(struct i40e_ring *rx_ring,
 			  unsigned int total_rx_bytes,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 433c8e688c78..a6ea2b249471 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -634,7 +634,6 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		struct i40e_rx_buffer *bi;
 		union i40e_rx_desc *rx_desc;
 		unsigned int size;
-		u16 vlan_tag;
 		u8 rx_ptype;
 		u64 qword;
 
@@ -717,10 +716,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
 			   I40E_RXD_QW1_PTYPE_SHIFT;
 		i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
-
-		vlan_tag = (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
-			   le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1) : 0;
-		i40e_receive_skb(rx_ring, skb, vlan_tag);
+		napi_gro_receive(&rx_ring->q_vector->napi, skb);
 	}
 
 	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
-- 
2.19.2

