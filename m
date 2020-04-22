From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 22 Apr 2020 18:09:38 +0200
Subject: [Intel-wired-lan] [PATCH net-next 27/33] xdp: for Intel AF_XDP
 drivers add XDP frame_sz
In-Reply-To: <158757160439.1370371.13213378122947426220.stgit@firesoul>
References: <158757160439.1370371.13213378122947426220.stgit@firesoul>
Message-ID: <158757177823.1370371.13765060372269609117.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Intel drivers implement native AF_XDP zerocopy in separate C-files,
that have its own invocation of bpf_prog_run_xdp(). The setup of
xdp_buff is also handled in separately from normal code path.

This patch update XDP frame_sz for AF_XDP zerocopy drivers i40e, ice
and ixgbe, as the code changes needed are very similar.  Introduce a
helper function xsk_umem_xdp_frame_sz() for calculating frame size.

Cc: intel-wired-lan at lists.osuosl.org
Cc: Bj?rn T?pel <bjorn.topel@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c   |    2 ++
 drivers/net/ethernet/intel/ice/ice_xsk.c     |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c |    2 ++
 include/net/xdp_sock.h                       |   11 +++++++++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 0b7d29192b2c..2b9184aead5f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -531,12 +531,14 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
+	struct xdp_umem *umem = rx_ring->xsk_umem;
 	unsigned int xdp_res, xdp_xmit = 0;
 	bool failure = false;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.frame_sz = xsk_umem_xdp_frame_sz(umem);
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		struct i40e_rx_buffer *bi;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8279db15e870..23e5515d4527 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -840,11 +840,13 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
+	struct xdp_umem *umem = rx_ring->xsk_umem;
 	unsigned int xdp_xmit = 0;
 	bool failure = false;
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.frame_sz = xsk_umem_xdp_frame_sz(umem);
 
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 74b540ebb3dc..a656ee9a1fae 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -431,12 +431,14 @@ int ixgbe_clean_rx_irq_zc(struct ixgbe_q_vector *q_vector,
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct ixgbe_adapter *adapter = q_vector->adapter;
 	u16 cleaned_count = ixgbe_desc_unused(rx_ring);
+	struct xdp_umem *umem = rx_ring->xsk_umem;
 	unsigned int xdp_res, xdp_xmit = 0;
 	bool failure = false;
 	struct sk_buff *skb;
 	struct xdp_buff xdp;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
+	xdp.frame_sz = xsk_umem_xdp_frame_sz(umem);
 
 	while (likely(total_rx_packets < budget)) {
 		union ixgbe_adv_rx_desc *rx_desc;
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index e86ec48ef627..1cd1ec3cea97 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -237,6 +237,12 @@ static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 address,
 	else
 		return address + offset;
 }
+
+static inline u32 xsk_umem_xdp_frame_sz(struct xdp_umem *umem)
+{
+	return umem->chunk_size_nohr + umem->headroom;
+}
+
 #else
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
@@ -367,6 +373,11 @@ static inline u64 xsk_umem_adjust_offset(struct xdp_umem *umem, u64 handle,
 	return 0;
 }
 
+static inline u32 xsk_umem_xdp_frame_sz(struct xdp_umem *umem)
+{
+	return 0;
+}
+
 static inline int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp)
 {
 	return -EOPNOTSUPP;


