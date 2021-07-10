From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sat, 10 Jul 2021 20:57:50 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove phy->type checking
Message-ID: <20210710175750.2088213-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 devices have only one phy->type: copper. There is no point checking
phy->type during the igc_has_link method from the watchdog that
invoked every 2 seconds.
This patch comes to clean up these pointless checkings.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index c8abd7fb70e5..722b79ba2abd 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5222,17 +5222,10 @@ bool igc_has_link(struct igc_adapter *adapter)
 	 * false until the igc_check_for_link establishes link
 	 * for copper adapters ONLY
 	 */
-	switch (hw->phy.media_type) {
-	case igc_media_type_copper:
-		if (!hw->mac.get_link_status)
-			return true;
-		hw->mac.ops.check_for_link(hw);
-		link_active = !hw->mac.get_link_status;
-		break;
-	default:
-	case igc_media_type_unknown:
-		break;
-	}
+	if (!hw->mac.get_link_status)
+		return true;
+	hw->mac.ops.check_for_link(hw);
+	link_active = !hw->mac.get_link_status;
 
 	if (hw->mac.type == igc_i225) {
 		if (!netif_carrier_ok(adapter->netdev)) {
-- 
2.25.1

