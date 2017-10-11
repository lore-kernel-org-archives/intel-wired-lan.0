From: Alan Brady <alan.brady@intel.com>
Date: Wed, 11 Oct 2017 14:49:42 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/2 net-next] i40e: fix link reporting
Message-ID: <20171011214943.7076-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When querying the NVM for supported phy_types, on some firmware
versions, we were failing to actually fill out the phy_types which means
ethtool wouldn't report any link types.

Testing-hints:
Check 'ethtool <iface>' if you have the right (wrong?) firmware.
Without this patch, no link modes will be reported.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 1b85eb3e6443..8d0ee006606b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1613,8 +1613,13 @@ i40e_status i40e_aq_get_phy_capabilities(struct i40e_hw *hw,
 	if (report_init) {
 		if (hw->mac.type ==  I40E_MAC_XL710 &&
 		    hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
-		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710)
+		    hw->aq.api_min_ver >= I40E_MINOR_VER_GET_LINK_INFO_XL710) {
 			status = i40e_aq_get_link_info(hw, true, NULL, NULL);
+		} else {
+			hw->phy.phy_types = le32_to_cpu(abilities->phy_type);
+			hw->phy.phy_types |=
+					((u64)abilities->phy_type_ext << 32);
+		}
 	}
 
 	return status;
-- 
2.14.2

