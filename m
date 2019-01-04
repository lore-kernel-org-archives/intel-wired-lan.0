From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu,  3 Jan 2019 17:17:03 -0800
Subject: [Intel-wired-lan] [PATCH v2] e1000e: fix a missing check for return
 value
Message-ID: <20190104011703.11365-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The change is based on the issue found by Kangjie Lu <kjlu@umn.edu> where
we not checking the return value of a register read/write which could result
in a NULL pointer dereference if the read/write fails.

Since we are only trying to disable the far-end loopback, if the read
and write of register fails, we do not want to bail out of the function.
We just want to log that it failed to disable and continue on.

CC: Sasha Neftin <sasha.neftin@intel.com>
CC: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
v2: fixed a compilation error due to me fat fingering missing braces.

 .../net/ethernet/intel/e1000e/80003es2lan.c   | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59bc9c6..f86d55657959 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -696,11 +696,16 @@ static s32 e1000_reset_hw_80003es2lan(struct e1000_hw *hw)
 	ret_val =
 	    e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					    &kum_reg_data);
-	if (ret_val)
-		return ret_val;
-	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	if (!ret_val) {
+		kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
+		ret_val = e1000_write_kmrn_reg_80003es2lan(hw,
+						 E1000_KMRNCTRLSTA_INBAND_PARAM,
+						 kum_reg_data);
+		if (ret_val)
+			e_dbg("Error disabling far-end loopback\n");
+	} else {
+		e_dbg("Error disabling far-end loopback\n");
+	}
 
 	ret_val = e1000e_get_auto_rd_done(hw);
 	if (ret_val)
@@ -754,11 +759,19 @@ static s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 		return ret_val;
 
 	/* Disable IBIST slave mode (far-end loopback) */
-	e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					&kum_reg_data);
-	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
-	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					 kum_reg_data);
+	ret_val =
+	    e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
+					    &kum_reg_data);
+	if (!ret_val) {
+		kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
+		ret_val = e1000_write_kmrn_reg_80003es2lan(hw,
+						 E1000_KMRNCTRLSTA_INBAND_PARAM,
+						 kum_reg_data);
+		if (ret_val)
+			e_dbg("Error disabling far-end loopback\n");
+	} else {
+		e_dbg("Error disabling far-end loopback\n");
+	}
 
 	/* Set the transmit descriptor write-back policy */
 	reg_data = er32(TXDCTL(0));
-- 
2.20.1

