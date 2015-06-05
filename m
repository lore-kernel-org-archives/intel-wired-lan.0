From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Fri, 05 Jun 2015 18:56:14 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: fix X550 PHY function
	pointers
Message-ID: <20150605225614.16409.32750.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A subset of the X550 function pointers didn't have default methods. This
didn't cause any issue with previous X550 devices as they were all
redefined.  However future devices will need these default values.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index d271076..af884f6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1807,6 +1807,9 @@ static struct ixgbe_eeprom_operations eeprom_ops_X550EM_x = {
 	.read_i2c_sff8472	= &ixgbe_read_i2c_sff8472_generic, \
 	.read_i2c_eeprom	= &ixgbe_read_i2c_eeprom_generic, \
 	.write_i2c_eeprom	= &ixgbe_write_i2c_eeprom_generic, \
+	.read_reg		= &ixgbe_read_phy_reg_generic, \
+	.write_reg		= &ixgbe_write_phy_reg_generic, \
+	.setup_link		= &ixgbe_setup_phy_link_generic, \
 	.check_overtemp		= &ixgbe_tn_check_overtemp, \
 	.get_firmware_version	= &ixgbe_get_phy_firmware_version_generic,
 
@@ -1814,9 +1817,6 @@ static struct ixgbe_phy_operations phy_ops_X550 = {
 	X550_COMMON_PHY
 	.init			= NULL,
 	.identify		= &ixgbe_identify_phy_generic,
-	.read_reg		= &ixgbe_read_phy_reg_generic,
-	.write_reg		= &ixgbe_write_phy_reg_generic,
-	.setup_link		= &ixgbe_setup_phy_link_generic,
 	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
 	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
 	.set_phy_power		= &ixgbe_set_copper_phy_power,
@@ -1826,9 +1826,6 @@ static struct ixgbe_phy_operations phy_ops_X550EM_x = {
 	X550_COMMON_PHY
 	.init			= &ixgbe_init_phy_ops_X550em,
 	.identify		= &ixgbe_identify_phy_x550em,
-	.read_reg		= NULL, /* defined later */
-	.write_reg		= NULL, /* defined later */
-	.setup_link		= NULL, /* defined later */
 };
 
 static const u32 ixgbe_mvals_X550[IXGBE_MVALS_IDX_LIMIT] = {

