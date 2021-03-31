From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:16:58 -0700
Subject: [Intel-wired-lan] [PATCH S58 03/13] ice: manage interrupts during
 poll exit
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver would occasionally miss that there were outstanding
descriptors to clean when exiting busy/napi poll. This issue has
been in the code since the introduction of the ice driver.

Attempt to "catch" any remaining work by triggering a software
interrupt when exiting napi poll or busy-poll. This will not
cause extra interrupts in the case of normal execution.

This issue was found when running sfnt-pingpong, with busy
poll enabled, and typically with larger I/O sizes like > 8192,
the program would occasionally report > 1 second maximums
to complete a ping pong.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c       | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index a501e2b7e09e..9b8300d4a267 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -131,6 +131,7 @@
 #define GLINT_DYN_CTL_ITR_INDX_M		ICE_M(0x3, 3)
 #define GLINT_DYN_CTL_INTERVAL_S		5
 #define GLINT_DYN_CTL_INTERVAL_M		ICE_M(0xFFF, 5)
+#define GLINT_DYN_CTL_SW_ITR_INDX_ENA_M		BIT(24)
 #define GLINT_DYN_CTL_SW_ITR_INDX_M		ICE_M(0x3, 25)
 #define GLINT_DYN_CTL_WB_ON_ITR_M		BIT(30)
 #define GLINT_DYN_CTL_INTENA_MSK_M		BIT(31)
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 035fac5f74dc..ac22457f3bf8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1302,6 +1302,7 @@ static u32 ice_buildreg_itr(u16 itr_idx, u16 itr)
 static void ice_update_ena_itr(struct ice_q_vector *q_vector)
 {
 	struct ice_vsi *vsi = q_vector->vsi;
+	bool wb_en = q_vector->wb_on_itr;
 	u32 itr_val;
 
 	if (test_bit(ICE_DOWN, vsi->state))
@@ -1310,7 +1311,7 @@ static void ice_update_ena_itr(struct ice_q_vector *q_vector)
 	/* When exiting WB_ON_ITR, let ITR resume its normal
 	 * interrupts-enabled path.
 	 */
-	if (q_vector->wb_on_itr)
+	if (wb_en)
 		q_vector->wb_on_itr = false;
 
 	/* This will do nothing if dynamic updates are not enabled. */
@@ -1318,6 +1319,16 @@ static void ice_update_ena_itr(struct ice_q_vector *q_vector)
 
 	/* net_dim() updates ITR out-of-band using a work item */
 	itr_val = ice_buildreg_itr(ICE_ITR_NONE, 0);
+	/* trigger an immediate software interrupt when exiting
+	 * busy poll, to make sure to catch any pending cleanups
+	 * that might have been missed due to interrupt state
+	 * transition.
+	 */
+	if (wb_en) {
+		itr_val |= GLINT_DYN_CTL_SWINT_TRIG_M |
+			   GLINT_DYN_CTL_SW_ITR_INDX_M |
+			   GLINT_DYN_CTL_SW_ITR_INDX_ENA_M;
+	}
 	wr32(&vsi->back->hw, GLINT_DYN_CTL(q_vector->reg_idx), itr_val);
 }
 
-- 
2.20.1

