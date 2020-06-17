From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 17 Jun 2020 15:01:31 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove checking media type
 during MAC initialization
Message-ID: <20200617120131.21277-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 device support only copper mode.
There is no point to check media type in the
igc_config_fc_after_link_up() method.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 9a5e44ef45f4..b47e7b0a6398 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -468,10 +468,8 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	 * so we had to force link.  In this case, we need to force the
 	 * configuration of the MAC to match the "fc" parameter.
 	 */
-	if (mac->autoneg_failed) {
-		if (hw->phy.media_type == igc_media_type_copper)
-			ret_val = igc_force_mac_fc(hw);
-	}
+	if (mac->autoneg_failed)
+		ret_val = igc_force_mac_fc(hw);
 
 	if (ret_val) {
 		hw_dbg("Error forcing flow control settings\n");
@@ -483,7 +481,7 @@ s32 igc_config_fc_after_link_up(struct igc_hw *hw)
 	 * has completed, and if so, how the PHY and link partner has
 	 * flow control configured.
 	 */
-	if (hw->phy.media_type == igc_media_type_copper && mac->autoneg) {
+	if (mac->autoneg) {
 		/* Read the MII Status Register and check to see if AutoNeg
 		 * has completed.  We read this twice because this reg has
 		 * some "sticky" (latched) bits.
-- 
2.11.0

