From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 13 Aug 2018 11:43:45 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 8/8] ixgbevf: enable VF ipsec
 offload operations
In-Reply-To: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <1534185825-12451-9-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ipsec initialization into the driver startup and
add the Rx and Tx processing hooks.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbevf/defines.h      |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  2 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 25 ++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 74 +++++++++++++++++------
 drivers/net/ethernet/intel/ixgbevf/vf.c           |  4 ++
 5 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/defines.h b/drivers/net/ethernet/intel/ixgbevf/defines.h
index 8b627b6..6c3d6bf 100644
--- a/drivers/net/ethernet/intel/ixgbevf/defines.h
+++ b/drivers/net/ethernet/intel/ixgbevf/defines.h
@@ -234,7 +234,7 @@ union ixgbe_adv_rx_desc {
 /* Context descriptors */
 struct ixgbe_adv_tx_context_desc {
 	__le32 vlan_macip_lens;
-	__le32 seqnum_seed;
+	__le32 fceof_saidx;
 	__le32 type_tucmd_mlhl;
 	__le32 mss_l4len_idx;
 };
diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
index 631c910..5399787 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -55,6 +55,8 @@ static struct ixgbe_stats ixgbevf_gstrings_stats[] = {
 	IXGBEVF_STAT("alloc_rx_page", alloc_rx_page),
 	IXGBEVF_STAT("alloc_rx_page_failed", alloc_rx_page_failed),
 	IXGBEVF_STAT("alloc_rx_buff_failed", alloc_rx_buff_failed),
+	IXGBEVF_STAT("tx_ipsec", tx_ipsec),
+	IXGBEVF_STAT("rx_ipsec", rx_ipsec),
 };
 
 #define IXGBEVF_QUEUE_STATS_LEN ( \
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index 172637e..e399e1c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -459,6 +459,31 @@ int ethtool_ioctl(struct ifreq *ifr);
 
 extern void ixgbevf_write_eitr(struct ixgbevf_q_vector *q_vector);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter);
+void ixgbevf_stop_ipsec_offload(struct ixgbevf_adapter *adapter);
+void ixgbevf_ipsec_restore(struct ixgbevf_adapter *adapter);
+void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
+		      union ixgbe_adv_rx_desc *rx_desc,
+		      struct sk_buff *skb);
+int ixgbevf_ipsec_tx(struct ixgbevf_ring *tx_ring,
+		     struct ixgbevf_tx_buffer *first,
+		     struct ixgbevf_ipsec_tx_data *itd);
+#else
+static inline void ixgbevf_init_ipsec_offload(struct ixgbevf_adapter *adapter)
+{ }
+static inline void ixgbevf_stop_ipsec_offload(struct ixgbevf_adapter *adapter)
+{ }
+static inline void ixgbevf_ipsec_restore(struct ixgbevf_adapter *adapter) { }
+static inline void ixgbevf_ipsec_rx(struct ixgbevf_ring *rx_ring,
+				    union ixgbe_adv_rx_desc *rx_desc,
+				    struct sk_buff *skb) { }
+static inline int ixgbevf_ipsec_tx(struct ixgbevf_ring *tx_ring,
+				   struct ixgbevf_tx_buffer *first,
+				   struct ixgbevf_ipsec_tx_data *itd)
+{ return 0; }
+#endif /* CONFIG_XFRM_OFFLOAD */
+
 void ixgbe_napi_add_all(struct ixgbevf_adapter *adapter);
 void ixgbe_napi_del_all(struct ixgbevf_adapter *adapter);
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d86446d..f745a52 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -40,7 +40,7 @@ static const char ixgbevf_driver_string[] =
 #define DRV_VERSION "4.1.0-k"
 const char ixgbevf_driver_version[] = DRV_VERSION;
 static char ixgbevf_copyright[] =
