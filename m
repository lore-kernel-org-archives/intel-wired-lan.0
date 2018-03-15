From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 15 Mar 2018 08:22:07 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix read-modify-write in x550 phy
 setup
Message-ID: <1521116527-49781-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replaced an assignment operation with an OR operation.

The variable assignment was overwriting the value read from the PHY
register. The OR operation sets only the intended register bits.

The bits that were being overwritten are reserved, so the assignment had no
functional impact.

Reported by: Shannon Nelson <shannon.nelson@oracle.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index f470d02..3123267 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1847,9 +1847,9 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 			 (IXGBE_CS4227_EDC_MODE_SR << 1));
 
 	if (setup_linear)
-		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
+		reg_phy_ext |= (IXGBE_CS4227_EDC_MODE_CX1 << 1) | 1;
 	else
-		reg_phy_ext = (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
+		reg_phy_ext |= (IXGBE_CS4227_EDC_MODE_SR << 1) | 1;
 
 	ret_val = hw->phy.ops.write_reg(hw, reg_slice,
 					IXGBE_MDIO_ZERO_DEV_TYPE, reg_phy_ext);
-- 
2.7.5

