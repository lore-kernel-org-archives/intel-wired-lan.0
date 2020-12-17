From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 17 Dec 2020 12:24:09 -0800
Subject: [Intel-wired-lan] [PATCH 04/10] igc: Refactor XDP rxq info
 registration
In-Reply-To: <20201217202415.77891-1-andre.guedes@intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
Message-ID: <20201217202415.77891-5-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch does a refactoring on the XDP rxq info registration code,
preparing the driver for AF_XDP zero-copy support which is added by
upcoming patches.

Currently, xdp_rxq and memory model are both registered during RX
resource setup time by igc_xdp_register_rxq_info() helper. With AF_XDP,
we want to register the memory model later on while configuring the ring
because we will know which memory model type to register
(MEM_TYPE_PAGE_SHARED or MEM_TYPE_XSK_BUFF_POOL).

The helpers igc_xdp_register_rxq_info() and igc_xdp_unregister_rxq_
info() are not useful anymore so they are removed.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 14 ++++++++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 27 -----------------------
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  3 ---
 3 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d591c1e0581f..1870ca37d650 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -419,7 +419,7 @@ void igc_free_rx_resources(struct igc_ring *rx_ring)
 {
 	igc_clean_rx_ring(rx_ring);
 
-	igc_xdp_unregister_rxq_info(rx_ring);
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
@@ -460,9 +460,12 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
 	struct device *dev = rx_ring->dev;
 	int size, desc_len, res;
 
-	res = igc_xdp_register_rxq_info(rx_ring);
-	if (res < 0)
+	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, rx_ring->queue_index,
+			       0);
+	if (res < 0) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
 		return res;
+	}
 
 	size = sizeof(struct igc_rx_buffer) * rx_ring->count;
 	rx_ring->rx_buffer_info = vzalloc(size);
@@ -488,7 +491,7 @@ int igc_setup_rx_resources(struct igc_ring *rx_ring)
 	return 0;
 
 err:
-	igc_xdp_unregister_rxq_info(rx_ring);
+	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	vfree(rx_ring->rx_buffer_info);
 	rx_ring->rx_buffer_info = NULL;
 	netdev_err(ndev, "Unable to allocate memory for Rx descriptor ring\n");
@@ -536,6 +539,9 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 	u32 srrctl = 0, rxdctl = 0;
 	u64 rdba = ring->dma;
 
+	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+					   MEM_TYPE_PAGE_SHARED, NULL));
+
 	if (igc_xdp_is_enabled(adapter))
 		set_ring_uses_large_buffer(ring);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 11133c4619bb..27c886a254f1 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -31,30 +31,3 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 
 	return 0;
 }
-
-int igc_xdp_register_rxq_info(struct igc_ring *ring)
-{
-	struct net_device *dev = ring->netdev;
-	int err;
-
-	err = xdp_rxq_info_reg(&ring->xdp_rxq, dev, ring->queue_index, 0);
-	if (err) {
-		netdev_err(dev, "Failed to register xdp rxq info\n");
-		return err;
-	}
-
-	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_SHARED,
-					 NULL);
-	if (err) {
-		netdev_err(dev, "Failed to register xdp rxq mem model\n");
-		xdp_rxq_info_unreg(&ring->xdp_rxq);
-		return err;
-	}
-
-	return 0;
-}
-
-void igc_xdp_unregister_rxq_info(struct igc_ring *ring)
-{
-	xdp_rxq_info_unreg(&ring->xdp_rxq);
-}
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.h b/drivers/net/ethernet/intel/igc/igc_xdp.h
index 412aa369e6ba..cdaa2c39b03a 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.h
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.h
@@ -7,9 +7,6 @@
 int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 		     struct netlink_ext_ack *extack);
 
-int igc_xdp_register_rxq_info(struct igc_ring *ring);
-void igc_xdp_unregister_rxq_info(struct igc_ring *ring);
-
 static inline bool igc_xdp_is_enabled(struct igc_adapter *adapter)
 {
 	return !!adapter->xdp_prog;
-- 
2.29.2

