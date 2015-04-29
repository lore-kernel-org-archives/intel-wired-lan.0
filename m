From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Wed, 29 Apr 2015 15:23:28 -0700
Subject: [Intel-wired-lan] [PATCH] igb: Fix i354 88E1112 PHY on RCC boards
 using AutoMediaDetect
Message-ID: <20150429222328.18201.67366.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000_check_for_link_media_swap() checks PHY page 0 for copper and PHY
page 1 for "other" (fiber) link. The switch back from page 1 to page 0
happened too soon, before e1000_check_for_link_82575() is executed, and
link on fiber (other) was never detected. Check for link while still on
the proper PHY page.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index b0182dd..d192569 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -139,10 +139,6 @@ static s32 igb_check_for_link_media_swap(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
-	/* reset page to 0 */
-	ret_val = phy->ops.write_reg(hw, E1000_M88E1112_PAGE_ADDR, 0);
-	if (ret_val)
-		return ret_val;
 
 	if (data & E1000_M88E1112_STATUS_LINK)
 		port = E1000_MEDIA_PORT_OTHER;
@@ -151,8 +147,20 @@ static s32 igb_check_for_link_media_swap(struct e1000_hw *hw)
 	if (port && (hw->dev_spec._82575.media_port != port)) {
 		hw->dev_spec._82575.media_port = port;
 		hw->dev_spec._82575.media_changed = true;
+	}
+
+	if (port == E1000_MEDIA_PORT_COPPER) {
+		/* reset page to 0 */
+		ret_val = phy->ops.write_reg(hw, E1000_M88E1112_PAGE_ADDR, 0);
+		if (ret_val)
+			return ret_val;
+		igb_check_for_link_82575(hw);
 	} else {
-		ret_val = igb_check_for_link_82575(hw);
+		igb_check_for_link_82575(hw);
+		/* reset page to 0 */
+		ret_val = phy->ops.write_reg(hw, E1000_M88E1112_PAGE_ADDR, 0);
+		if (ret_val)
+			return ret_val;
 	}
 
 	return 0;

