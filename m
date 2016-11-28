From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Mon, 28 Nov 2016 09:09:57 -0800
Subject: [Intel-wired-lan] [PATCH] igb: add i211 to i210 PHY workaround
Message-ID: <20161128170957.26228-1-todd.fujinaka@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i210 and i211 share the same PHY but have different PCI IDs. Don't
forget i211 for any i210 workarounds.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index 93ec2d0..6ebfb75 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -78,7 +78,7 @@ s32 igb_get_phy_id(struct e1000_hw *hw)
 	u16 phy_id;
 
 	/* ensure phy page selection to fix misconfigured i210 */
-	if (hw->mac.type == e1000_i210)
+	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
 		phy->ops.write_reg(hw, I347AT4_PAGE_SELECT, 0);
 
 	ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
-- 
2.9.3

