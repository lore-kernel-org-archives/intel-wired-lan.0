From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 18 Oct 2018 08:37:08 -0700
Subject: [Intel-wired-lan] [PATCH 6/7] ice: Allocate VF interrupts and set
 queue map
In-Reply-To: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181018153709.32664-7-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Allocate VF interrupts using VPINT_ALLOC_PCI. Multiple interrupts are
specified as a range from "first" to "last".

Also, according to the spec, the queue mapping for a VF needs to be set
in both contig and scatter queue modes. So make this change as well.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |  6 ++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 15 +++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 228afcad6fc3..5fdea6ec7675 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -157,6 +157,12 @@
 #define VPINT_ALLOC_LAST_S			12
 #define VPINT_ALLOC_LAST_M			ICE_M(0x7FF, 12)
 #define VPINT_ALLOC_VALID_M			BIT(31)
+#define VPINT_ALLOC_PCI(_VF)			(0x0009D000 + ((_VF) * 4))
+#define VPINT_ALLOC_PCI_FIRST_S			0
+#define VPINT_ALLOC_PCI_FIRST_M			ICE_M(0x7FF, 0)
+#define VPINT_ALLOC_PCI_LAST_S			12
+#define VPINT_ALLOC_PCI_LAST_M			ICE_M(0x7FF, 12)
+#define VPINT_ALLOC_PCI_VALID_M			BIT(31)
 #define GLLAN_RCTL_0				0x002941F8
 #define QRX_CONTEXT(_i, _QRX)			(0x00280000 + ((_i) * 8192 + (_QRX) * 4))
 #define QRX_CTRL(_QRX)				(0x00120000 + ((_QRX) * 4))
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index c25e486706f3..45f10f8f01dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -173,6 +173,7 @@ static void ice_dis_vf_mappings(struct ice_vf *vf)
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	wr32(hw, VPINT_ALLOC(vf->vf_id), 0);
+	wr32(hw, VPINT_ALLOC_PCI(vf->vf_id), 0);
 
 	first = vf->first_vector_idx;
 	last = first + pf->num_vf_msix - 1;
@@ -519,6 +520,10 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
 	       VPINT_ALLOC_VALID_M);
 	wr32(hw, VPINT_ALLOC(vf->vf_id), reg);
 
+	reg = (((first << VPINT_ALLOC_PCI_FIRST_S) & VPINT_ALLOC_PCI_FIRST_M) |
+	       ((last << VPINT_ALLOC_PCI_LAST_S) & VPINT_ALLOC_PCI_LAST_M) |
+	       VPINT_ALLOC_PCI_VALID_M);
+	wr32(hw, VPINT_ALLOC_PCI(vf->vf_id), reg);
 	/* map the interrupts to its functions */
 	for (v = first; v <= last; v++) {
 		reg = (((abs_vf_id << GLINT_VECT2FUNC_VF_NUM_S) &
@@ -528,10 +533,11 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
 		wr32(hw, GLINT_VECT2FUNC(v), reg);
 	}
 
+	/* set regardless of mapping mode */
+	wr32(hw, VPLAN_TXQ_MAPENA(vf->vf_id), VPLAN_TXQ_MAPENA_TX_ENA_M);
+
 	/* VF Tx queues allocation */
 	if (vsi->tx_mapping_mode == ICE_VSI_MAP_CONTIG) {
-		wr32(hw, VPLAN_TXQ_MAPENA(vf->vf_id),
-		     VPLAN_TXQ_MAPENA_TX_ENA_M);
 		/* set the VF PF Tx queue range
 		 * VFNUMQ value should be set to (number of queues - 1). A value
 		 * of 0 means 1 queue and a value of 255 means 256 queues
@@ -546,10 +552,11 @@ static void ice_ena_vf_mappings(struct ice_vf *vf)
 			"Scattered mode for VF Tx queues is not yet implemented\n");
 	}
 
+	/* set regardless of mapping mode */
+	wr32(hw, VPLAN_RXQ_MAPENA(vf->vf_id), VPLAN_RXQ_MAPENA_RX_ENA_M);
+
 	/* VF Rx queues allocation */
 	if (vsi->rx_mapping_mode == ICE_VSI_MAP_CONTIG) {
-		wr32(hw, VPLAN_RXQ_MAPENA(vf->vf_id),
-		     VPLAN_RXQ_MAPENA_RX_ENA_M);
 		/* set the VF PF Rx queue range
 		 * VFNUMQ value should be set to (number of queues - 1). A value
 		 * of 0 means 1 queue and a value of 255 means 256 queues
-- 
2.14.3

