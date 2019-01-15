From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 15 Jan 2019 15:21:18 +0200
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Remove the 'igc_get_phy_id_base'
 method
Message-ID: <20190115132118.42860-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the redundant 'igc_get_phy_id_base' method and use
the 'igc_get_phy_id' method directly instead.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index 51a667c16dea..fe9a9666c70f 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -108,22 +108,6 @@ static s32 igc_reset_hw_base(struct igc_hw *hw)
 }
 
 /**
- * igc_get_phy_id_base - Retrieve PHY addr and id
- * @hw: pointer to the HW structure
- *
- * Retrieves the PHY address and ID for both PHY's which do and do not use
- * sgmi interface.
- */
-static s32 igc_get_phy_id_base(struct igc_hw *hw)
-{
-	s32  ret_val = 0;
-
-	ret_val = igc_get_phy_id(hw);
-
-	return ret_val;
-}
-
-/**
  * igc_init_nvm_params_base - Init NVM func ptrs.
  * @hw: pointer to the HW structure
  */
@@ -245,7 +229,7 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 		goto out;
 	}
 
-	ret_val = igc_get_phy_id_base(hw);
+	ret_val = igc_get_phy_id(hw);
 	if (ret_val)
 		return ret_val;
 
-- 
2.11.0

