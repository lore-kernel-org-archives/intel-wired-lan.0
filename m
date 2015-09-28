From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:56 -0400
Subject: [Intel-wired-lan] [next PATCH S17 07/11] i40e: fix for PHY NVM
	interaction problem
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes a problem where the NVMUpdate Tool, when using the PHY
NVM feature, gets bad data from the PHY because of contention on the
MDIO interface from get phy capability calls from the driver during
regular operations.  The problem is fixed by adding a check if media
is available before calling get phy capability function because that
bit is not set when device is in PHY interaction mode.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ib89991b0f841808dd92410f5e8683d6ee3301cd0
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 01d5f0b..a1cfb16 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2346,13 +2346,15 @@ i40e_status i40e_update_link_info(struct i40e_hw *hw)
 	if (status)
 		return status;
 
-	status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
-					      NULL);
-	if (status)
-		return status;
+	if (hw->phy.link_info.link_info & I40E_AQ_MEDIA_AVAILABLE) {
+		status = i40e_aq_get_phy_capabilities(hw, false, false,
+						      &abilities, NULL);
+		if (status)
+			return status;
 
-	memcpy(hw->phy.link_info.module_type, &abilities.module_type,
-	       sizeof(hw->phy.link_info.module_type));
+		memcpy(hw->phy.link_info.module_type, &abilities.module_type,
+		       sizeof(hw->phy.link_info.module_type));
+	}
 
 	return status;
 }
-- 
1.9.3

