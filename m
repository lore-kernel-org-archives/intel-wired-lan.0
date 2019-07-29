From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 29 Jul 2019 02:04:44 -0700
Subject: [Intel-wired-lan] [PATCH S24 v2 02/12] ice: Account for all states
 of FW DCBx and LLDP
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <20190729090454.5501-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

Currently, only the DCBx status is taken into account to
determine if FW LLDP is possible.  But there are NVM version
coming out with DCBx enabled, and FW LLDP disabled.  This
is causing errors where the driver sees that DCBx is not
disabled, and then tries to register for LLDP MIB change
events, and fails.

Change the logic to detect both DCBx and LLDP states in the
FW engine.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 34 +++++++-------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index d285aba3fea7..9ab9ec1ce19e 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -324,6 +324,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	}
 
 	ice_init_dcb(&pf->hw);
+	if (pf->hw.port_info->dcbx_status == ICE_DCBX_STATUS_DIS)
+		pf->hw.port_info->is_sw_lldp = true;
+	else
+		pf->hw.port_info->is_sw_lldp = false;
+
 	if (ice_dcb_need_recfg(pf, prev_cfg, local_dcbx_cfg)) {
 		/* difference in cfg detected - disable DCB till next MIB */
 		dev_err(&pf->pdev->dev, "Set local MIB not accurate\n");
@@ -445,35 +450,17 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 	struct device *dev = &pf->pdev->dev;
 	struct ice_port_info *port_info;
 	struct ice_hw *hw = &pf->hw;
-	int sw_default = 0;
 	int err;
 
 	port_info = hw->port_info;
 
 	err = ice_init_dcb(hw);
 	if (err) {
-		/* FW LLDP is not active, default to SW DCBX/LLDP */
-		dev_info(&pf->pdev->dev, "FW LLDP is not active\n");
-		hw->port_info->dcbx_status = ICE_DCBX_STATUS_NOT_STARTED;
-		hw->port_info->is_sw_lldp = true;
-	}
-
-	if (port_info->dcbx_status == ICE_DCBX_STATUS_DIS)
-		dev_info(&pf->pdev->dev, "DCBX disabled\n");
-
-	/* LLDP disabled in FW */
-	if (port_info->is_sw_lldp) {
-		sw_default = 1;
-		dev_info(&pf->pdev->dev, "DCBx/LLDP in SW mode.\n");
+		/* FW LLDP is disabled, activate SW DCBX/LLDP mode */
+		dev_info(&pf->pdev->dev,
+			 "FW LLDP is disabled, DCBx/LLDP in SW mode.\n");
+		port_info->is_sw_lldp = true;
 		clear_bit(ICE_FLAG_ENABLE_FW_LLDP, pf->flags);
-	} else {
-		set_bit(ICE_FLAG_ENABLE_FW_LLDP, pf->flags);
-	}
-
-	if (port_info->dcbx_status == ICE_DCBX_STATUS_NOT_STARTED)
-		dev_info(&pf->pdev->dev, "DCBX not started\n");
-
-	if (sw_default) {
 		err = ice_dcb_sw_dflt_cfg(pf, locked);
 		if (err) {
 			dev_err(&pf->pdev->dev,
@@ -488,6 +475,9 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 		return 0;
 	}
 
+	port_info->is_sw_lldp = false;
+	set_bit(ICE_FLAG_ENABLE_FW_LLDP, pf->flags);
+
 	/* DCBX in FW and LLDP enabled in FW */
 	pf->dcbx_cap = DCB_CAP_DCBX_LLD_MANAGED | DCB_CAP_DCBX_VER_IEEE;
 
-- 
2.20.1

