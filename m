From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Fri,  4 Nov 2016 16:46:16 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct X550 phy ID
Message-ID: <1478292376-38601-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were using an old Alpha version of the X550 phy ID.  This was leading
to unnecessary queries of the PHY.  I removed the old ID (which shouldn't
be on any HW) and add the two that are.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index b1a26cd..4aa6793 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -389,7 +389,8 @@ static enum ixgbe_phy_type ixgbe_get_phy_type_from_id(u32 phy_id)
 	case TN1010_PHY_ID:
 		phy_type = ixgbe_phy_tn;
 		break;
-	case X550_PHY_ID:
+	case X550_PHY_ID2:
+	case X550_PHY_ID3:
 	case X540_PHY_ID:
 		phy_type = ixgbe_phy_aq;
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 9ad110d..c81116b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1377,7 +1377,8 @@ struct ixgbe_thermal_sensor_data {
 #define TN1010_PHY_ID    0x00A19410
 #define TNX_FW_REV       0xB
 #define X540_PHY_ID      0x01540200
-#define X550_PHY_ID      0x01540220
+#define X550_PHY_ID2     0x01540223
+#define X550_PHY_ID3     0x01540221
 #define X557_PHY_ID      0x01540240
 #define X557_PHY_ID2	0x01540250
 #define QT2022_PHY_ID    0x0043A400
-- 
2.4.3

