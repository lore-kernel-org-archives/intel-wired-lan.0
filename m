From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Tue, 13 Dec 2016 14:40:05 +0100
Subject: [Intel-wired-lan] [PATCH v3 2/4] i40e: Initial support for XDP
In-Reply-To: <20161213134007.14707-1-bjorn.topel@gmail.com>
References: <20161213134007.14707-1-bjorn.topel@gmail.com>
Message-ID: <20161213134007.14707-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bj?rn T?pel <bjorn.topel@intel.com>

This commit adds basic XDP support for i40e derived NICs. All XDP
actions will end up in XDP_DROP.

Only the default/main VSI has support for enabling XDP.

Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  13 +++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   4 +
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  83 +++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 123 +++++++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   2 +
 5 files changed, 219 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 0f2bf241b24e..be26986ed25f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -587,6 +587,8 @@ struct i40e_vsi {
 	struct i40e_ring **rx_rings;
 	struct i40e_ring **tx_rings;
 
+	bool xdp_enabled;
+
 	u32  active_filters;
 	u32  promisc_threshold;
 
@@ -946,4 +948,15 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
+
+/**
+ * i40e_enabled_xdp_vsi - Check if VSI has XDP enabled
+ * @vsi: pointer to a vsi
+ *
+ * Returns true if the VSI has XDP enabled.
+ **/
+static inline bool i40e_enabled_xdp_vsi(const struct i40e_vsi *vsi)
+{
+	return !!vsi->xdp_enabled;
+}
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index dece0d676482..ccb3b77405d7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1257,6 +1257,10 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
 
+	/* Don't allow any change while XDP is enabled. */
+	if (i40e_enabled_xdp_vsi(vsi))
+		return -EINVAL;
+
 	if (ring->tx_pending > I40E_MAX_NUM_DESCRIPTORS ||
 	    ring->tx_pending < I40E_MIN_NUM_DESCRIPTORS ||
 	    ring->rx_pending > I40E_MAX_NUM_DESCRIPTORS ||
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fd29ced281f3..e81d77b396d4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -24,6 +24,7 @@
  *
  ******************************************************************************/
 
+#include <linux/bpf.h>
 #include <linux/etherdevice.h>
 #include <linux/of_net.h>
 #include <linux/pci.h>
@@ -2481,6 +2482,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 
+	if (i40e_enabled_xdp_vsi(vsi)) {
+		int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+
+		if (max_frame > I40E_RXBUFFER_2048)
+			return -EINVAL;
+	}
+
 	netdev_info(netdev, "changing MTU from %d to %d\n",
 		    netdev->mtu, new_mtu);
 	netdev->mtu = new_mtu;
@@ -9328,6 +9336,78 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
 	return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
 }
 
+/**
+ * i40e_xdp_setup - Add/remove an XDP program to a VSI
+ * @vsi: the VSI to add the program
+ * @prog: the XDP program
+ **/
+static int i40e_xdp_setup(struct i40e_vsi *vsi,
+			  struct bpf_prog *prog)
+{
+	struct i40e_pf *pf = vsi->back;
+	struct net_device *netdev = vsi->netdev;
+	int i, frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	bool need_reset;
+	struct bpf_prog *old_prog;
+
+	/* The Rx frame has to fit in 2k */
+	if (frame_size > I40E_RXBUFFER_2048)
+		return -EINVAL;
+
+	if (!i40e_enabled_xdp_vsi(vsi) && !prog)
+		return 0;
+
+	if (prog) {
+		prog = bpf_prog_add(prog, vsi->num_queue_pairs - 1);
+		if (IS_ERR(prog))
+			return PTR_ERR(prog);
+	}
+
+	/* When turning XDP on->off/off->on we reset and rebuild the rings. */
+	need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog);
+
+	if (need_reset)
+		i40e_prep_for_reset(pf);
+
+	vsi->xdp_enabled = !!prog;
+
+	if (need_reset)
+		i40e_reset_and_rebuild(pf, true);
+
+	for (i = 0; i < vsi->num_queue_pairs; i++) {
+		old_prog = rtnl_dereference(vsi->rx_rings[i]->xdp_prog);
+		rcu_assign_pointer(vsi->rx_rings[i]->xdp_prog, prog);
+		if (old_prog)
+			bpf_prog_put(old_prog);
+	}
+	return 0;
+}
+
+/**
+ * i40e_xdp - NDO for enabled/query
+ * @dev: the netdev
+ * @xdp: XDP program
+ **/
+static int i40e_xdp(struct net_device *dev,
+		    struct netdev_xdp *xdp)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+
+	if (vsi->type != I40E_VSI_MAIN)
+		return -EINVAL;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return i40e_xdp_setup(vsi, xdp->prog);
+	case XDP_QUERY_PROG:
+		xdp->prog_attached = i40e_enabled_xdp_vsi(vsi);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_open		= i40e_open,
 	.ndo_stop		= i40e_close,
