From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 00:50:38 -0400
Subject: [Intel-wired-lan] [net-next PATCH 2 01/13] ixgbe: add support for
 WoL and autoneg FC for some X550 devices
Message-ID: <20150605045038.26373.94842.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These Device ID could support both WoL and autoneg flow control. In
the case of WoL this is indicated by the eeprom.  This patch enables
these devices this support.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 13a6fe05..21e5ae3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -96,6 +96,8 @@ bool ixgbe_device_supports_autoneg_fc(struct ixgbe_hw *hw)
 		case IXGBE_DEV_ID_82599_T3_LOM:
 		case IXGBE_DEV_ID_X540T:
 		case IXGBE_DEV_ID_X540T1:
+		case IXGBE_DEV_ID_X550T:
+		case IXGBE_DEV_ID_X550EM_X_10G_T:
 			supported = true;
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2dc3f2e..43cb17f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8317,6 +8317,10 @@ int ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 		break;
 	case IXGBE_DEV_ID_X540T:
 	case IXGBE_DEV_ID_X540T1:
+	case IXGBE_DEV_ID_X550T:
+	case IXGBE_DEV_ID_X550EM_X_KX4:
+	case IXGBE_DEV_ID_X550EM_X_KR:
+	case IXGBE_DEV_ID_X550EM_X_10G_T:
 		/* check eeprom to see if enabled wol */
 		if ((wol_cap == IXGBE_DEVICE_CAPS_WOL_PORT0_1) ||
 		    ((wol_cap == IXGBE_DEVICE_CAPS_WOL_PORT0) &&

