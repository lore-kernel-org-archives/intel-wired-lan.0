From: Haiyue Wang <haiyue.wang@intel.com>
Date: Wed,  1 Jul 2020 09:25:56 +0800
Subject: [Intel-wired-lan] [net-next,
 v7 4/5] ice: enable DDP package info querying
In-Reply-To: <20200701012557.40234-1-haiyue.wang@intel.com>
References: <20200619045711.16055-1-haiyue.wang@intel.com>
 <20200701012557.40234-1-haiyue.wang@intel.com>
Message-ID: <20200701012557.40234-5-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the firmware doesn't support reading the DDP package data that PF
is using. The DCF has to find the PF's DDP package file directly.

For searching the right DDP package that the PF uses, the DCF needs the
DDP package characteristic information such as the PF's device serial
number which is used to find the package loading path, and the exact DDP
track ID, package name, version.

Only with the matched DDP package, the DCF can get the right metadata to
create switch rules etc.

Signed-off-by: Leyi Rong <leyi.rong@intel.com>
Signed-off-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcf.h      |  6 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 52 +++++++++++++++++++
 include/linux/avf/virtchnl.h                  | 23 ++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcf.h b/drivers/net/ethernet/intel/ice/ice_dcf.h
index 1dabcca6f753..1ca228f89a19 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcf.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcf.h
@@ -32,6 +32,12 @@ struct ice_dcf {
 	struct ice_aq_desc aq_desc;
 	u8 aq_desc_received;
 	unsigned long aq_desc_expires;
+
+	/* Save the current Device Serial Number when searching the package
+	 * path for later query.
+	 */
+#define ICE_DSN_NUM_LEN 8
+	u8 dsn[ICE_DSN_NUM_LEN];
 };
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a1cef089201a..983b5e21b436 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3243,6 +3243,8 @@ static char *ice_get_opt_fw_name(struct ice_pf *pf)
 	snprintf(opt_fw_filename, NAME_MAX, "%sice-%016llx.pkg",
 		 ICE_DDP_PKG_PATH, dsn);
 
+	memcpy(pf->dcf.dsn, &dsn, sizeof(pf->dcf.dsn));
+
 	return opt_fw_filename;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 2584c3f199e3..919f1cec784e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -3906,6 +3906,55 @@ static int ice_vc_dcf_get_vsi_map(struct ice_vf *vf)
 	return ret;
 }
 
+/**
+ * ice_vc_dcf_query_pkg_info - query DDP package info from PF
+ * @vf: pointer to VF info
+ *
+ * Called from VF to query DDP package information loaded in PF,
+ * including track ID, package name, version and device serial
+ * number.
+ */
+static int ice_vc_dcf_query_pkg_info(struct ice_vf *vf)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	struct virtchnl_pkg_info *pkg_info = NULL;
+	struct ice_hw *hw = &vf->pf->hw;
+	struct ice_pf *pf = vf->pf;
+	int len = 0;
+	int ret;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	if (!ice_is_vf_dcf(vf) || ice_dcf_get_state(pf) != ICE_DCF_STATE_ON) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	len = sizeof(struct virtchnl_pkg_info);
+	pkg_info = kzalloc(len, GFP_KERNEL);
+	if (!pkg_info) {
+		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
+		len = 0;
+		goto err;
+	}
+
+	pkg_info->track_id = hw->active_track_id;
+	memcpy(&pkg_info->pkg_ver, &hw->active_pkg_ver,
+	       sizeof(pkg_info->pkg_ver));
+	memcpy(pkg_info->pkg_name, hw->active_pkg_name,
+	       sizeof(pkg_info->pkg_name));
+	memcpy(pkg_info->dsn, pf->dcf.dsn, sizeof(pkg_info->dsn));
+
+err:
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_DCF_GET_PKG_INFO,
+				    v_ret, (u8 *)pkg_info, len);
+	kfree(pkg_info);
+	return ret;
+}
+
 /**
  * ice_vc_process_vf_msg - Process request from VF
  * @pf: pointer to the PF structure
@@ -4028,6 +4077,9 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event)
 	case VIRTCHNL_OP_DCF_GET_VSI_MAP:
 		err = ice_vc_dcf_get_vsi_map(vf);
 		break;
+	case VIRTCHNL_OP_DCF_GET_PKG_INFO:
+		err = ice_vc_dcf_query_pkg_info(vf);
+		break;
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
 		dev_err(dev, "Unsupported opcode %d from VF %d\n", v_opcode,
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index ef07cff40662..b14ff350469b 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -141,6 +141,7 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DCF_CMD_BUFF = 40,
 	VIRTCHNL_OP_DCF_DISABLE = 41,
 	VIRTCHNL_OP_DCF_GET_VSI_MAP = 42,
+	VIRTCHNL_OP_DCF_GET_PKG_INFO = 43,
 	/* New major set of opcodes introduced and so leaving room for
 	 * old misc opcodes to be added in future. Also these opcodes may only
 	 * be used if both the PF and VF have successfully negotiated the
@@ -647,6 +648,27 @@ struct virtchnl_dcf_vsi_map {
 
 VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_dcf_vsi_map);
 
+#define PKG_NAME_SIZE	32
+#define DSN_SIZE	8
+
+struct pkg_version {
+	u8 major;
+	u8 minor;
+	u8 update;
+	u8 draft;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(4, pkg_version);
+
+struct virtchnl_pkg_info {
+	struct pkg_version pkg_ver;
+	u32 track_id;
+	char pkg_name[PKG_NAME_SIZE];
+	u8 dsn[DSN_SIZE];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_pkg_info);
+
 /* VIRTCHNL_OP_EVENT
  * PF sends this message to inform the VF driver of events that may affect it.
  * No direct response is expected from the VF, though it may generate other
@@ -1301,6 +1323,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		break;
 	case VIRTCHNL_OP_DCF_DISABLE:
 	case VIRTCHNL_OP_DCF_GET_VSI_MAP:
+	case VIRTCHNL_OP_DCF_GET_PKG_INFO:
 		break;
 	case VIRTCHNL_OP_GET_CAPS:
 		valid_len = sizeof(struct virtchnl_get_capabilities);
-- 
2.27.0