@@ -9364,6 +9444,7 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_features_check	= i40e_features_check,
 	.ndo_bridge_getlink	= i40e_ndo_bridge_getlink,
 	.ndo_bridge_setlink	= i40e_ndo_bridge_setlink,
+	.ndo_xdp                = i40e_xdp,
 };
 
 /**
@@ -11588,7 +11669,9 @@ static void i40e_remove(struct pci_dev *pdev)
 		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
 	}
 
+	rtnl_lock();
 	i40e_fdir_teardown(pf);
+	rtnl_unlock();
 
 	/* If there is a switch structure or any orphans, remove them.
 	 * This will leave only the PF's VSI remaining.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7dacde6608d1..2695cf9fc270 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -24,6 +24,7 @@
  *
  ******************************************************************************/
 
+#include <linux/bpf.h>
 #include <linux/prefetch.h>
 #include <net/busy_poll.h>
 #include "i40e.h"
@@ -1013,6 +1014,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 	struct device *dev = rx_ring->dev;
 	unsigned long bi_size;
 	u16 i;
+	struct bpf_prog *old_prog;
 
 	/* ring already cleared, nothing to do */
 	if (!rx_ring->rx_bi)
@@ -1046,6 +1048,11 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
 	rx_ring->next_to_use = 0;
+
+	old_prog = rtnl_dereference(rx_ring->xdp_prog);
+	RCU_INIT_POINTER(rx_ring->xdp_prog, NULL);
+	if (old_prog)
+		bpf_prog_put(old_prog);
 }
 
 /**
@@ -1620,19 +1627,83 @@ static bool i40e_add_rx_frag(struct i40e_ring *rx_ring,
 }
 
 /**
+ * i40e_run_xdp - Runs an XDP program for an Rx ring
+ * @rx_ring: Rx ring used for XDP
+ * @rx_buffer: current Rx buffer
+ * @rx_desc: current Rx descriptor
+ * @size: buffer size
+ * @xdp_prog: the XDP program to run
+ *
+ * Returns true if the XDP program consumed the incoming frame. False
+ * means pass the frame to the good old stack.
+ **/
+static bool i40e_run_xdp(struct i40e_ring *rx_ring,
+			 struct i40e_rx_buffer *rx_buffer,
+			 union i40e_rx_desc *rx_desc,
+			 unsigned int size,
+			 struct bpf_prog *xdp_prog)
+{
+	struct xdp_buff xdp;
+	u32 xdp_action;
+
+	if (unlikely(!i40e_test_staterr(rx_desc,
+					BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)))) {
+		dev_warn_once(&rx_ring->vsi->back->pdev->dev,
+			      "Received unexpected RXD_EOF!\n");
+		goto do_drop;
+	}
+
+	xdp.data = page_address(rx_buffer->page) + rx_buffer->page_offset;
+	xdp.data_end = xdp.data + size;
+	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp);
+
+	switch (xdp_action) {
+	case XDP_PASS:
+		return false;
+	default:
+		bpf_warn_invalid_xdp_action(xdp_action);
+	case XDP_ABORTED:
+	case XDP_TX:
+	case XDP_DROP:
+do_drop:
+		if (likely(i40e_page_is_reusable(rx_buffer->page))) {
+			i40e_reuse_rx_page(rx_ring, rx_buffer);
+			rx_ring->rx_stats.page_reuse_count++;
+			break;
+		}
+
+		/* we are not reusing the buffer so unmap it */
+		dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
+			       DMA_FROM_DEVICE);
+		__free_pages(rx_buffer->page, 0);
+	}
+
+	/* clear contents of buffer_info */
+	rx_buffer->page = NULL;
+	return true; /* Swallowed by XDP */
+}
+
+/**
  * i40e_fetch_rx_buffer - Allocate skb and populate it
  * @rx_ring: rx descriptor ring to transact packets on
  * @rx_desc: descriptor containing info written by hardware
+ * @skb: The allocated skb, if any
+ * @xdp_consumed_bytes: The size of the frame consumed by XDP
  *
- * This function allocates an skb on the fly, and populates it with the page
- * data from the current receive descriptor, taking care to set up the skb
- * correctly, as well as handling calling the page recycle function if
- * necessary.
+ * Unless XDP is enabled, this function allocates an skb on the fly,
+ * and populates it with the page data from the current receive
+ * descriptor, taking care to set up the skb correctly, as well as
+ * handling calling the page recycle function if necessary.
+ *
+ * If the received frame was handled by XDP, true is
+ * returned. Otherwise, the skb is returned to the caller via the skb
+ * parameter.
  */
 static inline
 struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 				     union i40e_rx_desc *rx_desc,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb,
