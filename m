From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 19 Dec 2017 16:00:00 -0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 08/10] ixgbe: process the Tx
 ipsec offload
In-Reply-To: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1513728002-7643-9-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the skb has a security association referenced in the skb, then
set up the Tx descriptor with the ipsec offload bits.  While we're
here, we fix an oddly named field in the context descriptor struct.

v3: added ifdef CONFIG_XFRM_OFFLOAD check around call to ixgbe_ipsec_tx()

v2: use ihl != 5
    move the ixgbe_ipsec_tx() call to near the call to ixgbe_tso()
    drop the ipsec packet if the tx offload setup fails
    simplify the ixgbe_ipsec_tx() parameters by using 'first'
    leave out the ixgbe_tso() changes since we don't support TSO
       with ipsec yet.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 10 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 79 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 26 +++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |  2 +-
 5 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index a094b23..3d2b7bf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -171,10 +171,11 @@ enum ixgbe_tx_flags {
 	IXGBE_TX_FLAGS_CC	= 0x08,
 	IXGBE_TX_FLAGS_IPV4	= 0x10,
 	IXGBE_TX_FLAGS_CSUM	= 0x20,
+	IXGBE_TX_FLAGS_IPSEC	= 0x40,
 
 	/* software defined flags */
-	IXGBE_TX_FLAGS_SW_VLAN	= 0x40,
-	IXGBE_TX_FLAGS_FCOE	= 0x80,
+	IXGBE_TX_FLAGS_SW_VLAN	= 0x80,
+	IXGBE_TX_FLAGS_FCOE	= 0x100,
 };
 
 /* VLAN info */
@@ -1014,6 +1015,8 @@ void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
 void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 		    union ixgbe_adv_rx_desc *rx_desc,
 		    struct sk_buff *skb);
+int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring, struct ixgbe_tx_buffer *first,
+		   struct ixgbe_ipsec_tx_data *itd);
 #else
 static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter) { };
 static inline void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter) { };
@@ -1021,5 +1024,8 @@ static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) { };
 static inline void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
 				  union ixgbe_adv_rx_desc *rx_desc,
 				  struct sk_buff *skb) { };
+static inline int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
+				 struct ixgbe_tx_buffer *first,
+				 struct ixgbe_ipsec_tx_data *itd) { return 0; };
 #endif /* CONFIG_XFRM_OFFLOAD */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index a9b8f5c..c2fd2ac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -695,12 +695,91 @@ static void ixgbe_ipsec_del_sa(struct xfrm_state *xs)
 	}
 }
 
+/**
+ * ixgbe_ipsec_offload_ok - can this packet use the xfrm hw offload
+ * @skb: current data packet
+ * @xs: pointer to transformer state struct
+ **/
+static bool ixgbe_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
+{
+	if (xs->props.family == AF_INET) {
+		/* Offload with IPv4 options is not supported yet */
+		if (ip_hdr(skb)->ihl != 5)
+			return false;
+	} else {
+		/* Offload with IPv6 extension headers is not support yet */
+		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
+			return false;
+	}
+
+	return true;
+}
+
 static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
 	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
 	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
