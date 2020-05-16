From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:36:42 -0700
Subject: [Intel-wired-lan] [PATCH S43 13/15] ice: Fix memory leak
In-Reply-To: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516003644.4658-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Surabhi Boob <surabhi.boob@intel.com>

Handle memory leak on filter management initialization failure.

Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index bba787a6faff..b0bbba8e6f6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -387,6 +387,7 @@ ice_aq_set_mac_cfg(struct ice_hw *hw, u16 max_frame_size, struct ice_sq_cd *cd)
 static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 {
 	struct ice_switch_info *sw;
+	enum ice_status status;
 
 	hw->switch_info = devm_kzalloc(ice_hw_to_dev(hw),
 				       sizeof(*hw->switch_info), GFP_KERNEL);
@@ -397,7 +398,12 @@ static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 
 	INIT_LIST_HEAD(&sw->vsi_list_map_head);
 
-	return ice_init_def_sw_recp(hw);
+	status = ice_init_def_sw_recp(hw);
+	if (status) {
+		devm_kfree(ice_hw_to_dev(hw), hw->switch_info);
+		return status;
+	}
+	return 0;
 }
 
 /**
-- 
2.20.1

