From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  1 Sep 2017 13:43:08 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: point wb_desc at the nvm_wb_desc
	during i40e_read_nvm_aq
Message-ID: <20170901204308.4098-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When introducing the functions to read the NVM through the AdminQ, we
did not correctly mark the wb_desc.

Fixes: 7073f46e443e ("i40e: Add AQ commands for NVM Update for X722", 2015-06-05)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index d92aedc278aa..1b39cf7a0473 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -247,6 +247,7 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
 	struct i40e_asq_cmd_details cmd_details;
 
 	memset(&cmd_details, 0, sizeof(cmd_details));
+	cmd_details.wb_desc = &hw->nvm_wb_desc;
 
 	/* Here we are checking the SR limit only for the flat memory model.
 	 * We cannot do it for the module-based model, as we did not acquire
-- 
2.14.1.436.g33e61a4f0239

