From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 13 Apr 2022 08:33:17 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused phy_type enum
Message-ID: <20220413053317.3297670-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Complete to commit 8e153faf5827 ("igc: Remove unused phy type")
i225 parts have only one phy. There is no point to use phy_type enum.
Clean up the code accordingly, and get rid of the unused enum lines.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c |  2 --
 drivers/net/ethernet/intel/igc/igc_hw.h   |  7 -------
 drivers/net/ethernet/intel/igc/igc_phy.c  | 10 +++-------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index f068b66b8025..a15927e77272 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -182,8 +182,6 @@ static s32 igc_init_phy_params_base(struct igc_hw *hw)
 
 	igc_check_for_copper_link(hw);
 
-	phy->type = igc_phy_i225;
-
 out:
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
index b1e72ec5f131..360644f33d5f 100644
--- a/drivers/net/ethernet/intel/igc/igc_hw.h
+++ b/drivers/net/ethernet/intel/igc/igc_hw.h
@@ -53,11 +53,6 @@ enum igc_mac_type {
 	igc_num_macs  /* List is 1-based, so subtract 1 for true count. */
 };
 
-enum igc_phy_type {
-	igc_phy_unknown = 0,
-	igc_phy_i225,
-};
-
 enum igc_media_type {
 	igc_media_type_unknown = 0,
 	igc_media_type_copper = 1,
@@ -138,8 +133,6 @@ struct igc_nvm_info {
 struct igc_phy_info {
 	struct igc_phy_operations ops;
 
-	enum igc_phy_type type;
-
 	u32 addr;
 	u32 id;
 	u32 reset_delay_us; /* in usec */
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 6961f65d36b9..4f06e6bb68b1 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -150,13 +150,9 @@ s32 igc_check_downshift(struct igc_hw *hw)
 	struct igc_phy_info *phy = &hw->phy;
 	s32 ret_val;
 
-	switch (phy->type) {
-	case igc_phy_i225:
-	default:
-		/* speed downshift not supported */
-		phy->speed_downgraded = false;
-		ret_val = 0;
-	}
+	/* speed downshift not supported */
+	phy->speed_downgraded = false;
+	ret_val = 0;
 
 	return ret_val;
 }
-- 
2.30.2

