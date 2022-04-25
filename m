From: Jeff Daly <jeffd@silicom-usa.com>
Date: Mon, 25 Apr 2022 09:17:57 -0400
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: correct SDP0 check of SFP
 cage for X550
In-Reply-To: <20220420205130.23616-1-jeffd@silicom-usa.com>
References: <20220420205130.23616-1-jeffd@silicom-usa.com>
Message-ID: <20220425131758.4749-1-jeffd@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

SDP0 for X550 NICs is active low to indicate the presence of an SFP in the
cage (MOD_ABS#).  Invert the results of the logical AND to set
sfp_cage_full variable correctly.

Fixes: aac9e053f104 ("ixgbe: cleanup crosstalk fix")
Suggested-by: Stephen Douthit <stephend@silicom-usa.com>
Signed-off-by: Jeff Daly <jeffd@silicom-usa.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4c26c4b92f07..13482d4e24e2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3299,17 +3299,17 @@ s32 ixgbe_check_mac_link_generic(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 	 * the SFP+ cage is full.
 	 */
 	if (ixgbe_need_crosstalk_fix(hw)) {
-		u32 sfp_cage_full;
+		bool sfp_cage_full;
 
 		switch (hw->mac.type) {
 		case ixgbe_mac_82599EB:
-			sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
-					IXGBE_ESDP_SDP2;
+			sfp_cage_full = !!(IXGBE_READ_REG(hw, IXGBE_ESDP) &
+					   IXGBE_ESDP_SDP2);
 			break;
 		case ixgbe_mac_X550EM_x:
 		case ixgbe_mac_x550em_a:
-			sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
-					IXGBE_ESDP_SDP0;
+			sfp_cage_full = !(IXGBE_READ_REG(hw, IXGBE_ESDP) &
+					  IXGBE_ESDP_SDP0);
 			break;
 		default:
 			/* sanity check - No SFP+ devices here */
-- 
2.25.1

