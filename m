From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 11 Jun 2018 13:41:24 -0400
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 6/7] net: allow
 ndo_select_queue to pass netdev
In-Reply-To: <20180611173003.41352.25621.stgit@ahduyck-green-test.jf.intel.com>
References: <20180611173003.41352.25621.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <20180611174124.41352.80522.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes it so that instead of passing a void pointer as the
accel_priv we instead pass a net_device pointer as sb_dev. Making this
change allows us to pass the subordinate device through to the fallback
function eventually so that we can keep the actual code in the
ndo_select_queue call as focused on possible on the exception cases.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/infiniband/hw/hfi1/vnic_main.c            |    2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c |    4 ++--
 drivers/net/bonding/bond_main.c                   |    3 ++-
 drivers/net/ethernet/amazon/ena/ena_netdev.c      |    3 ++-
 drivers/net/ethernet/broadcom/bcmsysport.c        |    2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   |    3 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |    3 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    3 ++-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     |    3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |    7 ++++---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c        |    3 ++-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |    3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |    3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |    3 ++-
 drivers/net/ethernet/renesas/ravb_main.c          |    3 ++-
 drivers/net/ethernet/sun/ldmvsw.c                 |    3 ++-
 drivers/net/ethernet/sun/sunvnet.c                |    3 ++-
 drivers/net/hyperv/netvsc_drv.c                   |    4 ++--
 drivers/net/net_failover.c                        |    5 +++--
 drivers/net/team/team.c                           |    3 ++-
 drivers/net/tun.c                                 |    3 ++-
 drivers/net/wireless/marvell/mwifiex/main.c       |    3 ++-
 drivers/net/xen-netback/interface.c               |    2 +-
 drivers/net/xen-netfront.c                        |    3 ++-
 drivers/staging/rtl8188eu/os_dep/os_intfs.c       |    3 ++-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c       |    7 +++----
 include/linux/netdevice.h                         |   11 +++++++----
 net/core/dev.c                                    |    6 ++++--
 net/mac80211/iface.c                              |    4 ++--
 net/packet/af_packet.c                            |    9 +++++++--
 30 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index 5d65582..616fc9b 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -423,7 +423,7 @@ static netdev_tx_t hfi1_netdev_start_xmit(struct sk_buff *skb,
 
 static u16 hfi1_vnic_select_queue(struct net_device *netdev,
 				  struct sk_buff *skb,
-				  void *accel_priv,
+				  struct net_device *sb_dev,
 				  select_queue_fallback_t fallback)
 {
 	struct hfi1_vnic_vport_info *vinfo = opa_vnic_dev_priv(netdev);
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
index 0c8aec6..6155878 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
@@ -95,7 +95,7 @@ static netdev_tx_t opa_netdev_start_xmit(struct sk_buff *skb,
 }
 
 static u16 opa_vnic_select_queue(struct net_device *netdev, struct sk_buff *skb,
-				 void *accel_priv,
+				 struct net_device *sb_dev,
 				 select_queue_fallback_t fallback)
 {
 	struct opa_vnic_adapter *adapter = opa_vnic_priv(netdev);
@@ -107,7 +107,7 @@ static u16 opa_vnic_select_queue(struct net_device *netdev, struct sk_buff *skb,
 	mdata->entropy = opa_vnic_calc_entropy(skb);
 	mdata->vl = opa_vnic_get_vl(adapter, skb);
 	rc = adapter->rn_ops->ndo_select_queue(netdev, skb,
-					       accel_priv, fallback);
+					       sb_dev, fallback);
 	skb_pull(skb, sizeof(*mdata));
 	return rc;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index bd53a71..e33f689 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4094,7 +4094,8 @@ static inline int bond_slave_override(struct bonding *bond,
 
 
 static u16 bond_select_queue(struct net_device *dev, struct sk_buff *skb,
-			     void *accel_priv, select_queue_fallback_t fallback)
+			     struct net_device *sb_dev,
+			     select_queue_fallback_t fallback)
 {
 	/* This helper function exists to help dev_pick_tx get the correct
 	 * destination queue.  Using a helper function skips a call to
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index f2af87d..e3befb1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2213,7 +2213,8 @@ static void ena_netpoll(struct net_device *netdev)
 #endif /* CONFIG_NET_POLL_CONTROLLER */
 
 static u16 ena_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    void *accel_priv, select_queue_fallback_t fallback)
+			    struct net_device *sb_dev,
+			    select_queue_fallback_t fallback)
 {
 	u16 qid;
 	/* we suspect that this is good for in--kernel network services that
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index d5fca2e..32f548e 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2107,7 +2107,7 @@ static int bcm_sysport_stop(struct net_device *dev)
 };
 
 static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
-				    void *accel_priv,
+				    struct net_device *sb_dev,
 				    select_queue_fallback_t fallback)
 {
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 8cd73ff..969dcc9 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -1905,7 +1905,8 @@ void bnx2x_netif_stop(struct bnx2x *bp, int disable_hw)
 }
 
 u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
-		       void *accel_priv, select_queue_fallback_t fallback)
+		       struct net_device *sb_dev,
+		       select_queue_fallback_t fallback)
 {
 	struct bnx2x *bp = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index a8ce5c5..0e508e5 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -497,7 +497,8 @@ int bnx2x_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos,
 
 /* select_queue callback */
 u16 bnx2x_select_queue(struct net_device *dev, struct sk_buff *skb,
-		       void *accel_priv, select_queue_fallback_t fallback);
+		       struct net_device *sb_dev,
+		       select_queue_fallback_t fallback);
 
 static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 					struct bnx2x_fastpath *fp,
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 35cb3ae..8de3039 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -929,7 +929,8 @@ static int setup_sge_queues(struct adapter *adap)
 }
 
 static u16 cxgb_select_queue(struct net_device *dev, struct sk_buff *skb,
-			     void *accel_priv, select_queue_fallback_t fallback)
+			     struct net_device *sb_dev,
+			     select_queue_fallback_t fallback)
 {
 	int txq;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 1ccb644..c36a231 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2022,7 +2022,8 @@ static void hns_nic_get_stats64(struct net_device *ndev,
 
 static u16
 hns_nic_select_queue(struct net_device *ndev, struct sk_buff *skb,
-		     void *accel_priv, select_queue_fallback_t fallback)
+		     struct net_device *sb_dev,
+		     select_queue_fallback_t fallback)
 {
 	struct ethhdr *eth_hdr = (struct ethhdr *)skb->data;
 	struct hns_nic_priv *priv = netdev_priv(ndev);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 053a54c..5d9867e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8221,15 +8221,16 @@ static void ixgbe_atr(struct ixgbe_ring *ring,
 
 #ifdef IXGBE_FCOE
 static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
-			      void *accel_priv, select_queue_fallback_t fallback)
+			      struct net_device *sb_dev,
+			      select_queue_fallback_t fallback)
 {
 	struct ixgbe_adapter *adapter;
 	struct ixgbe_ring_feature *f;
 	int txq;
 
-	if (accel_priv) {
+	if (sb_dev) {
 		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
-		struct net_device *vdev = accel_priv;
+		struct net_device *vdev = sb_dev;
 
 		txq = vdev->tc_to_txq[tc].offset;
 		txq += reciprocal_scale(skb_get_hash(skb),
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 0227786..df29966 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -688,7 +688,8 @@ static void build_inline_wqe(struct mlx4_en_tx_desc *tx_desc,
 }
 
 u16 mlx4_en_select_queue(struct net_device *dev, struct sk_buff *skb,
-			 void *accel_priv, select_queue_fallback_t fallback)
+			 struct net_device *sb_dev,
+			 select_queue_fallback_t fallback)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	u16 rings_p_up = priv->num_tx_rings_p_up;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index ace6545..c3228b8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -699,7 +699,8 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 
 void mlx4_en_tx_irq(struct mlx4_cq *mcq);
 u16 mlx4_en_select_queue(struct net_device *dev, struct sk_buff *skb,
-			 void *accel_priv, select_queue_fallback_t fallback);
+			 struct net_device *sb_dev,
+			 select_queue_fallback_t fallback);
 netdev_tx_t mlx4_en_xmit(struct sk_buff *skb, struct net_device *dev);
 netdev_tx_t mlx4_en_xmit_frame(struct mlx4_en_rx_ring *rx_ring,
 			       struct mlx4_en_rx_alloc *frame,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index eb9eb7a..df2d1e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -866,7 +866,8 @@ struct mlx5e_profile {
 void mlx5e_build_ptys2ethtool_map(void);
 
 u16 mlx5e_select_queue(struct net_device *dev, struct sk_buff *skb,
-		       void *accel_priv, select_queue_fallback_t fallback);
+		       struct net_device *sb_dev,
+		       select_queue_fallback_t fallback);
 netdev_tx_t mlx5e_xmit(struct sk_buff *skb, struct net_device *dev);
 netdev_tx_t mlx5e_sq_xmit(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 			  struct mlx5e_tx_wqe *wqe, u16 pi);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f29deb4..0119e86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -111,7 +111,8 @@ static inline int mlx5e_get_dscp_up(struct mlx5e_priv *priv, struct sk_buff *skb
 #endif
 
 u16 mlx5e_select_queue(struct net_device *dev, struct sk_buff *skb,
-		       void *accel_priv, select_queue_fallback_t fallback)
+		       struct net_device *sb_dev,
+		       select_queue_fallback_t fallback)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	int channel_ix = fallback(dev, skb);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 68f1221..4a7f54c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1656,7 +1656,8 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 }
 
 static u16 ravb_select_queue(struct net_device *ndev, struct sk_buff *skb,
-			     void *accel_priv, select_queue_fallback_t fallback)
+			     struct net_device *sb_dev,
+			     select_queue_fallback_t fallback)
 {
 	/* If skb needs TX timestamp, it is handled in network control queue */
 	return (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) ? RAVB_NC :
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index a5dd627..d42f47f 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -101,7 +101,8 @@ static struct vnet_port *vsw_tx_port_find(struct sk_buff *skb,
 }
 
 static u16 vsw_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    void *accel_priv, select_queue_fallback_t fallback)
+			    struct net_device *sb_dev,
+			    select_queue_fallback_t fallback)
 {
 	struct vnet_port *port = netdev_priv(dev);
 
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index a94f504..12539b3 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -234,7 +234,8 @@ static struct vnet_port *vnet_tx_port_find(struct sk_buff *skb,
 }
 
 static u16 vnet_select_queue(struct net_device *dev, struct sk_buff *skb,
-			     void *accel_priv, select_queue_fallback_t fallback)
+			     struct net_device *sb_dev,
+			     select_queue_fallback_t fallback)
 {
 	struct vnet *vp = netdev_priv(dev);
 	struct vnet_port *port = __tx_port_find(vp, skb);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 7b18a8c..0a01572 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -328,7 +328,7 @@ static u16 netvsc_pick_tx(struct net_device *ndev, struct sk_buff *skb)
 }
 
 static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
-			       void *accel_priv,
+			       struct net_device *sb_dev,
 			       select_queue_fallback_t fallback)
 {
 	struct net_device_context *ndc = netdev_priv(ndev);
@@ -342,7 +342,7 @@ static u16 netvsc_select_queue(struct net_device *ndev, struct sk_buff *skb,
 
 		if (vf_ops->ndo_select_queue)
 			txq = vf_ops->ndo_select_queue(vf_netdev, skb,
-						       accel_priv, fallback);
+						       sb_dev, fallback);
 		else
 			txq = fallback(vf_netdev, skb);
 
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index 83f7420..b2dc2e7 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -115,7 +115,8 @@ static netdev_tx_t net_failover_start_xmit(struct sk_buff *skb,
 }
 
 static u16 net_failover_select_queue(struct net_device *dev,
-				     struct sk_buff *skb, void *accel_priv,
+				     struct sk_buff *skb,
+				     struct net_device *sb_dev,
 				     select_queue_fallback_t fallback)
 {
 	struct net_failover_info *nfo_info = netdev_priv(dev);
@@ -128,7 +129,7 @@ static u16 net_failover_select_queue(struct net_device *dev,
 
 		if (ops->ndo_select_queue)
 			txq = ops->ndo_select_queue(primary_dev, skb,
-						    accel_priv, fallback);
+						    sb_dev, fallback);
 		else
 			txq = fallback(primary_dev, skb);
 
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 8863fa0..b704051 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1706,7 +1706,8 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 static u16 team_select_queue(struct net_device *dev, struct sk_buff *skb,
-			     void *accel_priv, select_queue_fallback_t fallback)
+			     struct net_device *sb_dev,
+			     select_queue_fallback_t fallback)
 {
 	/*
 	 * This helper function exists to help dev_pick_tx get the correct
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a192a01..76f0f41 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -607,7 +607,8 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    void *accel_priv, select_queue_fallback_t fallback)
+			    struct net_device *sb_dev,
+			    select_queue_fallback_t fallback)
 {
 	struct tun_struct *tun = netdev_priv(dev);
 	u16 ret;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 510f6b8..fa3e8dd 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1279,7 +1279,8 @@ static struct net_device_stats *mwifiex_get_stats(struct net_device *dev)
 
 static u16
 mwifiex_netdev_select_wmm_queue(struct net_device *dev, struct sk_buff *skb,
-				void *accel_priv, select_queue_fallback_t fallback)
+				struct net_device *sb_dev,
+				select_queue_fallback_t fallback)
 {
 	skb->priority = cfg80211_classify8021d(skb, NULL);
 	return mwifiex_1d_to_wmm_queue[skb->priority];
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index 78ebe49..19c4c58 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -148,7 +148,7 @@ void xenvif_wake_queue(struct xenvif_queue *queue)
 }
 
 static u16 xenvif_select_queue(struct net_device *dev, struct sk_buff *skb,
-			       void *accel_priv,
+			       struct net_device *sb_dev,
 			       select_queue_fallback_t fallback)
 {
 	struct xenvif *vif = netdev_priv(dev);
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 679da1a..3c21a8f 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -545,7 +545,8 @@ static int xennet_count_skb_slots(struct sk_buff *skb)
 }
 
 static u16 xennet_select_queue(struct net_device *dev, struct sk_buff *skb,
-			       void *accel_priv, select_queue_fallback_t fallback)
+			       struct net_device *sb_dev,
+			       select_queue_fallback_t fallback)
 {
 	unsigned int num_queues = dev->real_num_tx_queues;
 	u32 hash;
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index add1ba0..38e85c8 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -253,7 +253,8 @@ static unsigned int rtw_classify8021d(struct sk_buff *skb)
 }
 
 static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
-			    void *accel_priv, select_queue_fallback_t fallback)
+			    struct net_device *sb_dev,
+			    select_queue_fallback_t fallback)
 {
 	struct adapter	*padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index ace68f0..1816423 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -403,10 +403,9 @@ static unsigned int rtw_classify8021d(struct sk_buff *skb)
 }
 
 
-static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb
-				, void *accel_priv
-				, select_queue_fallback_t fallback
-)
+static u16 rtw_select_queue(struct net_device *dev, struct sk_buff *skb,
+			    struct net_device *sb_dev,
+			    select_queue_fallback_t fallback)
 {
 	struct adapter	*padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f277149..e366f42 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -945,7 +945,8 @@ struct dev_ifalias {
  *	those the driver believes to be appropriate.
  *
  * u16 (*ndo_select_queue)(struct net_device *dev, struct sk_buff *skb,
- *                         void *accel_priv, select_queue_fallback_t fallback);
+ *                         struct net_device *sb_dev,
+ *                         select_queue_fallback_t fallback);
  *	Called to decide which queue to use when device supports multiple
  *	transmit queues.
  *
@@ -1217,7 +1218,7 @@ struct net_device_ops {
 						      netdev_features_t features);
 	u16			(*ndo_select_queue)(struct net_device *dev,
 						    struct sk_buff *skb,
-						    void *accel_priv,
+						    struct net_device *sb_dev,
 						    select_queue_fallback_t fallback);
 	void			(*ndo_change_rx_flags)(struct net_device *dev,
 						       int flags);
@@ -2551,8 +2552,10 @@ struct net_device *__dev_get_by_flags(struct net *net, unsigned short flags,
 void dev_close_many(struct list_head *head, bool unlink);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
-u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb);
-u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb);
+u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
+		     struct net_device *sb_dev);
+u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
+		       struct net_device *sb_dev);
 int dev_queue_xmit(struct sk_buff *skb);
 int dev_queue_xmit_accel(struct sk_buff *skb, struct net_device *sb_dev);
 int dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
diff --git a/net/core/dev.c b/net/core/dev.c
index d746fdd..514dcec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3505,13 +3505,15 @@ static inline int get_xps_queue(struct net_device *dev,
 #endif
 }
 
-u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb)
+u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
+		     struct net_device *sb_dev)
 {
 	return 0;
 }
 EXPORT_SYMBOL(dev_pick_tx_zero);
 
-u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb)
+u16 dev_pick_tx_cpu_id(struct net_device *dev, struct sk_buff *skb,
+		       struct net_device *sb_dev)
 {
 	return (u16)raw_smp_processor_id() % dev->real_num_tx_queues;
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 555e389..5e6cf2c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1130,7 +1130,7 @@ static void ieee80211_uninit(struct net_device *dev)
 
 static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 					 struct sk_buff *skb,
-					 void *accel_priv,
+					 struct net_device *sb_dev,
 					 select_queue_fallback_t fallback)
 {
 	return ieee80211_select_queue(IEEE80211_DEV_TO_SUB_IF(dev), skb);
@@ -1176,7 +1176,7 @@ static u16 ieee80211_netdev_select_queue(struct net_device *dev,
 
 static u16 ieee80211_monitor_select_queue(struct net_device *dev,
 					  struct sk_buff *skb,
-					  void *accel_priv,
+					  struct net_device *sb_dev,
 					  select_queue_fallback_t fallback)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 015a18d..24b6e60 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -275,6 +275,11 @@ static bool packet_use_direct_xmit(const struct packet_sock *po)
 	return po->xmit == packet_direct_xmit;
 }
 
+static u16 packet_fallback(struct net_device *dev, struct sk_buff *skb)
+{
+	return dev_pick_tx_cpu_id(dev, skb, NULL);
+}
+
 static u16 packet_pick_tx_queue(struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
@@ -283,10 +288,10 @@ static u16 packet_pick_tx_queue(struct sk_buff *skb)
 
 	if (ops->ndo_select_queue) {
 		queue_index = ops->ndo_select_queue(dev, skb, NULL,
-						    dev_pick_tx_cpu_id);
+						    packet_fallback);
 		queue_index = netdev_cap_txqueue(dev, queue_index);
 	} else {
-		queue_index = dev_pick_tx_cpu_id(dev, skb);
+		queue_index = dev_pick_tx_cpu_id(dev, skb, NULL);
 	}
 
 	return queue_index;

