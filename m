From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:10 -0700
Subject: [Intel-wired-lan] [PATCH S51 01/13] ice: rename misleading
 grst_delay variable
Message-ID: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nick Nunley <nicholas.d.nunley@intel.com>

The grst_delay variable in ice_check_reset contains the maximum time
(in 100 msec units) that the driver will wait for a reset event to
transition to the Device Active state. The value is the sum of three
separate components:
1) The maximum time it may take for the firmware to process its
outstanding command before handling the reset request.
2) The value in RSTCTL.GRSTDEL (the delay firmware inserts between first
seeing the driver reset request and the actual hardware assertion).
3) The maximum expected reset processing time in hardware.

Referring to this total time as "grst_delay" is misleading and
potentially confusing to someone checking the code and cross-referencing
the hardware specification.

Fix this by renaming the variable to "grst_timeout", which is more
descriptive of its actual use.

Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ad5941ec7b11..8a93fbd6f1be 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1027,23 +1027,23 @@ void ice_deinit_hw(struct ice_hw *hw)
  */
 enum ice_status ice_check_reset(struct ice_hw *hw)
 {
-	u32 cnt, reg = 0, grst_delay, uld_mask;
+	u32 cnt, reg = 0, grst_timeout, uld_mask;
 
 	/* Poll for Device Active state in case a recent CORER, GLOBR,
 	 * or EMPR has occurred. The grst delay value is in 100ms units.
 	 * Add 1sec for outstanding AQ commands that can take a long time.
 	 */
-	grst_delay = ((rd32(hw, GLGEN_RSTCTL) & GLGEN_RSTCTL_GRSTDEL_M) >>
-		      GLGEN_RSTCTL_GRSTDEL_S) + 10;
+	grst_timeout = ((rd32(hw, GLGEN_RSTCTL) & GLGEN_RSTCTL_GRSTDEL_M) >>
+			GLGEN_RSTCTL_GRSTDEL_S) + 10;
 
-	for (cnt = 0; cnt < grst_delay; cnt++) {
+	for (cnt = 0; cnt < grst_timeout; cnt++) {
 		mdelay(100);
 		reg = rd32(hw, GLGEN_RSTAT);
 		if (!(reg & GLGEN_RSTAT_DEVSTATE_M))
 			break;
 	}
 
-	if (cnt == grst_delay) {
+	if (cnt == grst_timeout) {
 		ice_debug(hw, ICE_DBG_INIT,
 			  "Global reset polling failed to complete.\n");
 		return ICE_ERR_RESET_FAILED;
-- 
2.20.1

