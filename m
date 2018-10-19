From: Alice Michael <alice.michael@intel.com>
Date: Fri, 19 Oct 2018 14:11:03 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Update status codes
Message-ID: <20181019211103.13873-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Add a few new status code which will be used by the ice driver, and
rename a few to make them more consistent. Error code are mapped to
similar values as in i40e_status.h, so as to be compatible with older
VF drivers not using this status enum.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  2 +-
 include/linux/avf/virtchnl.h                       | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 81b0e1f8..ac5698e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3674,7 +3674,7 @@ int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
 		dev_err(&pf->pdev->dev, "Invalid message from VF %d, opcode %d, len %d\n",
 			local_vf_id, v_opcode, msglen);
 		switch (ret) {
-		case VIRTCHNL_ERR_PARAM:
+		case VIRTCHNL_STATUS_ERR_PARAM:
 			return -EPERM;
 		default:
 			return -EINVAL;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 2c9756b..b248805 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -62,13 +62,19 @@
 /* Error Codes */
 enum virtchnl_status_code {
 	VIRTCHNL_STATUS_SUCCESS				= 0,
-	VIRTCHNL_ERR_PARAM				= -5,
+	VIRTCHNL_STATUS_ERR_PARAM			= -5,
+	VIRTCHNL_STATUS_ERR_NO_MEMORY			= -18,
 	VIRTCHNL_STATUS_ERR_OPCODE_MISMATCH		= -38,
 	VIRTCHNL_STATUS_ERR_CQP_COMPL_ERROR		= -39,
 	VIRTCHNL_STATUS_ERR_INVALID_VF_ID		= -40,
-	VIRTCHNL_STATUS_NOT_SUPPORTED			= -64,
+	VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR		= -53,
+	VIRTCHNL_STATUS_ERR_NOT_SUPPORTED		= -64,
 };
 
+/* Backward compatibility */
+#define VIRTCHNL_ERR_PARAM VIRTCHNL_STATUS_ERR_PARAM
+#define VIRTCHNL_STATUS_NOT_SUPPORTED VIRTCHNL_STATUS_ERR_NOT_SUPPORTED
+
 #define VIRTCHNL_LINK_SPEED_100MB_SHIFT		0x1
 #define VIRTCHNL_LINK_SPEED_1000MB_SHIFT	0x2
 #define VIRTCHNL_LINK_SPEED_10GB_SHIFT		0x3
@@ -831,7 +837,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
-		return VIRTCHNL_ERR_PARAM;
+		return VIRTCHNL_STATUS_ERR_PARAM;
 	}
 	/* few more checks */
 	if (err_msg_format || valid_len != msglen)
-- 
2.9.5

