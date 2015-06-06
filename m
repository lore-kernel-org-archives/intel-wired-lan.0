From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Sat, 06 Jun 2015 13:53:47 -0400
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: fix X550 default
	set_phy_power method
Message-ID: <20150606175347.31199.32645.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Even though X550 may later clear this value for certain devices
set it initially to support copper.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 7b5b48e..dc9cdb6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
  *
  *  Intel 10 Gigabit PCI Express Linux driver
- *  Copyright(c) 1999 - 2014 Intel Corporation.
+ *  Copyright(c) 1999 - 2015 Intel Corporation.
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms and conditions of the GNU General Public License,
@@ -1855,6 +1855,7 @@ static struct ixgbe_eeprom_operations eeprom_ops_X550EM_x = {
 	.read_reg		= &ixgbe_read_phy_reg_generic, \
 	.write_reg		= &ixgbe_write_phy_reg_generic, \
 	.setup_link		= &ixgbe_setup_phy_link_generic, \
+	.set_phy_power		= &ixgbe_set_copper_phy_power, \
 	.check_overtemp		= &ixgbe_tn_check_overtemp, \
 	.get_firmware_version	= &ixgbe_get_phy_firmware_version_generic,
 
@@ -1864,7 +1865,6 @@ static struct ixgbe_phy_operations phy_ops_X550 = {
 	.identify		= &ixgbe_identify_phy_generic,
 	.read_i2c_combined	= &ixgbe_read_i2c_combined_generic,
 	.write_i2c_combined	= &ixgbe_write_i2c_combined_generic,
-	.set_phy_power		= &ixgbe_set_copper_phy_power,
 };
 
 static struct ixgbe_phy_operations phy_ops_X550EM_x = {

