From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Thu, 19 Nov 2015 11:34:21 -0800
Subject: [Intel-wired-lan] [V3: next PATCH S22 08/12] i40e: hush little
	warnings
In-Reply-To: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447961665-12344-9-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

These messages seem big and scary, but they're really not. The driver
can fully recover from any of these. The overflow error in particular
can happen when enabling a bunch of VFs and the VF driver is not
blacklisted.

Since these messages are really for debugging purposes, reclassify
them as such.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I628d0f5e135e7063450ba05393a50b7af23aa6d7
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7ded5e5..c03bb72 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6219,15 +6219,18 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 	val = rd32(&pf->hw, pf->hw.aq.arq.len);
 	oldval = val;
 	if (val & I40E_PF_ARQLEN_ARQVFE_MASK) {
-		dev_info(&pf->pdev->dev, "ARQ VF Error detected\n");
+		if (hw->debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ARQ VF Error detected\n");
 		val &= ~I40E_PF_ARQLEN_ARQVFE_MASK;
 	}
 	if (val & I40E_PF_ARQLEN_ARQOVFL_MASK) {
-		dev_info(&pf->pdev->dev, "ARQ Overflow Error detected\n");
+		if (hw->debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ARQ Overflow Error detected\n");
 		val &= ~I40E_PF_ARQLEN_ARQOVFL_MASK;
 	}
 	if (val & I40E_PF_ARQLEN_ARQCRIT_MASK) {
-		dev_info(&pf->pdev->dev, "ARQ Critical Error detected\n");
+		if (hw->debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ARQ Critical Error detected\n");
 		val &= ~I40E_PF_ARQLEN_ARQCRIT_MASK;
 	}
 	if (oldval != val)
@@ -6236,15 +6239,18 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 	val = rd32(&pf->hw, pf->hw.aq.asq.len);
 	oldval = val;
 	if (val & I40E_PF_ATQLEN_ATQVFE_MASK) {
-		dev_info(&pf->pdev->dev, "ASQ VF Error detected\n");
+		if (pf->hw.debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ASQ VF Error detected\n");
 		val &= ~I40E_PF_ATQLEN_ATQVFE_MASK;
 	}
 	if (val & I40E_PF_ATQLEN_ATQOVFL_MASK) {
-		dev_info(&pf->pdev->dev, "ASQ Overflow Error detected\n");
+		if (pf->hw.debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ASQ Overflow Error detected\n");
 		val &= ~I40E_PF_ATQLEN_ATQOVFL_MASK;
 	}
 	if (val & I40E_PF_ATQLEN_ATQCRIT_MASK) {
-		dev_info(&pf->pdev->dev, "ASQ Critical Error detected\n");
+		if (pf->hw.debug_mask & I40E_DEBUG_AQ)
+			dev_info(&pf->pdev->dev, "ASQ Critical Error detected\n");
 		val &= ~I40E_PF_ATQLEN_ATQCRIT_MASK;
 	}
 	if (oldval != val)
-- 
2.1.0

