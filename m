From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:40 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 05/16] ixgbe: Fix
 limitations on macvlan so we can support up to 63 offloaded devices
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185640.29785.25035.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

This change is a fix of the macvlan offload so that we correctly handle
macvlan offloaded devices. Specificaly we were configuring our limits based
on the assumption that we were going to max out the RSS indices for every
mode. As a result when we went to 15 or more macvlan interfaces we were
forced into the 2 queue RSS mode on VFs even though they could have still
supported 4.

This change splits the logic up so that we limit either the total number of
macvlan instances if DCB is enabled, or limit the number of RSS queues used
per macvlan (instead of per pool) if SR-IOV is enabled. By doing this we
can make best use of the part.

In addition I have increased the maximum number of supported interfaces to
63 with one queue per offloaded interface as this more closely reflects the
actual values supported by the interface.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    6 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   |    9 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   35 ++++++++++--------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   27 ++++++-------------
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 92a784bd2ca2..7a421b70afce 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -395,8 +395,7 @@ enum ixgbe_ring_f_enum {
 #define MAX_XDP_QUEUES			(IXGBE_MAX_FDIR_INDICES + 1)
 #define IXGBE_MAX_L2A_QUEUES		4
 #define IXGBE_BAD_L2A_QUEUE		3
-#define IXGBE_MAX_MACVLANS		31
-#define IXGBE_MAX_DCBMACVLANS		8
+#define IXGBE_MAX_MACVLANS		63
 
 struct ixgbe_ring_feature {
 	u16 limit;	/* upper limit on feature indices */
@@ -765,7 +764,8 @@ struct ixgbe_adapter {
 #endif /*CONFIG_DEBUG_FS*/
 
 	u8 default_up;
-	unsigned long fwd_bitmask; /* Bitmask indicating in use pools */
+	/* Bitmask indicating in use pools */
+	DECLARE_BITMAP(fwd_bitmask, IXGBE_MAX_MACVLANS + 1);
 
 #define IXGBE_MAX_LINK_HANDLE 10
 	struct ixgbe_jump_table *jump_tables[IXGBE_MAX_LINK_HANDLE];
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 56622adc76dc..cceafbc3f1db 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -350,6 +350,9 @@ static bool ixgbe_set_dcb_sriov_queues(struct ixgbe_adapter *adapter)
 	if (!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED))
 		return false;
 
+	/* limit VMDq instances on the PF by number of Tx queues */
+	vmdq_i = min_t(u16, vmdq_i, MAX_TX_QUEUES / tcs);
+
 	/* Add starting offset to total pool count */
 	vmdq_i += adapter->ring_feature[RING_F_VMDQ].offset;
 
@@ -512,12 +515,14 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
 #ifdef IXGBE_FCOE
 	u16 fcoe_i = 0;
 #endif
-	bool pools = (find_first_zero_bit(&adapter->fwd_bitmask, 32) > 1);
 
 	/* only proceed if SR-IOV is enabled */
 	if (!(adapter->flags & IXGBE_FLAG_SRIOV_ENABLED))
 		return false;
 
+	/* limit l2fwd RSS based on total Tx queue limit */
+	rss_i = min_t(u16, rss_i, MAX_TX_QUEUES / vmdq_i);
+
 	/* Add starting offset to total pool count */
 	vmdq_i += adapter->ring_feature[RING_F_VMDQ].offset;
 
@@ -525,7 +530,7 @@ static bool ixgbe_set_sriov_queues(struct ixgbe_adapter *adapter)
 	vmdq_i = min_t(u16, IXGBE_MAX_VMDQ_INDICES, vmdq_i);
 
 	/* 64 pool mode with 2 queues per pool */
-	if ((vmdq_i > 32) || (vmdq_i > 16 && pools)) {
+	if (vmdq_i > 32) {
 		vmdq_m = IXGBE_82599_VMDQ_2Q_MASK;
 		rss_m = IXGBE_RSS_2Q_MASK;
 		rss_i = min_t(u16, rss_i, 2);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index c1df873faf68..101b3521ab0b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -5377,14 +5377,13 @@ static int ixgbe_fwd_ring_up(struct net_device *vdev,
 	unsigned int rxbase, txbase, queues;
 	int i, baseq, err = 0;
 
-	if (!test_bit(accel->pool, &adapter->fwd_bitmask))
+	if (!test_bit(accel->pool, adapter->fwd_bitmask))
 		return 0;
 
 	baseq = accel->pool * adapter->num_rx_queues_per_pool;
-	netdev_dbg(vdev, "pool %i:%i queues %i:%i VSI bitmask %lx\n",
+	netdev_dbg(vdev, "pool %i:%i queues %i:%i\n",
 		   accel->pool, adapter->num_rx_pools,
-		   baseq, baseq + adapter->num_rx_queues_per_pool,
-		   adapter->fwd_bitmask);
+		   baseq, baseq + adapter->num_rx_queues_per_pool);
 
 	accel->netdev = vdev;
 	accel->rx_base_queue = rxbase = baseq;
@@ -6282,7 +6281,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	}
 
 	/* PF holds first pool slot */
-	set_bit(0, &adapter->fwd_bitmask);
+	set_bit(0, adapter->fwd_bitmask);
 	set_bit(__IXGBE_DOWN, &adapter->state);
 
 	return 0;
@@ -8848,7 +8847,6 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 	struct ixgbe_hw *hw = &adapter->hw;
-	bool pools;
 
 	/* Hardware supports up to 8 traffic classes */
 	if (tc > adapter->dcb_cfg.num_tcs.pg_tcs)
@@ -8857,10 +8855,6 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	if (hw->mac.type == ixgbe_mac_82598EB && tc && tc < MAX_TRAFFIC_CLASS)
 		return -EINVAL;
 
-	pools = (find_first_zero_bit(&adapter->fwd_bitmask, 32) > 1);
-	if (tc && pools && adapter->num_rx_pools > IXGBE_MAX_DCBMACVLANS)
-		return -EBUSY;
-
 	/* Hardware has to reinitialize queues and interrupts to
 	 * match packet buffer alignment. Unfortunately, the
 	 * hardware is not flexible enough to do this dynamically.
@@ -9797,6 +9791,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	struct ixgbe_fwd_adapter *fwd_adapter = NULL;
 	struct ixgbe_adapter *adapter = netdev_priv(pdev);
 	int used_pools = adapter->num_vfs + adapter->num_rx_pools;
+	int tcs = netdev_get_num_tc(pdev) ? : 1;
 	unsigned int limit;
 	int pool, err;
 
@@ -9824,7 +9819,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	}
 
 	if (((adapter->flags & IXGBE_FLAG_DCB_ENABLED) &&
-	      adapter->num_rx_pools > IXGBE_MAX_DCBMACVLANS - 1) ||
+	      adapter->num_rx_pools >= (MAX_TX_QUEUES / tcs)) ||
 	    (adapter->num_rx_pools > IXGBE_MAX_MACVLANS))
 		return ERR_PTR(-EBUSY);
 
@@ -9832,9 +9827,9 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	if (!fwd_adapter)
 		return ERR_PTR(-ENOMEM);
 
-	pool = find_first_zero_bit(&adapter->fwd_bitmask, 32);
-	set_bit(pool, &adapter->fwd_bitmask);
-	limit = find_last_bit(&adapter->fwd_bitmask, 32);
+	pool = find_first_zero_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
+	set_bit(pool, adapter->fwd_bitmask);
+	limit = find_last_bit(adapter->fwd_bitmask, adapter->num_rx_pools + 1);
 
 	/* Enable VMDq flag so device will be set in VM mode */
 	adapter->flags |= IXGBE_FLAG_VMDQ_ENABLED | IXGBE_FLAG_SRIOV_ENABLED;
@@ -9860,7 +9855,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	/* unwind counter and free adapter struct */
 	netdev_info(pdev,
 		    "%s: dfwd hardware acceleration failed\n", vdev->name);
-	clear_bit(pool, &adapter->fwd_bitmask);
+	clear_bit(pool, adapter->fwd_bitmask);
 	kfree(fwd_adapter);
 	return ERR_PTR(err);
 }
@@ -9871,9 +9866,9 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	struct ixgbe_adapter *adapter = fwd_adapter->real_adapter;
 	unsigned int limit;
 
-	clear_bit(fwd_adapter->pool, &adapter->fwd_bitmask);
+	clear_bit(fwd_adapter->pool, adapter->fwd_bitmask);
 
-	limit = find_last_bit(&adapter->fwd_bitmask, 32);
+	limit = find_last_bit(adapter->fwd_bitmask, adapter->num_rx_pools);
 	adapter->ring_feature[RING_F_VMDQ].limit = limit + 1;
 	ixgbe_fwd_ring_down(fwd_adapter->netdev, fwd_adapter);
 
@@ -9888,11 +9883,11 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 	}
 
 	ixgbe_setup_tc(pdev, netdev_get_num_tc(pdev));
-	netdev_dbg(pdev, "pool %i:%i queues %i:%i VSI bitmask %lx\n",
+	netdev_dbg(pdev, "pool %i:%i queues %i:%i\n",
 		   fwd_adapter->pool, adapter->num_rx_pools,
 		   fwd_adapter->rx_base_queue,
-		   fwd_adapter->rx_base_queue + adapter->num_rx_queues_per_pool,
-		   adapter->fwd_bitmask);
+		   fwd_adapter->rx_base_queue +
+		   adapter->num_rx_queues_per_pool);
 	kfree(fwd_adapter);
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 15d89258fbc3..0085f4632966 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -290,10 +290,9 @@ static int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs)
 {
 #ifdef CONFIG_PCI_IOV
 	struct ixgbe_adapter *adapter = pci_get_drvdata(dev);
-	int err = 0;
-	u8 num_tc;
-	int i;
 	int pre_existing_vfs = pci_num_vf(dev);
+	int err = 0, num_rx_pools, i, limit;
+	u8 num_tc;
 
 	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
 		err = ixgbe_disable_sriov(adapter);
@@ -316,22 +315,14 @@ static int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs)
 	 * other values out of range.
 	 */
 	num_tc = netdev_get_num_tc(adapter->netdev);
+	num_rx_pools = adapter->num_rx_pools;
+	limit = (num_tc > 4) ? IXGBE_MAX_VFS_8TC :
+		(num_tc > 1) ? IXGBE_MAX_VFS_4TC : IXGBE_MAX_VFS_1TC;
 
-	if (num_tc > 4) {
-		if ((num_vfs + adapter->num_rx_pools) > IXGBE_MAX_VFS_8TC) {
-			e_dev_err("Currently the device is configured with %d TCs, Creating more than %d VFs is not allowed\n", num_tc, IXGBE_MAX_VFS_8TC);
-			return -EPERM;
-		}
-	} else if ((num_tc > 1) && (num_tc <= 4)) {
-		if ((num_vfs + adapter->num_rx_pools) > IXGBE_MAX_VFS_4TC) {
-			e_dev_err("Currently the device is configured with %d TCs, Creating more than %d VFs is not allowed\n", num_tc, IXGBE_MAX_VFS_4TC);
-			return -EPERM;
-		}
-	} else {
-		if ((num_vfs + adapter->num_rx_pools) > IXGBE_MAX_VFS_1TC) {
-			e_dev_err("Currently the device is configured with %d TCs, Creating more than %d VFs is not allowed\n", num_tc, IXGBE_MAX_VFS_1TC);
-			return -EPERM;
-		}
+	if (num_vfs > (limit - num_rx_pools)) {
+		e_dev_err("Currently configured with %d TCs, and %d offloaded macvlans. Creating more than %d VFs is not allowed\n",
+			  num_tc, num_rx_pools - 1, limit - num_rx_pools);
+		return -EPERM;
 	}
 
 	err = __ixgbe_enable_sriov(adapter, num_vfs);

