From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 15:08:26 -0800
Subject: [Intel-wired-lan] [next PATCH S2-V2 12/12] i40e: Fix misleading
 error message
In-Reply-To: <20190206230826.24970-1-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
Message-ID: <20190206230826.24970-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch changes an error code for an admin queue
head overrun to use I40E_ERR_ADMIN_QUEUE_FULL instead
of I40E_ERR_QUEUE_EMPTY.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 7ab61f6ebb5f..45f6adc8ff2f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -749,7 +749,7 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	if (val >= hw->aq.num_asq_entries) {
 		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
 			   "AQTX: head overrun at %d\n", val);
-		status = I40E_ERR_QUEUE_EMPTY;
+		status = I40E_ERR_ADMIN_QUEUE_FULL;
 		goto asq_send_command_error;
 	}
 
-- 
2.19.2

