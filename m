From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:35:59 -0700
Subject: [Intel-wired-lan] [next PATCH S52 02/11] i40e: Remove unreachable
	code
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

The code at the end of i40e_read_phy_register_clause22() contained
unreachable code and redundant control statements.

This change removes the unreachable code. And deletes the redundant
goto statement and if statement.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: I713032b1585396f40f903cbcfdea987abd874400
---
Testing Hints:
    Found by static analysis. Test by code inspection.

 drivers/net/ethernet/intel/i40e/i40e_common.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 4672bf1..b0358c0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -4439,19 +4439,12 @@ i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw, u16 reg,
 	if (status) {
 		i40e_debug(hw, I40E_DEBUG_PHY,
 			   "PHY: Can't write command to external PHY.\n");
-		goto phy_read_end;
-	}
-
-	if (!status) {
+	} else {
 		command = rd32(hw, I40E_GLGEN_MSRWD(port_num));
 		*value = (command & I40E_GLGEN_MSRWD_MDIRDDATA_MASK) >>
 			 I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT;
-	} else {
-		i40e_debug(hw, I40E_DEBUG_PHY,
-			   "PHY: Can't read register value from external PHY.\n");
 	}
 
-phy_read_end:
 	return status;
 }
 
-- 
2.4.11

