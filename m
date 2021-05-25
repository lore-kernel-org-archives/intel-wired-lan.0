From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Tue, 25 May 2021 18:06:12 -0500
Subject: [Intel-wired-lan] [PATCH][next] iavf: Replace one-element array in
 struct virtchnl_vlan_filter_list
Message-ID: <20210525230612.GA175718@embeddedor>
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
virtchnl_vlan_filter_list instead of one-element array, and use the
struct_size() and flex_array_size() helpers.

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 12 ++++--------
 include/linux/avf/virtchnl.h                    |  7 ++++---
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index b2392af4e048..167955094170 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -573,15 +573,13 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_ADD_VLAN;
 
-	len = sizeof(struct virtchnl_vlan_filter_list) +
-	      (count * sizeof(u16));
+	len = struct_size(vvfl, vlan_id, count);
 	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many add VLAN changes in one request\n");
 		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_vlan_filter_list)) /
 			sizeof(u16);
-		len = sizeof(struct virtchnl_vlan_filter_list) +
-		      (count * sizeof(u16));
+		len = struct_size(vvfl, vlan_id, count);
 		more = true;
 	}
 	vvfl = kzalloc(len, GFP_ATOMIC);
@@ -643,15 +641,13 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 	}
 	adapter->current_op = VIRTCHNL_OP_DEL_VLAN;
 
-	len = sizeof(struct virtchnl_vlan_filter_list) +
-	      (count * sizeof(u16));
+	len = struct_size(vvfl, vlan_id, count);
 	if (len > IAVF_MAX_AQ_BUF_SIZE) {
 		dev_warn(&adapter->pdev->dev, "Too many delete VLAN changes in one request\n");
 		count = (IAVF_MAX_AQ_BUF_SIZE -
 			 sizeof(struct virtchnl_vlan_filter_list)) /
 			sizeof(u16);
-		len = sizeof(struct virtchnl_vlan_filter_list) +
-		      (count * sizeof(u16));
+		len = struct_size(vvfl, vlan_id, count);
 		more = true;
 	}
 	vvfl = kzalloc(len, GFP_ATOMIC);
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 15b982911321..9b9d79c270b1 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -444,10 +444,10 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_ether_addr_list);
 struct virtchnl_vlan_filter_list {
 	u16 vsi_id;
 	u16 num_elements;
-	u16 vlan_id[1];
+	u16 vlan_id[];
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_vlan_filter_list);
 
 /* VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE
  * VF sends VSI id and flags.
@@ -1037,7 +1037,8 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		if (msglen >= valid_len) {
 			struct virtchnl_vlan_filter_list *vfl =
 			    (struct virtchnl_vlan_filter_list *)msg;
-			valid_len += vfl->num_elements * sizeof(u16);
+			valid_len += flex_array_size(vfl, vlan_id,
+						     vfl->num_elements);
 			if (vfl->num_elements == 0)
 				err_msg_format = true;
 		}
-- 
2.27.0

