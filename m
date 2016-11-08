From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:07 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 03/15] i40e: Pass unknown PHY
	type for unknown PHYs
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

The PHY type value for unrecognized PHYs and cables was changed
based on firmware version number. Newer hardware use lower firmware
version numbers and this was causing some PHYs to be identified
as type 0x16 instead of 0xe (unknown).

Without this patch, newer card will incorrectly identify unknown
PHYs and cables.

This change adds hardware type to the check for firmware version
so the PHY type is reported correctly.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: I0723cbfd263c76fc73ff1a5275d1639051376c9a
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index b0358c0..33bcf23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1854,7 +1854,8 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	else
 		hw_link_info->lse_enable = false;
 
-	if ((hw->aq.fw_maj_ver < 4 || (hw->aq.fw_maj_ver == 4 &&
+	if ((hw->mac.type == I40E_MAC_XL710) &&
+	    (hw->aq.fw_maj_ver < 4 || (hw->aq.fw_maj_ver == 4 &&
 	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
-- 
2.4.11

