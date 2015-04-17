From: Todd Fujinaka <todd.fujinaka@intel.com>
Date: Fri, 17 Apr 2015 11:24:38 -0700
Subject: [Intel-wired-lan] [PATCH v2] igb: disable IPv6 extension header
	processing
Message-ID: <20150417182418.13628.80701.stgit@htfujina-fc.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Disable IPv6 extension header processing as per hardware errata.

Also fix copyright date.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_82575.c   |   12 ++++++++----
 drivers/net/ethernet/intel/igb/e1000_defines.h |    3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.c b/drivers/net/ethernet/intel/igb/e1000_82575.c
index 0f69ef8..b0182dd 100644
--- a/drivers/net/ethernet/intel/igb/e1000_82575.c
+++ b/drivers/net/ethernet/intel/igb/e1000_82575.c
@@ -1,5 +1,5 @@
 /* Intel(R) Gigabit Ethernet Linux driver
- * Copyright(c) 2007-2014 Intel Corporation.
+ * Copyright(c) 2007-2015 Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -1900,8 +1900,8 @@ static void igb_clear_hw_cntrs_82575(struct e1000_hw *hw)
  *  igb_rx_fifo_flush_82575 - Clean rx fifo after RX enable
  *  @hw: pointer to the HW structure
  *
- *  After rx enable if managability is enabled then there is likely some
- *  bad data at the start of the fifo and possibly in the DMA fifo.  This
+ *  After rx enable if manageability is enabled then there is likely some
+ *  bad data at the start of the fifo and possibly in the DMA fifo. This
  *  function clears the fifos and flushes any packets that came in as rx was
  *  being enabled.
  **/
@@ -1910,6 +1910,11 @@ void igb_rx_fifo_flush_82575(struct e1000_hw *hw)
 	u32 rctl, rlpml, rxdctl[4], rfctl, temp_rctl, rx_enabled;
 	int i, ms_wait;
 
+	/* disable IPv6 options as per hardware errata */
+	rfctl = rd32(E1000_RFCTL);
+	rfctl |= E1000_RFCTL_IPV6_EX_DIS;
+	wr32(E1000_RFCTL, rfctl);
+
 	if (hw->mac.type != e1000_82575 ||
 	    !(rd32(E1000_MANC) & E1000_MANC_RCV_TCO_EN))
 		return;
@@ -1937,7 +1942,6 @@ void igb_rx_fifo_flush_82575(struct e1000_hw *hw)
 	 * incoming packets are rejected.  Set enable and wait 2ms so that
 	 * any packet that was coming in as RCTL.EN was set is flushed
 	 */
-	rfctl = rd32(E1000_RFCTL);
 	wr32(E1000_RFCTL, rfctl & ~E1000_RFCTL_LEF);
 
 	rlpml = rd32(E1000_RLPML);
diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 217f813..f8684aa 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -344,7 +344,8 @@
 #define E1000_RXCSUM_PCSD      0x00002000   /* packet checksum disabled */
 
 /* Header split receive */
-#define E1000_RFCTL_LEF        0x00040000
+#define E1000_RFCTL_IPV6_EX_DIS         0x00010000
+#define E1000_RFCTL_LEF                 0x00040000
 
 /* Collision related configuration parameters */
 #define E1000_COLLISION_THRESHOLD       15

