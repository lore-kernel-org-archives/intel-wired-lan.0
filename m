From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:10:41 -0500
Subject: [Intel-wired-lan] [PATCH][next] iavf: Replace one-element array in
 struct virtchnl_tc_info
Message-ID: <20210525231041.GA175914@embeddedor>
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
virtchnl_tc_info instead of one-element array, and use the flex_array_size()
helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 include/linux/avf/virtchnl.h                    | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 123a737f6955..cf2ac577a96f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1021,7 +1021,7 @@ void iavf_enable_channels(struct iavf_adapter *adapter)
 		return;
 	}
 
-	len = struct_size(vti, list, adapter->num_tc - 1);
+	len = struct_size(vti, list, adapter->num_tc);
 	vti = kzalloc(len, GFP_KERNEL);
 	if (!vti)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index cda0c98ca978..b554913804bd 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -529,10 +529,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_channel_info);
 struct virtchnl_tc_info {
 	u32	num_tc;
 	u32	pad;
-	struct	virtchnl_channel_info list[1];
+	struct	virtchnl_channel_info list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_tc_info);
 
 /* VIRTCHNL_ADD_CLOUD_FILTER
  * VIRTCHNL_DEL_CLOUD_FILTER
@@ -1106,8 +1106,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_tc_info *vti =
 				(struct virtchnl_tc_info *)msg;
-			valid_len += (vti->num_tc - 1) *
-				     sizeof(struct virtchnl_channel_info);
+			valid_len += flex_array_size(vti, list, vti->num_tc);
 			if (vti->num_tc == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

