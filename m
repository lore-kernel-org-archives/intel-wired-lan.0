From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Wed, 10 Jun 2015 01:15:57 +0300
Subject: [Intel-wired-lan] [PATCH 3/5] e1000e: i219 - increase IPG for speed
	10/100 full duplex
In-Reply-To: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
References: <f60bcfb3d2cf6db3c53fe84b1620dad209976300.1433877893.git.yanirx.lubetkin@intel.com>
Message-ID: <827ef89b421f872487196fb255d81e4f6d4976bc.1433877893.git.yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In SPT/Jacksonville, there were CRC errors in speed 10/100 full duplex.
The solution  given by the HW team is to increase the IPG from 8 to 0xC

Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index bdb745d..af4431d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1401,16 +1401,20 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	if (((hw->mac.type == e1000_pch2lan) ||
 	     (hw->mac.type == e1000_pch_lpt) ||
 	     (hw->mac.type == e1000_pch_spt)) && link) {
-		u32 reg;
+		u16 speed, duplex;
 
-		reg = er32(STATUS);
+		e1000e_get_speed_and_duplex_copper(hw, &speed, &duplex);
 		tipg_reg = er32(TIPG);
 		tipg_reg &= ~E1000_TIPG_IPGT_MASK;
 
-		if (!(reg & (E1000_STATUS_FD | E1000_STATUS_SPEED_MASK))) {
+		if (duplex == HALF_DUPLEX && speed == SPEED_10) {
 			tipg_reg |= 0xFF;
 			/* Reduce Rx latency in analog PHY */
 			emi_val = 0;
+		} else if (hw->mac.type == e1000_pch_spt &&
+			   duplex == FULL_DUPLEX && speed != SPEED_1000) {
+			tipg_reg |= 0xC;
+			emi_val = 1;
 		} else {
 
 			/* Roll back the default values */
-- 
2.1.0

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

