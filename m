From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 13 Feb 2020 13:31:18 -0800
Subject: [Intel-wired-lan] [PATCH S39 v2 04/15] ice: Always clear the
 QRXFLXP_CNTXT register for VF Rx queues
In-Reply-To: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
Message-ID: <20200213213129.34023-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently when the PF reduces its number of channels via ethtool and
then VFs are created there may be stale data for some of the Rx queues
belonging to VFs. This happens when a VF reuses an Rx queue that was
previously used by the PF. Specifically, the QRXFLXP_CNTXT register
will have incorrect values. Fix this by always clearing the relevant
values in the QRXFLXP_CNTXT register for VF queues.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c       | 8 ++++++--
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 75cc5a366b26..54aa533f36d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -386,8 +386,8 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 	 /* Enable Flexible Descriptors in the queue context which
 	  * allows this driver to select a specific receive descriptor format
 	  */
+	regval = rd32(hw, QRXFLXP_CNTXT(pf_q));
 	if (vsi->type != ICE_VSI_VF) {
-		regval = rd32(hw, QRXFLXP_CNTXT(pf_q));
 		regval |= (rxdid << QRXFLXP_CNTXT_RXDID_IDX_S) &
 			QRXFLXP_CNTXT_RXDID_IDX_M;
 
@@ -398,8 +398,12 @@ int ice_setup_rx_ctx(struct ice_ring *ring)
 		regval |= (0x03 << QRXFLXP_CNTXT_RXDID_PRIO_S) &
 			QRXFLXP_CNTXT_RXDID_PRIO_M;
 
-		wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
+	} else {
+		regval &= ~(QRXFLXP_CNTXT_RXDID_IDX_M |
+			    QRXFLXP_CNTXT_RXDID_PRIO_M |
+			    QRXFLXP_CNTXT_TS_M);
 	}
+	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
 
 	/* Absolute queue number out of 2K needs to be passed */
 	err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 57f1c4513c0b..3f40736a8295 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -86,6 +86,7 @@
 #define QRXFLXP_CNTXT_RXDID_IDX_M		ICE_M(0x3F, 0)
 #define QRXFLXP_CNTXT_RXDID_PRIO_S		8
 #define QRXFLXP_CNTXT_RXDID_PRIO_M		ICE_M(0x7, 8)
+#define QRXFLXP_CNTXT_TS_M			BIT(11)
 #define GLGEN_RSTAT				0x000B8188
 #define GLGEN_RSTAT_DEVSTATE_M			ICE_M(0x3, 0)
 #define GLGEN_RSTCTL				0x000B8180
-- 
2.20.1

