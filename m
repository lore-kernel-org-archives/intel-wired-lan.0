From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:16:58 -0500
Subject: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element array
 in struct virtchnl_vsi_queue_config_info
Message-ID: <20210525231658.GA176466@embeddedor>
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
virtchnl_vsi_queue_config_info instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index b554913804bd..ed9c4998f8ac 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -338,10 +338,10 @@ struct virtchnl_vsi_queue_config_info {
 	u16 vsi_id;
 	u16 num_queue_pairs;
 	u32 pad;
-	struct virtchnl_queue_pair_info qpair[1];
+	struct virtchnl_queue_pair_info qpair[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(72, virtchnl_vsi_queue_config_info);
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_vsi_queue_config_info);
 
 /* VIRTCHNL_OP_REQUEST_QUEUES
  * VF sends this message to request the PF to allocate additional queues to
@@ -997,9 +997,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_vsi_queue_config_info *vqc =
 			    (struct virtchnl_vsi_queue_config_info *)msg;
-			valid_len += (vqc->num_queue_pairs *
-				      sizeof(struct
-					     virtchnl_queue_pair_info));
+			valid_len += flex_array_size(vqc, qpair,
+						     vqc->num_queue_pairs);
 			if (vqc->num_queue_pairs == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

