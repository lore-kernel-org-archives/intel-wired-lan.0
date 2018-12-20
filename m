From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 20 Dec 2018 15:23:59 -0600
Subject: [Intel-wired-lan] [PATCH] net: 80003es2lan: fix a missing check of
 read failure
Message-ID: <20181220212359.564-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When e1000_read_kmrn_reg_80003es2lan() fails, "kum_reg_data" is
uninitialized and may contain random value. However, it is further
used in the following execution, which will lead to undefined
behaviors.
The fix checks the failure of e1000_read_kmrn_reg_80003es2lan() and
returns with its error code if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/intel/e1000e/80003es2lan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/80003es2lan.c b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
index 257bd59bc9c6..8a6f8e80e062 100644
--- a/drivers/net/ethernet/intel/e1000e/80003es2lan.c
+++ b/drivers/net/ethernet/intel/e1000e/80003es2lan.c
@@ -754,8 +754,11 @@ static s32 e1000_init_hw_80003es2lan(struct e1000_hw *hw)
 		return ret_val;
 
 	/* Disable IBIST slave mode (far-end loopback) */
-	e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
-					&kum_reg_data);
+	ret_val = 
+	    e1000_read_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
+					    &kum_reg_data);
+	if (ret_val)
+		return ret_val;
 	kum_reg_data |= E1000_KMRNCTRLSTA_IBIST_DISABLE;
 	e1000_write_kmrn_reg_80003es2lan(hw, E1000_KMRNCTRLSTA_INBAND_PARAM,
 					 kum_reg_data);
-- 
2.17.1

