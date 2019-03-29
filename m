From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 16:38:49 -0700
Subject: [Intel-wired-lan] [PATCH 5/6] i40e: Use struct_size() in kzalloc()
In-Reply-To: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190329233850.29630-5-jeffrey.t.kirsher@intel.com>
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
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable size is not necessary, hence it
is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 5f3b8b9ff511..e81530ca08d0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -578,11 +578,9 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_qv_info *qv_info;
 	u32 v_idx, i, reg_idx, reg;
-	u32 size;
 
-	size = sizeof(struct i40e_qvlist_info) +
-	       (sizeof(struct i40e_qv_info) * (qvlist_info->num_vectors - 1));
-	ldev->qvlist_info = kzalloc(size, GFP_KERNEL);
+	ldev->qvlist_info = kzalloc(struct_size(ldev->qvlist_info, qv_info,
+				    qvlist_info->num_vectors - 1), GFP_KERNEL);
 	if (!ldev->qvlist_info)
 		return -ENOMEM;
 	ldev->qvlist_info->num_vectors = qvlist_info->num_vectors;
-- 
2.20.1

