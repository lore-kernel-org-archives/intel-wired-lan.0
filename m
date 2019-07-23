From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 23 Jul 2019 02:27:51 -0700
Subject: [Intel-wired-lan] [PATCH S24 04/12] ice: Treat DCBx state
 NOT_STARTED as valid
In-Reply-To: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
Message-ID: <20190723092759.3614-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

When a port is not cabled, but DCBx is enabled in the
firmware, the status of DCBx will be NOT_STARTED.  This
is a valid state for FW enabled and should not be
treated as a is_fw_lldp true automatically.

Add the code to treat NOT_STARTED as another valid state.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index c2002ded65f6..d60c942249e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -954,7 +954,8 @@ enum ice_status ice_init_dcb(struct ice_hw *hw)
 	pi->dcbx_status = ice_get_dcbx_status(hw);
 
 	if (pi->dcbx_status == ICE_DCBX_STATUS_DONE ||
-	    pi->dcbx_status == ICE_DCBX_STATUS_IN_PROGRESS) {
+	    pi->dcbx_status == ICE_DCBX_STATUS_IN_PROGRESS ||
+	    pi->dcbx_status == ICE_DCBX_STATUS_NOT_STARTED) {
 		/* Get current DCBX configuration */
 		ret = ice_get_dcb_cfg(pi);
 		pi->is_sw_lldp = (hw->adminq.sq_last_status == ICE_AQ_RC_EPERM);
-- 
2.20.1

