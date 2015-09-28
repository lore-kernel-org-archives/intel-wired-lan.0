From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:32 -0400
Subject: [Intel-wired-lan] [next PATCH S16 03/15] i40e: remove read/write
	failed messages from nvmupdate
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Allow the nvmupdate application to decide when a read or write error
should be exposed to the user.  Since the application needs to use
write probes to find the ReadOnly sections on a potentially unknown NVM
version in the HW and read probes to check the status of the last write,
some error messages are expected, but need not be shown to the users.
The driver doesn't know which are ignorable from real errors, so needs
to let the application make the decision.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I78fca8ab672bede11c10c820b83c26adfd536d03
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0d5aecf..0ea71c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -993,9 +993,7 @@ static int i40e_get_eeprom(struct net_device *netdev,
 
 		cmd = (struct i40e_nvm_access *)eeprom;
 		ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
-		if (ret_val &&
-		    ((hw->aq.asq_last_status != I40E_AQ_RC_EACCES) ||
-		     (hw->debug_mask & I40E_DEBUG_NVM)))
+		if (ret_val && (hw->debug_mask & I40E_DEBUG_NVM))
 			dev_info(&pf->pdev->dev,
 				 "NVMUpdate read failed err=%d status=0x%x errno=%d module=%d offset=0x%x size=%d\n",
 				 ret_val, hw->aq.asq_last_status, errno,
@@ -1099,10 +1097,7 @@ static int i40e_set_eeprom(struct net_device *netdev,
 
 	cmd = (struct i40e_nvm_access *)eeprom;
 	ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
-	if (ret_val &&
-	    ((hw->aq.asq_last_status != I40E_AQ_RC_EPERM &&
-	      hw->aq.asq_last_status != I40E_AQ_RC_EBUSY) ||
-	     (hw->debug_mask & I40E_DEBUG_NVM)))
+	if (ret_val && (hw->debug_mask & I40E_DEBUG_NVM))
 		dev_info(&pf->pdev->dev,
 			 "NVMUpdate write failed err=%d status=0x%x errno=%d module=%d offset=0x%x size=%d\n",
 			 ret_val, hw->aq.asq_last_status, errno,
-- 
1.9.3

