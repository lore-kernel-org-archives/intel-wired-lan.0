From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Tue, 22 Dec 2015 14:25:07 -0800
Subject: [Intel-wired-lan] [next PATCH S24 05/12] i40evf: add new write-back
	mode
In-Reply-To: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450823114-29514-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450823114-29514-6-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Add write-back on interrupt throttle rate timer expiration support
for the i40evf driver, when running on X722 devices.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 ++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 16 ++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  5 +++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3cc98b0..8c02fa9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1222,6 +1222,12 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING)
 		vfres->vf_offload_flags |= I40E_VIRTCHNL_VF_OFFLOAD_RX_POLLING;
 
+	if (pf->flags & I40E_FLAG_WB_ON_ITR_CAPABLE) {
+		if (vf->driver_caps & I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
+			vfres->vf_offload_flags |=
+					I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR;
+	}
+
 	vfres->num_vsis = num_vsis;
 	vfres->num_queue_pairs = vf->num_queue_pairs;
 	vfres->max_vectors = pf->hw.func_caps.num_msix_vectors_vf;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index ed4934a..0e2c627 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -252,6 +252,22 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring, int budget)
 	tx_ring->q_vector->tx.total_bytes += total_bytes;
 	tx_ring->q_vector->tx.total_packets += total_packets;
 
+	if (tx_ring->flags & I40E_TXR_FLAGS_WB_ON_ITR) {
+		unsigned int j = 0;
+		/* check to see if there are < 4 descriptors
+		 * waiting to be written back, then kick the hardware to force
+		 * them to be written back in case we stay in NAPI.
+		 * In this mode on X722 we do not enable Interrupt.
+		 */
+		j = i40evf_get_tx_pending(tx_ring);
+
+		if (budget &&
+		    ((j / (WB_STRIDE + 1)) == 0) && (j > 0) &&
+		    !test_bit(__I40E_DOWN, &tx_ring->vsi->state) &&
+		    (I40E_DESC_UNUSED(tx_ring) != tx_ring->count))
+			tx_ring->arm_wb = true;
+	}
+
 	netdev_tx_completed_queue(netdev_get_tx_queue(tx_ring->netdev,
 						      tx_ring->queue_index),
 				  total_packets, total_bytes);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7bdb9f9..ab77e20 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2511,6 +2511,11 @@ static void i40evf_init_task(struct work_struct *work)
 	if (adapter->vf_res->vf_offload_flags &
 		    I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
 		adapter->flags |= I40EVF_FLAG_WB_ON_ITR_CAPABLE;
+
+	if (adapter->vf_res->vf_offload_flags &
+	    I40E_VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)
+		adapter->flags |= I40EVF_FLAG_WB_ON_ITR_CAPABLE;
+
 	err = i40evf_request_misc_irq(adapter);
 	if (err)
 		goto err_sw_init;
-- 
2.1.0

