From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:07 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 01/13] i40e: Fix for unused
	value issue found by static analysis
Message-ID: <20170714131019.52530-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes an issue where an error return value is
set, but without an immediate exit, the value can be overwritten
by the following code execution.  The condition  at this point
is not fatal, so remove the error assignment and comment the
intent for future code maintainers

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 998ad96..9ee1d0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9865,13 +9865,15 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			 */
 			ret = i40e_vsi_config_tc(vsi, enabled_tc);
 			if (ret) {
+				/* Single TC condition is not fatal,
+				 * message and continue
+				 */
 				dev_info(&pf->pdev->dev,
 					 "failed to configure TCs for main VSI tc_map 0x%08x, err %s aq_err %s\n",
 					 enabled_tc,
 					 i40e_stat_str(&pf->hw, ret),
 					 i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
-				ret = -ENOENT;
 			}
 		}
 		break;
-- 
2.9.3

