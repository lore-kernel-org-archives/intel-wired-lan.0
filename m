From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:32 -0700
Subject: [Intel-wired-lan] [PATCH S43 03/15] ice: Fix Tx timeout when link
 is toggled on a VF's interface
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if the iavf is loaded and a VF link transitions from up to
down to up again a Tx timeout will be triggered. This happens because
Tx/Rx queue interrupts are only enabled when receiving the
VIRTCHNL_OP_CONFIG_MAP_IRQ message, which happens on reset or initial
iavf driver load, but not when bringing link up. This is problematic
because they are disabled on the VIRTCHNL_OP_DISABLE_QUEUES message,
which is part of bringing a VF's link down. However, they are not
enabled on the VIRTCHNL_OP_ENABLE_QUEUES message, which is part of
bringing a VF's link up.

Fix this by re-enabling the VF's Rx and Tx queue interrupts when they
were previously configured. This is done by first checking to make
sure the previous value in QINT_[R|T]QCTL.MSIX_INDX is not 0, which
is used to represent the OICR in the VF's interrupt space. If the
MSIX_INDX is non-zero then enable the interrupt by setting the
QINT_[R|T]CTL.CAUSE_ENA bit to 1.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 7c8c1687f0bf..2e6c81555668 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2291,6 +2291,52 @@ static bool ice_vc_validate_vqs_bitmaps(struct virtchnl_queue_select *vqs)
 	return true;
 }
 
+/**
+ * ice_vf_ena_txq_interrupt - enable Tx queue interrupt via QINT_TQCTL
+ * @vsi: VSI of the VF to configure
+ * @q_idx: VF queue index used to determine the queue in the PF's space
+ */
+static void ice_vf_ena_txq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 pfq = vsi->txq_map[q_idx];
+	u32 reg;
+
+	reg = rd32(hw, QINT_TQCTL(pfq));
+
+	/* MSI-X index 0 in the VF's space is always for the OICR, which means
+	 * this is most likely a poll mode VF driver, so don't enable an
+	 * interrupt that was never configured via VIRTCHNL_OP_CONFIG_IRQ_MAP
+	 */
+	if (!(reg & QINT_TQCTL_MSIX_INDX_M))
+		return;
+
+	wr32(hw, QINT_TQCTL(pfq), reg | QINT_TQCTL_CAUSE_ENA_M);
+}
+
+/**
+ * ice_vf_ena_rxq_interrupt - enable Tx queue interrupt via QINT_RQCTL
+ * @vsi: VSI of the VF to configure
+ * @q_idx: VF queue index used to determine the queue in the PF's space
+ */
+static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 pfq = vsi->rxq_map[q_idx];
+	u32 reg;
+
+	reg = rd32(hw, QINT_RQCTL(pfq));
+
+	/* MSI-X index 0 in the VF's space is always for the OICR, which means
+	 * this is most likely a poll mode VF driver, so don't enable an
+	 * interrupt that was never configured via VIRTCHNL_OP_CONFIG_IRQ_MAP
+	 */
+	if (!(reg & QINT_RQCTL_MSIX_INDX_M))
+		return;
+
+	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -2351,6 +2397,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
+		ice_vf_ena_rxq_interrupt(vsi, vf_q_id);
 		set_bit(vf_q_id, vf->rxq_ena);
 	}
 
@@ -2365,6 +2412,7 @@ static int ice_vc_ena_qs_msg(struct ice_vf *vf, u8 *msg)
 		if (test_bit(vf_q_id, vf->txq_ena))
 			continue;
 
+		ice_vf_ena_txq_interrupt(vsi, vf_q_id);
 		set_bit(vf_q_id, vf->txq_ena);
 	}
 
-- 
2.20.1

