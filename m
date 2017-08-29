From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:35 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 06/13] i40e/i40evf: use
	DECLARE_BITMAP for state
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

When using set_bit and friends, we should be using actual
bitmaps, and fix all the locations where we might access
it.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 3 ++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e9fc34c..1764fd2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2892,7 +2892,7 @@ static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
 		return;
 
 	if ((vsi->tc_config.numtc <= 1) &&
-	    !test_and_set_bit(__I40E_TX_XPS_INIT_DONE, &ring->state)) {
+	    !test_and_set_bit(__I40E_TX_XPS_INIT_DONE, ring->state)) {
 		cpu = cpumask_local_spread(ring->q_vector->v_idx, -1);
 		netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
 				    ring->queue_index);
@@ -3011,7 +3011,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	struct i40e_hmc_obj_rxq rx_ctx;
 	i40e_status err = 0;
 
-	ring->state = 0;
+	bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
 
 	/* clear the context structure first */
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 2f848bc..a4e3e66 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -342,6 +342,7 @@ struct i40e_rx_queue_stats {
 enum i40e_ring_state_t {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
+	__I40E_RING_STATE_NBITS /* must be last */
 };
 
 /* some useful defines for virtchannel interface, which
@@ -366,7 +367,7 @@ struct i40e_ring {
 		struct i40e_tx_buffer *tx_bi;
 		struct i40e_rx_buffer *rx_bi;
 	};
-	unsigned long state;
+	DECLARE_BITMAP(state, __I40E_RING_STATE_NBITS);
 	u16 queue_index;		/* Queue number of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 0d9f98b..d8ca802 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -325,6 +325,7 @@ struct i40e_rx_queue_stats {
 enum i40e_ring_state_t {
 	__I40E_TX_FDIR_INIT_DONE,
 	__I40E_TX_XPS_INIT_DONE,
+	__I40E_RING_STATE_NBITS /* must be last */
 };
 
 /* some useful defines for virtchannel interface, which
@@ -348,7 +349,7 @@ struct i40e_ring {
 		struct i40e_tx_buffer *tx_bi;
 		struct i40e_rx_buffer *rx_bi;
 	};
-	unsigned long state;
+	DECLARE_BITMAP(state, __I40E_RING_STATE_NBITS);
 	u16 queue_index;		/* Queue number of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 __iomem *tail;
-- 
2.9.4

