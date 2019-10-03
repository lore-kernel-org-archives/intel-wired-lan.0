From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  3 Oct 2019 13:43:05 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Add rx checksum support
Message-ID: <20191003104305.42463-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Extend the socket buffer field process and add rx checksum functionality
Minor: fix indentation with tab instead of spaces.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  5 +++-
 drivers/net/ethernet/intel/igc/igc_main.c    | 43 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 03f1aca3f57f..f3788f0b95b4 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -282,7 +282,10 @@
 #define IGC_RCTL_BAM		0x00008000 /* broadcast enable */
 
 /* Receive Descriptor bit definitions */
-#define IGC_RXD_STAT_EOP	0x02    /* End of Packet */
+#define IGC_RXD_STAT_EOP	0x02	/* End of Packet */
+#define IGC_RXD_STAT_IXSM	0x04	/* Ignore checksum */
+#define IGC_RXD_STAT_UDPCS	0x10	/* UDP xsum calculated */
+#define IGC_RXD_STAT_TCPCS	0x20	/* TCP xsum calculated */
 
 #define IGC_RXDEXT_STATERR_CE		0x01000000
 #define IGC_RXDEXT_STATERR_SE		0x02000000
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a861fc038721..52521a0bbf48 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1201,6 +1201,46 @@ static netdev_tx_t igc_xmit_frame(struct sk_buff *skb,
 	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
 }
 
+static inline void igc_rx_checksum(struct igc_ring *ring,
+				   union igc_adv_rx_desc *rx_desc,
+				   struct sk_buff *skb)
+{
+	skb_checksum_none_assert(skb);
+
+	/* Ignore Checksum bit is set */
+	if (igc_test_staterr(rx_desc, IGC_RXD_STAT_IXSM))
+		return;
+
+	/* Rx checksum disabled via ethtool */
+	if (!(ring->netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	/* TCP/UDP checksum error bit is set */
+	if (igc_test_staterr(rx_desc,
+			     IGC_RXDEXT_STATERR_TCPE |
+			     IGC_RXDEXT_STATERR_IPE)) {
+		/* work around errata with sctp packets where the TCPE aka
+		 * L4E bit is set incorrectly on 64 byte (60 byte w/o crc)
+		 * packets, (aka let the stack check the crc32c)
+		 */
+		if (!(skb->len == 60 &&
+		      test_bit(IGC_RING_FLAG_RX_SCTP_CSUM, &ring->flags))) {
+			u64_stats_update_begin(&ring->rx_syncp);
+			ring->rx_stats.csum_err++;
+			u64_stats_update_end(&ring->rx_syncp);
+		}
+		/* let the stack verify checksum errors */
+		return;
+	}
+	/* It must be a TCP or UDP packet with a valid checksum */
+	if (igc_test_staterr(rx_desc, IGC_RXD_STAT_TCPCS |
+				      IGC_RXD_STAT_UDPCS))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	dev_dbg(ring->dev, "cksum success: bits %08X\n",
+		le32_to_cpu(rx_desc->wb.upper.status_error));
+}
+
 static inline void igc_rx_hash(struct igc_ring *ring,
 			       union igc_adv_rx_desc *rx_desc,
 			       struct sk_buff *skb)
@@ -1227,6 +1267,8 @@ static void igc_process_skb_fields(struct igc_ring *rx_ring,
 {
 	igc_rx_hash(rx_ring, rx_desc, skb);
 
+	igc_rx_checksum(rx_ring, rx_desc, skb);
+
 	skb_record_rx_queue(skb, rx_ring->queue_index);
 
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
@@ -4392,6 +4434,7 @@ static int igc_probe(struct pci_dev *pdev,
 		goto err_sw_init;
 
 	/* Add supported features to the features list*/
+	netdev->features |= NETIF_F_RXCSUM;
 	netdev->features |= NETIF_F_HW_CSUM;
 	netdev->features |= NETIF_F_SCTP_CRC;
 
-- 
2.11.0

