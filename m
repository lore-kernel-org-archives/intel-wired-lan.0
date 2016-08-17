From: Donald C Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 17 Aug 2016 17:34:07 -0400
Subject: [Intel-wired-lan] [PATCH] ixgbe: add device to MDIO speed setting
Message-ID: <1471469647-39487-1-git-send-email-donald.c.skidmore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This shouldn't matter as nothing should be attached still to be
consisted control MDIO speed for these devices as well.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 4716ca4..f16682c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2514,6 +2514,8 @@ static void ixgbe_set_mdio_speed(struct ixgbe_hw *hw)
 
 	switch (hw->device_id) {
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
+	case IXGBE_DEV_ID_X550EM_A_SGMII:
+	case IXGBE_DEV_ID_X550EM_A_SGMII_L:
 	case IXGBE_DEV_ID_X550EM_A_SFP:
 		/* Config MDIO clock speed before the first MDIO PHY access */
 		hlreg0 = IXGBE_READ_REG(hw, IXGBE_HLREG0);
-- 
2.4.3

