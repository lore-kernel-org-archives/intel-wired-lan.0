From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Thu,  2 Feb 2017 14:38:46 -0500
Subject: [Intel-wired-lan] [PATCH] ixgbe: Remove unused define
Message-ID: <1486064326-43511-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove the Marvell 1145 PHY define as we have never had a device that
supports it and have no plan to in the future.  The existence of this
define has caused confusing on whether or not this PHY was supported
by ixgbe.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index f5fdd9b..2f06e4d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1388,9 +1388,6 @@ struct ixgbe_thermal_sensor_data {
 #define ATH_PHY_ID       0x03429050
 #define AQ_FW_REV        0x20
 
-/* PHY Types */
-#define IXGBE_M88E1145_E_PHY_ID  0x01410CD0
-
 /* Special PHY Init Routine */
 #define IXGBE_PHY_INIT_OFFSET_NL 0x002B
 #define IXGBE_PHY_INIT_END_NL    0xFFFF
-- 
2.4.3

