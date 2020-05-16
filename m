From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:51:20 -0700
Subject: [Intel-wired-lan] [PATCH S45 14/15] ice: Increase timeout after PFR
In-Reply-To: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
Message-ID: <20200516005121.4963-14-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dan Nowlin <dan.nowlin@intel.com>

To allow for resets during package download, increase the timeout period
after performing a PFR. The time waited is the global config lock
timeout plus the normal PFSWR timeout.

Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8eccec1fa9e7..ce578fe4ab3e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -965,7 +965,12 @@ static enum ice_status ice_pf_reset(struct ice_hw *hw)
 
 	wr32(hw, PFGEN_CTRL, (reg | PFGEN_CTRL_PFSWR_M));
 
-	for (cnt = 0; cnt < ICE_PF_RESET_WAIT_COUNT; cnt++) {
+	/* Wait for the PFR to complete. The wait time is the global config lock
+	 * timeout plus the PFR timeout which will account for a possible reset
+	 * that is occurring during a download package operation.
+	 */
+	for (cnt = 0; cnt < ICE_GLOBAL_CFG_LOCK_TIMEOUT +
+	     ICE_PF_RESET_WAIT_COUNT; cnt++) {
 		reg = rd32(hw, PFGEN_CTRL);
 		if (!(reg & PFGEN_CTRL_PFSWR_M))
 			break;
-- 
2.20.1

