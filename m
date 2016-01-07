From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:10:39 -0800
Subject: [Intel-wired-lan] [next PATCH 03/11] igb: Allow asymmetric
 configuration of MTU versus Rx frame size
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071039.13648.55302.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since the igb driver is using page based receive there is no point in
limiting the Rx capabilities of the device.  The driver can receive 9K
jumbo frames at all times.  The only changes needed due to MTU changes are
updates for the FIFO sizes and flow-control watermarks.

Update the maximum frame size to reflect the 9.5K limitation of the
hardware, and replace all instances of max_frame_size with
MAX_JUMBO_FRAME_SIZE when referring to an Rx FIFO or frame.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h |    3 -
 drivers/net/ethernet/intel/igb/igb_main.c      |  107 +++++++++---------------
 2 files changed, 42 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index e28f06e56f37..3e4181a4b177 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -357,7 +357,8 @@
 /* Ethertype field values */
 #define ETHERNET_IEEE_VLAN_TYPE 0x8100  /* 802.3ac packet */
 
-#define MAX_JUMBO_FRAME_SIZE    0x3F00
+/* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
+#define MAX_JUMBO_FRAME_SIZE    0x2600
 
 /* PBA constants */
 #define E1000_PBA_32K 0x0020
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3b6d4e10d095..5b200c9f7658 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1891,7 +1891,7 @@ void igb_reset(struct igb_adapter *adapter)
 	struct e1000_hw *hw = &adapter->hw;
 	struct e1000_mac_info *mac = &hw->mac;
 	struct e1000_fc_info *fc = &hw->fc;
