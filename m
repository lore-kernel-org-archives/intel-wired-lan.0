From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:18 -0800
Subject: [Intel-wired-lan] [next PATCH S28 11/15] i40e: better error
	reporting for nvmupdate
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-12-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Make sure we return EBUSY while finishing up a reset, and add a few bits
for better debug messages.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I23f6c28a8d96d7aa171abcc265737cec7826c292
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 39 +++++++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  5 +++-
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d2010290..54d63a6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1005,16 +1005,19 @@ static int i40e_get_eeprom(struct net_device *netdev,
 	/* check for NVMUpdate access method */
 	magic = hw->vendor_id | (hw->device_id << 16);
 	if (eeprom->magic && eeprom->magic != magic) {
-		struct i40e_nvm_access *cmd;
-		int errno;
+		struct i40e_nvm_access *cmd = (struct i40e_nvm_access *)eeprom;
+		int errno = 0;
 
 		/* make sure it is the right magic for NVMUpdate */
 		if ((eeprom->magic >> 16) != hw->device_id)
-			return -EINVAL;
+			errno = -EINVAL;
+		else if (test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state) ||
+			 test_bit(__I40E_RESET_INTR_RECEIVED, &pf->state))
+			errno = -EBUSY;
+		else
+			ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
 
-		cmd = (struct i40e_nvm_access *)eeprom;
-		ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
-		if (ret_val && (hw->debug_mask & I40E_DEBUG_NVM))
+		if ((errno || ret_val) && (hw->debug_mask & I40E_DEBUG_NVM))
 			dev_info(&pf->pdev->dev,
 				 "NVMUpdate read failed err=%d status=0x%x errno=%d module=%d offset=0x%x size=%d\n",
 				 ret_val, hw->aq.asq_last_status, errno,
@@ -1098,27 +1101,25 @@ static int i40e_set_eeprom(struct net_device *netdev,
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_hw *hw = &np->vsi->back->hw;
 	struct i40e_pf *pf = np->vsi->back;
-	struct i40e_nvm_access *cmd;
+	struct i40e_nvm_access *cmd = (struct i40e_nvm_access *)eeprom;
 	int ret_val = 0;
-	int errno;
+	int errno = 0;
 	u32 magic;
 
 	/* normal ethtool set_eeprom is not supported */
 	magic = hw->vendor_id | (hw->device_id << 16);
 	if (eeprom->magic == magic)
-		return -EOPNOTSUPP;
-
+		errno = -EOPNOTSUPP;
 	/* check for NVMUpdate access method */
-	if (!eeprom->magic || (eeprom->magic >> 16) != hw->device_id)
-		return -EINVAL;
-
-	if (test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state) ||
-	    test_bit(__I40E_RESET_INTR_RECEIVED, &pf->state))
-		return -EBUSY;
+	else if (!eeprom->magic || (eeprom->magic >> 16) != hw->device_id)
+		errno = -EINVAL;
+	else if (test_bit(__I40E_RESET_RECOVERY_PENDING, &pf->state) ||
+		 test_bit(__I40E_RESET_INTR_RECEIVED, &pf->state))
+		errno = -EBUSY;
+	else
+		ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
 
-	cmd = (struct i40e_nvm_access *)eeprom;
-	ret_val = i40e_nvmupd_command(hw, cmd, bytes, &errno);
-	if (ret_val && (hw->debug_mask & I40E_DEBUG_NVM))
+	if ((errno || ret_val) && (hw->debug_mask & I40E_DEBUG_NVM))
 		dev_info(&pf->pdev->dev,
 			 "NVMUpdate write failed err=%d status=0x%x errno=%d module=%d offset=0x%x size=%d\n",
 			 ret_val, hw->aq.asq_last_status, errno,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5e7a7a1..98cbc90 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3475,6 +3475,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
 	if (icr0 & I40E_PFINT_ICR0_ADMINQ_MASK) {
 		ena_mask &= ~I40E_PFINT_ICR0_ENA_ADMINQ_MASK;
 		set_bit(__I40E_ADMINQ_EVENT_PENDING, &pf->state);
+		i40e_debug(&pf->hw, I40E_DEBUG_NVM, "AdminQ event\n");
 	}
 
 	if (icr0 & I40E_PFINT_ICR0_MAL_DETECT_MASK) {
@@ -6323,7 +6324,9 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 		case i40e_aqc_opc_nvm_erase:
 		case i40e_aqc_opc_nvm_update:
 		case i40e_aqc_opc_oem_post_update:
-			i40e_debug(&pf->hw, I40E_DEBUG_NVM, "ARQ NVM operation completed\n");
+			i40e_debug(&pf->hw, I40E_DEBUG_NVM,
+				   "ARQ NVM operation 0x%04x completed\n",
+				   opcode);
 			break;
 		default:
 			dev_info(&pf->pdev->dev,
-- 
2.1.0

