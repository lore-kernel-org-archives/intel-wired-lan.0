From: Jan Sokolowski <jan.sokolowski@intel.com>
Date: Wed, 20 Feb 2019 15:28:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: remove umem from
 adapter
In-Reply-To: <20190220152826.14083-1-jan.sokolowski@intel.com>
References: <20190220152826.14083-1-jan.sokolowski@intel.com>
Message-ID: <20190220152826.14083-2-jan.sokolowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As current implementation of netdev already contains and provides
umems for us, we no longer have the need to contain these
structures in ixgbe_adapter.

Refactor the code to operate on netdev-provided umems.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h     | 11 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 77 ++++----------------
 2 files changed, 19 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5f5db6eb261e..aa923d6d596b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -775,11 +775,6 @@ struct ixgbe_adapter {
 #ifdef CONFIG_IXGBE_IPSEC
 	struct ixgbe_ipsec *ipsec;
 #endif /* CONFIG_IXGBE_IPSEC */
-
-	/* AF_XDP zero-copy */
-	struct xdp_umem **xsk_umems;
-	u16 num_xsk_umems_used;
-	u16 num_xsk_umems;
 };
 
 static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
@@ -1040,4 +1035,10 @@ static inline int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter,
 static inline int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter,
 					u32 *mbuf, u32 vf) { return -EACCES; }
 #endif /* CONFIG_IXGBE_IPSEC */
+
+static inline bool ixgbe_enabled_xdp_adapter(struct ixgbe_adapter *adapter)
+{
+	return !!adapter->xdp_prog;
+}
+
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index fccfb422e45c..6587a583c8c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -14,58 +14,10 @@ struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
 	bool xdp_on = READ_ONCE(adapter->xdp_prog);
 	int qid = ring->ring_idx;
 
-	if (!adapter->xsk_umems || !adapter->xsk_umems[qid] ||
-	    qid >= adapter->num_xsk_umems || !xdp_on ||
-	    !test_bit(qid, adapter->af_xdp_zc_qps))
+	if (!xdp_on || !test_bit(qid, adapter->af_xdp_zc_qps))
 		return NULL;
 
-	return adapter->xsk_umems[qid];
-}
-
-static int ixgbe_alloc_xsk_umems(struct ixgbe_adapter *adapter)
-{
-	if (adapter->xsk_umems)
-		return 0;
-
-	adapter->num_xsk_umems_used = 0;
-	adapter->num_xsk_umems = adapter->num_rx_queues;
-	adapter->xsk_umems = kcalloc(adapter->num_xsk_umems,
-				     sizeof(*adapter->xsk_umems),
-				     GFP_KERNEL);
-	if (!adapter->xsk_umems) {
-		adapter->num_xsk_umems = 0;
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int ixgbe_add_xsk_umem(struct ixgbe_adapter *adapter,
-			      struct xdp_umem *umem,
-			      u16 qid)
-{
-	int err;
-
-	err = ixgbe_alloc_xsk_umems(adapter);
-	if (err)
-		return err;
-
-	adapter->xsk_umems[qid] = umem;
-	adapter->num_xsk_umems_used++;
-
-	return 0;
-}
-
-static void ixgbe_remove_xsk_umem(struct ixgbe_adapter *adapter, u16 qid)
-{
-	adapter->xsk_umems[qid] = NULL;
-	adapter->num_xsk_umems_used--;
-
-	if (adapter->num_xsk_umems == 0) {
-		kfree(adapter->xsk_umems);
-		adapter->xsk_umems = NULL;
-		adapter->num_xsk_umems = 0;
-	}
+	return xdp_get_umem_from_qid(adapter->netdev, qid);
 }
 
 static int ixgbe_xsk_umem_dma_map(struct ixgbe_adapter *adapter,
@@ -114,6 +66,7 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 				 struct xdp_umem *umem,
 				 u16 qid)
 {
+	struct net_device *netdev = adapter->netdev;
 	struct xdp_umem_fq_reuse *reuseq;
 	bool if_running;
 	int err;
@@ -121,12 +74,9 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 	if (qid >= adapter->num_rx_queues)
 		return -EINVAL;
 
-	if (adapter->xsk_umems) {
-		if (qid >= adapter->num_xsk_umems)
-			return -EINVAL;
-		if (adapter->xsk_umems[qid])
-			return -EBUSY;
-	}
+	if (qid >= netdev->real_num_rx_queues ||
+	    qid >= netdev->real_num_tx_queues)
+		return -EINVAL;
 
 	reuseq = xsk_reuseq_prepare(adapter->rx_ring[0]->count);
 	if (!reuseq)
@@ -139,13 +89,12 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 		return err;
 
 	if_running = netif_running(adapter->netdev) &&
-		     READ_ONCE(adapter->xdp_prog);
+		     ixgbe_enabled_xdp_adapter(adapter);
 
 	if (if_running)
 		ixgbe_txrx_ring_disable(adapter, qid);
 
 	set_bit(qid, adapter->af_xdp_zc_qps);
-	err = ixgbe_add_xsk_umem(adapter, umem, qid);
 
 	if (if_running)
 		ixgbe_txrx_ring_enable(adapter, qid);
@@ -155,21 +104,21 @@ static int ixgbe_xsk_umem_enable(struct ixgbe_adapter *adapter,
 
 static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 {
+	struct xdp_umem *umem;
 	bool if_running;
 
-	if (!adapter->xsk_umems || qid >= adapter->num_xsk_umems ||
-	    !adapter->xsk_umems[qid])
+	umem = xdp_get_umem_from_qid(adapter->netdev, qid);
+	if (!umem)
 		return -EINVAL;
 
 	if_running = netif_running(adapter->netdev) &&
-		     READ_ONCE(adapter->xdp_prog);
+		     ixgbe_enabled_xdp_adapter(adapter);
 
 	if (if_running)
 		ixgbe_txrx_ring_disable(adapter, qid);
 
 	clear_bit(qid, adapter->af_xdp_zc_qps);
-	ixgbe_xsk_umem_dma_unmap(adapter, adapter->xsk_umems[qid]);
-	ixgbe_remove_xsk_umem(adapter, qid);
+	ixgbe_xsk_umem_dma_unmap(adapter, umem);
 
 	if (if_running)
 		ixgbe_txrx_ring_enable(adapter, qid);
@@ -748,7 +697,7 @@ int ixgbe_xsk_async_xmit(struct net_device *dev, u32 qid)
 	if (qid >= adapter->num_xdp_queues)
 		return -ENXIO;
 
-	if (!adapter->xsk_umems || !adapter->xsk_umems[qid])
+	if (!adapter->xdp_ring[qid]->xsk_umem)
 		return -ENXIO;
 
 	ring = adapter->xdp_ring[qid];
-- 
2.18.1

