From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Jun 2017 15:16:55 -0700
Subject: [Intel-wired-lan] [next PATCH S73-V2 3/9] i40e: Handle admin Q
	timeout when releasing NVM
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170620221701.46765-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

There are some rare cases where the release resource call will return an
admin Q timeout. In these cases the code needs to try to release the
resource again until it succeeds or it times out.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 800bd55..17607a2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -134,8 +134,25 @@ i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
  **/
 void i40e_release_nvm(struct i40e_hw *hw)
 {
-	if (!hw->nvm.blank_nvm_mode)
-		i40e_aq_release_resource(hw, I40E_NVM_RESOURCE_ID, 0, NULL);
+	i40e_status ret_code = I40E_SUCCESS;
+	u32 total_delay = 0;
+
+	if (hw->nvm.blank_nvm_mode)
+		return;
+
+	ret_code = i40e_aq_release_resource(hw, I40E_NVM_RESOURCE_ID, 0, NULL);
+
+	/* there are some rare cases when trying to release the resource
+	 * results in an admin Q timeout, so handle them correctly
+	 */
+	while ((ret_code == I40E_ERR_ADMIN_QUEUE_TIMEOUT) &&
+	       (total_delay < hw->aq.asq_cmd_timeout)) {
+		usleep_range(1000, 2000);
+		ret_code = i40e_aq_release_resource(hw,
+						    I40E_NVM_RESOURCE_ID,
+						    0, NULL);
+			total_delay++;
+	}
 }
 
 /**
-- 
2.9.3

