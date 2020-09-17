From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 13:13:41 -0700
Subject: [Intel-wired-lan] [PATCH S53 09/15] ice: Enable Support for FW
 Override (E82X)
In-Reply-To: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
References: <20200917201347.81570-1-anthony.l.nguyen@intel.com>
Message-ID: <20200917201347.81570-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeb Cramer <jeb.j.cramer@intel.com>

The driver is able to override the firmware when it comes to supporting
a more lenient link mode.  This feature was limited to E810 devices.  It
is now extended to E82X devices.

Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a0cf60272aab..3b2d48906e61 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4261,10 +4261,6 @@ ice_sched_query_elem(struct ice_hw *hw, u32 node_teid,
  */
 bool ice_fw_supports_link_override(struct ice_hw *hw)
 {
-	/* Currently, only supported for E810 devices */
-	if (hw->mac_type != ICE_MAC_E810)
-		return false;
-
 	if (hw->api_maj_ver == ICE_FW_API_LINK_OVERRIDE_MAJ) {
 		if (hw->api_min_ver > ICE_FW_API_LINK_OVERRIDE_MIN)
 			return true;
-- 
2.20.1

