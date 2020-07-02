From: Qi Zhang <qi.z.zhang@intel.com>
Date: Fri,  3 Jul 2020 06:57:52 +0800
Subject: [Intel-wired-lan] [PATCH S48 v3 01/14] ice: Enable flexible
 descriptor RXDID querying and configuration
In-Reply-To: <20200702225805.32167-1-qi.z.zhang@intel.com>
References: <20200702225805.32167-1-qi.z.zhang@intel.com>
Message-ID: <20200702225805.32167-2-qi.z.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support to allow VF to query flexible descriptor RXDIDs supported
by DDP package and configure Rx queues with selected RXDID for IAVF.

Signed-off-by: Xu Ting <ting.xu@intel.com>
Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h             |   1 +
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 109 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   3 +
 include/linux/avf/virtchnl.h                     |  15 +++-
 5 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a6e419a3f547..5fde85c70e2e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -437,6 +437,7 @@ struct ice_pf {
 	u32 sw_int_count;
 
 	struct ice_dcf dcf;
+	u64 supported_rxdids; /* bitmap for supported RXDID */
 };
 
 struct ice_netdev_priv {
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 1086c9f778b4..bb1cc372ee95 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -60,6 +60,9 @@
 #define PRTDCB_TUP2TC				0x001D26C0 /* Reset Source: CORER */
 #define GL_PREEXT_L2_PMASK0(_i)			(0x0020F0FC + ((_i) * 4))
 #define GL_PREEXT_L2_PMASK1(_i)			(0x0020F108 + ((_i) * 4))
+#define GLFLXP_RXDID_FLAGS(_i, _j)		(0x0045D000 + ((_i) * 4 + (_j) * 256))
+#define GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S	0
+#define GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M	ICE_M(0x3F, 0)
 #define GLFLXP_RXDID_FLX_WRD_0(_i)		(0x0045c800 + ((_i) * 4))
 #define GLFLXP_RXDID_FLX_WRD_0_PROT_MDID_S	0
 #define GLFLXP_RXDID_FLX_WRD_0_PROT_MDID_M	ICE_M(0xFF, 0)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index fa1f84118456..8022300f9c8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1985,6 +1985,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
 	}
 
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
+		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC;
+
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2;
 
@@ -3059,8 +3062,51 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	vsi->tc_cfg.tc_info[0].qcount_tx = num_txq;
 	vsi->tc_cfg.tc_info[0].qcount_rx = num_rxq;
 
-	if (ice_vsi_cfg_lan_txqs(vsi) || ice_vsi_cfg_rxqs(vsi))
+	if (ice_vsi_cfg_lan_txqs(vsi) || ice_vsi_cfg_rxqs(vsi)) {
 		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
+		goto error_param;
+	}
+
+	/* VF Rx queue RXDID configuration */
+	for (i = 0; i < qci->num_queue_pairs; i++) {
+		struct ice_hw *hw;
+		u16 queue_id;
+		u32 rxdid;
+		u16 pf_q;
+
+		qpi = &qci->qpair[i];
+
+		/* start queue_id with whatever is specified and update
+		 * as needed
+		 */
+		queue_id = qpi->rxq.queue_id;
+		if (queue_id >= vsi->alloc_rxq) {
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+			goto error_param;
+		}
+
+		pf_q = vsi->rxq_map[queue_id];
+
+		rxdid = qpi->rxq.rxdid;
+		hw = &vsi->back->hw;
+
+		/* If Rx flex desc is supported, select RXDID for Rx queues.
+		 * Otherwise, use legacy 32byte descriptor format.
+		 * Legacy 16byte descriptor is not supported. If this RXDID
+		 * is selected, return error.
+		 */
+		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC) {
+			if (!(BIT(rxdid) & pf->supported_rxdids)) {
+				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+				goto error_param;
+			}
+		} else {
+			rxdid = ICE_RXDID_LEGACY_1;
+		}
+
+		ice_write_qrxflxp_cntxt(hw, pf_q, rxdid, 0x03);
+
+	}
 
 error_param:
 	/* send the response to the VF */
