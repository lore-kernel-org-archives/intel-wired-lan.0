From: Alice Michael <alice.michael@intel.com>
Date: Mon, 12 Mar 2018 07:00:18 -0700
Subject: [Intel-wired-lan] [next PATCH S88 4/8] i40e: add doxygen comment
 for new mode parameter
In-Reply-To: <20180312140022.59580-1-alice.michael@intel.com>
References: <20180312140022.59580-1-alice.michael@intel.com>
Message-ID: <20180312140022.59580-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

A recent patch updated the signature for i40e_aq_set_switch_config() to
add a new parameter 'mode'. It forgot to document the parameter in the
doxygen function header comment. Add the parameter to the function
description now.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 792d420..2d00e95 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2416,6 +2416,7 @@ i40e_status i40e_aq_get_switch_config(struct i40e_hw *hw,
  * i40e_aq_set_switch_config
  * @hw: pointer to the hardware structure
  * @flags: bit flag values to set
+ * @mode: cloud filter mode
  * @valid_flags: which bit flags to set
  * @mode: cloud filter mode
  * @cmd_details: pointer to command details structure or NULL
-- 
2.9.5

