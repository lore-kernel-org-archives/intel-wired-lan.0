From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:42 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 04/13] i40e: Fix up return code
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-5-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The i40e_common.c typically uses i40e_status as a return code,
but got missed this one case.

Testing Hints: Compile Linux kernel build.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index b0fd684..8276a13 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1901,13 +1901,13 @@ i40e_status i40e_aq_set_phy_int_mask(struct i40e_hw *hw,
  *
  * Reset the external PHY.
  **/
-enum i40e_status_code i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
-					struct i40e_asq_cmd_details *cmd_details)
+i40e_status i40e_aq_set_phy_debug(struct i40e_hw *hw, u8 cmd_flags,
+				  struct i40e_asq_cmd_details *cmd_details)
 {
 	struct i40e_aq_desc desc;
 	struct i40e_aqc_set_phy_debug *cmd =
 		(struct i40e_aqc_set_phy_debug *)&desc.params.raw;
-	enum i40e_status_code status;
+	i40e_status status;
 
 	i40e_fill_default_direct_cmd_desc(&desc,
 					  i40e_aqc_opc_set_phy_debug);
-- 
2.4.3