@@ -3679,6 +3725,64 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 }
 
 /**
+ * ice_vc_query_rxdid - query RXDID supported by DDP package
+ * @vf: pointer to VF info
+ *
+ * Called from VF to query a bitmap of supported flexible
+ * descriptor RXDIDs of a DDP package.
+ */
+static int ice_vc_query_rxdid(struct ice_vf *vf)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	struct virtchnl_supported_rxdids *rxdid = NULL;
+	struct ice_hw *hw = &vf->pf->hw;
+	struct ice_pf *pf = vf->pf;
+	int len = 0;
+	int ret, i;
+	u32 regval;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	if (!(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	len = sizeof(struct virtchnl_supported_rxdids);
+	rxdid = kzalloc(len, GFP_KERNEL);
+	if (!rxdid) {
+		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
+		len = 0;
+		goto err;
+	}
+
+	/* RXDIDs supported by DDP package can be read from the register
+	 * to get the supported RXDID bitmap. But the legacy 32byte RXDID
+	 * is not listed in DDP package, add it in the bitmap manually.
+	 * Legacy 16byte descriptor is not supported.
+	 */
+	rxdid->supported_rxdids |= BIT(ICE_RXDID_LEGACY_1);
+
+	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
+		regval = rd32(hw, GLFLXP_RXDID_FLAGS(i, 0));
+		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
+			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
+			rxdid->supported_rxdids |= BIT(i);
+	}
+
+	pf->supported_rxdids = rxdid->supported_rxdids;
+
+err:
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
+				    v_ret, (u8 *)rxdid, len);
+	kfree(rxdid);
+	return ret;
+}
+
+/**
  * ice_vf_init_vlan_stripping - enable/disable VLAN stripping on initialization
  * @vf: VF to enable/disable VLAN stripping for on initialization
  *
@@ -4093,6 +4197,9 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 	case VIRTCHNL_OP_DEL_VLAN:
 		err = ice_vc_remove_vlan_msg(vf, msg);
 		break;
+	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
+		err = ice_vc_query_rxdid(vf);
+		break;
 	case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
 		err = ice_vc_ena_vlan_stripping(vf);
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 4a257415f6a5..25dcdd86d663 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -40,6 +40,9 @@
 #define ice_for_each_vf(pf, i) \
 	for ((i) = 0; (i) < (pf)->num_alloc_vfs; (i)++)
 
+/* Max number of flexible descriptor rxdid */
+#define ICE_FLEX_DESC_RXDID_MAX_NUM 64
+
 /* Specific VF states */
 enum ice_vf_states {
 	ICE_VF_STATE_INIT = 0,		/* PF is initializing VF */
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b14ff350469b..825cdc0e9ffe 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -142,6 +142,7 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DCF_DISABLE = 41,
 	VIRTCHNL_OP_DCF_GET_VSI_MAP = 42,
 	VIRTCHNL_OP_DCF_GET_PKG_INFO = 43,
+	VIRTCHNL_OP_GET_SUPPORTED_RXDIDS = 44,
 	/* New major set of opcodes introduced and so leaving room for
 	 * old misc opcodes to be added in future. Also these opcodes may only
 	 * be used if both the PF and VF have successfully negotiated the
@@ -281,6 +282,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM		0X00200000
 #define VIRTCHNL_VF_OFFLOAD_RX_ENCAP_CSUM	0X00400000
 #define VIRTCHNL_VF_OFFLOAD_ADQ			0X00800000
+#define VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC	0X04000000
 #define VIRTCHNL_VF_CAP_DCF			0X40000000
 
 /* Define below the capability flags that are not offloads */
@@ -337,10 +339,12 @@ struct virtchnl_rxq_info {
 	u16 splithdr_enabled; /* deprecated with AVF 1.0 */
 	u32 databuffer_size;
 	u32 max_pkt_size;
-	u32 pad1;
+	u8  pad1;
+	u8  rxdid;
+	u8  pad2[2];
 	u64 dma_ring_addr;
 	enum virtchnl_rx_hsplit rx_split_pos; /* deprecated with AVF 1.0 */
-	u32 pad2;
+	u32 pad3;
 };
 
 VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_rxq_info);
@@ -669,6 +673,12 @@ struct virtchnl_pkg_info {
 
 VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_pkg_info);
 
+struct virtchnl_supported_rxdids {
+	u64 supported_rxdids;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_supported_rxdids);
+
 /* VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
@@ -1324,6 +1334,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DCF_DISABLE:
 	case VIRTCHNL_OP_DCF_GET_VSI_MAP:
 	case VIRTCHNL_OP_DCF_GET_PKG_INFO:
+	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
 		break;
 	case VIRTCHNL_OP_GET_CAPS:
 		valid_len = sizeof(struct virtchnl_get_capabilities);
-- 
2.13.6

