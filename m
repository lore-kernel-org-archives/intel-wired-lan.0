From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:45 -0800
Subject: [Intel-wired-lan] [PATCH S56 13/13] ice: Fix prototype warnings
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Correct reported warnings for "warning: expecting prototype for ...
Prototype was for ... instead"

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c      | 2 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c         | 2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c        | 4 ++--
 drivers/net/ethernet/intel/ice/ice_sched.c       | 2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 3fdd76a85ab9..34fddbc30822 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4367,7 +4367,7 @@ ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 }
 
 /**
- * ice_fw_supports_lldp_fltr - check NVM version supports lldp_fltr_ctrl
+ * ice_fw_supports_lldp_fltr_ctrl - check NVM version supports lldp_fltr_ctrl
  * @hw: pointer to HW struct
  */
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 356fc0f025a2..34c1aba050b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -857,7 +857,7 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,
 }
 
 /**
- * ice_get_ieee_dcb_cfg
+ * ice_get_ieee_or_cee_dcb_cfg
  * @pi: port information structure
  * @dcbx_mode: mode of DCBX (IEEE or CEE)
  *
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 7446f236eb90..a8e4b07d7a9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1135,7 +1135,7 @@ bool ice_fdir_has_frag(enum ice_fltr_ptype flow)
 }
 
 /**
- * ice_fdir_find_by_idx - find filter with idx
+ * ice_fdir_find_fltr_by_idx - find filter with idx
  * @hw: pointer to hardware structure
  * @fltr_idx: index to find.
  *
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f243668b8956..ecadc517e9eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1047,7 +1047,7 @@ struct ice_aq_task {
 };
 
 /**
- * ice_wait_for_aq_event - Wait for an AdminQ event from firmware
+ * ice_aq_wait_for_event - Wait for an AdminQ event from firmware
  * @pf: pointer to the PF private structure
  * @opcode: the opcode to wait for
  * @timeout: how long to wait, in jiffies
@@ -4344,7 +4344,7 @@ static void ice_set_wake(struct ice_pf *pf)
 }
 
 /**
- * ice_setup_magic_mc_wake - setup device to wake on multicast magic packet
+ * ice_setup_mc_magic_wake - setup device to wake on multicast magic packet
  * @pf: pointer to the PF struct
  *
  * Issue firmware command to enable multicast magic wake, making
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 2403cb38b93c..f890337cc24a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1857,7 +1857,7 @@ ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 maxqs,
 }
 
 /**
- * ice_sched_rm_agg_vsi_entry - remove aggregator related VSI info entry
+ * ice_sched_rm_agg_vsi_info - remove aggregator related VSI info entry
  * @pi: port information structure
  * @vsi_handle: software VSI handle
  *
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 420fcb58e0d3..d899676a487b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1599,7 +1599,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 }
 
 /**
- * ice_set_dflt_settings - set VF defaults during initialization/creation
+ * ice_set_dflt_settings_vfs - set VF defaults during initialization/creation
  * @pf: PF holding reference to all VFs for default configuration
  */
 static void ice_set_dflt_settings_vfs(struct ice_pf *pf)
@@ -4324,7 +4324,7 @@ void ice_print_vf_rx_mdd_event(struct ice_vf *vf)
 }
 
 /**
- * ice_print_vfs_mdd_event - print VFs malicious driver detect event
+ * ice_print_vfs_mdd_events - print VFs malicious driver detect event
  * @pf: pointer to the PF structure
  *
  * Called from ice_handle_mdd_event to rate limit and print VFs MDD events.
-- 
2.20.1

