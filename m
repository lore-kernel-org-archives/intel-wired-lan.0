From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 30 Dec 2016 21:13:18 -0500
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: list X553 backplane speeds
	correctly
Message-ID: <1483150398-35222-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We forgot to indicate some of the supported speed on the X553
backplane.  This patch attempts to correct for that.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 22869aa..f5fdd9b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3775,6 +3775,11 @@ struct ixgbe_info {
 
 #define IXGBE_NW_MNG_IF_SEL		0x00011178
 #define IXGBE_NW_MNG_IF_SEL_MDIO_ACT		BIT(1)
+#define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_10M	BIT(17)
+#define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_100M	BIT(18)
+#define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_1G	BIT(19)
+#define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_2_5G	BIT(20)
+#define IXGBE_NW_MNG_IF_SEL_PHY_SPEED_10G	BIT(21)
 #define IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M	BIT(23)
 #define IXGBE_NW_MNG_IF_SEL_INT_PHY_MODE	BIT(24)
 #define IXGBE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT	3
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 70171e7..27340e7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2241,6 +2241,20 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
 		case ixgbe_phy_sgmii:
 			*speed = IXGBE_LINK_SPEED_1GB_FULL;
 			break;
+		case ixgbe_phy_x550em_kr:
+			if (hw->mac.type == ixgbe_mac_x550em_a) {
+				/* check different backplane modes */
+				if (hw->phy.nw_mng_if_sel &
+				    IXGBE_NW_MNG_IF_SEL_PHY_SPEED_2_5G) {
+					*speed = IXGBE_LINK_SPEED_2_5GB_FULL;
+					break;
+				} else if (hw->device_id ==
+					   IXGBE_DEV_ID_X550EM_A_KR_L) {
+					*speed = IXGBE_LINK_SPEED_1GB_FULL;
+					break;
+				}
+			}
+			/* fall through */
 		default:
 			*speed = IXGBE_LINK_SPEED_10GB_FULL |
 				 IXGBE_LINK_SPEED_1GB_FULL;
-- 
2.4.3

