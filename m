From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 18 Jul 2021 12:42:09 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove media type checking on
 the PHY initialization
Message-ID: <20210718094209.3692993-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i225 devices have only copper phy media type. There is no point in checking
phy media type during the phy initialization.
This patch comes to clean up these pointless checkings.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 93feed4f7f1c..260b7b17bbcc 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -158,11 +158,6 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 	struct igc_phy_info *phy = &hw->phy;
 	s32 ret_val = 0;
 
-	if (hw->phy.media_type != igc_media_type_copper) {
-		phy->type = igc_phy_none;
-		goto out;
-	}
-
 	phy->autoneg_mask	= AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
 	phy->reset_delay_us	= 100;
 
-- 
2.25.1

