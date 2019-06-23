From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 23 Jun 2019 13:42:31 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/2] igc: Remove the polarity field
 from a PHY information structure
Message-ID: <20190623104232.36661-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Polarity and cable length fields is not applicable for the i225 device.
This patch comes to clean up phy information structure.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_hw.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index 1039a224ac80..f689f0a02b5d 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -151,16 +151,10 @@ struct igc_phy_info {
 
 	u16 autoneg_advertised;
 	u16 autoneg_mask;
-	u16 cable_length;
-	u16 max_cable_length;
-	u16 min_cable_length;
-	u16 pair_length[4];
 
 	u8 mdix;
 
-	bool disable_polarity_correction;
 	bool is_mdix;
-	bool polarity_correction;
 	bool reset_disable;
 	bool speed_downgraded;
 	bool autoneg_wait_to_complete;
-- 
2.11.0

