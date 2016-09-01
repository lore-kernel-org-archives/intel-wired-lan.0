From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 01 Sep 2016 13:58:51 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use MDIO_PRTAD_NONE consistently
Message-ID: <147276353170.65625.9520381365094159590.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The value MDIO_PRTAD_NONE should be used to indicate no PHY address.
Not 0, not 0xFFFF. Use the MDIO_PRTAD_NONE value consistently.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index db0731e05401..021ab9b89c71 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -346,8 +346,8 @@ s32 ixgbe_identify_phy_generic(struct ixgbe_hw *hw)
 				return 0;
 			}
 		}
-		/* clear value if nothing found */
-		hw->phy.mdio.prtad = 0;
+		/* indicate no PHY found */
+		hw->phy.mdio.prtad = MDIO_PRTAD_NONE;
 		return IXGBE_ERR_PHY_ADDR_INVALID;
 	}
 	return 0;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index cd22efb940ad..7e6b9267ca9d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1459,7 +1459,7 @@ ixgbe_setup_mac_link_sfp_x550a(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 	/* Configure internal PHY for KR/KX. */
 	ixgbe_setup_kr_speed_x550em(hw, speed);
 
-	if (!hw->phy.mdio.prtad || hw->phy.mdio.prtad == 0xFFFF)
+	if (hw->phy.mdio.prtad == MDIO_PRTAD_NONE)
 		return IXGBE_ERR_PHY_ADDR_INVALID;
 
 	/* Get external PHY device id */

