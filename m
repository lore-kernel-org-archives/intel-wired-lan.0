From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:08 -0800
Subject: [Intel-wired-lan] [PATCH S14 08/15] ice: Prevent unintended
 multiple chain resets
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

In the current implementation of ice_reset_subtask, if multiple reset
types are set in the pf->state, the most intrusive one is meant to be
performed only, but the bits requesting the other types are not being
cleared. This would lead to another reset being performed the next time
the service task is scheduled.

Change the flow of ice_reset_subtask so that all reset request bits in
pf->state are cleared, and we still perform the most intrusive of the
resets requested.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c0b7e695cc43..ced774dd879b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -478,8 +478,14 @@ static void ice_reset_subtask(struct ice_pf *pf)
 	 * for the reset now), poll for reset done, rebuild and return.
 	 */
 	if (test_bit(__ICE_RESET_OICR_RECV, pf->state)) {
-		clear_bit(__ICE_GLOBR_RECV, pf->state);
-		clear_bit(__ICE_CORER_RECV, pf->state);
+		/* Perform the largest reset requested */
+		if (test_and_clear_bit(__ICE_CORER_RECV, pf->state))
+			reset_type = ICE_RESET_CORER;
+		if (test_and_clear_bit(__ICE_GLOBR_RECV, pf->state))
+			reset_type = ICE_RESET_GLOBR;
+		/* return if no valid reset type requested */
+		if (reset_type == ICE_RESET_INVAL)
+			return;
 		if (!test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
 			ice_prepare_for_reset(pf);
 
-- 
2.14.5

