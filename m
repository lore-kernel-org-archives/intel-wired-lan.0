From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:12:02 -0800
Subject: [Intel-wired-lan] [PATCH S55 03/14] ice: Add Support for XPS
In-Reply-To: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181213.51718-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Benita Bose <benita.bose@intel.com>

Enable and configure XPS. The driver code implemented sets up the Transmit
Packet Steering Map, which in turn will be used by the kernel in queue
selection during Tx.

Signed-off-by: Benita Bose <benita.bose@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
Note: Emails to Benita will bounce as she has since left Intel
---
 drivers/net/ethernet/intel/ice/ice_base.c | 23 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index a99658462e29..c28cfd85587f 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -214,6 +214,26 @@ static u16 ice_calc_q_handle(struct ice_vsi *vsi, struct ice_ring *ring, u8 tc)
 	return ring->q_index - vsi->tc_cfg.tc_info[tc].qoffset;
 }
 
+/**
+ * ice_cfg_xps_tx_ring - Configure XPS for a Tx ring
+ * @ring: The Tx ring to configure
+ *
+ * This enables/disables XPS for a given Tx descriptor ring
+ * based on the TCs enabled for the VSI that ring belongs to.
+ */
+static void ice_cfg_xps_tx_ring(struct ice_ring *ring)
+{
+	if (!ring->q_vector || !ring->netdev)
+		return;
+
+	/* We only initialize XPS once, so as not to overwrite user settings */
+	if (test_and_set_bit(ICE_TX_XPS_INIT_DONE, ring->xps_state))
+		return;
+
+	netif_set_xps_queue(ring->netdev, &ring->q_vector->affinity_mask,
+			    ring->q_index);
+}
+
 /**
  * ice_setup_tx_ctx - setup a struct ice_tlan_ctx instance
  * @ring: The Tx ring to configure
@@ -672,6 +692,9 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_ring *ring,
 	u16 pf_q;
 	u8 tc;
 
+	/* Configure XPS */
+	ice_cfg_xps_tx_ring(ring);
+
 	pf_q = ring->reg_idx;
 	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
 	/* copy context contents into the qg_buf */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 9d14bac658df..f72b154b03c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -195,6 +195,11 @@ struct ice_rxq_stats {
 	u64 gro_dropped; /* GRO returned dropped */
 };
 
+enum ice_ring_state_t {
+	ICE_TX_XPS_INIT_DONE,
+	ICE_TX_NBITS,
+};
+
 /* this enum matches hardware bits and is meant to be used by DYN_CTLN
  * registers and QINT registers or more generally anywhere in the manual
  * mentioning ITR_INDX, ITR_NONE cannot be used as an index 'n' into any
@@ -294,6 +299,7 @@ struct ice_ring {
 	};
 
 	struct rcu_head rcu;		/* to avoid race on free */
+	DECLARE_BITMAP(xps_state, ICE_TX_NBITS);	/* XPS Config State */
 	struct bpf_prog *xdp_prog;
 	struct xsk_buff_pool *xsk_pool;
 	u16 rx_offset;
-- 
2.20.1

