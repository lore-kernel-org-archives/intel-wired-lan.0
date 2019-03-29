From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 16:38:50 -0700
Subject: [Intel-wired-lan] [PATCH 6/6] iavf: iavf_client: use struct_size()
 helper
In-Reply-To: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190329233850.29630-6-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

size = struct_size(instance, entry, count);

This code was detected with the help of Coccinelle.

Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/iavf/iavf_client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_client.c b/drivers/net/ethernet/intel/iavf/iavf_client.c
index aea45364fd1c..ab9db7e9f09d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_client.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_client.c
@@ -451,7 +451,7 @@ static int iavf_client_setup_qvlist(struct i40e_info *ldev,
 	struct i40e_qv_info *qv_info;
 	iavf_status err;
 	u32 v_idx, i;
-	u32 msg_size;
+	size_t msg_size;
 
 	if (adapter->aq_required)
 		return -EAGAIN;
@@ -469,9 +469,8 @@ static int iavf_client_setup_qvlist(struct i40e_info *ldev,
 	}
 
 	v_qvlist_info = (struct virtchnl_iwarp_qvlist_info *)qvlist_info;
-	msg_size = sizeof(struct virtchnl_iwarp_qvlist_info) +
-			(sizeof(struct virtchnl_iwarp_qv_info) *
-			(v_qvlist_info->num_vectors - 1));
+	msg_size = struct_size(v_qvlist_info, qv_info,
+			       v_qvlist_info->num_vectors - 1);
 
 	adapter->client_pending |= BIT(VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP);
 	err = iavf_aq_send_msg_to_pf(&adapter->hw,
-- 
2.20.1

