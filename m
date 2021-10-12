From: Dave Ertman <david.m.ertman@intel.com>
Date: Tue, 12 Oct 2021 13:31:21 -0700
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix problems with DSCP QoS
 implementation
Message-ID: <20211012203121.85155-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The patch that implemented DSCP QoS implementation removed a
bandwidth check that was used to check for a specific condition
caused by some corner cases.  This check should not of been
removed.

The same patch also added a check for when the DCBx state could
be changed in relation to DSCP, but the check was erroneously
added nested in a check for CEE mode, which made the check useless.

Fix these problems by re-adding the bandwidth check and relocating
the DSCP mode check earlier in the function that changes DCBx state
in the driver.

Fixes: 2a87bd73e5 ("ice: Add DSCP support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 7fdeb411b6df..3eb01731e496 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -97,6 +97,9 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 
 	new_cfg->etscfg.maxtcs = pf->hw.func_caps.common_cap.maxtc;
 
+	if (!bwcfg)
+		new_cfg->etscfg.tcbwtable[0] = 100;
+
 	if (!bwrec)
 		new_cfg->etsrec.tcbwtable[0] = 100;
 
@@ -167,15 +170,18 @@ static u8 ice_dcbnl_setdcbx(struct net_device *netdev, u8 mode)
 	if (mode == pf->dcbx_cap)
 		return ICE_DCB_NO_HW_CHG;
 
-	pf->dcbx_cap = mode;
 	qos_cfg = &pf->hw.port_info->qos_cfg;
-	if (mode & DCB_CAP_DCBX_VER_CEE) {
-		if (qos_cfg->local_dcbx_cfg.pfc_mode == ICE_QOS_MODE_DSCP)
-			return ICE_DCB_NO_HW_CHG;
+
+	/* DSCP configuration is not DCBx negotiated */
+	if (qos_cfg->local_dcbx_cfg.pfc_mode == ICE_QOS_MODE_DSCP)
+		return ICE_DCB_NO_HW_CHG;
+
+	pf->dcbx_cap = mode;
+
+	if (mode & DCB_CAP_DCBX_VER_CEE)
 		qos_cfg->local_dcbx_cfg.dcbx_mode = ICE_DCBX_MODE_CEE;
-	} else {
+	else
 		qos_cfg->local_dcbx_cfg.dcbx_mode = ICE_DCBX_MODE_IEEE;
-	}
 
 	dev_info(ice_pf_to_dev(pf), "DCBx mode = 0x%x\n", mode);
 	return ICE_DCB_HW_CHG_RST;
-- 
2.31.1

