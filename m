From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 28 Jun 2019 08:03:24 -0700
Subject: [Intel-wired-lan] [PATCH S23 v2 06/15] ice: Set WB_ON_ITR when we
 don't re-enable interrupts
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <20190628150332.59155-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently when busy polling is enabled we aren't setting/enabling
WB_ON_ITR in the driver. This doesn't break the driver, but it does
cause issues. If we don't enable WB_ON_ITR mode we will still get
write-backs from hardware during polling when a cache line has been
filled, but if a cache line is not filled we will not get the
write-back because WB_ON_ITR is not set. Fix this by enabling
WB_ON_ITR in the driver when interrupts are disabled.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  3 ++
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 54 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 13 +++++
 3 files changed, 70 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 87652d722a30..f8bfeed194f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -337,6 +337,9 @@
 #define VSIQF_HLUT_MAX_INDEX			15
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
 #define VFINT_DYN_CTLN_CLEARPBA_M		BIT(1)
+#define GLINT_DYN_CTL_ITR_INDX_M		ICE_M(0x3, 3)
+#define GLINT_DYN_CTL_INTERVAL_M		ICE_M(0xFFF, 5)
+#define GLINT_DYN_CTL_WB_ON_ITR_M		BIT(30)
 #define PRTRPB_RDPC				0x000AC260
 
 #endif /* _ICE_HW_AUTOGEN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 7229dea0b83f..1085ab920155 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1658,6 +1658,23 @@ ice_update_ena_itr(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 	struct ice_ring_container *rx = &q_vector->rx;
 	u32 itr_val;
 
+	/* when exiting WB_ON_ITR lets set a low ITR value and trigger
+	 * interrupts to expire right away in case we have more work ready to go
+	 * already
+	 */
+	if (q_vector->itr_countdown == ICE_IN_WB_ON_ITR_MODE) {
+		itr_val = ice_buildreg_itr(rx->itr_idx, ICE_WB_ON_ITR_USECS);
+		wr32(&vsi->back->hw, GLINT_DYN_CTL(q_vector->reg_idx), itr_val);
+		/* set target back to last user set value */
+		rx->target_itr = rx->itr_setting;
+		/* set current to what we just wrote and dynamic if needed */
+		rx->current_itr = ICE_WB_ON_ITR_USECS |
+			(rx->itr_setting & ICE_ITR_DYNAMIC);
+		/* allow normal interrupt flow to start */
+		q_vector->itr_countdown = 0;
+		return;
+	}
+
 	/* This will do nothing if dynamic updates are not enabled */
 	ice_update_itr(q_vector, tx);
 	ice_update_itr(q_vector, rx);
@@ -1702,6 +1719,41 @@ ice_update_ena_itr(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
 		     itr_val);
 }
 
+/**
+ * ice_set_wb_on_itr - set WB_ON_ITR for this q_vector
+ * @vsi: pointer to the VSI structure
+ * @q_vector: q_vector to set WB_ON_ITR on
+ *
+ * We need to tell hardware to write-back completed descriptors even when
+ * interrupts are disabled. Descriptors will be written back on cache line
+ * boundaries without WB_ON_ITR enabled, but if we don't enable WB_ON_ITR
+ * descriptors may not be written back if they don't fill a cache line until the
+ * next interrupt.
+ *
+ * This sets the write-back frequency to 2 microseconds as that is the minimum
+ * value that's not 0 due to ITR granularity. Also, set the INTENA_MSK bit to
+ * make sure hardware knows we aren't meddling with the INTENA_M bit.
+ */
+static void
+ice_set_wb_on_itr(struct ice_vsi *vsi, struct ice_q_vector *q_vector)
+{
+	/* already in WB_ON_ITR mode no need to change it */
+	if (q_vector->itr_countdown == ICE_IN_WB_ON_ITR_MODE)
+		return;
+
+	if (q_vector->num_ring_rx)
+		wr32(&vsi->back->hw, GLINT_DYN_CTL(q_vector->reg_idx),
+		     ICE_GLINT_DYN_CTL_WB_ON_ITR(ICE_WB_ON_ITR_USECS,
+						 ICE_RX_ITR));
+
+	if (q_vector->num_ring_tx)
+		wr32(&vsi->back->hw, GLINT_DYN_CTL(q_vector->reg_idx),
+		     ICE_GLINT_DYN_CTL_WB_ON_ITR(ICE_WB_ON_ITR_USECS,
+						 ICE_TX_ITR));
+
+	q_vector->itr_countdown = ICE_IN_WB_ON_ITR_MODE;
+}
+
 /**
  * ice_napi_poll - NAPI polling Rx/Tx cleanup routine
  * @napi: napi struct with our devices info in it
@@ -1773,6 +1825,8 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	if (likely(napi_complete_done(napi, work_done)))
 		ice_update_ena_itr(vsi, q_vector);
+	else
+		ice_set_wb_on_itr(vsi, q_vector);
 
 	return min_t(int, work_done, budget - 1);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 8f857e423739..4756306d64c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -168,6 +168,19 @@ enum ice_rx_dtype {
 #define ICE_DFLT_INTRL	0
 #define ICE_MAX_INTRL	236
 
+#define ICE_WB_ON_ITR_USECS	2
+#define ICE_IN_WB_ON_ITR_MODE	255
+/* Sets WB_ON_ITR and assumes INTENA bit is already cleared, which allows
+ * setting the MSK_M bit to tell hardware to ignore the INTENA_M bit. Also,
+ * set the write-back latency to the usecs passed in.
+ */
+#define ICE_GLINT_DYN_CTL_WB_ON_ITR(usecs, itr_idx)	\
+	((((usecs) << (GLINT_DYN_CTL_INTERVAL_S - ICE_ITR_GRAN_S)) & \
+	  GLINT_DYN_CTL_INTERVAL_M) | \
+	 (((itr_idx) << GLINT_DYN_CTL_ITR_INDX_S) & \
+	  GLINT_DYN_CTL_ITR_INDX_M) | GLINT_DYN_CTL_INTENA_MSK_M | \
+	 GLINT_DYN_CTL_WB_ON_ITR_M)
+
 /* Legacy or Advanced Mode Queue */
 #define ICE_TX_ADVANCED	0
 #define ICE_TX_LEGACY	1
-- 
2.20.1

