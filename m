From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed,  1 Jul 2020 14:30:43 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove ledctl_ fields from
 the mac_info structure
Message-ID: <20200701113043.9053-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

LED control currently not implemented.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 2ab7d9fab6af..8066749a55d0 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -83,9 +83,6 @@ struct igc_mac_info {
 	enum igc_mac_type type;
 
 	u32 collision_delta;
-	u32 ledctl_default;
-	u32 ledctl_mode1;
-	u32 ledctl_mode2;
 	u32 mc_filter_type;
 	u32 tx_packet_delta;
 	u32 txcw;
-- 
2.11.0

