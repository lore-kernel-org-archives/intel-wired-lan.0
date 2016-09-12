From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:38 -0700
Subject: [Intel-wired-lan] [next PATCH S46 2/8] i40evf: enable adaptive
	interrupt throttling
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

All of the code to support adaptive interrupt throttling is already in
the interrupt handler, it just needs to be enabled. Fill out the data
structures properly to make it happen. Single-flow traffic tests may
show slightly lower throughput, but interrupts per second will drop by
about 75%.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I9cd7d42c025b906bf1bb85c6aeb6112684aa6471
---
Testing Hints : Use itop to monitor interrupt load
and run netperf.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 064419e..302c974 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -370,6 +370,8 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 {
 	struct i40e_q_vector *q_vector = &adapter->q_vectors[v_idx];
 	struct i40e_ring *rx_ring = &adapter->rx_rings[r_idx];
+	struct i40e_vsi *vsi = &adapter->vsi;
+	struct i40e_hw *hw = &adapter->hw;
 
 	rx_ring->q_vector = q_vector;
 	rx_ring->next = q_vector->rx.ring;
@@ -377,7 +379,10 @@ i40evf_map_vector_to_rxq(struct i40evf_adapter *adapter, int v_idx, int r_idx)
 	q_vector->rx.ring = rx_ring;
 	q_vector->rx.count++;
 	q_vector->rx.latency_range = I40E_LOW_LATENCY;
+	q_vector->rx.itr = ITR_TO_REG(vsi->rx_itr_setting);
+	q_vector->ring_mask |= BIT(r_idx);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
+	wr32(hw, I40E_VFINT_ITRN1(I40E_RX_ITR, v_idx - 1), q_vector->rx.itr);
 }
 
 /**
@@ -391,6 +396,8 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 {
 	struct i40e_q_vector *q_vector = &adapter->q_vectors[v_idx];
 	struct i40e_ring *tx_ring = &adapter->tx_rings[t_idx];
+	struct i40e_vsi *vsi = &adapter->vsi;
+	struct i40e_hw *hw = &adapter->hw;
 
 	tx_ring->q_vector = q_vector;
 	tx_ring->next = q_vector->tx.ring;
@@ -398,9 +405,10 @@ i40evf_map_vector_to_txq(struct i40evf_adapter *adapter, int v_idx, int t_idx)
 	q_vector->tx.ring = tx_ring;
 	q_vector->tx.count++;
 	q_vector->tx.latency_range = I40E_LOW_LATENCY;
+	q_vector->tx.itr = ITR_TO_REG(vsi->tx_itr_setting);
 	q_vector->itr_countdown = ITR_COUNTDOWN_START;
 	q_vector->num_ringpairs++;
-	q_vector->ring_mask |= BIT(t_idx);
+	wr32(hw, I40E_VFINT_ITRN1(I40E_TX_ITR, v_idx - 1), q_vector->tx.itr);
 }
 
 /**
@@ -2269,10 +2277,8 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	adapter->vsi.back = adapter;
 	adapter->vsi.base_vector = 1;
 	adapter->vsi.work_limit = I40E_DEFAULT_IRQ_WORK;
-	adapter->vsi.rx_itr_setting = (I40E_ITR_DYNAMIC |
-				       ITR_REG_TO_USEC(I40E_ITR_RX_DEF));
-	adapter->vsi.tx_itr_setting = (I40E_ITR_DYNAMIC |
-				       ITR_REG_TO_USEC(I40E_ITR_TX_DEF));
+	adapter->vsi.rx_itr_setting = (I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF);
+	adapter->vsi.tx_itr_setting = (I40E_ITR_DYNAMIC | I40E_ITR_TX_DEF);
 	vsi->netdev = adapter->netdev;
 	vsi->qs_handle = adapter->vsi_res->qset_handle;
 	if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_RSS_PF) {
-- 
2.4.11

