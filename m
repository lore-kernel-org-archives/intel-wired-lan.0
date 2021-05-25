From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:12:33 -0500
Subject: [Intel-wired-lan] [PATCH][next] virtchnl: Replace one-element array
 in struct virtchnl_ether_addr_list
Message-ID: <20210525231233.GA175955@embeddedor>
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
virtchnl_ether_addr_list instead of one-element array, and use the
flex_array_size() helper.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/avf/virtchnl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 7ded2b454122..c2e7ffc8ada7 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -422,10 +422,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_ether_addr);
 struct virtchnl_ether_addr_list {
 	u16 vsi_id;
 	u16 num_elements;
-	struct virtchnl_ether_addr list[1];
+	struct virtchnl_ether_addr list[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_ether_addr_list);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_ether_addr_list);
 
 /* VIRTCHNL_OP_ADD_VLAN
  * VF sends this message to add one or more VLAN tag filters for receives.
@@ -1024,8 +1024,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_ether_addr_list *veal =
 			    (struct virtchnl_ether_addr_list *)msg;
-			valid_len += veal->num_elements *
-			    sizeof(struct virtchnl_ether_addr);
+			valid_len += flex_array_size(veal, list,
+						     veal->num_elements);
 			if (veal->num_elements == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