+	.xdo_dev_offload_ok = ixgbe_ipsec_offload_ok,
 };
 
 /**
+ * ixgbe_ipsec_tx - setup Tx flags for ipsec offload
+ * @tx_ring: outgoing context
+ * @first: current data packet
+ * @itd: ipsec Tx data for later use in building context descriptor
+ **/
+int ixgbe_ipsec_tx(struct ixgbe_ring *tx_ring,
+		   struct ixgbe_tx_buffer *first,
+		   struct ixgbe_ipsec_tx_data *itd)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
+	struct ixgbe_ipsec *ipsec = adapter->ipsec;
+	struct xfrm_state *xs;
+	struct tx_sa *tsa;
+
+	if (!first->skb->sp->len) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm state len = %d\n",
+			   __func__, first->skb->sp->len);
+		return 0;
+	}
+
+	xs = xfrm_input_state(first->skb);
+	if (!xs) {
+		netdev_err(tx_ring->netdev, "%s: no xfrm_input_state() xs = %p\n",
+			   __func__, xs);
+		return 0;
+	}
+
+	itd->sa_idx = xs->xso.offload_handle - IXGBE_IPSEC_BASE_TX_INDEX;
+	if (itd->sa_idx > IXGBE_IPSEC_MAX_SA_COUNT) {
+		netdev_err(tx_ring->netdev, "%s: bad sa_idx=%d handle=%lu\n",
+			   __func__, itd->sa_idx, xs->xso.offload_handle);
+		return 0;
+	}
+
+	tsa = &ipsec->tx_tbl[itd->sa_idx];
+	if (!tsa->used) {
+		netdev_err(tx_ring->netdev, "%s: unused sa_idx=%d\n",
+			   __func__, itd->sa_idx);
+		return 0;
+	}
+
+	first->tx_flags |= IXGBE_TX_FLAGS_IPSEC | IXGBE_TX_FLAGS_CC;
+
+	itd->flags = 0;
+	if (xs->id.proto == IPPROTO_ESP) {
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_TYPE_ESP |
+			      IXGBE_ADVTXD_TUCMD_L4T_TCP;
+		if (first->protocol == htons(ETH_P_IP))
+			itd->flags |= IXGBE_ADVTXD_TUCMD_IPV4;
+		itd->trailer_len = xs->props.trailer_len;
+	}
+	if (tsa->encrypt)
+		itd->flags |= IXGBE_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN;
+
+	return 1;
+}
+
+/**
  * ixgbe_ipsec_rx - decode ipsec bits from Rx descriptor
  * @rx_ring: receiving ring
  * @rx_desc: receive data descriptor
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index f1bfae0..d7875b3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1261,7 +1261,7 @@ void ixgbe_clear_interrupt_scheme(struct ixgbe_adapter *adapter)
 }
 
 void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
-		       u32 fcoe_sof_eof, u32 type_tucmd, u32 mss_l4len_idx)
+		       u32 fceof_saidx, u32 type_tucmd, u32 mss_l4len_idx)
 {
 	struct ixgbe_adv_tx_context_desc *context_desc;
 	u16 i = tx_ring->next_to_use;
@@ -1275,7 +1275,7 @@ void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
 	type_tucmd |= IXGBE_TXD_CMD_DEXT | IXGBE_ADVTXD_DTYP_CTXT;
 
 	context_desc->vlan_macip_lens	= cpu_to_le32(vlan_macip_lens);
-	context_desc->seqnum_seed	= cpu_to_le32(fcoe_sof_eof);
+	context_desc->fceof_saidx	= cpu_to_le32(fceof_saidx);
 	context_desc->type_tucmd_mlhl	= cpu_to_le32(type_tucmd);
 	context_desc->mss_l4len_idx	= cpu_to_le32(mss_l4len_idx);
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0ee1e5e..6b9a9b2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7756,10 +7756,12 @@ static inline bool ixgbe_ipv6_csum_is_sctp(struct sk_buff *skb)
 }
 
 static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
-			  struct ixgbe_tx_buffer *first)
+			  struct ixgbe_tx_buffer *first,
+			  struct ixgbe_ipsec_tx_data *itd)
 {
 	struct sk_buff *skb = first->skb;
 	u32 vlan_macip_lens = 0;
+	u32 fceof_saidx = 0;
 	u32 type_tucmd = 0;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
@@ -7800,7 +7802,12 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
 	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 
-	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd, 0);
+	if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
+		fceof_saidx |= itd->sa_idx;
+		type_tucmd |= itd->flags | itd->trailer_len;
+	}
+
+	ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd, 0);
 }
 
 #define IXGBE_SET_FLAG(_input, _flag, _result) \
@@ -7843,11 +7850,16 @@ static void ixgbe_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 					IXGBE_TX_FLAGS_CSUM,
 					IXGBE_ADVTXD_POPTS_TXSM);
 
-	/* enble IPv4 checksum for TSO */
+	/* enable IPv4 checksum for TSO */
 	olinfo_status |= IXGBE_SET_FLAG(tx_flags,
 					IXGBE_TX_FLAGS_IPV4,
 					IXGBE_ADVTXD_POPTS_IXSM);
 
+	/* enable IPsec */
+	olinfo_status |= IXGBE_SET_FLAG(tx_flags,
+					IXGBE_TX_FLAGS_IPSEC,
+					IXGBE_ADVTXD_POPTS_IPSEC);
+
 	/*
 	 * Check Context must be set if Tx switch is enabled, which it
 	 * always is for case where virtual functions are running
@@ -8306,6 +8318,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 	u32 tx_flags = 0;
 	unsigned short f;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	struct ixgbe_ipsec_tx_data ipsec_tx = { 0 };
 	__be16 protocol = skb->protocol;
 	u8 hdr_len = 0;
 
@@ -8410,11 +8423,16 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 	}
 
 #endif /* IXGBE_FCOE */
+
+#ifdef CONFIG_XFRM_OFFLOAD
+	if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
+		goto out_drop;
+#endif
 	tso = ixgbe_tso(tx_ring, first, &hdr_len);
 	if (tso < 0)
 		goto out_drop;
 	else if (!tso)
-		ixgbe_tx_csum(tx_ring, first);
+		ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
 
 	/* add the ATR filter if ATR is on */
 	if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 3df0763..0ac725fa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2856,7 +2856,7 @@ union ixgbe_adv_rx_desc {
 /* Context descriptors */
 struct ixgbe_adv_tx_context_desc {
 	__le32 vlan_macip_lens;
-	__le32 seqnum_seed;
+	__le32 fceof_saidx;
 	__le32 type_tucmd_mlhl;
 	__le32 mss_l4len_idx;
 };
-- 
2.7.4

