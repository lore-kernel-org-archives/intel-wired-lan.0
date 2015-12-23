From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:51 -0800
Subject: [Intel-wired-lan] [next PATCH S25 11/16] i40e: add a little more to
	an NVM update debug message
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-12-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add a little more detail to an NVM update debug message in order to
see the full ethtool request data.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Acked-by: Kevin Scott <kevin.c.scott@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: Iab10437cb32d6fddc67ee347e7c0b42511e152cd
---
Testing-Hints:
Turn on NVM update debug and see the new data in the logfile
ethtool -s eth0 msglvl 0xf000008f

 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 59edd33..042feca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -750,10 +750,11 @@ i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
 	/* early check for status command and debug msgs */
 	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
 
-	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d\n",
+	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d cmd 0x%08x config 0x%08x offset 0x%08x data_size 0x%08x\n",
 		   i40e_nvm_update_state_str[upd_cmd],
 		   hw->nvmupd_state,
-		   hw->aq.nvm_release_on_done);
+		   hw->aq.nvm_release_on_done,
+		   cmd->command, cmd->config, cmd->offset, cmd->data_size);
 
 	if (upd_cmd == I40E_NVMUPD_INVALID) {
 		*perrno = -EFAULT;
-- 
2.1.0

