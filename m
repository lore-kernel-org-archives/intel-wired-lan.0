From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 29 Mar 2019 16:38:47 -0700
Subject: [Intel-wired-lan] [PATCH 3/6] ice: Use struct_size() helper
In-Reply-To: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20190329233850.29630-3-jeffrey.t.kirsher@intel.com>
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
instance = alloc(size, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

size = struct_size(instance, entry, count);

This code was detected with the help of Coccinelle.

Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 8d49f83be7a5..2a232504379d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -683,10 +683,10 @@ ice_sched_add_elems(struct ice_port_info *pi, struct ice_sched_node *tc_node,
 	u16 i, num_groups_added = 0;
 	enum ice_status status = 0;
 	struct ice_hw *hw = pi->hw;
-	u16 buf_size;
+	size_t buf_size;
 	u32 teid;
 
-	buf_size = sizeof(*buf) + sizeof(*buf->generic) * (num_nodes - 1);
+	buf_size = struct_size(buf, generic, num_nodes - 1);
 	buf = devm_kzalloc(ice_hw_to_dev(hw), buf_size, GFP_KERNEL);
 	if (!buf)
 		return ICE_ERR_NO_MEMORY;
-- 
2.20.1

