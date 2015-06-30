From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Tue, 30 Jun 2015 15:16:55 -0700
Subject: [Intel-wired-lan] [PATCH] igb: use ARRAY_SIZE to replace
 calculating sizeof(a)/sizeof(a[0])
Message-ID: <20150630221655.24543.21613.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the ARRAY_SIZE macro rather than calculating sizeof(a)/sizeof(a[0]).
Also directly replace the code rather than using an unnecessary define.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
Reported-by: Maninder Singh <maninder1.s@samsung.com>
Reported-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/intel/igb/e1000_phy.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
index c1bb64d..987c9de 100644
--- a/drivers/net/ethernet/intel/igb/e1000_phy.c
+++ b/drivers/net/ethernet/intel/igb/e1000_phy.c
@@ -1,5 +1,5 @@
 /* Intel(R) Gigabit Ethernet Linux driver
- * Copyright(c) 2007-2014 Intel Corporation.
+ * Copyright(c) 2007-2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -36,9 +36,6 @@ static s32  igb_set_master_slave_mode(struct e1000_hw *hw);
 /* Cable length tables */
 static const u16 e1000_m88_cable_length_table[] = {
 	0, 50, 80, 110, 140, 140, E1000_CABLE_LENGTH_UNDEFINED };
-#define M88E1000_CABLE_LENGTH_TABLE_SIZE \
-	(sizeof(e1000_m88_cable_length_table) / \
-	sizeof(e1000_m88_cable_length_table[0]))
 
 static const u16 e1000_igp_2_cable_length_table[] = {
 	0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11, 13, 16, 18, 21,
@@ -49,9 +46,6 @@ static const u16 e1000_igp_2_cable_length_table[] = {
 	60, 66, 72, 77, 82, 87, 92, 96, 100, 104, 108, 111, 114, 117, 119, 121,
 	83, 89, 95, 100, 105, 109, 113, 116, 119, 122, 124,
 	104, 109, 114, 118, 121, 124};
-#define IGP02E1000_CABLE_LENGTH_TABLE_SIZE \
-	(sizeof(e1000_igp_2_cable_length_table) / \
-	 sizeof(e1000_igp_2_cable_length_table[0]))
 
 /**
  *  igb_check_reset_block - Check if PHY reset is blocked
@@ -1700,7 +1694,7 @@ s32 igb_get_cable_length_m88(struct e1000_hw *hw)
 
 	index = (phy_data & M88E1000_PSSR_CABLE_LENGTH) >>
 		M88E1000_PSSR_CABLE_LENGTH_SHIFT;
-	if (index >= M88E1000_CABLE_LENGTH_TABLE_SIZE - 1) {
+	if (index >= ARRAY_SIZE(e1000_m88_cable_length_table) - 1) {
 		ret_val = -E1000_ERR_PHY;
 		goto out;
 	}
@@ -1796,7 +1790,7 @@ s32 igb_get_cable_length_m88_gen2(struct e1000_hw *hw)
 
 		index = (phy_data & M88E1000_PSSR_CABLE_LENGTH) >>
 			M88E1000_PSSR_CABLE_LENGTH_SHIFT;
-		if (index >= M88E1000_CABLE_LENGTH_TABLE_SIZE - 1) {
+		if (index >= ARRAY_SIZE(e1000_m88_cable_length_table) - 1) {
 			ret_val = -E1000_ERR_PHY;
 			goto out;
 		}
@@ -1840,7 +1834,7 @@ s32 igb_get_cable_length_igp_2(struct e1000_hw *hw)
 	s32 ret_val = 0;
 	u16 phy_data, i, agc_value = 0;
 	u16 cur_agc_index, max_agc_index = 0;
-	u16 min_agc_index = IGP02E1000_CABLE_LENGTH_TABLE_SIZE - 1;
+	u16 min_agc_index = ARRAY_SIZE(e1000_igp_2_cable_length_table) - 1;
 	static const u16 agc_reg_array[IGP02E1000_PHY_CHANNEL_NUM] = {
 		IGP02E1000_PHY_AGC_A,
 		IGP02E1000_PHY_AGC_B,
@@ -1863,7 +1857,7 @@ s32 igb_get_cable_length_igp_2(struct e1000_hw *hw)
 				IGP02E1000_AGC_LENGTH_MASK;
 
 		/* Array index bound check. */
-		if ((cur_agc_index >= IGP02E1000_CABLE_LENGTH_TABLE_SIZE) ||
+		if ((cur_agc_index >= ARRAY_SIZE(e1000_igp_2_cable_length_table)) ||
 		    (cur_agc_index == 0)) {
 			ret_val = -E1000_ERR_PHY;
 			goto out;