-	"Copyright (c) 2009 - 2015 Intel Corporation.";
+	"Copyright (c) 2009 - 2018 Intel Corporation.";
 
 static const struct ixgbevf_info *ixgbevf_info_tbl[] = {
 	[board_82599_vf]	= &ixgbevf_82599_vf_info,
@@ -268,7 +268,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 	struct ixgbevf_adapter *adapter = q_vector->adapter;
 	struct ixgbevf_tx_buffer *tx_buffer;
 	union ixgbe_adv_tx_desc *tx_desc;
-	unsigned int total_bytes = 0, total_packets = 0;
+	unsigned int total_bytes = 0, total_packets = 0, total_ipsec = 0;
 	unsigned int budget = tx_ring->count / 2;
 	unsigned int i = tx_ring->next_to_clean;
 
@@ -299,6 +299,8 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 		/* update the statistics for this packet */
 		total_bytes += tx_buffer->bytecount;
 		total_packets += tx_buffer->gso_segs;
+		if (tx_buffer->tx_flags & IXGBE_TX_FLAGS_IPSEC)
+			total_ipsec++;
 
 		/* free the skb */
 		if (ring_is_xdp(tx_ring))
@@ -361,6 +363,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vector *q_vector,
 	u64_stats_update_end(&tx_ring->syncp);
 	q_vector->tx.total_bytes += total_bytes;
 	q_vector->tx.total_packets += total_packets;
+	adapter->tx_ipsec += total_ipsec;
 
 	if (check_for_tx_hang(tx_ring) && ixgbevf_check_tx_hang(tx_ring)) {
 		struct ixgbe_hw *hw = &adapter->hw;
@@ -516,6 +519,9 @@ static void ixgbevf_process_skb_fields(struct ixgbevf_ring *rx_ring,
 			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
 	}
 
+	if (ixgbevf_test_staterr(rx_desc, IXGBE_RXDADV_STAT_SECP))
+		ixgbevf_ipsec_rx(rx_ring, rx_desc, skb);
+
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 }
 
@@ -1012,7 +1018,7 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring *ring,
 		context_desc = IXGBEVF_TX_CTXTDESC(ring, 0);
 		context_desc->vlan_macip_lens	=
 			cpu_to_le32(ETH_HLEN << IXGBE_ADVTXD_MACLEN_SHIFT);
-		context_desc->seqnum_seed	= 0;
+		context_desc->fceof_saidx	= 0;
 		context_desc->type_tucmd_mlhl	=
 			cpu_to_le32(IXGBE_TXD_CMD_DEXT |
 				    IXGBE_ADVTXD_DTYP_CTXT);
@@ -2200,6 +2206,7 @@ static void ixgbevf_configure(struct ixgbevf_adapter *adapter)
 	ixgbevf_set_rx_mode(adapter->netdev);
 
 	ixgbevf_restore_vlan(adapter);
+	ixgbevf_ipsec_restore(adapter);
 
 	ixgbevf_configure_tx(adapter);
 	ixgbevf_configure_rx(adapter);
@@ -2246,7 +2253,8 @@ static void ixgbevf_init_last_counter_stats(struct ixgbevf_adapter *adapter)
 static void ixgbevf_negotiate_api(struct ixgbevf_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int api[] = { ixgbe_mbox_api_13,
+	int api[] = { ixgbe_mbox_api_14,
+		      ixgbe_mbox_api_13,
 		      ixgbe_mbox_api_12,
 		      ixgbe_mbox_api_11,
 		      ixgbe_mbox_api_10,
@@ -2605,6 +2613,7 @@ static void ixgbevf_set_num_queues(struct ixgbevf_adapter *adapter)
 		case ixgbe_mbox_api_11:
 		case ixgbe_mbox_api_12:
 		case ixgbe_mbox_api_13:
+		case ixgbe_mbox_api_14:
 			if (adapter->xdp_prog &&
 			    hw->mac.max_tx_queues == rss)
 				rss = rss > 3 ? 2 : 1;
@@ -3700,8 +3709,8 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
 }
 
 static void ixgbevf_tx_ctxtdesc(struct ixgbevf_ring *tx_ring,
-				u32 vlan_macip_lens, u32 type_tucmd,
-				u32 mss_l4len_idx)
+				u32 vlan_macip_lens, u32 fceof_saidx,
+				u32 type_tucmd, u32 mss_l4len_idx)
 {
 	struct ixgbe_adv_tx_context_desc *context_desc;
 	u16 i = tx_ring->next_to_use;
@@ -3715,14 +3724,15 @@ static void ixgbevf_tx_ctxtdesc(struct ixgbevf_ring *tx_ring,
 	type_tucmd |= IXGBE_TXD_CMD_DEXT | IXGBE_ADVTXD_DTYP_CTXT;
 
 	context_desc->vlan_macip_lens	= cpu_to_le32(vlan_macip_lens);
-	context_desc->seqnum_seed	= 0;
+	context_desc->fceof_saidx	= cpu_to_le32(fceof_saidx);
 	context_desc->type_tucmd_mlhl	= cpu_to_le32(type_tucmd);
 	context_desc->mss_l4len_idx	= cpu_to_le32(mss_l4len_idx);
 }
 
 static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 		       struct ixgbevf_tx_buffer *first,
-		       u8 *hdr_len)
+		       u8 *hdr_len,
+		       struct ixgbevf_ipsec_tx_data *itd)
 {
 	u32 vlan_macip_lens, type_tucmd, mss_l4len_idx;
 	struct sk_buff *skb = first->skb;
@@ -3736,6 +3746,7 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 		unsigned char *hdr;
 	} l4;
 	u32 paylen, l4_offset;
+	u32 fceof_saidx = 0;
 	int err;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -3761,13 +3772,15 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	if (ip.v4->version == 4) {
 		unsigned char *csum_start = skb_checksum_start(skb);
 		unsigned char *trans_start = ip.hdr + (ip.v4->ihl * 4);
+		int len = csum_start - trans_start;
 
 		/* IP header will have to cancel out any data that
-		 * is not a part of the outer IP header
+		 * is not a part of the outer IP header, so set to
+		 * a reverse csum if needed, else init check to 0.
 		 */
-		ip.v4->check = csum_fold(csum_partial(trans_start,
-						      csum_start - trans_start,
-						      0));
+		ip.v4->check = (skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL) ?
+					   csum_fold(csum_partial(trans_start,
+								  len, 0)) : 0;
 		type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;
 
 		ip.v4->tot_len = 0;
@@ -3799,13 +3812,16 @@ static int ixgbevf_tso(struct ixgbevf_ring *tx_ring,
 	mss_l4len_idx |= skb_shinfo(skb)->gso_size << IXGBE_ADVTXD_MSS_SHIFT;
 	mss_l4len_idx |= (1u << IXGBE_ADVTXD_IDX_SHIFT);
 
+	fceof_saidx |= itd->pfsa;
+	type_tucmd |= itd->flags | itd->trailer_len;
+
 	/* vlan_macip_lens: HEADLEN, MACLEN, VLAN tag */
 	vlan_macip_lens = l4.hdr - ip.hdr;
 	vlan_macip_lens |= (ip.hdr - skb->data) << IXGBE_ADVTXD_MACLEN_SHIFT;
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 
-	ixgbevf_tx_ctxtdesc(tx_ring, vlan_macip_lens,
-			    type_tucmd, mss_l4len_idx);
+	ixgbevf_tx_ctxtdesc(tx_ring, vlan_macip_lens, fceof_saidx, type_tucmd,
+			    mss_l4len_idx);
 
 	return 1;
 }
@@ -3820,10 +3836,12 @@ static inline bool ixgbevf_ipv6_csum_is_sctp(struct sk_buff *skb)
 }
 
 static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
-			    struct ixgbevf_tx_buffer *first)
+			    struct ixgbevf_tx_buffer *first,
+			    struct ixgbevf_ipsec_tx_data *itd)
 {
 	struct sk_buff *skb = first->skb;
 	u32 vlan_macip_lens = 0;
+	u32 fceof_saidx = 0;
 	u32 type_tucmd = 0;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -3858,7 +3876,11 @@ static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
 	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
 	vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
 
-	ixgbevf_tx_ctxtdesc(tx_ring, vlan_macip_lens, type_tucmd, 0);
+	fceof_saidx |= itd->pfsa;
+	type_tucmd |= itd->flags | itd->trailer_len;
+
+	ixgbevf_tx_ctxtdesc(tx_ring, vlan_macip_lens,
+			    fceof_saidx, type_tucmd, 0);
 }
 
 static __le32 ixgbevf_tx_cmd_type(u32 tx_flags)
