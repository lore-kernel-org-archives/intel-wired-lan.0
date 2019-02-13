From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 13 Feb 2019 10:51:14 -0800
Subject: [Intel-wired-lan] [PATCH S14 14/15] ice: Put
 __ICE_PREPARED_FOR_RESET check in ice_prepare_for_reset
In-Reply-To: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190213185115.25877-15-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently we check if the __ICE_PREPARED_FOR_RESET bit is set prior to
calling ice_prepare_for_reset in ice_reset_subtask(), but we aren't
checking that bit in ice_do_reset() before calling
ice_prepare_for_reset(). This is not consistent and can cause issues if
ice_prepare_for_reset() is called prior to ice_do_reset(). Fix this by
checking if the __ICE_PREPARED_FOR_RESET bit is set internal to
ice_prepare_for_reset().

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ced774dd879b..6e069e84d486 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -403,6 +403,10 @@ ice_prepare_for_reset(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 
+	/* already prepared for reset */
+	if (test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
+		return;
+
 	/* Notify VFs of impending reset */
 	if (ice_check_sq_alive(hw, &hw->mailboxq))
 		ice_vc_notify_reset(pf);
@@ -486,8 +490,7 @@ static void ice_reset_subtask(struct ice_pf *pf)
 		/* return if no valid reset type requested */
 		if (reset_type == ICE_RESET_INVAL)
 			return;
-		if (!test_bit(__ICE_PREPARED_FOR_RESET, pf->state))
-			ice_prepare_for_reset(pf);
+		ice_prepare_for_reset(pf);
 
 		/* make sure we are ready to rebuild */
 		if (ice_check_reset(&pf->hw)) {
-- 
2.14.5

