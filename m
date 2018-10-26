From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:45 -0700
Subject: [Intel-wired-lan] [PATCH S9 13/15] ice: Cleanup short function
 signatures
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Function signatures that do not exceed 80-characters should be on a single
line.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 +--
 drivers/net/ethernet/intel/ice/ice_sched.c  | 6 ++----
 drivers/net/ethernet/intel/ice/ice_switch.c | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0b528602c4c9..b3d73be9f649 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1713,8 +1713,7 @@ void ice_clear_pxe_mode(struct ice_hw *hw)
  * If no bit gets set, ICE_LINK_SPEED_UNKNOWN will be returned
  * If more than one bit gets set, ICE_LINK_SPEED_UNKNOWN will be returned
  */
-static u16
-ice_get_link_speed_based_on_phy_type(u64 phy_type_low)
+static u16 ice_get_link_speed_based_on_phy_type(u64 phy_type_low)
 {
 	u16 speed_phy_type_low = ICE_AQ_LINK_SPEED_UNKNOWN;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index c950ebc11d98..b39484da5a7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -894,8 +894,7 @@ static u8 ice_sched_get_vsi_layer(struct ice_hw *hw)
  * This function removes the leaf node that was created by the FW
  * during initialization
  */
-static void
-ice_rm_dflt_leaf_node(struct ice_port_info *pi)
+static void ice_rm_dflt_leaf_node(struct ice_port_info *pi)
 {
 	struct ice_sched_node *node;
 
@@ -923,8 +922,7 @@ ice_rm_dflt_leaf_node(struct ice_port_info *pi)
  * This function frees all the nodes except root and TC that were created by
  * the FW during initialization
  */
-static void
-ice_sched_rm_dflt_nodes(struct ice_port_info *pi)
+static void ice_sched_rm_dflt_nodes(struct ice_port_info *pi)
 {
 	struct ice_sched_node *node;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 107ca08899b6..af55c74c2378 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -92,8 +92,7 @@ ice_aq_alloc_free_res(struct ice_hw *hw, u16 num_entries,
  * Allocate memory for the entire recipe table and initialize the structures/
  * entries corresponding to basic recipes.
  */
-enum ice_status
-ice_init_def_sw_recp(struct ice_hw *hw)
+enum ice_status ice_init_def_sw_recp(struct ice_hw *hw)
 {
 	struct ice_sw_recipe *recps;
 	u8 i;
-- 
2.14.3

