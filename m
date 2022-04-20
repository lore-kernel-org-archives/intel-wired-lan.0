From: Jeff Daly <jeffd@silicom-usa.com>
Date: Wed, 20 Apr 2022 16:51:30 -0400
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: correct SDP0 check of SFP cage
 for X550
Message-ID: <20220420205130.23616-1-jeffd@silicom-usa.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 4c26c4b92f07..26d16bc85c59 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -3308,8 +3308,8 @@ s32 ixgbe_check_mac_link_generic(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 			break;
 		case ixgbe_mac_X550EM_x:
 		case ixgbe_mac_x550em_a:
-			sfp_cage_full = IXGBE_READ_REG(hw, IXGBE_ESDP) &
-					IXGBE_ESDP_SDP0;
+			sfp_cage_full = !(IXGBE_READ_REG(hw, IXGBE_ESDP) &
+					IXGBE_ESDP_SDP0);
 			break;
 		default:
 			/* sanity check - No SFP+ devices here */
-- 
2.25.1

