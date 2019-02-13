From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 13 Feb 2019 18:07:29 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next] net: bpf: remove
 XDP_QUERY_XSK_UMEM enumerator
Message-ID: <20190213170729.13845-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

Commit c9b47cc1fabc ("xsk: fix bug when trying to use both copy and
zero-copy on one queue id") moved the umem query code to the AF_XDP
core, and therefore removed the need to query the netdevice for a
umem.

This patch removes XDP_QUERY_XSK_UMEM and all code that implement that
behavior, which is just dead code.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 --
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 28 -------------------
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  3 --
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |  2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 17 -----------
 include/linux/netdevice.h                     |  7 ++---
 7 files changed, 3 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 44856a84738d..5e74a5127849 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12128,9 +12128,6 @@ static int i40e_xdp(struct net_device *dev,
 	case XDP_QUERY_PROG:
 		xdp->prog_id = vsi->xdp_prog ? vsi->xdp_prog->aux->id : 0;
 		return 0;
-	case XDP_QUERY_XSK_UMEM:
-		return i40e_xsk_umem_query(vsi, &xdp->xsk.umem,
-					   xdp->xsk.queue_id);
 	case XDP_SETUP_XSK_UMEM:
 		return i40e_xsk_umem_setup(vsi, xdp->xsk.umem,
 					   xdp->xsk.queue_id);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 96d849460d9b..e190a2c2b9ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -154,34 +154,6 @@ static int i40e_xsk_umem_disable(struct i40e_vsi *vsi, u16 qid)
 	return 0;
 }
 
-/**
- * i40e_xsk_umem_query - Queries a certain ring/qid for its UMEM
- * @vsi: Current VSI
- * @umem: UMEM associated to the ring, if any
- * @qid: Rx ring to associate UMEM to
- *
- * This function will store, if any, the UMEM associated to certain ring.
- *
- * Returns 0 on success, <0 on failure
- **/
-int i40e_xsk_umem_query(struct i40e_vsi *vsi, struct xdp_umem **umem,
-			u16 qid)
-{
-	struct net_device *netdev = vsi->netdev;
-	struct xdp_umem *queried_umem;
-
-	if (vsi->type != I40E_VSI_MAIN)
-		return -EINVAL;
-
-	queried_umem = xdp_get_umem_from_qid(netdev, qid);
-
-	if (!queried_umem)
-		return -EINVAL;
-
-	*umem = queried_umem;
-	return 0;
-}
-
 /**
  * i40e_xsk_umem_setup - Enable/disassociate a UMEM to/from a ring/qid
  * @vsi: Current VSI
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index 9038c5d5cf08..8cc0a2e7d9a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -10,8 +10,6 @@ struct zero_copy_allocator;
 
 int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair);
 int i40e_queue_pair_enable(struct i40e_vsi *vsi, int queue_pair);
-int i40e_xsk_umem_query(struct i40e_vsi *vsi, struct xdp_umem **umem,
-			u16 qid);
 int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
 			u16 qid);
 void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b53087a980ef..38c430b94ae3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10280,9 +10280,6 @@ static int ixgbe_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 		xdp->prog_id = adapter->xdp_prog ?
 			adapter->xdp_prog->aux->id : 0;
 		return 0;
-	case XDP_QUERY_XSK_UMEM:
-		return ixgbe_xsk_umem_query(adapter, &xdp->xsk.umem,
-					    xdp->xsk.queue_id);
 	case XDP_SETUP_XSK_UMEM:
 		return ixgbe_xsk_umem_setup(adapter, xdp->xsk.umem,
 					    xdp->xsk.queue_id);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
index 53d4089f5644..d93a690aff74 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_txrx_common.h
@@ -30,8 +30,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring);
 
 struct xdp_umem *ixgbe_xsk_umem(struct ixgbe_adapter *adapter,
 				struct ixgbe_ring *ring);
-int ixgbe_xsk_umem_query(struct ixgbe_adapter *adapter, struct xdp_umem **umem,
-			 u16 qid);
 int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
 			 u16 qid);
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 65c3e2c979d4..98870707b51a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -174,23 +174,6 @@ static int ixgbe_xsk_umem_disable(struct ixgbe_adapter *adapter, u16 qid)
 	return 0;
 }
 
-int ixgbe_xsk_umem_query(struct ixgbe_adapter *adapter, struct xdp_umem **umem,
-			 u16 qid)
-{
-	if (qid >= adapter->num_rx_queues)
-		return -EINVAL;
-
-	if (adapter->xsk_umems) {
-		if (qid >= adapter->num_xsk_umems)
-			return -EINVAL;
-		*umem = adapter->xsk_umems[qid];
-		return 0;
-	}
-
-	*umem = NULL;
-	return 0;
-}
-
 int ixgbe_xsk_umem_setup(struct ixgbe_adapter *adapter, struct xdp_umem *umem,
 			 u16 qid)
 {
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1d95e634f3fe..6aedaf1e9a25 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -868,7 +868,6 @@ enum bpf_netdev_command {
 	/* BPF program for offload callbacks, invoked at program load time. */
 	BPF_OFFLOAD_MAP_ALLOC,
 	BPF_OFFLOAD_MAP_FREE,
-	XDP_QUERY_XSK_UMEM,
 	XDP_SETUP_XSK_UMEM,
 };
 
@@ -895,10 +894,10 @@ struct netdev_bpf {
 		struct {
 			struct bpf_offloaded_map *offmap;
 		};
-		/* XDP_QUERY_XSK_UMEM, XDP_SETUP_XSK_UMEM */
+		/* XDP_SETUP_XSK_UMEM */
 		struct {
-			struct xdp_umem *umem; /* out for query*/
-			u16 queue_id; /* in for query */
+			struct xdp_umem *umem;
+			u16 queue_id;
 		} xsk;
 	};
 };
-- 
2.19.1

