From: Alice Michael <alice.michael@intel.com>
Date: Fri, 21 Jul 2017 11:18:01 -0400
Subject: [Intel-wired-lan] [next PATCH S75-V4 04/11] i40e: synchronize
	nvmupdate command and adminq subtask
Message-ID: <20170721151801.30794-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

During NVM update, state machine gets into unrecoverable state because
i40e_clean_adminq_subtask can get scheduled after the admin queue
command but before other state variables are updated. This causes
incorrect input to i40e_nvmupd_check_wait_event and state transitions
don't happen.

This issue existed before but surfaced after commit 373149fc99a0
("i40e: Decrease the scope of rtnl lock")

This fix adds locking around admin queue command and update of
state variables so that adminq_subtask will have accurate information
whenever it gets scheduled.

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 17607a2..c90abb2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -753,6 +753,15 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
 	}
 
+	/* Acquire lock to prevent race condition where adminq_task
+	 * can execute after i40e_nvmupd_nvm_read/write but before state
+	 * variables (nvm_wait_opcode, nvm_release_on_done) are updated.
+	 *
+	 * During NVMUpdate, it is observed that lock could be held for
+	 * ~5ms for most commands. However lock is held for ~60ms for
+	 * NVMUPD_CSUM_LCB command.
+	 */
+	mutex_lock(&hw->aq.arq_mutex);
 	switch (hw->nvmupd_state) {
 	case I40E_NVMUPD_STATE_INIT:
 		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno);
@@ -773,7 +782,8 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		 */
 		if (cmd->offset == 0xffff) {
 			i40e_nvmupd_check_wait_event(hw, hw->nvm_wait_opcode);
-			return 0;
+			status = 0;
+			goto exit;
 		}
 
 		status = I40E_ERR_NOT_READY;
@@ -788,6 +798,8 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 		*perrno = -ESRCH;
 		break;
 	}
+exit:
+	mutex_unlock(&hw->aq.arq_mutex);
 	return status;
 }
 
-- 
2.9.4

