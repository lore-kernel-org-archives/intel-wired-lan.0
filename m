From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 10 Apr 2018 10:49:49 -0700
Subject: [Intel-wired-lan] [PATCH] ice: Fix initialization for
 num_nodes_added
Message-ID: <20180410174949.8141-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_sched_add_nodes_to_layer is used recursively, and so we start
with num_nodes_added being 0. This way, in case of an error or if
num_nodes is NULL, the function just returns 0 to indicate that no
nodes were added.

Fixes commit 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI
multi-Tx queue support")

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index f16ff3e4a840..2e6c1d92cc88 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -751,14 +751,14 @@ ice_sched_add_nodes_to_layer(struct ice_port_info *pi,
 	u16 num_added = 0;
 	u32 temp;
 
+	*num_nodes_added = 0;
+
 	if (!num_nodes)
 		return status;
 
 	if (!parent || layer < hw->sw_entry_point_layer)
 		return ICE_ERR_PARAM;
 
-	*num_nodes_added = 0;
-
 	/* max children per node per layer */
 	max_child_nodes =
 	    le16_to_cpu(hw->layer_info[parent->tx_sched_layer].max_children);
-- 
2.14.3

