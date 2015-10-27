From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Tue, 27 Oct 2015 13:23:14 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Correct spec violations by
	waiting after reset
Message-ID: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The ixgbe driver was violating the specification in the datasheel
by not waiting 1ms before checking for the reset bit clearing. This
is called out for devices supported by ixgbe, so implement the
required delay.

Reported-by: Dan Streetman <dan.streetman@canonical.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |    5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |    3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |    3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |    3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
index 65db69b862fb..8f09d291a043 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2015 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -765,13 +765,14 @@ mac_reset_top:
 	ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL) | IXGBE_CTRL_RST;
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear indicating reset is complete */
 	for (i = 0; i < 10; i++) {
-		udelay(1);
 		ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL);
 		if (!(ctrl & IXGBE_CTRL_RST))
 			break;
+		udelay(1);
 	}
 	if (ctrl & IXGBE_CTRL_RST) {
 		status = IXGBE_ERR_RESET_FAILED;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index a39afcf03e2c..b8bd72589f72 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -990,13 +990,14 @@ mac_reset_top:
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear indicating reset is complete */
 	for (i = 0; i < 10; i++) {
-		udelay(1);
 		ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL);
 		if (!(ctrl & IXGBE_CTRL_RST_MASK))
 			break;
+		udelay(1);
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index c1d4584f6469..b9e9b0c17398 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -110,13 +110,14 @@ mac_reset_top:
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear indicating reset is complete */
 	for (i = 0; i < 10; i++) {
-		udelay(1);
 		ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL);
 		if (!(ctrl & IXGBE_CTRL_RST_MASK))
 			break;
+		udelay(1);
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b8ad3f212e72..f4ef0d1a5dbe 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -2146,13 +2146,14 @@ mac_reset_top:
 	ctrl |= IXGBE_READ_REG(hw, IXGBE_CTRL);
 	IXGBE_WRITE_REG(hw, IXGBE_CTRL, ctrl);
 	IXGBE_WRITE_FLUSH(hw);
+	usleep_range(1000, 1200);
 
 	/* Poll for reset bit to self-clear meaning reset is complete */
 	for (i = 0; i < 10; i++) {
-		udelay(1);
 		ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL);
 		if (!(ctrl & IXGBE_CTRL_RST_MASK))
 			break;
+		udelay(1);
 	}
 
 	if (ctrl & IXGBE_CTRL_RST_MASK) {

