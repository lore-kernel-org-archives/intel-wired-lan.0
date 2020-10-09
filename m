From: Andre Guedes <andre.guedes@intel.com>
Date: Thu,  8 Oct 2020 19:53:49 -0700
Subject: [Intel-wired-lan] [PATCH 9/9] igc: Implement ndo_xdp_xmit callback
In-Reply-To: <20201009025349.4037-1-andre.guedes@intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
Message-ID: <20201009025349.4037-10-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch introduces the helper igc_xdp_xmit() which implements the
ndo_xdp_xmit ops, enabling the igc driver to transmit packets forwarded
to it by xdp programs running on other interfaces.

This patch has been tested with the sample app "xdp_redirect_map"
located in samples/bpf/.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 41 +++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  3 +-
 drivers/net/ethernet/intel/igc/igc_xdp.h  |  2 ++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7cdfce6c0d63..907238d1094a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4976,6 +4976,46 @@ static int igc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 	}
 }
 
+static int igc_xdp_xmit(struct net_device *dev, int num_frames,
+			struct xdp_frame **frames, u32 flags)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	struct igc_ring *ring;
+	int i, drops;
+
+	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	ring = igc_xdp_get_tx_ring(adapter, cpu);
+	nq = txring_txq(ring);
+
+	__netif_tx_lock(nq, cpu);
+
+	drops = 0;
+	for (i = 0; i < num_frames; i++) {
+		int err;
+		struct xdp_frame *xdpf = frames[i];
+
+		err = igc_xdp_init_tx_descriptor(ring, xdpf);
+		if (err) {
+			xdp_return_frame_rx_napi(xdpf);
+			drops++;
+		}
+	}
+
+	if (flags & XDP_XMIT_FLUSH)
+		igc_flush_tx_descriptors(ring);
+
+	__netif_tx_unlock(nq);
+
+	return num_frames - drops;
+}
+
 static const struct net_device_ops igc_netdev_ops = {
 	.ndo_open		= igc_open,
 	.ndo_stop		= igc_close,
@@ -4990,6 +5030,7 @@ static const struct net_device_ops igc_netdev_ops = {
 	.ndo_do_ioctl		= igc_ioctl,
 	.ndo_setup_tc		= igc_setup_tc,
 	.ndo_bpf		= igc_bpf,
+	.ndo_xdp_xmit		= igc_xdp_xmit,
 };
 
 /* PCIe configuration access */
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index e9a81975324f..bc473161899c 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -59,8 +59,7 @@ static int igc_xdp_init_tx_buffer(struct igc_tx_buffer *buffer,
 }
 
 /* This function requires __netif_tx_lock is held by the caller. */
-static int igc_xdp_init_tx_descriptor(struct igc_ring *ring,
-				      struct xdp_frame *xdpf)
+int igc_xdp_init_tx_descriptor(struct igc_ring *ring, struct xdp_frame *xdpf)
 {
 	struct igc_tx_buffer *buffer;
 	union igc_adv_tx_desc *desc;
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.h b/drivers/net/ethernet/intel/igc/igc_xdp.h
index 1c38a80c3aa0..801fb27fbb85 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.h
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.h
@@ -22,4 +22,6 @@ void igc_xdp_unregister_rxq_info(struct igc_ring *ring);
 
 struct igc_ring *igc_xdp_get_tx_ring(struct igc_adapter *adapter, int cpu);
 
+int igc_xdp_init_tx_descriptor(struct igc_ring *ring, struct xdp_frame *xdpf);
+
 #endif /* _IGC_XDP_H_ */
-- 
2.26.2

