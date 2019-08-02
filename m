From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:25 -0700
Subject: [Intel-wired-lan] [PATCH S26 07/15] ice: Fix EMP reset handling
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

ice_reset_subtask needs to handle EMP resets as well, as EMP resets
can be triggered by the firmware. This patch adds the logic to do
this.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2955220ca56e..805a6379c605 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -567,6 +567,8 @@ static void ice_reset_subtask(struct ice_pf *pf)
 			reset_type = ICE_RESET_CORER;
 		if (test_and_clear_bit(__ICE_GLOBR_RECV, pf->state))
 			reset_type = ICE_RESET_GLOBR;
+		if (test_and_clear_bit(__ICE_EMPR_RECV, pf->state))
+			reset_type = ICE_RESET_EMPR;
 		/* return if no valid reset type requested */
 		if (reset_type == ICE_RESET_INVAL)
 			return;
-- 
2.20.1

