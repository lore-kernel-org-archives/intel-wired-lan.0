From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:01 -0700
Subject: [Intel-wired-lan] [PATCH S41 03/15] ice: Fix check for contiguous
 TCs
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

The current implementation for contiguous TC check
is assuming that the UPs will be mapped to TCs in
a linear progressing fashion.  This is obviously
not always true.

Change the check to allow for various UP2TC mapping
configurations.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index d91bd72eebdc..d5055d9e3fd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -611,16 +611,21 @@ static int ice_dcb_sw_dflt_cfg(struct ice_pf *pf, bool ets_willing, bool locked)
  */
 static bool ice_dcb_tc_contig(u8 *prio_table)
 {
-	u8 max_tc = 0;
+	bool found_empty = false;
+	u8 used_tc = 0;
 	int i;
 
-	for (i = 0; i < CEE_DCBX_MAX_PRIO; i++) {
-		u8 cur_tc = prio_table[i];
+	/* Create a bitmap of used TCs */
+	for (i = 0; i < CEE_DCBX_MAX_PRIO; i++)
+		used_tc |= BIT(prio_table[i]);
 
-		if (cur_tc > max_tc)
-			return false;
-		else if (cur_tc == max_tc)
-			max_tc++;
+	for (i = 0; i < CEE_DCBX_MAX_PRIO; i++) {
+		if (used_tc & BIT(i)) {
+			if (found_empty)
+				return false;
+		} else {
+			found_empty = true;
+		}
 	}
 
 	return true;
-- 
2.20.1

