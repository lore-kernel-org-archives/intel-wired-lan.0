From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed,  3 May 2017 19:51:52 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 08/13] i40evf/virtchnl:
	whitespace cleanups
In-Reply-To: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
References: <20170504025157.71107-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170504025157.71107-9-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This patch fixes up a bunch of whitespace issues introduced
by the previous automated change of name from i40e to virtchnl.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 41a046e..4d359b5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1485,8 +1485,7 @@ static int i40e_vc_get_version_msg(struct i40e_vf *vf, u8 *msg)
 		info.minor = VIRTCHNL_VERSION_MINOR_NO_VF_CAPS;
 	return i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_VERSION,
 				      I40E_SUCCESS, (u8 *)&info,
-				      sizeof(struct
-					     virtchnl_version_info));
+				      sizeof(struct virtchnl_version_info));
 }
 
 /**
@@ -1544,11 +1543,9 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	} else {
 		if ((pf->flags & I40E_FLAG_RSS_AQ_CAPABLE) &&
 		    (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_AQ))
-			vfres->vf_offload_flags |=
-					VIRTCHNL_VF_OFFLOAD_RSS_AQ;
+			vfres->vf_offload_flags |= VIRTCHNL_VF_OFFLOAD_RSS_AQ;
 		else
-			vfres->vf_offload_flags |=
-					VIRTCHNL_VF_OFFLOAD_RSS_REG;
+			vfres->vf_offload_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
 	}
 
 	if (pf->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
@@ -2530,8 +2527,7 @@ static int i40e_vc_set_rss_hena(struct i40e_vf *vf, u8 *msg, u16 msglen)
 
 	/* send the response to the VF */
 err:
-	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_SET_RSS_HENA,
-				       aq_ret);
+	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_SET_RSS_HENA, aq_ret);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 90a17b0..d9f0409 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1018,8 +1018,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 				~(BIT(VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP));
 		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS: {
-		struct virtchnl_rss_hena *vrh =
-			(struct virtchnl_rss_hena *)msg;
+		struct virtchnl_rss_hena *vrh = (struct virtchnl_rss_hena *)msg;
 		if (msglen == sizeof(*vrh))
 			adapter->hena = vrh->hena;
 		else
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 0e0c198..43b694f 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -175,10 +175,10 @@ struct virtchnl_vsi_resource {
 #define VIRTCHNL_VF_OFFLOAD_IWARP		0x00000002
 #define VIRTCHNL_VF_OFFLOAD_FCOE		0x00000004
 #define VIRTCHNL_VF_OFFLOAD_RSS_AQ		0x00000008
-#define VIRTCHNL_VF_OFFLOAD_RSS_REG	0x00000010
-#define VIRTCHNL_VF_OFFLOAD_WB_ON_ITR	0x00000020
+#define VIRTCHNL_VF_OFFLOAD_RSS_REG		0x00000010
+#define VIRTCHNL_VF_OFFLOAD_WB_ON_ITR		0x00000020
 #define VIRTCHNL_VF_OFFLOAD_VLAN		0x00010000
-#define VIRTCHNL_VF_OFFLOAD_RX_POLLING	0x00020000
+#define VIRTCHNL_VF_OFFLOAD_RX_POLLING		0x00020000
 #define VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2	0x00040000
 #define VIRTCHNL_VF_OFFLOAD_RSS_PF		0X00080000
 #define VIRTCHNL_VF_OFFLOAD_ENCAP		0X00100000
-- 
1.8.3.1

