From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 26 Aug 2016 14:48:22 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Eliminate useless message and
	improve logic
Message-ID: <147224810290.93893.8237532391891649262.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove a useless log message and improve the logic for setting
a PHY address from the contents of the MNG_IF_SEL register.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 417913e2deb1..dec8b116e6a2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2394,18 +2394,12 @@ static void ixgbe_read_mng_if_sel_x550em(struct ixgbe_hw *hw)
 	/* If X552 (X550EM_a) and MDIO is connected to external PHY, then set
 	 * PHY address. This register field was has only been used for X552.
 	 */
-	if (!hw->phy.nw_mng_if_sel) {
-		if (hw->mac.type == ixgbe_mac_x550em_a) {
-			struct ixgbe_adapter *adapter = hw->back;
-
-			e_warn(drv, "nw_mng_if_sel not set\n");
-		}
-		return;
+	if (hw->mac.type == ixgbe_mac_x550em_a &&
+	    hw->phy.nw_mng_if_sel & IXGBE_NW_MNG_IF_SEL_MDIO_ACT) {
+		hw->phy.mdio.prtad = (hw->phy.nw_mng_if_sel &
+				      IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD) >>
+				     IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT;
 	}
-
-	hw->phy.mdio.prtad = (hw->phy.nw_mng_if_sel &
-			      IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD) >>
-			     IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT;
 }
 
 /** ixgbe_init_phy_ops_X550em - PHY/SFP specific init

