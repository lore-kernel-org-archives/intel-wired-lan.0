From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 26 Sep 2016 14:08:18 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: fix link status check for
	copper X550em
In-Reply-To: <20160926210813.30339.95294.stgit@localhost6.localdomain6>
References: <20160926210813.30339.95294.stgit@localhost6.localdomain6>
Message-ID: <20160926210818.30339.75039.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Read the PHY register twice in order to get the correct value for
autoneg_status.


Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index aa32e61..fffefcf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1556,7 +1556,7 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 				     bool link_up_wait_to_complete)
 {
 	u32 status;
-	u16 autoneg_status;
+	u16 i, autoneg_status;
 
 	if (hw->mac.ops.get_media_type(hw) != ixgbe_media_type_copper)
 		return IXGBE_ERR_CONFIG;
@@ -1568,13 +1568,18 @@ static s32 ixgbe_check_link_t_X550em(struct ixgbe_hw *hw,
 	if (status || !(*link_up))
 		return status;
 
-	 /* MAC link is up, so check external PHY link.
-	  * Read this twice back to back to indicate current status.
-	  */
-	status = hw->phy.ops.read_reg(hw, MDIO_STAT1, MDIO_MMD_AN,
-				      &autoneg_status);
-	if (status)
-		return status;
+	/* MAC link is up, so check external PHY link.
+	 * Link status is latching low, and can only be used to detect link
+	 * drop, and not the current status of the link without performing
+	 * back-to-back reads.
+	 */
+	for (i = 0; i < 2; i++) {
+		status = hw->phy.ops.read_reg(hw, MDIO_STAT1, MDIO_MMD_AN,
+					      &autoneg_status);
+
+		if (status)
+			return status;
+	}
 
 	/* If external PHY link is not up, then indicate link not up */
 	if (!(autoneg_status & IXGBE_MDIO_AUTO_NEG_LINK_STATUS))

