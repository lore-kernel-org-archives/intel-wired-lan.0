From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:42 -0700
Subject: [Intel-wired-lan] [PATCH S53 10/15] ice: Remove gate to OROM init
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeb Cramer <jeb.j.cramer@intel.com>

Remove the gate that prevents the OROM and netlist info from being
populated.  The NVM now has the appropriate section for software to
reference the versioning info.

Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_nvm.c | 26 ------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 5903a36763de..cd442a5415d1 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -634,32 +634,6 @@ enum ice_status ice_init_nvm(struct ice_hw *hw)
 		return status;
 	}
 
-	switch (hw->device_id) {
-	/* the following devices do not have boot_cfg_tlv yet */
-	case ICE_DEV_ID_E823C_BACKPLANE:
-	case ICE_DEV_ID_E823C_QSFP:
-	case ICE_DEV_ID_E823C_SFP:
-	case ICE_DEV_ID_E823C_10G_BASE_T:
-	case ICE_DEV_ID_E823C_SGMII:
-	case ICE_DEV_ID_E822C_BACKPLANE:
-	case ICE_DEV_ID_E822C_QSFP:
-	case ICE_DEV_ID_E822C_10G_BASE_T:
-	case ICE_DEV_ID_E822C_SGMII:
-	case ICE_DEV_ID_E822C_SFP:
-	case ICE_DEV_ID_E822L_BACKPLANE:
-	case ICE_DEV_ID_E822L_SFP:
-	case ICE_DEV_ID_E822L_10G_BASE_T:
-	case ICE_DEV_ID_E822L_SGMII:
-	case ICE_DEV_ID_E823L_BACKPLANE:
-	case ICE_DEV_ID_E823L_SFP:
-	case ICE_DEV_ID_E823L_10G_BASE_T:
-	case ICE_DEV_ID_E823L_1GBE:
-	case ICE_DEV_ID_E823L_QSFP:
-		return status;
-	default:
-		break;
-	}
-
 	status = ice_get_orom_ver_info(hw);
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to read Option ROM info.\n");
-- 
2.20.1