-	u32 pba = 0, tx_space, min_tx_space, min_rx_space, hwm;
+	u32 pba, hwm;
 
 	/* Repartition Pba for greater than 9k mtu
 	 * To take effect CTRL.RST is required.
@@ -1917,9 +1917,10 @@ void igb_reset(struct igb_adapter *adapter)
 		break;
 	}
 
-	if ((adapter->max_frame_size > ETH_FRAME_LEN + ETH_FCS_LEN) &&
-	    (mac->type < e1000_82576)) {
-		/* adjust PBA for jumbo frames */
+	if (mac->type == e1000_82575) {
+		u32 min_rx_space, min_tx_space, needed_tx_space;
+
+		/* write Rx PBA so that hardware can report correct Tx PBA */
 		wr32(E1000_PBA, pba);
 
 		/* To maintain wire speed transmits, the Tx FIFO should be
@@ -1929,31 +1930,26 @@ void igb_reset(struct igb_adapter *adapter)
 		 * one full receive packet and is similarly rounded up and
 		 * expressed in KB.
 		 */
-		pba = rd32(E1000_PBA);
-		/* upper 16 bits has Tx packet buffer allocation size in KB */
-		tx_space = pba >> 16;
-		/* lower 16 bits has Rx packet buffer allocation size in KB */
-		pba &= 0xffff;
-		/* the Tx fifo also stores 16 bytes of information about the Tx
-		 * but don't include ethernet FCS because hardware appends it
+		min_rx_space = DIV_ROUND_UP(MAX_JUMBO_FRAME_SIZE, 1024);
+
+		/* The Tx FIFO also stores 16 bytes of information about the Tx
+		 * but don't include Ethernet FCS because hardware appends it.
+		 * We only need to round down to the nearest 512 byte block count
+		 * since the value we care about is 2 frames, not 1.
 		 */
-		min_tx_space = (adapter->max_frame_size +
-				sizeof(union e1000_adv_tx_desc) -
-				ETH_FCS_LEN) * 2;
-		min_tx_space = ALIGN(min_tx_space, 1024);
-		min_tx_space >>= 10;
-		/* software strips receive CRC, so leave room for it */
-		min_rx_space = adapter->max_frame_size;
-		min_rx_space = ALIGN(min_rx_space, 1024);
-		min_rx_space >>= 10;
+		min_tx_space = adapter->max_frame_size;
+		min_tx_space += sizeof(union e1000_adv_tx_desc) - ETH_FCS_LEN;
+		min_tx_space = DIV_ROUND_UP(min_tx_space, 512);
+
+		/* upper 16 bits has Tx packet buffer allocation size in KB */
+		needed_tx_space = min_tx_space - (rd32(E1000_PBA) >> 16);
 
 		/* If current Tx allocation is less than the min Tx FIFO size,
 		 * and the min Tx FIFO size is less than the current Rx FIFO
-		 * allocation, take space away from current Rx allocation
+		 * allocation, take space away from current Rx allocation.
 		 */
-		if (tx_space < min_tx_space &&
-		    ((min_tx_space - tx_space) < pba)) {
-			pba = pba - (min_tx_space - tx_space);
+		if (needed_tx_space < pba) {
+			pba -= needed_tx_space;
 
 			/* if short on Rx space, Rx wins and must trump Tx
 			 * adjustment
@@ -1961,18 +1957,20 @@ void igb_reset(struct igb_adapter *adapter)
 			if (pba < min_rx_space)
 				pba = min_rx_space;
 		}
+
+		/* adjust PBA for jumbo frames */
 		wr32(E1000_PBA, pba);
 	}
 
-	/* flow control settings */
-	/* The high water mark must be low enough to fit one full frame
-	 * (or the size used for early receive) above it in the Rx FIFO.
-	 * Set it to the lower of:
-	 * - 90% of the Rx FIFO size, or
-	 * - the full Rx FIFO size minus one full frame
+	/* flow control settings
+	 * The high water mark must be low enough to fit one full frame
+	 * after transmitting the pause frame.  As such we must have enough
+	 * space to allow for us to complete our current transmit and then
+	 * receive the frame that is in progress from the link partner.
+	 * Set it to:
+	 * - the full Rx FIFO size minus one full Tx plus one full Rx frame
 	 */
-	hwm = min(((pba << 10) * 9 / 10),
-			((pba << 10) - 2 * adapter->max_frame_size));
+	hwm = (pba << 10) - (adapter->max_frame_size + MAX_JUMBO_FRAME_SIZE);
 
 	fc->high_water = hwm & 0xFFFFFFF0;	/* 16-byte granularity */
 	fc->low_water = fc->high_water - 16;
@@ -3612,7 +3610,7 @@ void igb_setup_rctl(struct igb_adapter *adapter)
 	/* disable store bad packets and clear size bits. */
 	rctl &= ~(E1000_RCTL_SBP | E1000_RCTL_SZ_256);
 
-	/* enable LPE to prevent packets larger than max_frame_size */
+	/* enable LPE to allow for reception of jumbo frames */
 	rctl |= E1000_RCTL_LPE;
 
 	/* disable queue 0 to prevent tail write w/o re-config */
@@ -3668,32 +3666,6 @@ static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
 	return 0;
 }
 
-/**
- *  igb_rlpml_set - set maximum receive packet size
- *  @adapter: board private structure
- *
- *  Configure maximum receivable packet size.
- **/
-static void igb_rlpml_set(struct igb_adapter *adapter)
-{
-	u32 max_frame_size = adapter->max_frame_size;
-	struct e1000_hw *hw = &adapter->hw;
-	u16 pf_id = adapter->vfs_allocated_count;
-
-	if (pf_id) {
-		igb_set_vf_rlpml(adapter, max_frame_size, pf_id);
-		/* If we're in VMDQ or SR-IOV mode, then set global RLPML
-		 * to our max jumbo frame size, in case we need to enable
-		 * jumbo frames on one of the rings later.
-		 * This will not pass over-length frames into the default
-		 * queue because it's gated by the VMOLR.RLPML.
-		 */
-		max_frame_size = MAX_JUMBO_FRAME_SIZE;
-	}
-
-	wr32(E1000_RLPML, max_frame_size);
-}
-
 static inline void igb_set_vmolr(struct igb_adapter *adapter,
 				 int vfn, bool aupe)
 {
@@ -4191,7 +4163,14 @@ static void igb_set_rx_mode(struct net_device *netdev)
 
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
+
+	/* enable Rx jumbo frames, no need for restriction */
+	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	vmolr |= MAX_JUMBO_FRAME_SIZE | E1000_VMOLR_LPE;
+
 	wr32(E1000_VMOLR(vfn), vmolr);
+	wr32(E1000_RLPML, MAX_JUMBO_FRAME_SIZE);
+
 	igb_restore_vf_multicasts(adapter);
 }
 
@@ -7331,8 +7310,6 @@ static void igb_vlan_mode(struct net_device *netdev, netdev_features_t features)
 		ctrl &= ~E1000_CTRL_VME;
 		wr32(E1000_CTRL, ctrl);
 	}
-
-	igb_rlpml_set(adapter);
 }
 
 static int igb_vlan_rx_add_vid(struct net_device *netdev,
@@ -8088,9 +8065,7 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			 * than the Rx threshold. Set hwm to PBA - max frame
 			 * size in 16B units, capping it at PBA - 6KB.
 			 */
-			hwm = 64 * pba - adapter->max_frame_size / 16;
-			if (hwm < 64 * (pba - 6))
-				hwm = 64 * (pba - 6);
+			hwm = 64 * (pba - 6);
 			reg = rd32(E1000_FCRTC);
 			reg &= ~E1000_FCRTC_RTH_COAL_MASK;
 			reg |= ((hwm << E1000_FCRTC_RTH_COAL_SHIFT)
@@ -8100,9 +8075,7 @@ static void igb_init_dmac(struct igb_adapter *adapter, u32 pba)
 			/* Set the DMA Coalescing Rx threshold to PBA - 2 * max
 			 * frame size, capping it@PBA - 10KB.
 			 */
-			dmac_thr = pba - adapter->max_frame_size / 512;
-			if (dmac_thr < pba - 10)
-				dmac_thr = pba - 10;
+			dmac_thr = pba - 10;
 			reg = rd32(E1000_DMACR);
 			reg &= ~E1000_DMACR_DMACTHR_MASK;
 			reg |= ((dmac_thr << E1000_DMACR_DMACTHR_SHIFT)

