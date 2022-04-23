From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sat, 23 Apr 2022 19:55:02 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Change type of the
 'igc_check_downshift' method
Message-ID: <20220423165502.838143-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The 'igc_check_downshift' method always return 0 value. There is no point
return value. Change the return type of this method to void.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_phy.c | 6 +-----
 drivers/net/ethernet/intel/igc/igc_phy.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 2140ad1e8443..53b77c969c85 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -141,18 +141,14 @@ void igc_power_down_phy_copper(struct igc_hw *hw)
  * igc_check_downshift - Checks whether a downshift in speed occurred
  * @hw: pointer to the HW structure
  *
- * Success returns 0, Failure returns 1
- *
  * A downshift is detected by querying the PHY link health.
  */
-s32 igc_check_downshift(struct igc_hw *hw)
+void igc_check_downshift(struct igc_hw *hw)
 {
 	struct igc_phy_info *phy = &hw->phy;
 
 	/* speed downshift not supported */
 	phy->speed_downgraded = false;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.h b/drivers/net/ethernet/intel/igc/igc_phy.h
index 1b031372d206..832a7e359f18 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.h
+++ b/drivers/net/ethernet/intel/igc/igc_phy.h
@@ -11,7 +11,7 @@ s32 igc_phy_hw_reset(struct igc_hw *hw);
 s32 igc_get_phy_id(struct igc_hw *hw);
 s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
 		     u32 usec_interval, bool *success);
-s32 igc_check_downshift(struct igc_hw *hw);
+void igc_check_downshift(struct igc_hw *hw);
 s32 igc_setup_copper_link(struct igc_hw *hw);
 void igc_power_up_phy_copper(struct igc_hw *hw);
 void igc_power_down_phy_copper(struct igc_hw *hw);
-- 
2.30.2

