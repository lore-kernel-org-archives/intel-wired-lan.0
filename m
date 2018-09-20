From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:15 -0700
Subject: [Intel-wired-lan] [PATCH 12/16] ice: Check for actual link state of
 port after reset
In-Reply-To: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002319.10971-13-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

We are currently replaying the link state of a port after a reset, but
it is possible that the link state of a port can change during the reset
process. So check for the current link state of a port during the rebuild
process of a reset.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> minor cleanup for upstream submission]
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 +--
 drivers/net/ethernet/intel/ice/ice_common.h | 1 +
 drivers/net/ethernet/intel/ice/ice_main.c   | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 1b38610f8d19..78315bb6431c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1740,8 +1740,7 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
  * ice_update_link_info - update status of the HW network link
  * @pi: port info structure of the interested logical port
  */
-static enum ice_status
-ice_update_link_info(struct ice_port_info *pi)
+enum ice_status ice_update_link_info(struct ice_port_info *pi)
 {
 	struct ice_aqc_get_phy_caps_data *pcaps;
 	struct ice_phy_info *phy_info;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 5493266d4204..7b2a5bb2e550 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -21,6 +21,7 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		  struct ice_rq_event_info *e, u16 *pending);
 enum ice_status
 ice_get_link_status(struct ice_port_info *pi, bool *link_up);
+enum ice_status ice_update_link_info(struct ice_port_info *pi);
 enum ice_status
 ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids res,
 		enum ice_aq_res_access_type access, u32 timeout);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e59fe46b0469..cc10eb28c8b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3243,6 +3243,10 @@ static void ice_rebuild(struct ice_pf *pf)
 		goto err_vsi_rebuild;
 	}
 
+	err = ice_update_link_info(hw->port_info);
+	if (err)
+		dev_err(&pf->pdev->dev, "Get link status error %d\n", err);
+
 	/* Replay all VSIs Configuration, including filters after reset */
 	if (ice_vsi_replay_all(pf)) {
 		dev_err(&pf->pdev->dev,
-- 
2.14.3

