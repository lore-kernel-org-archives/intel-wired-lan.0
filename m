From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:55:06 -0700
Subject: [Intel-wired-lan] [PATCH S46 9/9] ice: Ignore EMODE when setting
 PHY config
In-Reply-To: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005506.5113-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Chinh T Cao <chinh.t.cao@intel.com>

When setting the PHY cfg (CQ cmd 0x0601), if the firmware responds
with an EMODE error, software will ignore the error as it simply
means that manageability (ex: BMC) is in control of the link and that
the new setting may not be applied.

Signed-off-by: Chinh T Cao <chinh.t.cao@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 +
 drivers/net/ethernet/intel/ice/ice_common.c     | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_main.c       | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index bba47f11e546..3c28379dfb3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1858,6 +1858,7 @@ enum ice_aq_err {
 	ICE_AQ_RC_EINVAL	= 14, /* Invalid argument */
 	ICE_AQ_RC_ENOSPC	= 16, /* No space left or allocation failure */
 	ICE_AQ_RC_ENOSYS	= 17, /* Function not implemented */
+	ICE_AQ_RC_EMODE		= 21, /* Op not allowed in current dev mode */
 	ICE_AQ_RC_ENOSEC	= 24, /* Missing security manifest */
 	ICE_AQ_RC_EBADSIG	= 25, /* Bad RSA signature */
 	ICE_AQ_RC_ESVN		= 26, /* SVN number prohibits this package */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce578fe4ab3e..da724b0e524d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2248,6 +2248,7 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
 		   struct ice_aqc_set_phy_cfg_data *cfg, struct ice_sq_cd *cd)
 {
 	struct ice_aq_desc desc;
+	enum ice_status status;
 
 	if (!cfg)
 		return ICE_ERR_PARAM;
@@ -2276,7 +2277,11 @@ ice_aq_set_phy_cfg(struct ice_hw *hw, u8 lport,
 	ice_debug(hw, ICE_DBG_LINK, "eeer_value = 0x%x\n", cfg->eeer_value);
 	ice_debug(hw, ICE_DBG_LINK, "link_fec_opt = 0x%x\n", cfg->link_fec_opt);
 
-	return ice_aq_send_cmd(hw, &desc, cfg, sizeof(*cfg), cd);
+	status = ice_aq_send_cmd(hw, &desc, cfg, sizeof(*cfg), cd);
+	if (hw->adminq.sq_last_status == ICE_AQ_RC_EMODE)
+		status = 0;
+
+	return status;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7f444a24be07..a2d3cba19565 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5245,6 +5245,8 @@ const char *ice_aq_str(enum ice_aq_err aq_err)
 		return "ICE_AQ_RC_ENOSPC";
 	case ICE_AQ_RC_ENOSYS:
 		return "ICE_AQ_RC_ENOSYS";
+	case ICE_AQ_RC_EMODE:
+		return "ICE_AQ_RC_EMODE";
 	case ICE_AQ_RC_ENOSEC:
 		return "ICE_AQ_RC_ENOSEC";
 	case ICE_AQ_RC_EBADSIG:
-- 
2.20.1

