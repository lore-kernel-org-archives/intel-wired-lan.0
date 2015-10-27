From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 27 Oct 2015 13:23:23 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Wait for master disable to be
	set
In-Reply-To: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
References: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20151027202323.87452.79685.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

According to the datasheets, the driver should wait for the master
disable bit to read as being set before checking the status
register for master disable.

Reported-by: Dan Streetman <dan.streetman@canonical.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index ce61b36b94f1..daec6aef5dc8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2015 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -2454,6 +2454,17 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	/* Always set this bit to ensure any future transactions are blocked */
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, IXGBE_CTRL_GIO_DIS);
 
+	/* Poll for bit to read as set */
+	for (i = 0; i < IXGBE_PCI_MASTER_DISABLE_TIMEOUT; i++) {
+		if (IXGBE_READ_REG(hw, IXGBE_CTRL) & IXGBE_CTRL_GIO_DIS)
+			break;
+		usleep_range(100, 120);
+	}
+	if (i >= IXGBE_PCI_MASTER_DISABLE_TIMEOUT) {
+		hw_dbg(hw, "GIO disable did not set - requesting resets\n");
+		goto gio_disable_fail;
+	}
+
 	/* Exit if master requests are blocked */
 	if (!(IXGBE_READ_REG(hw, IXGBE_STATUS) & IXGBE_STATUS_GIO) ||
 	    ixgbe_removed(hw->hw_addr))
@@ -2475,6 +2486,7 @@ static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw)
 	 * again to clear out any effects they may have had on our device.
 	 */
 	hw_dbg(hw, "GIO Master Disable bit didn't clear - requesting resets\n");
+gio_disable_fail:
 	hw->mac.flags |= IXGBE_FLAGS_DOUBLE_RESET_REQUIRED;
 
 	if (hw->mac.type >= ixgbe_mac_X550)

