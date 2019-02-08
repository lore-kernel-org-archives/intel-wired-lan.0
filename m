From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:30 -0800
Subject: [Intel-wired-lan] [PATCH S11 03/16] ice: Fix added in VSI supported
 nodes calc
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

VSI supported nodes are calculated in order to add the VSI parent or
intermediate nodes to the scheduler tree. If one of the node in below
layers (from VSI layer) has space to add the new VSI or intermediate node
above that layer then it's not required to continue the calculation further
for below layers.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index fb38e8be1e2e..81fb7d19c0fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1344,9 +1344,14 @@ ice_sched_calc_vsi_support_nodes(struct ice_hw *hw,
 				node = node->sibling;
 			}
 
+			/* tree has one intermediate node to add this new VSI.
+			 * So no need to calculate supported nodes for below
+			 * layers.
+			 */
+			if (node)
+				break;
 			/* all the nodes are full, allocate a new one */
-			if (!node)
-				num_nodes[i]++;
+			num_nodes[i]++;
 		}
 }
 
-- 
2.14.5

