From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 20 May 2021 08:35:00 +0200
Subject: [Intel-wired-lan] [PATCH v2 intel-net 2/2] ice: parametrize
 functions responsible for Tx ring management
In-Reply-To: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
References: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
Message-ID: <20210520063500.62037-3-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit ae15e0ba1b33 ("ice: Change number of XDP Tx queues to match
number of Rx queues") tried to address the incorrect setting of XDP
queue count that was based on the Tx queue count, whereas in theory we
should provide the XDP queue per Rx queue. However, the routines that
setup and destroy the set of Tx resources are still based on the
vsi->num_txq.

Ice supports the asynchronous Tx/Rx queue count, so for a setup where
vsi->num_txq > vsi->num_rxq, ice_vsi_stop_tx_rings and ice_vsi_cfg_txqs
will be accessing the vsi->xdp_rings out of the bounds.

Parametrize two mentioned functions so they get the size of Tx resources
array as the input.

Fixes: ae15e0ba1b33 ("ice: Change number of XDP Tx queues to match number of Rx queues")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4f8b29d6dcfd..3c8668d8b964 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1705,12 +1705,13 @@ int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
  * ice_vsi_cfg_txqs - Configure the VSI for Tx
  * @vsi: the VSI being configured
  * @rings: Tx ring array to be configured
+ * @count: number of Tx ring array elements
  *
  * Return 0 on success and a negative value on error
  * Configure the Tx VSI for operation.
  */
 static int
-ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_ring **rings)
+ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_ring **rings, u16 count)
 {
 	struct ice_aqc_add_tx_qgrp *qg_buf;
 	u16 q_idx = 0;
@@ -1722,7 +1723,7 @@ ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_ring **rings)
 
 	qg_buf->num_txqs = 1;
 
-	for (q_idx = 0; q_idx < vsi->num_txq; q_idx++) {
+	for (q_idx = 0; q_idx < count; q_idx++) {
 		err = ice_vsi_cfg_txq(vsi, rings[q_idx], qg_buf);
 		if (err)
 			goto err_cfg_txqs;
@@ -1742,7 +1743,7 @@ ice_vsi_cfg_txqs(struct ice_vsi *vsi, struct ice_ring **rings)
  */
 int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi)
 {
-	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings);
+	return ice_vsi_cfg_txqs(vsi, vsi->tx_rings, vsi->num_txq);
 }
 
 /**
@@ -1757,7 +1758,7 @@ int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi)
 	int ret;
 	int i;
 
-	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings);
+	ret = ice_vsi_cfg_txqs(vsi, vsi->xdp_rings, vsi->num_xdp_txq);
 	if (ret)
 		return ret;
 
@@ -1997,17 +1998,18 @@ int ice_vsi_stop_all_rx_rings(struct ice_vsi *vsi)
  * @rst_src: reset source
  * @rel_vmvf_num: Relative ID of VF/VM
  * @rings: Tx ring array to be stopped
+ * @count: number of Tx ring array elements
  */
 static int
 ice_vsi_stop_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
-		      u16 rel_vmvf_num, struct ice_ring **rings)
+		      u16 rel_vmvf_num, struct ice_ring **rings, u16 count)
 {
 	u16 q_idx;
 
 	if (vsi->num_txq > ICE_LAN_TXQ_MAX_QDIS)
 		return -EINVAL;
 
-	for (q_idx = 0; q_idx < vsi->num_txq; q_idx++) {
+	for (q_idx = 0; q_idx < count; q_idx++) {
 		struct ice_txq_meta txq_meta = { };
 		int status;
 
@@ -2035,7 +2037,7 @@ int
 ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
 			  u16 rel_vmvf_num)
 {
-	return ice_vsi_stop_tx_rings(vsi, rst_src, rel_vmvf_num, vsi->tx_rings);
+	return ice_vsi_stop_tx_rings(vsi, rst_src, rel_vmvf_num, vsi->tx_rings, vsi->num_txq);
 }
 
 /**
@@ -2044,7 +2046,7 @@ ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
  */
 int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi)
 {
-	return ice_vsi_stop_tx_rings(vsi, ICE_NO_RESET, 0, vsi->xdp_rings);
+	return ice_vsi_stop_tx_rings(vsi, ICE_NO_RESET, 0, vsi->xdp_rings, vsi->num_xdp_txq);
 }
 
 /**
-- 
2.20.1

