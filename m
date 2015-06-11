From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 11 Jun 2015 11:02:20 -0700
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Check whether FDIRCMD writes
	actually complete
Message-ID: <20150611180220.98698.69987.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wait up to about 100 us for FDIRCMD writes to complete and return
failure indications.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Remove unnecesary wait in ixgbe_fdir_add_signature_filter_82599
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |   63 +++++++++++++++---------
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |    1 
 2 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index b1e364d26aa7..31ba211c8ed3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2015 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -1246,6 +1246,25 @@ mac_reset_top:
 }
 
 /**
+ * ixgbe_fdir_check_cmd_complete - poll to check whether FDIRCMD is complete
+ * @hw: pointer to hardware structure
+ * @fdircmd: current value of FDIRCMD register
+ */
+static s32 ixgbe_fdir_check_cmd_complete(struct ixgbe_hw *hw, u32 *fdircmd)
+{
+	int i;
+
+	for (i = 0; i < IXGBE_FDIRCMD_CMD_POLL; i++) {
+		*fdircmd = IXGBE_READ_REG(hw, IXGBE_FDIRCMD);
+		if (!(*fdircmd & IXGBE_FDIRCMD_CMD_MASK))
+			return 0;
+		udelay(10);
+	}
+
+	return IXGBE_ERR_FDIR_CMD_INCOMPLETE;
+}
+
+/**
  *  ixgbe_reinit_fdir_tables_82599 - Reinitialize Flow Director tables.
  *  @hw: pointer to hardware structure
  **/
@@ -1253,6 +1272,8 @@ s32 ixgbe_reinit_fdir_tables_82599(struct ixgbe_hw *hw)
 {
 	int i;
 	u32 fdirctrl = IXGBE_READ_REG(hw, IXGBE_FDIRCTRL);
+	u32 fdircmd;
+	s32 err;
 
 	fdirctrl &= ~IXGBE_FDIRCTRL_INIT_DONE;
 
@@ -1260,15 +1281,10 @@ s32 ixgbe_reinit_fdir_tables_82599(struct ixgbe_hw *hw)
 	 * Before starting reinitialization process,
 	 * FDIRCMD.CMD must be zero.
 	 */
-	for (i = 0; i < IXGBE_FDIRCMD_CMD_POLL; i++) {
-		if (!(IXGBE_READ_REG(hw, IXGBE_FDIRCMD) &
-		      IXGBE_FDIRCMD_CMD_MASK))
-			break;
-		udelay(10);
-	}
-	if (i >= IXGBE_FDIRCMD_CMD_POLL) {
-		hw_dbg(hw, "Flow Director previous command isn't complete, aborting table re-initialization.\n");
-		return IXGBE_ERR_FDIR_REINIT_FAILED;
+	err = ixgbe_fdir_check_cmd_complete(hw, &fdircmd);
+	if (err) {
+		hw_dbg(hw, "Flow Director previous command did not complete, aborting table re-initialization.\n");
+		return err;
 	}
 
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRFREE, 0);
@@ -1758,6 +1774,7 @@ s32 ixgbe_fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 					  u16 soft_id, u8 queue)
 {
 	u32 fdirport, fdirvlan, fdirhash, fdircmd;
+	s32 err;
 
 	/* currently IPv6 is not supported, must be programmed with 0 */
 	IXGBE_WRITE_REG_BE32(hw, IXGBE_FDIRSIPv6(0),
@@ -1806,6 +1823,11 @@ s32 ixgbe_fdir_write_perfect_filter_82599(struct ixgbe_hw *hw,
 	fdircmd |= (u32)input->formatted.vm_pool << IXGBE_FDIRCMD_VT_POOL_SHIFT;
 
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRCMD, fdircmd);
+	err = ixgbe_fdir_check_cmd_complete(hw, &fdircmd);
+	if (err) {
+		hw_dbg(hw, "Flow Director command did not complete!\n");
+		return err;
+	}
 
 	return 0;
 }
@@ -1815,9 +1837,8 @@ s32 ixgbe_fdir_erase_perfect_filter_82599(struct ixgbe_hw *hw,
 					  u16 soft_id)
 {
 	u32 fdirhash;
-	u32 fdircmd = 0;
-	u32 retry_count;
-	s32 err = 0;
+	u32 fdircmd;
+	s32 err;
 
 	/* configure FDIRHASH register */
 	fdirhash = input->formatted.bkt_hash;
@@ -1830,18 +1851,12 @@ s32 ixgbe_fdir_erase_perfect_filter_82599(struct ixgbe_hw *hw,
 	/* Query if filter is present */
 	IXGBE_WRITE_REG(hw, IXGBE_FDIRCMD, IXGBE_FDIRCMD_CMD_QUERY_REM_FILT);
 
-	for (retry_count = 10; retry_count; retry_count--) {
-		/* allow 10us for query to process */
-		udelay(10);
-		/* verify query completed successfully */
-		fdircmd = IXGBE_READ_REG(hw, IXGBE_FDIRCMD);
-		if (!(fdircmd & IXGBE_FDIRCMD_CMD_MASK))
-			break;
+	err = ixgbe_fdir_check_cmd_complete(hw, &fdircmd);
+	if (err) {
+		hw_dbg(hw, "Flow Director command did not complete!\n");
+		return err;
 	}
 
-	if (!retry_count)
-		err = IXGBE_ERR_FDIR_REINIT_FAILED;
-
 	/* if filter exists in hardware then remove it */
 	if (fdircmd & IXGBE_FDIRCMD_FILTER_VALID) {
 		IXGBE_WRITE_REG(hw, IXGBE_FDIRHASH, fdirhash);
@@ -1850,7 +1865,7 @@ s32 ixgbe_fdir_erase_perfect_filter_82599(struct ixgbe_hw *hw,
 				IXGBE_FDIRCMD_CMD_REMOVE_FLOW);
 	}
 
-	return err;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index b6f424f3b1a8..b16d26b8f505 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3460,6 +3460,7 @@ struct ixgbe_info {
 #define IXGBE_ERR_PBA_SECTION                   -31
 #define IXGBE_ERR_INVALID_ARGUMENT              -32
 #define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
+#define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
 #define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
 
 #define IXGBE_KRM_PORT_CAR_GEN_CTRL(P)	((P == 0) ? (0x4010) : (0x8010))

