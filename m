From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:16 -0700
Subject: [Intel-wired-lan] [next PATCH S6 2/7] i40e: Fix for missing "link
 modes" info in ethtool
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Martyna Szapar <martyna.szapar@intel.com>

Fix for missing "Supported link modes" and "Advertised link modes"
info in ethtool after changed speed on X722 devices with BASE-T PHY
with FW API version >= 1.7.
The same FW API version on X710 and X722 does not mean the same
feature set so the change was needed as mac type of the device
should also be checked instead of FW API version only.

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 641b500ad919..906cf68d3453 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1861,8 +1861,7 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	     hw->aq.fw_min_ver < 40)) && hw_link_info->phy_type == 0xE)
 		hw_link_info->phy_type = I40E_PHY_TYPE_10GBASE_SFPP_CU;
 
-	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-	    hw->aq.api_min_ver >= 7) {
+	if (hw->flags & I40E_HW_FLAG_AQ_PHY_ACCESS_CAPABLE) {
 		__le32 tmp;
 
 		memcpy(&tmp, resp->link_type, sizeof(tmp));
-- 
2.19.2