+				     unsigned int *xdp_consumed_bytes)
 {
 	u64 local_status_error_len =
 		le64_to_cpu(rx_desc->wb.qword1.status_error_len);
@@ -1641,6 +1712,7 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 		I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
 	struct i40e_rx_buffer *rx_buffer;
 	struct page *page;
+	struct bpf_prog *xdp_prog;
 
 	rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
 	page = rx_buffer->page;
@@ -1653,6 +1725,19 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
 				      size,
 				      DMA_FROM_DEVICE);
 
+	rcu_read_lock();
+	xdp_prog = rcu_dereference(rx_ring->xdp_prog);
+	if (xdp_prog) {
+		bool xdp_consumed = i40e_run_xdp(rx_ring, rx_buffer, rx_desc,
+						 size, xdp_prog);
+		if (xdp_consumed) {
+			rcu_read_unlock();
+			*xdp_consumed_bytes = size;
+			return NULL;
+		}
+	}
+	rcu_read_unlock();
+
 	if (likely(!skb)) {
 		void *page_addr = page_address(page) + rx_buffer->page_offset;
 
@@ -1734,6 +1819,20 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
 }
 
 /**
+ * i40e_update_rx_next_to_clean - Bumps the next-to-clean for an Rx ing
+ * @rx_ring: Rx ring to bump
+ **/
+static void i40e_update_rx_next_to_clean(struct i40e_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(I40E_RX_DESC(rx_ring, ntc));
+}
+
+/**
  * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: rx descriptor ring to transact packets on
  * @budget: Total limit on number of packets to process
@@ -1757,6 +1856,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		u16 vlan_tag;
 		u8 rx_ptype;
 		u64 qword;
+		unsigned int xdp_consumed_bytes = 0;
 
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
@@ -1782,7 +1882,18 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		skb = i40e_fetch_rx_buffer(rx_ring, rx_desc, skb);
+		skb = i40e_fetch_rx_buffer(rx_ring, rx_desc, skb,
+					   &xdp_consumed_bytes);
+		if (xdp_consumed_bytes) {
+			cleaned_count++;
+
+			i40e_update_rx_next_to_clean(rx_ring);
+
+			total_rx_bytes += xdp_consumed_bytes;
+			total_rx_packets++;
+			continue;
+		}
+
 		if (!skb)
 			break;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index f80979025c01..78d0aa0468f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -361,6 +361,8 @@ struct i40e_ring {
 					 * i40e_clean_rx_ring_irq() is called
 					 * for this ring.
 					 */
+
+	struct bpf_prog __rcu *xdp_prog;
 } ____cacheline_internodealigned_in_smp;
 
 enum i40e_latency_range {
-- 
2.9.3

