From: Alice Michael <alice.michael@intel.com>
Date: Fri, 23 Jun 2017 04:24:48 -0400
Subject: [Intel-wired-lan] [next PATCH S74-V2 07/10] i40e: Detect ATR HW
	Evict NVM issue and disable the feature
In-Reply-To: <20170623082451.32671-1-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
Message-ID: <20170623082451.32671-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a problem with the HW ATR eviction feature where the
NVM setting was incorrect.  This patch detects the issue on X720
adapters and disables the feature if the NVM setting is incorrect.

Without this patch, HW ATR Evict feature does not work on broken NVMs
and is not detected either.  If the HW ATR Evict feature is disabled
the SW Eviction feature will take effect.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 43840cf..ffd4891 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8963,6 +8963,14 @@ static int i40e_sw_init(struct i40e_pf *pf)
 				    I40E_HW_PTP_L4_CAPABLE |
 				    I40E_HW_WOL_MC_MAGIC_PKT_WAKE |
 				    I40E_HW_OUTER_UDP_CSUM_CAPABLE);
+
+#define I40E_FDEVICT_PCTYPE_DEFAULT 0xc03
+		if (rd32(&pf->hw, I40E_GLQF_FDEVICTENA(1)) !=
+						I40E_FDEVICT_PCTYPE_DEFAULT) {
+			dev_warn(&pf->pdev->dev,
+				 "FD EVICT PCTYPES are not right, disable FD HW EVICT\n");
+			pf->hw_features &= ~I40E_HW_ATR_EVICT_CAPABLE;
+		}
 	} else if ((pf->hw.aq.api_maj_ver > 1) ||
 		   ((pf->hw.aq.api_maj_ver == 1) &&
 		    (pf->hw.aq.api_min_ver > 4))) {
-- 
2.9.3

