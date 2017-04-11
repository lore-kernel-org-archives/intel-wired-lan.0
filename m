From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 11 Apr 2017 20:31:08 +0000
Subject: [Intel-wired-lan] [PATCH v7 1/2] ixgbe: add XDP support for
 pass	and drop actions
In-Reply-To: <20170324043110.10293.50132.stgit@john-Precision-Tower-5810>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
 <20170324043110.10293.50132.stgit@john-Precision-Tower-5810>
Message-ID: <87618083B2453E4A8714035B62D679927E4AC526@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of John Fastabend
>Sent: Thursday, March 23, 2017 9:31 PM
To: john.fastabend@gmail.com; alexander.duyck at gmail.com
>Cc: intel-wired-lan at lists.osuosl.org; u9012063 at gmail.com
>Subject: [Intel-wired-lan] [PATCH v7 1/2] ixgbe: add XDP support for pass
>and drop actions
>
>Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
>programs instead of rcu primitives as suggested by Daniel Borkmann and
>Alex Duyck.
>
>Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 -
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 -
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  163
>+++++++++++++++++++---
> 3 files changed, 144 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>index 656ca8f..cb14813 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>@@ -318,6 +318,7 @@ struct ixgbe_ring {
> 	struct ixgbe_ring *next;	/* pointer to next ring in q_vector */
> 	struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
> 	struct net_device *netdev;	/* netdev ring belongs to */
>+	struct bpf_prog *xdp_prog;
> 	struct device *dev;		/* device for DMA mapping */
> 	struct ixgbe_fwd_adapter *l2_accel_priv;
> 	void *desc;			/* descriptor ring memory */
>@@ -555,6 +556,7 @@ struct ixgbe_adapter {
> 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> 	/* OS defined structs */
> 	struct net_device *netdev;
>+	struct bpf_prog *xdp_prog;
> 	struct pci_dev *pdev;
>
> 	unsigned long state;
>@@ -835,7 +837,7 @@ enum ixgbe_boards {
> void ixgbe_reinit_locked(struct ixgbe_adapter *adapter);
> void ixgbe_reset(struct ixgbe_adapter *adapter);
> void ixgbe_set_ethtool_ops(struct net_device *netdev);
>-int ixgbe_setup_rx_resources(struct ixgbe_ring *);
>+int ixgbe_setup_rx_resources(struct ixgbe_adapter *, struct ixgbe_ring *);
> int ixgbe_setup_tx_resources(struct ixgbe_ring *);
> void ixgbe_free_rx_resources(struct ixgbe_ring *);
> void ixgbe_free_tx_resources(struct ixgbe_ring *);
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>index 59730ed..79a126d 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>@@ -1128,7 +1128,7 @@ static int ixgbe_set_ringparam(struct net_device
>*netdev,
> 			       sizeof(struct ixgbe_ring));
>
> 			temp_ring[i].count = new_rx_count;
>-			err = ixgbe_setup_rx_resources(&temp_ring[i]);
>+			err = ixgbe_setup_rx_resources(adapter, &temp_ring[i]);
> 			if (err) {
> 				while (i) {
> 					i--;
>@@ -1761,7 +1761,7 @@ static int ixgbe_setup_desc_rings(struct
>ixgbe_adapter *adapter)
> 	rx_ring->netdev = adapter->netdev;
> 	rx_ring->reg_idx = adapter->rx_ring[0]->reg_idx;
>
>-	err = ixgbe_setup_rx_resources(rx_ring);
>+	err = ixgbe_setup_rx_resources(adapter, rx_ring);
> 	if (err) {
> 		ret_val = 4;
> 		goto err_nomem;
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>index 91c1cda..ddb75ba 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>@@ -49,6 +49,9 @@
> #include <linux/if_macvlan.h>
> #include <linux/if_bridge.h>
> #include <linux/prefetch.h>
>+#include <linux/bpf.h>
>+#include <linux/bpf_trace.h>
>+#include <linux/atomic.h>
> #include <scsi/fc/fc_fcoe.h>
> #include <net/udp_tunnel.h>
> #include <net/pkt_cls.h>
>@@ -1858,6 +1861,10 @@ static void ixgbe_dma_sync_frag(struct ixgbe_ring
>*rx_ring,
>  * @rx_desc: pointer to the EOP Rx descriptor
>  * @skb: pointer to current skb being fixed
>  *
>+ * Check if the skb is valid in the XDP case it will be an error pointer.
>+ * Return true in this case to abort processing and advance to next
>+ * descriptor.
>+ *
>  * Check for corrupted packet headers caused by senders on the local L2
>  * embedded NIC switch not setting up their Tx Descriptors right.  These
>  * should be very rare.
>@@ -1876,6 +1883,10 @@ static bool ixgbe_cleanup_headers(struct ixgbe_ring
>*rx_ring,
> {
> 	struct net_device *netdev = rx_ring->netdev;
>
>+	/* XDP packets use error pointer so abort at this point */
>+	if (IS_ERR(skb))
>+		return true;
>+
> 	/* verify that the packet does not have any known errors */
> 	if (unlikely(ixgbe_test_staterr(rx_desc,
> 					IXGBE_RXDADV_ERR_FRAME_ERR_MASK) &&
>@@ -2051,7 +2062,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring
>*rx_ring,
> 		/* hand second half of page back to the ring */
> 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
> 	} else {
>-		if (IXGBE_CB(skb)->dma == rx_buffer->dma) {
>+		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
> 			/* the page has been released from the ring */
> 			IXGBE_CB(skb)->page_released = true;
> 		} else {
>@@ -2072,10 +2083,10 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring
>*rx_ring,
>
> static struct sk_buff *ixgbe_construct_skb(struct ixgbe_ring *rx_ring,
> 					   struct ixgbe_rx_buffer *rx_buffer,
>-					   union ixgbe_adv_rx_desc *rx_desc,
>-					   unsigned int size)
>+					   struct xdp_buff *xdp,
>+					   union ixgbe_adv_rx_desc *rx_desc)
> {
>-	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
>+	unsigned int size = xdp->data_end - xdp->data;
> #if (PAGE_SIZE < 8192)
> 	unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
> #else
>@@ -2084,9 +2095,9 @@ static struct sk_buff *ixgbe_construct_skb(struct
>ixgbe_ring *rx_ring,
> 	struct sk_buff *skb;
>
> 	/* prefetch first cache line of first page */
>-	prefetch(va);
>+	prefetch(xdp->data);
> #if L1_CACHE_BYTES < 128
>-	prefetch(va + L1_CACHE_BYTES);
>+	prefetch(xdp->data + L1_CACHE_BYTES);
> #endif
>
> 	/* allocate a skb to store the frags */
>@@ -2099,7 +2110,7 @@ static struct sk_buff *ixgbe_construct_skb(struct
>ixgbe_ring *rx_ring,
> 			IXGBE_CB(skb)->dma = rx_buffer->dma;
>
> 		skb_add_rx_frag(skb, 0, rx_buffer->page,
>-				rx_buffer->page_offset,
>+				xdp->data - page_address(rx_buffer->page),
> 				size, truesize);
> #if (PAGE_SIZE < 8192)
> 		rx_buffer->page_offset ^= truesize;
>@@ -2107,7 +2118,8 @@ static struct sk_buff *ixgbe_construct_skb(struct
>ixgbe_ring *rx_ring,
> 		rx_buffer->page_offset += truesize;
> #endif
> 	} else {
>-		memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
>+		memcpy(__skb_put(skb, size),
>+		       xdp->data, ALIGN(size, sizeof(long)));
> 		rx_buffer->pagecnt_bias++;
> 	}
>
>@@ -2116,10 +2128,9 @@ static struct sk_buff *ixgbe_construct_skb(struct
>ixgbe_ring *rx_ring,
>
> static struct sk_buff *ixgbe_build_skb(struct ixgbe_ring *rx_ring,
> 				       struct ixgbe_rx_buffer *rx_buffer,
>-				       union ixgbe_adv_rx_desc *rx_desc,
>-				       unsigned int size)
>+				       struct xdp_buff *xdp,
>+				       union ixgbe_adv_rx_desc *rx_desc)
> {
>-	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> #if (PAGE_SIZE < 8192)
> 	unsigned int truesize = ixgbe_rx_pg_size(rx_ring) / 2;
> #else

This patch introduces a build error in the case where PAGE_SIZE >= 8192
because the "size" parameter was removed from the function parameters, but
it is still being used to calculate truesize for that case.

Thanks,
Emil
