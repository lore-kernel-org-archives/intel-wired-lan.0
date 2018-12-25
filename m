From: Kangjie Lu <kjlu@umn.edu>
Date: Tue, 25 Dec 2018 01:36:19 -0600
Subject: [Intel-wired-lan] [PATCH] ethernet: (80003es2lan) fix missing
 checks for return value of reg write
Message-ID: <20181225073620.67962-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000_write_kmrn_reg_80003es2lan() may fail. The fix checks its return
value and returns with its error code if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59bc9c6..7e2d4b9839bb 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -699,8 +699,11 @@ static s32 e1000_reset_hw_80003es2lan(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	ret_val =
+		e1000_write_kmrn_reg_80003es2lan(hw,
+				E1000_KMRNCTRLSTA_INBAND_PARAM, kum_reg_data);
+	if (ret_val)
+		return ret_val;
 
 	ret_val = e1000e_get_auto_rd_done(hw);
 	if (ret_val)
@@ -757,8 +760,11 @@ static s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 	e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					&kum_reg_data);
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	ret_val =
+		e1000_write_kmrn_reg_80003es2lan(hw,
+				E1000_KMRNCTRLSTA_INBAND_PARAM, kum_reg_data);
+	if (ret_val)
+		return ret_val;
 
 	/* Set the transmit descriptor write-back policy */
 	reg_data = er32(TXDCTL(0));
-- 
2.17.2 (Apple Git-113)

