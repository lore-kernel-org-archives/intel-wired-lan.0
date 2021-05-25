From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:15:42 -0500
Subject: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element array
 in struct virtchnl_irq_map_info
Message-ID: <20210525231542.GA176299@embeddedor>
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
virtchnl_irq_map_info instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index ed9c4998f8ac..7ded2b454122 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -378,10 +378,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_vector_map);
 
 struct virtchnl_irq_map_info {
 	u16 num_vectors;
-	struct virtchnl_vector_map vecmap[1];
+	struct virtchnl_vector_map vecmap[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
+VIRTCHNL_CHECK_STRUCT_LEN(2, virtchnl_irq_map_info);
 
 /* VIRTCHNL_OP_ENABLE_QUEUES
  * VIRTCHNL_OP_DISABLE_QUEUES
@@ -1008,8 +1008,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_irq_map_info *vimi =
 			    (struct virtchnl_irq_map_info *)msg;
-			valid_len += (vimi->num_vectors *
-				      sizeof(struct virtchnl_vector_map));
+			valid_len += flex_array_size(vimi, vecmap,
+						     vimi->num_vectors);
 			if (vimi->num_vectors == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

