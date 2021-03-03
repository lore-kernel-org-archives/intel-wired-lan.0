From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed,  3 Mar 2021 16:39:28 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 3/3] ixgbe: move headroom
 initialization to ixgbe_configure_rx_ring
In-Reply-To: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
Message-ID: <20210303153928.11764-4-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ixgbe_rx_offset(), that is supposed to initialize the Rx buffer headroom,
relies on __IXGBE_RX_BUILD_SKB_ENABLED flag.

Currently, the callsite of mentioned function is placed incorrectly
within ixgbe_setup_rx_resources() where Rx ring's build skb flag is not
set yet. This causes the XDP_REDIRECT to be partially broken due to
inability to create xdp_frame in the headroom space, as the headroom is
0.

Fix this by moving ixgbe_rx_offset() to ixgbe_configure_rx_ring() after
the flag setting, which happens to be set in ixgbe_set_rx_buffer_len.

Fixes: c0d4e9d223c5 ("ixgbe: store the result of ixgbe_rx_offset() onto ixgbe_ring")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fae84202d870..ac0d7a80de0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4118,6 +4118,8 @@ void ixgbe_configure_rx_ring(struct ixgbe_adapter *adapter,
 #endif
 	}
 
+	ring->rx_offset = ixgbe_rx_offset(ring);
+
 	if (ring->xsk_pool && hw->mac.type != ixgbe_mac_82599EB) {
 		u32 xsk_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
 
@@ -6578,7 +6580,6 @@ int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
 
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
-	rx_ring->rx_offset = ixgbe_rx_offset(rx_ring);
 
 	/* XDP RX-queue info */
 	if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
-- 
2.20.1

