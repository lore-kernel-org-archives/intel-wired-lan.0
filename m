From: John Fastabend <john.r.fastabend@intel.com>
Date: Fri, 08 May 2015 11:47:20 -0700
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: Allow flow director to
 use entire queue space
Message-ID: <20150508184720.22470.35134.stgit@jrfastab-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Flow director is exported to user space using the ethtool ntuple
support. However, currently it only supports steering traffic to a
subset of the queues in use by the hardware. This change allows
flow director to specify queues that have been assigned to virtual
functions or VMDQ pools.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   22 ++++++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   37 +++++++++++++++++++++-
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 0f1bff3..ccd661f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2595,16 +2595,18 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	struct ixgbe_fdir_filter *input;
 	union ixgbe_atr_input mask;
 	int err;
+	u8 queue;
 
 	if (!(adapter->flags & IXGBE_FLAG_FDIR_PERFECT_CAPABLE))
 		return -EOPNOTSUPP;
 
-	/*
-	 * Don't allow programming if the action is a queue greater than
-	 * the number of online Rx queues.
+	/* ring_cookie can not be larger than the total number of queues in use
+	 * by the device including the queues aassigned to virtual functions and
+	 * VMDQ pools.
 	 */
 	if ((fsp->ring_cookie != RX_CLS_FLOW_DISC) &&
-	    (fsp->ring_cookie >= adapter->num_rx_queues))
+	    (fsp->ring_cookie >=
+		(adapter->num_rx_queues * (adapter->num_vfs + 1))))
 		return -EINVAL;
 
 	/* Don't allow indexes to exist outside of available space */
@@ -2681,12 +2683,16 @@ static int ixgbe_add_ethtool_fdir_entry(struct ixgbe_adapter *adapter,
 	/* apply mask and compute/store hash */
 	ixgbe_atr_compute_perfect_hash_82599(&input->filter, &mask);
 
+	if (input->action < adapter->num_rx_queues)
+		queue = adapter->rx_ring[input->action]->reg_idx;
+	else if (input->action == IXGBE_FDIR_DROP_QUEUE)
+		queue = IXGBE_FDIR_DROP_QUEUE;
+	else
+		queue = input->action - adapter->num_rx_queues;
+
 	/* program filters to filter memory */
 	err = ixgbe_fdir_write_perfect_filter_82599(hw,
-				&input->filter, input->sw_idx,
-				(input->action == IXGBE_FDIR_DROP_QUEUE) ?
-				IXGBE_FDIR_DROP_QUEUE :
-				adapter->rx_ring[input->action]->reg_idx);
+				&input->filter, input->sw_idx, queue);
 	if (err)
 		goto err_out_w_lock;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ee600b2..23540dd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3166,8 +3166,20 @@ static void ixgbe_enable_rx_drop(struct ixgbe_adapter *adapter,
 	u8 reg_idx = ring->reg_idx;
 	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
 
+	pr_info("%s: enable_rx_drop on queue %d\n",
+		ixgbe_driver_string, reg_idx);
 	srrctl |= IXGBE_SRRCTL_DROP_EN;
+	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
+}
+
+static void ixgbe_enable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
 
+	pr_info("%s: enable_vf_rx_drop on queue %d\n",
+		ixgbe_driver_string, reg_idx);
+	srrctl |= IXGBE_SRRCTL_DROP_EN;
 	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
 }
 
@@ -3183,13 +3195,22 @@ static void ixgbe_disable_rx_drop(struct ixgbe_adapter *adapter,
 	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
 }
 
+static void ixgbe_disable_vf_rx_drop(struct ixgbe_adapter *adapter, u8 reg_idx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 srrctl = IXGBE_READ_REG(hw, IXGBE_SRRCTL(reg_idx));
+
+	srrctl &= ~IXGBE_SRRCTL_DROP_EN;
+	IXGBE_WRITE_REG(hw, IXGBE_SRRCTL(reg_idx), srrctl);
+}
+
 #ifdef CONFIG_IXGBE_DCB
 void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 #else
 static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 #endif
 {
-	int i;
+	int i, j;
 	bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
 
 	if (adapter->ixgbe_ieee_pfc)
@@ -3208,9 +3229,23 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 	    !(adapter->hw.fc.current_mode & ixgbe_fc_tx_pause) && !pfc_en)) {
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_enable_rx_drop(adapter, adapter->rx_ring[i]);
+		for (i = 0; i < adapter->num_vfs; i++) {
+			for (j = 0; j < adapter->num_rx_queues; j++) {
+				u8 q = i * adapter->num_rx_queues + j;
+
+				ixgbe_enable_vf_rx_drop(adapter, q);
+			}
+		}
 	} else {
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
+		for (i = 0; i < adapter->num_vfs; i++) {
+			for (j = 0; j < adapter->num_rx_queues; j++) {
+				u8 q = i * adapter->num_rx_queues + j;
+
+				ixgbe_disable_vf_rx_drop(adapter, q);
+			}
+		}
 	}
 }
 

