From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:38 -0700
Subject: [Intel-wired-lan] [PATCH S53 06/15] ice: Account for port VLAN in
 VF max packet size calculation
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently if an AVF driver doesn't account for the possibility of a
port VLAN when determining its max packet size then packets at MTU will
be dropped. It is not the VF driver's responsibility to account for a
port VLAN so fix this. To fix this, do the following:

1. Add a function that determines the max packet size a VF is allowed by
   using the port's max packet size and whether the VF is in a port
   VLAN. If a port VLAN is configured then a VF's max packet size will
   always be the port's max packet size minus VLAN_HLEN. Otherwise it
   will be the port's max packet size.

2. Use this function to verify the max packet size from the VF.

3. If there is a port VLAN configured then add 4 bytes (VLAN_HLEN) to
   the VF's max packet size configuration.

Also, the VIRTCHNL_OP_GET_VF_RESOURCES message provides the capability
to communicate a VF's max packet size. Use the new function for this
purpose.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 0478d8892f80..f360ae376825 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1880,6 +1880,29 @@ static int ice_vc_get_ver_msg(struct ice_vf *vf, u8 *msg)
 				     sizeof(struct virtchnl_version_info));
 }
 
+/**
+ * ice_vc_get_max_frame_size - get max frame size allowed for VF
+ * @vf: VF used to determine max frame size
+ *
+ * Max frame size is determined based on the current port's max frame size and
+ * whether a port VLAN is configured on this VF. The VF is not aware whether
+ * it's in a port VLAN so the PF needs to account for this in max frame size
+ * checks and sending the max frame size to the VF.
+ */
+static u16 ice_vc_get_max_frame_size(struct ice_vf *vf)
+{
+	struct ice_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
+	struct ice_port_info *pi = vsi->port_info;
+	u16 max_frame_size;
+
+	max_frame_size = pi->phy.link_info.max_frame_size;
+
+	if (vf->port_vlan_info)
+		max_frame_size -= VLAN_HLEN;
+
+	return max_frame_size;
+}
+
 /**
  * ice_vc_get_vf_res_msg
  * @vf: pointer to the VF info
@@ -1962,6 +1985,7 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->max_vectors = pf->num_msix_per_vf;
 	vfres->rss_key_size = ICE_VSIQF_HKEY_ARRAY_SIZE;
 	vfres->rss_lut_size = ICE_VSIQF_HLUT_ARRAY_SIZE;
+	vfres->max_mtu = ice_vc_get_max_frame_size(vf);
 
 	vfres->vsi_res[0].vsi_id = vf->lan_vsi_num;
 	vfres->vsi_res[0].vsi_type = VIRTCHNL_VSI_SRIOV;
@@ -2959,6 +2983,8 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 
 		/* copy Rx queue info from VF into VSI */
 		if (qpi->rxq.ring_len > 0) {
+			u16 max_frame_size = ice_vc_get_max_frame_size(vf);
+
 			num_rxq++;
 			vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
 			vsi->rx_rings[i]->count = qpi->rxq.ring_len;
@@ -2971,7 +2997,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			}
 			vsi->rx_buf_len = qpi->rxq.databuffer_size;
 			vsi->rx_rings[i]->rx_buf_len = vsi->rx_buf_len;
-			if (qpi->rxq.max_pkt_size >= (16 * 1024) ||
+			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
@@ -2979,6 +3005,11 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		}
 
 		vsi->max_frame = qpi->rxq.max_pkt_size;
+		/* add space for the port VLAN since the VF driver is not
+		 * expected to account for it in the MTU calculation
+		 */
+		if (vf->port_vlan_info)
+			vsi->max_frame += VLAN_HLEN;
 	}
 
 	/* VF can request to configure less than allocated queues or default
-- 
2.20.1

