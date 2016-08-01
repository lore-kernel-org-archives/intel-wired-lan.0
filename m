From: Denis Turischev <denis.turischev@compulab.co.il>
Date: Mon, 1 Aug 2016 15:28:46 +0300
Subject: [Intel-wired-lan] e1000e: PHY cann't be initialized correctly on
	some I218 controllers
Message-ID: <579F407E.9090602@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is an error "e1000e: probe of 0000:00:19.0 failed with error -3"
that can be observed after power-on on some I218 controllers.
Hardware reset and re-initialization fixes the issue.

Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>

diff -Nru linux-4.7.orig/drivers/net/ethernet/intel/e1000e/ich8lan.c linux-4.7/drivers/net/ethernet/intel/e1000e/ich8lan.c
--- linux-4.7.orig/drivers/net/ethernet/intel/e1000e/ich8lan.c	2016-07-24 22:23:50.000000000 +0300
+++ linux-4.7/drivers/net/ethernet/intel/e1000e/ich8lan.c	2016-08-01 13:59:08.046563095 +0300
@@ -155,6 +155,7 @@
 static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force);
 static s32 e1000_setup_copper_link_pch_lpt(struct e1000_hw *hw);
 static s32 e1000_oem_bits_config_ich8lan(struct e1000_hw *hw, bool d0_state);
+static s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw);
 
 static inline u16 __er16flash(struct e1000_hw *hw, unsigned long reg)
 {
@@ -459,8 +460,12 @@
 	phy->id = e1000_phy_unknown;
 
 	ret_val = e1000_init_phy_workarounds_pchlan(hw);
-	if (ret_val)
-		return ret_val;
+	if (ret_val) {
+		e1000_reset_hw_ich8lan(hw);
+		ret_val = e1000_init_phy_workarounds_pchlan(hw);
+		if (ret_val)
+			return ret_val;
+	}
 
 	if (phy->id == e1000_phy_unknown)
 		switch (hw->mac.type) {
