From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:57:11 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 10/16] ixgbe: Don't
 assume dev->num_tc is equal to hardware TC config
In-Reply-To: <20171122185256.29785.93548.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
Message-ID: <20171122185711.29785.52716.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The code throughout ixgbe was assuming that dev->num_tc was populated and
configured with the driver, when in fact this can be configured via mqprio
without any hardware coordination other than restricting us to the real
number of Tx queues we advertise.

Instead of handling things this way we need to keep a local copy of the
number of TCs in use so that we don't accidently pull in the TC
configuration from mqprio when it is configured in software mode.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c  |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   17 ++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   22 ++++++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   |    8 ++++----
 6 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 09def116bb48..5891731984b1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -672,6 +672,7 @@ struct ixgbe_adapter {
 	struct ieee_ets *ixgbe_ieee_ets;
 	struct ixgbe_dcb_config dcb_cfg;
 	struct ixgbe_dcb_config temp_dcb_cfg;
+	u8 hw_tcs;
 	u8 dcb_set_bitmap;
 	u8 dcbx_cap;
 	enum ixgbe_fc_mode last_lfc_mode;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index 78c52375acc6..b33f3f87e4b1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -571,7 +571,7 @@ static int ixgbe_dcbnl_ieee_setets(struct net_device *dev,
 	if (max_tc > adapter->dcb_cfg.num_tcs.pg_tcs)
 		return -EINVAL;
 
-	if (max_tc != netdev_get_num_tc(dev)) {
+	if (max_tc != adapter->hw_tcs) {
 		err = ixgbe_setup_tc(dev, max_tc);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 7634b1955863..539853aea8d2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3113,7 +3113,7 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 static unsigned int ixgbe_max_channels(struct ixgbe_adapter *adapter)
 {
 	unsigned int max_combined;
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	if (!(adapter->flags & IXGBE_FLAG_MSIX_ENABLED)) {
 		/* We only support one q_vector without MSI-X */
@@ -3170,7 +3170,7 @@ static void ixgbe_get_channels(struct net_device *dev,
 		return;
 
 	/* same thing goes for being DCB enabled */
-	if (netdev_get_num_tc(dev) > 1)
+	if (adapter->hw_tcs > 1)
 		return;
 
 	/* if ATR is disabled we can exit */
@@ -3216,7 +3216,7 @@ static int ixgbe_set_channels(struct net_device *dev,
 
 #endif
 	/* use setup TC to update any traffic class queue mapping */
-	return ixgbe_setup_tc(dev, netdev_get_num_tc(dev));
+	return ixgbe_setup_tc(dev, adapter->hw_tcs);
 }
 
 static int ixgbe_get_module_info(struct net_device *dev,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index cceafbc3f1db..df23a57ddb56 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -47,7 +47,7 @@ static bool ixgbe_cache_ring_dcb_sriov(struct ixgbe_adapter *adapter)
 	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
 	int i;
 	u16 reg_idx;
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	/* verify we have DCB queueing enabled before proceeding */
 	if (tcs <= 1)
@@ -111,9 +111,8 @@ static bool ixgbe_cache_ring_dcb_sriov(struct ixgbe_adapter *adapter)
 static void ixgbe_get_first_reg_idx(struct ixgbe_adapter *adapter, u8 tc,
 				    unsigned int *tx, unsigned int *rx)
 {
-	struct net_device *dev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
-	u8 num_tcs = netdev_get_num_tc(dev);
+	u8 num_tcs = adapter->hw_tcs;
 
 	*tx = 0;
 	*rx = 0;
@@ -168,10 +167,9 @@ static void ixgbe_get_first_reg_idx(struct ixgbe_adapter *adapter, u8 tc,
  **/
 static bool ixgbe_cache_ring_dcb(struct ixgbe_adapter *adapter)
 {
-	struct net_device *dev = adapter->netdev;
+	u8 num_tcs = adapter->hw_tcs;
 	unsigned int tx_idx, rx_idx;
 	int tc, offset, rss_i, i;
-	u8 num_tcs = netdev_get_num_tc(dev);
 
 	/* verify we have DCB queueing enabled before proceeding */
 	if (num_tcs <= 1)
@@ -340,7 +338,7 @@ static bool ixgbe_set_dcb_sriov_queues(struct ixgbe_adapter *adapter)
 #ifdef IXGBE_FCOE
 	u16 fcoe_i = 0;
 #endif
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	/* verify we have DCB queueing enabled before proceeding */
 	if (tcs <= 1)
@@ -440,7 +438,7 @@ static bool ixgbe_set_dcb_queues(struct ixgbe_adapter *adapter)
 	int tcs;
 
 	/* Map queue offset and counts onto allocated tx queues */
-	tcs = netdev_get_num_tc(dev);
+	tcs = adapter->hw_tcs;
 
 	/* verify we have DCB queueing enabled before proceeding */
 	if (tcs <= 1)
@@ -839,7 +837,7 @@ static int ixgbe_alloc_q_vector(struct ixgbe_adapter *adapter,
 	int node = NUMA_NO_NODE;
 	int cpu = -1;
 	int ring_count, size;
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	ring_count = txr_count + rxr_count + xdp_count;
 	size = sizeof(struct ixgbe_q_vector) +
@@ -1176,7 +1174,7 @@ static void ixgbe_set_interrupt_capability(struct ixgbe_adapter *adapter)
 	 */
 
 	/* Disable DCB unless we only have a single traffic class */
-	if (netdev_get_num_tc(adapter->netdev) > 1) {
+	if (adapter->hw_tcs > 1) {
 		e_dev_warn("Number of DCB TCs exceeds number of available queues. Disabling DCB support.\n");
 		netdev_reset_tc(adapter->netdev);
 
@@ -1188,6 +1186,7 @@ static void ixgbe_set_interrupt_capability(struct ixgbe_adapter *adapter)
 		adapter->dcb_cfg.pfc_mode_enable = false;
 	}
 
+	adapter->hw_tcs = 0;
 	adapter->dcb_cfg.num_tcs.pg_tcs = 1;
 	adapter->dcb_cfg.num_tcs.pfc_tcs = 1;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 611e6980b5ac..090d73df46cc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3572,7 +3572,7 @@ static void ixgbe_setup_mtqc(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 rttdcs, mtqc;
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	if (hw->mac.type == ixgbe_mac_82598EB)
 		return;
@@ -3927,7 +3927,7 @@ static void ixgbe_setup_mrqc(struct ixgbe_adapter *adapter)
 		if (adapter->ring_feature[RING_F_RSS].mask)
 			mrqc = IXGBE_MRQC_RSSEN;
 	} else {
-		u8 tcs = netdev_get_num_tc(adapter->netdev);
+		u8 tcs = adapter->hw_tcs;
 
 		if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) {
 			if (tcs > 4)
@@ -5195,7 +5195,7 @@ static int ixgbe_lpbthresh(struct ixgbe_adapter *adapter, int pb)
 static void ixgbe_pbthresh_setup(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	int num_tc = netdev_get_num_tc(adapter->netdev);
+	int num_tc = adapter->hw_tcs;
 	int i;
 
 	if (!num_tc)
@@ -5218,7 +5218,7 @@ static void ixgbe_configure_pb(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	int hdrm;
-	u8 tc = netdev_get_num_tc(adapter->netdev);
+	u8 tc = adapter->hw_tcs;
 
 	if (adapter->flags & IXGBE_FLAG_FDIR_HASH_CAPABLE ||
 	    adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE)
@@ -8867,6 +8867,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 		netdev_set_num_tc(dev, tc);
 		ixgbe_set_prio_tc_map(adapter);
 
+		adapter->hw_tcs = tc;
 		adapter->flags |= IXGBE_FLAG_DCB_ENABLED;
 
 		if (adapter->hw.mac.type == ixgbe_mac_82598EB) {
@@ -8880,6 +8881,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 			adapter->hw.fc.requested_mode = adapter->last_lfc_mode;
 
 		adapter->flags &= ~IXGBE_FLAG_DCB_ENABLED;
+		adapter->hw_tcs = tc;
 
 		adapter->temp_dcb_cfg.pfc_mode_enable = false;
 		adapter->dcb_cfg.pfc_mode_enable = false;
@@ -9410,7 +9412,7 @@ void ixgbe_sriov_reinit(struct ixgbe_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 
 	rtnl_lock();
-	ixgbe_setup_tc(netdev, netdev_get_num_tc(netdev));
+	ixgbe_setup_tc(netdev, adapter->hw_tcs);
 	rtnl_unlock();
 }
 
@@ -9486,7 +9488,7 @@ static int ixgbe_set_features(struct net_device *netdev,
 		/* We cannot enable ATR if SR-IOV is enabled */
 		if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED ||
 		    /* We cannot enable ATR if we have 2 or more tcs */
-		    (netdev_get_num_tc(netdev) > 1) ||
+		    (adapter->hw_tcs > 1) ||
 		    /* We cannot enable ATR if RSS is disabled */
 		    (adapter->ring_feature[RING_F_RSS].limit <= 1) ||
 		    /* A sample rate of 0 indicates ATR disabled */
@@ -9787,7 +9789,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	struct ixgbe_fwd_adapter *fwd_adapter = NULL;
 	struct ixgbe_adapter *adapter = netdev_priv(pdev);
 	int used_pools = adapter->num_vfs + adapter->num_rx_pools;
-	int tcs = netdev_get_num_tc(pdev) ? : 1;
+	int tcs = adapter->hw_tcs ? : 1;
 	unsigned int limit;
 	int pool, err;
 
@@ -9833,7 +9835,7 @@ static void *ixgbe_fwd_add(struct net_device *pdev, struct net_device *vdev)
 	adapter->ring_feature[RING_F_RSS].limit = vdev->num_tx_queues;
 
 	/* Force reinit of ring allocation with VMDQ enabled */
-	err = ixgbe_setup_tc(pdev, netdev_get_num_tc(pdev));
+	err = ixgbe_setup_tc(pdev, adapter->hw_tcs);
 	if (err)
 		goto fwd_add_err;
 	fwd_adapter->pool = pool;
@@ -9878,7 +9880,7 @@ static void ixgbe_fwd_del(struct net_device *pdev, void *priv)
 		adapter->ring_feature[RING_F_RSS].limit = rss;
 	}
 
-	ixgbe_setup_tc(pdev, netdev_get_num_tc(pdev));
+	ixgbe_setup_tc(pdev, adapter->hw_tcs);
 	netdev_dbg(pdev, "pool %i:%i queues %i:%i\n",
 		   fwd_adapter->pool, adapter->num_rx_pools,
 		   fwd_adapter->rx_base_queue,
@@ -9951,7 +9953,7 @@ static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
 
 	/* If transitioning XDP modes reconfigure rings */
 	if (!!prog != !!old_prog) {
-		int err = ixgbe_setup_tc(dev, netdev_get_num_tc(dev));
+		int err = ixgbe_setup_tc(dev, adapter->hw_tcs);
 
 		if (err) {
 			rcu_assign_pointer(adapter->xdp_prog, old_prog);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 543f2e60e4b7..27a70a52f3c9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -311,7 +311,7 @@ static int ixgbe_pci_sriov_enable(struct pci_dev *dev, int num_vfs)
 	 * than we have available pools. The PCI bus driver already checks for
 	 * other values out of range.
 	 */
-	num_tc = netdev_get_num_tc(adapter->netdev);
+	num_tc = adapter->hw_tcs;
 	num_rx_pools = adapter->num_rx_pools;
 	limit = (num_tc > 4) ? IXGBE_MAX_VFS_8TC :
 		(num_tc > 1) ? IXGBE_MAX_VFS_4TC : IXGBE_MAX_VFS_1TC;
@@ -713,7 +713,7 @@ static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct vf_data_storage *vfinfo = &adapter->vfinfo[vf];
-	u8 num_tcs = netdev_get_num_tc(adapter->netdev);
+	u8 num_tcs = adapter->hw_tcs;
 
 	/* remove VLAN filters beloning to this VF */
 	ixgbe_clear_vf_vlans(adapter, vf);
@@ -921,7 +921,7 @@ static int ixgbe_set_vf_vlan_msg(struct ixgbe_adapter *adapter,
 {
 	u32 add = (msgbuf[0] & IXGBE_VT_MSGINFO_MASK) >> IXGBE_VT_MSGINFO_SHIFT;
 	u32 vid = (msgbuf[1] & IXGBE_VLVF_VLANID_MASK);
-	u8 tcs = netdev_get_num_tc(adapter->netdev);
+	u8 tcs = adapter->hw_tcs;
 
 	if (adapter->vfinfo[vf].pf_vlan || tcs) {
 		e_warn(drv,
@@ -1009,7 +1009,7 @@ static int ixgbe_get_vf_queues(struct ixgbe_adapter *adapter,
 	struct net_device *dev = adapter->netdev;
 	struct ixgbe_ring_feature *vmdq = &adapter->ring_feature[RING_F_VMDQ];
 	unsigned int default_tc = 0;
-	u8 num_tcs = netdev_get_num_tc(dev);
+	u8 num_tcs = adapter->hw_tcs;
 
 	/* verify the PF is supporting the correct APIs */
 	switch (adapter->vfinfo[vf].vf_api) {

