From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed,  1 Dec 2021 09:14:34 +0100
Subject: [Intel-wired-lan] [PATCH net] iavf: do not override the adapter
 state in the watchdog task (again)
Message-ID: <20211201081434.3977672-1-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The watchdog task incorrectly changes the state to __IAVF_RESETTING,
instead of letting the reset task take care of that. This was already
resolved by
22c8fd71d3a5 iavf: do not override the adapter state in the watchdog task
but the problem was reintroduced by the recent code refactoring in
45eebd62999d.

Fixes: 45eebd62999d ("iavf: Refactor iavf state machine tracking")

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 14934a7a13ef..360dfb7594cb 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2085,7 +2085,6 @@ static void iavf_watchdog_task(struct work_struct *work)
 	/* check for hw reset */
 	reg_val = rd32(hw, IAVF_VF_ARQLEN1) & IAVF_VF_ARQLEN1_ARQENABLE_MASK;
 	if (!reg_val) {
-		iavf_change_state(adapter, __IAVF_RESETTING);
 		adapter->flags |= IAVF_FLAG_RESET_PENDING;
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
-- 
2.31.1

