From: Sasha Neftin <sasha.neftin@intel.com>
Date: Fri, 15 Mar 2019 17:12:07 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded hw_dbg prints
Message-ID: <20190315151207.12791-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove unneeded hw_dbg prints from igc_ethtool.c file.
Clean up code.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index aaa1f97d5920..ac98f1d96892 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1715,17 +1715,13 @@ static int igc_get_link_ksettings(struct net_device *netdev,
 			if (hw->mac.type == igc_i225 &&
 			    (status & IGC_STATUS_SPEED_2500)) {
 				speed = SPEED_2500;
-				hw_dbg("2500 Mbs, ");
 			} else {
 				speed = SPEED_1000;
-				hw_dbg("1000 Mbs, ");
 			}
 		} else if (status & IGC_STATUS_SPEED_100) {
 			speed = SPEED_100;
-			hw_dbg("100 Mbs, ");
 		} else {
 			speed = SPEED_10;
-			hw_dbg("10 Mbs, ");
 		}
 		if ((status & IGC_STATUS_FD) ||
 		    hw->phy.media_type != igc_media_type_copper)
-- 
2.11.0

