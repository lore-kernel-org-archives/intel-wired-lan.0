From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 13 Jan 2019 11:22:31 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unneeded code
Message-ID: <20190113092231.40675-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the 'igc_get_link_up_info_base method' from igc_base.c file.
Use the 'igc_get_speed_and_duplex_copper' method directly and reduce
the code redundancy.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 19ff987922d2..a31ec1682090 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -334,26 +334,6 @@ static void igc_release_phy_base(struct igc_hw *hw)
 }
 
 /**
- * igc_get_link_up_info_base - Get link speed/duplex info
- * @hw: pointer to the HW structure
- * @speed: stores the current speed
- * @duplex: stores the current duplex
- *
- * This is a wrapper function, if using the serial gigabit media independent
- * interface, use PCS to retrieve the link speed and duplex information.
- * Otherwise, use the generic function to get the link speed and duplex info.
- */
-static s32 igc_get_link_up_info_base(struct igc_hw *hw, u16 *speed,
-				     u16 *duplex)
-{
-	s32 ret_val;
-
-	ret_val = igc_get_speed_and_duplex_copper(hw, speed, duplex);
-
-	return ret_val;
-}
-
-/**
  * igc_init_hw_base - Initialize hardware
  * @hw: pointer to the HW structure
  *
@@ -499,7 +479,7 @@ static struct igc_mac_operations igc_mac_ops_base = {
 	.check_for_link		= igc_check_for_copper_link,
 	.rar_set		= igc_rar_set,
 	.read_mac_addr		= igc_read_mac_addr_base,
-	.get_speed_and_duplex	= igc_get_link_up_info_base,
+	.get_speed_and_duplex	= igc_get_speed_and_duplex_copper,
 };
 
 static const struct igc_phy_operations igc_phy_ops_base = {
-- 
2.11.0

