From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 24 Mar 2016 16:22:55 -0700
Subject: [Intel-wired-lan] [PATCH 04/11] ixgbe: Request token for PHY
	accesses
In-Reply-To: <20160324231833.108409.65944.stgit@mdrustad-wks.jf.intel.com>
References: <20160324231833.108409.65944.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160324232255.108409.94964.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Set the bit to request the PHY token for PHY accesses.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c |   34 +++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index db0731e05401..9092b9612271 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2016 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -570,24 +570,24 @@ s32 ixgbe_read_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr, u32 device_type,
 
 /**
  *  ixgbe_read_phy_reg_generic - Reads a value from a specified PHY register
- *  using the SWFW lock - this function is needed in most cases
  *  @hw: pointer to hardware structure
  *  @reg_addr: 32 bit address of PHY register to read
  *  @phy_data: Pointer to read data from PHY register
+ *
+ *  This function uses the SWFW lock which must be held for all accesses
  **/
 s32 ixgbe_read_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 			       u32 device_type, u16 *phy_data)
 {
+	u32 gssr = hw->phy.phy_semaphore_mask | IXGBE_GSSR_TOKEN_SM;
 	s32 status;
-	u32 gssr = hw->phy.phy_semaphore_mask;
 
-	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) == 0) {
-		status = ixgbe_read_phy_reg_mdi(hw, reg_addr, device_type,
-						phy_data);
-		hw->mac.ops.release_swfw_sync(hw, gssr);
-	} else {
+	if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
 		return IXGBE_ERR_SWFW_SYNC;
-	}
+
+	status = hw->phy.ops.read_reg_mdi(hw, reg_addr, device_type, phy_data);
+
+	hw->mac.ops.release_swfw_sync(hw, gssr);
 
 	return status;
 }
@@ -667,25 +667,25 @@ s32 ixgbe_write_phy_reg_mdi(struct ixgbe_hw *hw, u32 reg_addr,
 
 /**
  *  ixgbe_write_phy_reg_generic - Writes a value to specified PHY register
- *  using SWFW lock- this function is needed in most cases
  *  @hw: pointer to hardware structure
  *  @reg_addr: 32 bit PHY register to write
  *  @device_type: 5 bit device type
  *  @phy_data: Data to write to the PHY register
+ *
+ *  This function uses the SWFW lock which must be held for all accesses
  **/
 s32 ixgbe_write_phy_reg_generic(struct ixgbe_hw *hw, u32 reg_addr,
 				u32 device_type, u16 phy_data)
 {
+	u32 gssr = hw->phy.phy_semaphore_mask | IXGBE_GSSR_TOKEN_SM;
 	s32 status;
-	u32 gssr = hw->phy.phy_semaphore_mask;
 
-	if (hw->mac.ops.acquire_swfw_sync(hw, gssr) == 0) {
-		status = ixgbe_write_phy_reg_mdi(hw, reg_addr, device_type,
-						 phy_data);
-		hw->mac.ops.release_swfw_sync(hw, gssr);
-	} else {
+	if (hw->mac.ops.acquire_swfw_sync(hw, gssr))
 		return IXGBE_ERR_SWFW_SYNC;
-	}
+
+	status = hw->phy.ops.write_reg_mdi(hw, reg_addr, device_type, phy_data);
+
+	hw->mac.ops.release_swfw_sync(hw, gssr);
 
 	return status;
 }

