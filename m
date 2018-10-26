From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:40:53 -0700
Subject: [Intel-wired-lan] [PATCH S8 04/16] ice: Free VSI contexts during
 for unload
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Victor Raj <victor.raj@intel.com>

In the unload path, all VSIs are freed. Also free the related VSI
contexts to prevent memory leaks.

Signed-off-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_common.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_switch.c | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_switch.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8cd6a2401fd9..554fd707a6d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -811,6 +811,9 @@ void ice_deinit_hw(struct ice_hw *hw)
 	/* Attempt to disable FW logging before shutting down control queues */
 	ice_cfg_fw_log(hw, false);
 	ice_shutdown_all_ctrlq(hw);
+
+	/* Clear VSI contexts if not already cleared */
+	ice_clear_all_vsi_ctx(hw);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 33403f39f1b3..40c9c6558956 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -347,6 +347,18 @@ static void ice_clear_vsi_ctx(struct ice_hw *hw, u16 vsi_handle)
 	}
 }
 
+/**
+ * ice_clear_all_vsi_ctx - clear all the VSI context entries
+ * @hw: pointer to the hw struct
+ */
+void ice_clear_all_vsi_ctx(struct ice_hw *hw)
+{
+	u16 i;
+
+	for (i = 0; i < ICE_MAX_VSI; i++)
+		ice_clear_vsi_ctx(hw, i);
+}
+
 /**
  * ice_add_vsi - add VSI context to the hardware and VSI handle list
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index b88d96a1ef69..d5ef0bd58bf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -190,6 +190,8 @@ ice_update_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
 	       struct ice_sq_cd *cd);
 bool ice_is_vsi_valid(struct ice_hw *hw, u16 vsi_handle);
 struct ice_vsi_ctx *ice_get_vsi_ctx(struct ice_hw *hw, u16 vsi_handle);
+void ice_clear_all_vsi_ctx(struct ice_hw *hw);
+/* Switch config */
 enum ice_status ice_get_initial_sw_cfg(struct ice_hw *hw);
 
 /* Switch/bridge related commands */
-- 
2.14.3

