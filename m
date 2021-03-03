From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed,  3 Mar 2021 16:39:26 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 1/3] i40e: move headroom
 initialization to i40e_configure_rx_ring
In-Reply-To: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
Message-ID: <20210303153928.11764-2-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e_rx_offset(), that is supposed to initialize the Rx buffer headroom,
relies on I40E_RXR_FLAGS_BUILD_SKB_ENABLED flag.

Currently, the callsite of mentioned function is placed incorrectly
within i40e_setup_rx_descriptors() where Rx ring's build skb flag is not
set yet. This causes the XDP_REDIRECT to be partially broken due to
inability to create xdp_frame in the headroom space, as the headroom is
0.

For the record, below is the call graph:

i40e_vsi_open
 i40e_vsi_setup_rx_resources
  i40e_setup_rx_descriptors
   i40e_rx_offset() <-- sets offset to 0 as build_skb flag is set below

 i40e_vsi_configure_rx
  i40e_configure_rx_ring
   set_ring_build_skb_enabled(ring) <-- set build_skb flag

Fix this by moving i40e_rx_offset() to i40e_configure_rx_ring() after
the flag setting.

Fixes: f7bb0d71d658 ("i40e: store the result of i40e_rx_offset() onto i40e_ring")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 ------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2966b4766afd..472750e69259 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3273,6 +3273,17 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 	return 0;
 }
 
+/**
+ * i40e_rx_offset - Return expected offset into page to access data
+ * @rx_ring: Ring we are requesting offset of
+ *
+ * Returns the offset value for ring into the data buffer.
+ */
+static unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
+}
+
 /**
  * i40e_configure_rx_ring - Configure a receive ring context
  * @ring: The Rx ring to configure
@@ -3387,6 +3398,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	else
 		set_ring_build_skb_enabled(ring);
 
+	ring->rx_offset = i40e_rx_offset(ring);
+
 	/* cache tail for quicker writes, and clear the reg before use */
 	ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
 	writel(0, ring->tail);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index b2008f72494d..bffb881f7102 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1569,17 +1569,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 	}
 }
 
-/**
- * i40e_rx_offset - Return expected offset into page to access data
- * @rx_ring: Ring we are requesting offset of
- *
- * Returns the offset value for ring into the data buffer.
- */
-static unsigned int i40e_rx_offset(struct i40e_ring *rx_ring)
-{
-	return ring_uses_build_skb(rx_ring) ? I40E_SKB_PAD : 0;
-}
-
 /**
  * i40e_setup_rx_descriptors - Allocate Rx descriptors
  * @rx_ring: Rx descriptor ring (for a specific queue) to setup
@@ -1608,7 +1597,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
-	rx_ring->rx_offset = i40e_rx_offset(rx_ring);
 
 	/* XDP RX-queue info only needed for RX rings exposed to XDP */
 	if (rx_ring->vsi->type == I40E_VSI_MAIN) {
-- 
2.20.1

