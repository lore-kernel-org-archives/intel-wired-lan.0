From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:09:12 -0500
Subject: [Intel-wired-lan] [PATCH][next] iavf: Replace one-element array in
 struct virtchnl_rss_lut
Message-ID: <20210525230912.GA175802@embeddedor>
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
virtchnl_rss_lut instead of one-element array, and use the struct_size()
helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 5 ++---
 include/linux/avf/virtchnl.h                    | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 6f2a4c8beb0b..123a737f6955 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -830,7 +830,7 @@ void iavf_set_rss_key(struct iavf_adapter *adapter)
 void iavf_set_rss_lut(struct iavf_adapter *adapter)
 {
 	struct virtchnl_rss_lut *vrl;
-	int len;
+	size_t len;
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
@@ -838,8 +838,7 @@ void iavf_set_rss_lut(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	len = sizeof(struct virtchnl_rss_lut) +
-	      (adapter->rss_lut_size * sizeof(u8)) - 1;
+	len = struct_size(vrl, lut, adapter->rss_lut_size);
 	vrl = kzalloc(len, GFP_KERNEL);
 	if (!vrl)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index d2fd847a3880..cda0c98ca978 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -492,10 +492,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_key);
 struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
-	u8 lut[1];        /* RSS lookup table */
+	u8 lut[];        /* RSS lookup table */
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_lut);
 
 /* VIRTCHNL_OP_GET_RSS_HENA_CAPS
  * VIRTCHNL_OP_SET_RSS_HENA
@@ -1087,7 +1087,7 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_lut *vrl =
 				(struct virtchnl_rss_lut *)msg;
-			valid_len += vrl->lut_entries - 1;
+			valid_len += vrl->lut_entries;
 		}
 		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-- 
2.27.0

