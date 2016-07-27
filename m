From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 27 Jul 2016 12:02:34 -0700
Subject: [Intel-wired-lan] [next PATCH S40-V2 05/12] i40e: Fix static
	analysis tool warning
In-Reply-To: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469646161-30024-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

This patch fixes a problem where a static analysis tool generates
a warning for "INVARIANT_CONDITION: Expression 'enabled_tc' used
in the condition always yields the same result."

Without this patch, the driver will not pass the static analysis
tool checks without generating warnings.

This patch fixes the problem by eliminating the irrelevant check
and redundant assignment for the value of enabled_tc.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Change-ID: Ia7d44cb050f507df7de333e96369d322e08bf408
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 77a35cf..d80efc1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4590,7 +4590,7 @@ static u8 i40e_dcb_get_enabled_tc(struct i40e_dcbx_config *dcbcfg)
 static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
-	u8 i, enabled_tc;
+	u8 i, enabled_tc = 1;
 	u8 num_tc = 0;
 	struct i40e_dcbx_config *dcbcfg = &hw->local_dcbx_config;
 
@@ -4608,8 +4608,6 @@ static u8 i40e_pf_get_num_tc(struct i40e_pf *pf)
 	else
 		return 1; /* Only TC0 */
 
-	/* At least have TC0 */
-	enabled_tc = (enabled_tc ? enabled_tc : 0x1);
 	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 		if (enabled_tc & BIT(i))
 			num_tc++;
-- 
2.4.11

