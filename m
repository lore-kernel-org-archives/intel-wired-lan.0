From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  4 May 2017 02:35:21 -0700
Subject: [Intel-wired-lan] [net-next v2 06/13] virtchnl: convert to new
	macros
In-Reply-To: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
References: <20170504093528.76047-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170504093528.76047-7-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

As part of the conversion, change the arguments
to VF_IS_V1[01] macros and move them to virtchnl.h

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 63dcc61..09fd12c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1481,7 +1481,7 @@ static int i40e_vc_get_version_msg(struct i40e_vf *vf, u8 *msg)
 
 	vf->vf_ver = *(struct virtchnl_version_info *)msg;
 	/* VFs running the 1.0 API expect to get 1.0 back or they will cry. */
-	if (VF_IS_V10(vf))
+	if (VF_IS_V10(&vf->vf_ver))
 		info.minor = VIRTCHNL_VERSION_MINOR_NO_VF_CAPS;
 	return i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_VERSION,
 				      I40E_SUCCESS, (u8 *)&info,
@@ -1521,7 +1521,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		len = 0;
 		goto err;
 	}
-	if (VF_IS_V11(vf))
+	if (VF_IS_V11(&vf->vf_ver))
 		vf->driver_caps = *(u32 *)msg;
 	else
 		vf->driver_caps = VIRTCHNL_VF_OFFLOAD_L2 |
@@ -2557,7 +2557,7 @@ static int i40e_vc_validate_vf_msg(struct i40e_vf *vf, u32 v_opcode,
 	case VIRTCHNL_OP_RESET_VF:
 		break;
 	case VIRTCHNL_OP_GET_VF_RESOURCES:
-		if (VF_IS_V11(vf))
+		if (VF_IS_V11(&vf->vf_ver))
 			valid_len = sizeof(u32);
 		break;
 	case VIRTCHNL_OP_CONFIG_TX_QUEUE:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index b57ffff..1f4b0c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -40,9 +40,6 @@
 #define I40E_VLAN_MASK			0xFFF
 #define I40E_PRIORITY_MASK		0x7000
 
-#define VF_IS_V10(_v) (((_v)->vf_ver.major == 1) && ((_v)->vf_ver.minor == 0))
-#define VF_IS_V11(_v) (((_v)->vf_ver.major == 1) && ((_v)->vf_ver.minor == 1))
-
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
 	I40E_QUEUE_CTRL_UNKNOWN = 0,
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 4849e76..05c1895 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -123,6 +123,9 @@ struct virtchnl_version_info {
 	u32 minor;
 };
 
+#define VF_IS_V10(_v) (((_v)->major == 1) && ((_v)->minor == 0))
+#define VF_IS_V11(_ver) (((_ver)->major == 1) && ((_ver)->minor == 1))
+
 /* VIRTCHNL_OP_RESET_VF
  * VF sends this request to PF with no parameters
  * PF does NOT respond! VF driver must delay then poll VFGEN_RSTAT register
-- 
1.8.3.1

