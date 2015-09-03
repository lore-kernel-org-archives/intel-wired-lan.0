From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:54 -0400
Subject: [Intel-wired-lan] [next PATCH S15 07/15] i40e: remove obsolete
	version check
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This version check only applies to very, very old firmware,
that only ran on A0 hardware, which we never shipped and don't
support in this driver anyway. Remove it, before somebody
gets hurt.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I3752d090ff488acf98ee76b075af961e9c968ee4
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a323d6d..dd04b61 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6468,12 +6468,6 @@ static int i40e_get_capabilities(struct i40e_pf *pf)
 		}
 	} while (err);
 
-	if (((pf->hw.aq.fw_maj_ver == 2) && (pf->hw.aq.fw_min_ver < 22)) ||
-	    (pf->hw.aq.fw_maj_ver < 2)) {
-		pf->hw.func_caps.num_msix_vectors++;
-		pf->hw.func_caps.num_msix_vectors_vf++;
-	}
-
 	if (pf->hw.debug_mask & I40E_DEBUG_USER)
 		dev_info(&pf->pdev->dev,
 			 "pf=%d, num_vfs=%d, msix_pf=%d, msix_vf=%d, fd_g=%d, fd_b=%d, pf_max_q=%d num_vsi=%d\n",
-- 
1.9.3

