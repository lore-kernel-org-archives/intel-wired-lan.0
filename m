From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Nov 2019 06:24:04 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for ethtool -m issue on X722 NIC
Message-ID: <20191106142404.48814-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

This patch contains fix for a problem with command:
'ethtool -m <dev>'
which breaks functionality of:
'ethtool <dev>'
when called on X722 NIC

Disallowed update of link phy_types on X722 NIC
Currently correct value cannot be obtained from FW
Previously wrong value returned by FW was used and was
a root cause for incorrect output of 'ethtool <dev>' command

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index a0791447849a..d4055037af89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1896,7 +1896,8 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
-	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE &&
+	    hw->mac.type != I40E_MAC_X722) {
 		__le32 tmp;
 
 		memcpy(&tmp, resp->link_type, sizeof(tmp));
-- 
2.21.0

