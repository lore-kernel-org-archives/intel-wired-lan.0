From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:45 -0700
Subject: [Intel-wired-lan] [PATCH S31 07/15] ice: Adjust DCB INIT for SW mode
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

Adjust ice_init_dcb to set the is_sw_lldp boolean
in the case where the FW has been detected to be
in an untenable state such that the driver
should forcibly make sure it is off.

This will ensure that the FW is in a known state.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index dd7efff121bd..713e8a892e14 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -965,9 +965,9 @@ enum ice_status ice_init_dcb(struct ice_hw *hw, bool enable_mib_change)
 	    pi->dcbx_status == ICE_DCBX_STATUS_NOT_STARTED) {
 		/* Get current DCBX configuration */
 		ret = ice_get_dcb_cfg(pi);
-		pi->is_sw_lldp = (hw->adminq.sq_last_status == ICE_AQ_RC_EPERM);
 		if (ret)
 			return ret;
+		pi->is_sw_lldp = false;
 	} else if (pi->dcbx_status == ICE_DCBX_STATUS_DIS) {
 		return ICE_ERR_NOT_READY;
 	}
@@ -975,8 +975,8 @@ enum ice_status ice_init_dcb(struct ice_hw *hw, bool enable_mib_change)
 	/* Configure the LLDP MIB change event */
 	if (enable_mib_change) {
 		ret = ice_aq_cfg_lldp_mib_change(hw, true, NULL);
-		if (!ret)
-			pi->is_sw_lldp = false;
+		if (ret)
+			pi->is_sw_lldp = true;
 	}
 
 	return ret;
-- 
2.20.1

