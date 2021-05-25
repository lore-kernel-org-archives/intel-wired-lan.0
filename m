From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:04:29 -0500
Subject: [Intel-wired-lan] [PATCH][next] iavf: Replace one-element array in
 struct virtchnl_iwarp_qvlist_info and iavf_qvlist_info
Message-ID: <20210525230429.GA175658@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code
should always use ?flexible array members?[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

Refactor the code according to the use of a flexible-array member in struct
virtchnl_iwarp_qvlist_info and iavf_qvlist_info instead of one-element array,
and use the flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_client.c      | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_client.h      | 2 +-
 include/linux/avf/virtchnl.h                       | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c0afac8cf33b..6c55fe9cc132 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -515,7 +515,7 @@ static int i40e_config_iwarp_qvlist(struct i40e_vf *vf,
 
 	kfree(vf->qvlist_info);
 	vf->qvlist_info = kzalloc(struct_size(vf->qvlist_info, qv_info,
-					      qvlist_info->num_vectors - 1),
+					      qvlist_info->num_vectors),
 				  GFP_KERNEL);
 	if (!vf->qvlist_info) {
 		ret = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index 0c77e4171808..e70da05ef322 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -470,7 +470,7 @@ static int iavf_client_setup_qvlist(struct iavf_info *ldev,
 
 	v_qvlist_info = (struct virtchnl_iwarp_qvlist_info *)qvlist_info;
 	msg_size = struct_size(v_qvlist_info, qv_info,
-			       v_qvlist_info->num_vectors - 1);
+			       v_qvlist_info->num_vectors);
 
 	adapter->client_pending |= BIT(VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP);
 	err = iavf_aq_send_msg_to_pf(&adapter->hw,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.h b/drivers/net/ethernet/intel/iavf/iavf_client.h
index 9a7cf39ea75a..b14a82b65626 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.h
@@ -53,7 +53,7 @@ struct iavf_qv_info {
 
 struct iavf_qvlist_info {
 	u32 num_vectors;
-	struct iavf_qv_info qv_info[1];
+	struct iavf_qv_info qv_info[];
 };
 
 #define IAVF_CLIENT_MSIX_ALL 0xFFFFFFFF
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 85a687bc6096..15b982911321 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -658,10 +658,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_iwarp_qv_info);
 
 struct virtchnl_iwarp_qvlist_info {
 	u32 num_vectors;
-	struct virtchnl_iwarp_qv_info qv_info[1];
+	struct virtchnl_iwarp_qv_info qv_info[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_iwarp_qvlist_info);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_iwarp_qvlist_info);
 
 /* VF reset states - these are written into the RSTAT register:
  * VFGEN_RSTAT on the VF
@@ -1069,8 +1069,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 				err_msg_format = true;
 				break;
 			}
-			valid_len += ((qv->num_vectors - 1) *
-				sizeof(struct virtchnl_iwarp_qv_info));
+			valid_len += flex_array_size(qv, qv_info,
+						     qv->num_vectors);
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_KEY:
-- 
2.27.0

