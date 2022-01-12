From: Samuel Mendoza-Jonas <samjonas@amazon.com>
Date: Wed, 12 Jan 2022 15:32:31 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbevf: Require large buffers for
 build_skb on 82599VF
Message-ID: <20220112233231.317259-1-samjonas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From 4.17 onwards the ixgbevf driver uses build_skb() to build an skb
around new data in the page buffer shared with the ixgbe PF.
This uses either a 2K or 3K buffer, and offsets the DMA mapping by
NET_SKB_PAD + NET_IP_ALIGN. When using a smaller buffer RXDCTL is set to
ensure the PF does not write a full 2K bytes into the buffer, which is
actually 2K minus the offset.

However on the 82599 virtual function, the RXDCTL mechanism is not
available. The driver attempts to work around this by using the SET_LPE
mailbox method to lower the maximm frame size, but the ixgbe PF driver
ignores this in order to keep the PF and all VFs in sync[0].

This means the PF will write up to the full 2K set in SRRCTL, causing it
to write NET_SKB_PAD + NET_IP_ALIGN bytes past the end of the buffer.
With 4K pages split into two buffers, this means it either writes
NET_SKB_PAD + NET_IP_ALIGN bytes past the first buffer (and into the
second), or NET_SKB_PAD + NET_IP_ALIGN bytes past the end of the DMA
mapping.

Avoid this by only enabling build_skb when using "large" buffers (3K).
These are placed in each half of an order-1 page, preventing the PF from
writing past the end of the mapping.

[0]: Technically it only ever raises the max frame size, see
ixgbe_set_vf_lpe() in ixgbe_sriov.c

Signed-off-by: Samuel Mendoza-Jonas <samjonas@amazon.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 0015fcf1df2b..0f293acd17e8 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1984,14 +1984,15 @@ static void ixgbevf_set_rx_buffer_len(struct ixgbevf_adapter *adapter,
 	if (adapter->flags & IXGBEVF_FLAGS_LEGACY_RX)
 		return;
 
-	set_ring_build_skb_enabled(rx_ring);
+	if (PAGE_SIZE < 8192)
+		if (max_frame > IXGBEVF_MAX_FRAME_BUILD_SKB)
+			set_ring_uses_large_buffer(rx_ring);
 
-	if (PAGE_SIZE < 8192) {
-		if (max_frame <= IXGBEVF_MAX_FRAME_BUILD_SKB)
-			return;
+	/* 82599 can't rely on RXDCTL.RLPML to restrict the size of the frame */
+	if (adapter->hw.mac.type == ixgbe_mac_82599_vf && !ring_uses_large_buffer(rx_ring))
+		return;
 
-		set_ring_uses_large_buffer(rx_ring);
-	}
+	set_ring_build_skb_enabled(rx_ring);
 }
 
 /**
-- 
2.25.1