@@ -3892,8 +3914,12 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
 	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
 		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
 
-	/* use index 1 context for TSO/FSO/FCOE */
-	if (tx_flags & IXGBE_TX_FLAGS_TSO)
+	/* enable IPsec */
+	if (tx_flags & IXGBE_TX_FLAGS_IPSEC)
+		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IPSEC);
+
+	/* use index 1 context for TSO/FSO/FCOE/IPSEC */
+	if (tx_flags & (IXGBE_TX_FLAGS_TSO | IXGBE_TX_FLAGS_IPSEC))
 		olinfo_status |= cpu_to_le32(1u << IXGBE_ADVTXD_IDX_SHIFT);
 
 	/* Check Context must be set if Tx switch is enabled, which it
@@ -4075,6 +4101,7 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	int tso;
 	u32 tx_flags = 0;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
+	struct ixgbevf_ipsec_tx_data ipsec_tx = { 0 };
 #if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
 	unsigned short f;
 #endif
@@ -4119,11 +4146,15 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	first->tx_flags = tx_flags;
 	first->protocol = vlan_get_protocol(skb);
 
-	tso = ixgbevf_tso(tx_ring, first, &hdr_len);
+#ifdef CONFIG_XFRM_OFFLOAD
+	if (skb->sp && !ixgbevf_ipsec_tx(tx_ring, first, &ipsec_tx))
+		goto out_drop;
+#endif
+	tso = ixgbevf_tso(tx_ring, first, &hdr_len, &ipsec_tx);
 	if (tso < 0)
 		goto out_drop;
 	else if (!tso)
-		ixgbevf_tx_csum(tx_ring, first);
+		ixgbevf_tx_csum(tx_ring, first, &ipsec_tx);
 
 	ixgbevf_tx_map(tx_ring, first, hdr_len);
 
@@ -4634,6 +4665,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
 		netdev->max_mtu = IXGBE_MAX_JUMBO_FRAME_SIZE -
 				  (ETH_HLEN + ETH_FCS_LEN);
 		break;
@@ -4669,6 +4701,7 @@ static int ixgbevf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, netdev);
 	netif_carrier_off(netdev);
+	ixgbevf_init_ipsec_offload(adapter);
 
 	ixgbevf_init_last_counter_stats(adapter);
 
@@ -4735,6 +4768,7 @@ static void ixgbevf_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
+	ixgbevf_stop_ipsec_offload(adapter);
 	ixgbevf_clear_interrupt_scheme(adapter);
 	ixgbevf_reset_interrupt_capability(adapter);
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index bf0577e..cd3b813 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -309,6 +309,7 @@ int ixgbevf_get_reta_locked(struct ixgbe_hw *hw, u32 *reta, int num_rx_queues)
 	 * is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
 		if (hw->mac.type < ixgbe_mac_X550_vf)
@@ -376,6 +377,7 @@ int ixgbevf_get_rss_key_locked(struct ixgbe_hw *hw, u8 *rss_key)
 	 * or if the operation is not supported for this device type.
 	 */
 	switch (hw->api_version) {
+	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_12:
 		if (hw->mac.type < ixgbe_mac_X550_vf)
@@ -540,6 +542,7 @@ static s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 		if (xcast_mode == IXGBEVF_XCAST_MODE_PROMISC)
 			return -EOPNOTSUPP;
 		/* Fall threw */
+	case ixgbe_mbox_api_14:
 	case ixgbe_mbox_api_13:
 		break;
 	default:
@@ -890,6 +893,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_11:
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
+	case ixgbe_mbox_api_14:
 		break;
 	default:
 		return 0;
-- 
2.7.4

