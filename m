From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 11 Dec 2018 18:55:41 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unreachable code from
 igc_phy.c file
Message-ID: <20181211165541.42908-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Address community comment.
Remove the unreachable code leads to the static checker warning.
PHY functionality will be added later per demand.
Reported by Dan Carpenter.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_phy.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 38e43e6fc1c7..4c8f96a9a148 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -152,7 +152,6 @@ void igc_power_down_phy_copper(struct igc_hw *hw)
 s32 igc_check_downshift(struct igc_hw *hw)
 {
 	struct igc_phy_info *phy = &hw->phy;
-	u16 phy_data, offset, mask;
 	s32 ret_val;
 
 	switch (phy->type) {
@@ -161,15 +160,8 @@ s32 igc_check_downshift(struct igc_hw *hw)
 		/* speed downshift not supported */
 		phy->speed_downgraded = false;
 		ret_val = 0;
-		goto out;
 	}
 
-	ret_val = phy->ops.read_reg(hw, offset, &phy_data);
-
-	if (!ret_val)
-		phy->speed_downgraded = (phy_data & mask) ? true : false;
-
-out:
 	return ret_val;
 }
 
-- 
2.11.0

