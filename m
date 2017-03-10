From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri, 10 Mar 2017 12:22:04 -0800
Subject: [Intel-wired-lan] [next PATCH S62 5/6] i40e: remove a useless goto
	statement
In-Reply-To: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1489177325-13156-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The goto found here for when in MFP mode is pointless. It jumps to the
end of a series of if blocks. However, right after this statement is
a closing '}' for this if block, which will result in the program flow
going to the exact same location as the goto statement indicates. Thus,
regardless of whether we are in MFP mode, the program flow will resume
from the same location.

This arose due to various refactoring which did not notice that this
goto became essentially a no-op.

To properly understand this diff you will need to view a larger context
than is given by default.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I088f73c3831aa5c4e2281380c7a3ce605594300c
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bab9337..4cfe9491 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5175,10 +5175,6 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 		    (hw->dcbx_status == I40E_DCBX_STATUS_DISABLED)) {
 			dev_info(&pf->pdev->dev,
 				 "DCBX offload is not supported or is disabled for this PF.\n");
-
-			if (pf->flags & I40E_FLAG_MFP_ENABLED)
-				goto out;
-
 		} else {
 			/* When status is not DISABLED then DCBX in FW */
 			pf->dcbx_cap = DCB_CAP_DCBX_LLD_MANAGED |
-- 
2.4.11

