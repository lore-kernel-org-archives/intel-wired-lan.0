From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  2 Dec 2016 12:33:02 -0800
Subject: [Intel-wired-lan] [next PATCH S56 8/8] Acquire NVM lock before
	reads on all devices
In-Reply-To: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480710782-9195-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aaron Salter <aaron.k.salter@intel.com>

Acquire NVM lock before reads on all devices.  Previously, locks were
only used for X722 and later.  Fixes an issue where simultaneous X710
NVM accesses were interfering with each other.

Signed-off-by: Aaron Salter <aaron.k.salter@intel.com>
Change-ID: If570bb7acf958cef58725ec2a2011cead6f80638
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 38ee18f..800bd55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -292,14 +292,14 @@ i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 {
 	enum i40e_status_code ret_code = 0;
 
-	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
-		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!ret_code) {
+	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+	if (!ret_code) {
+		if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
 			ret_code = i40e_read_nvm_word_aq(hw, offset, data);
-			i40e_release_nvm(hw);
+		} else {
+			ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
 		}
-	} else {
-		ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
+		i40e_release_nvm(hw);
 	}
 	return ret_code;
 }
-- 
2.4.11

