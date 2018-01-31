From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 30 Jan 2018 16:51:33 -0800
Subject: [Intel-wired-lan] [PATCH 5/9] ixgbevf: add support for padding
 packet
In-Reply-To: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
References: <20180131005015.19264.44085.stgit@localhost6.localdomain6>
Message-ID: <20180131005133.19264.85496.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Following the logic from commit 2de6aa3a666e
("ixgbe: Add support for padding packet")

Add support for providing a buffer with headroom and tailroom
to allow for shared info, NET_SKB_PAD, and NET_IP_ALIGN.  With this
combined with the DMA changes we can start using build_skb to build frames
around an incoming Rx buffer instead of having to memcpy the headers.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   11 +++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   32 ++++++++++++++++++---
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
index d691d64..fe7111c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
@@ -90,6 +90,7 @@ struct ixgbevf_rx_queue_stats {
 
 enum ixgbevf_ring_state_t {
 	__IXGBEVF_RX_3K_BUFFER,
+	__IXGBEVF_RX_BUILD_SKB_ENABLED,
 	__IXGBEVF_TX_DETECT_HANG,
 	__IXGBEVF_HANG_CHECK_ARMED,
 };
@@ -179,11 +180,21 @@ struct ixgbevf_ring {
 #define clear_ring_uses_large_buffer(ring) \
 	clear_bit(__IXGBEVF_RX_3K_BUFFER, &(ring)->state)
 
+#define ring_uses_build_skb(ring) \
+	test_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
+#define set_ring_build_skb_enabled(ring) \
+	set_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
+#define clear_ring_build_skb_enabled(ring) \
+	clear_bit(__IXGBEVF_RX_BUILD_SKB_ENABLED, &(ring)->state)
+
 static inline unsigned int ixgbevf_rx_bufsz(struct ixgbevf_ring *ring)
 {
 #if (PAGE_SIZE < 8192)
 	if (ring_uses_large_buffer(ring))
 		return IXGBEVF_RXBUFFER_3072;
+
+	if (ring_uses_build_skb(ring))
+		return IXGBEVF_MAX_FRAME_BUILD_SKB;
 #endif
 	return IXGBEVF_RXBUFFER_2048;
 }
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index cb9d00a..d797265 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -554,6 +554,11 @@ static bool ixgbevf_is_non_eop(struct ixgbevf_ring *rx_ring,
 	return true;
 }
 
+static inline unsigned int ixgbevf_rx_offset(struct ixgbevf_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? IXGBEVF_SKB_PAD : 0;
+}
+
 static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 				      struct ixgbevf_rx_buffer *bi)
 {
@@ -588,7 +593,7 @@ static bool ixgbevf_alloc_mapped_page(struct ixgbevf_ring *rx_ring,
 
 	bi->dma = dma;
 	bi->page = page;
-	bi->page_offset = 0;
+	bi->page_offset = ixgbevf_rx_offset(rx_ring);
 	bi->pagecnt_bias = 1;
 	rx_ring->rx_stats.alloc_rx_page++;
 
@@ -803,7 +808,9 @@ static bool ixgbevf_add_rx_frag(struct ixgbevf_ring *rx_ring,
 #if (PAGE_SIZE < 8192)
 	unsigned int truesize = ixgbevf_rx_pg_size(rx_ring) / 2;
 #else
-	unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
+	unsigned int truesize = ring_uses_build_skb(rx_ring) ?
+				SKB_DATA_ALIGN(IXGBEVF_SKB_PAD + size) :
+				SKB_DATA_ALIGN(size);
 #endif
 	unsigned int pull_len;
 
@@ -1776,8 +1783,19 @@ static void ixgbevf_configure_rx_ring(struct ixgbevf_adapter *adapter,
 
 	ixgbevf_configure_srrctl(adapter, ring, reg_idx);
 
-	/* allow any size packet since we can handle overflow */
-	rxdctl &= ~IXGBE_RXDCTL_RLPML_EN;
+	/* RXDCTL.RLPML does not work on 82599 */
+	if (adapter->hw.mac.type != ixgbe_mac_82599_vf) {
+		rxdctl &= ~(IXGBE_RXDCTL_RLPMLMASK |
+			    IXGBE_RXDCTL_RLPML_EN);
+
+#if (PAGE_SIZE < 8192)
+		/* Limit the maximum frame size so we don't overrun the skb */
+		if (ring_uses_build_skb(ring) &&
+		   !ring_uses_large_buffer(ring))
+			rxdctl |= IXGBEVF_MAX_FRAME_BUILD_SKB |
+				  IXGBE_RXDCTL_RLPML_EN;
+#endif
+	}
 
 	rxdctl |= IXGBE_RXDCTL_ENABLE | IXGBE_RXDCTL_VME;
 	IXGBE_WRITE_REG(hw, IXGBE_VFRXDCTL(reg_idx), rxdctl);
@@ -1793,11 +1811,14 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
 	unsigned int max_frame = netdev->mtu + ETH_HLEN + ETH_FCS_LEN;
 
 	/* set build_skb and buffer size flags */
+	clear_ring_build_skb_enabled(rx_ring);
 	clear_ring_uses_large_buffer(rx_ring);
 
 	if (adapter->flags & IXGBEVF_FLAGS_LEGACY_RX)
 		return;
 
+	set_ring_build_skb_enabled(rx_ring);
+
 #if (PAGE_SIZE < 8192)
 	if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
 		return;
@@ -3890,6 +3911,9 @@ static int ixgbevf_change_mtu(struct net_device *netdev, int new_mtu)
 	/* must set new MTU before calling down or up */
 	netdev->mtu = new_mtu;
 
+	if (netif_running(netdev))
+		ixgbevf_reinit_locked(adapter);
+
 	return 0;
 }
 

