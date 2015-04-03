From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:27:10 -0700
Subject: [Intel-wired-lan] [net-next 20/25] fm10k: Add support for ITR
	scaling based on PCIe link speed
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-20-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fm10k's interrupt throttle timers are based on the PCIe link
speed. Because of this, the value being programmed into the ITR
registers must be scaled.

For the PF, this is as simple as reading the PCIe link speed and storing
the result. However, in the case of SR-IOV, the VF's interrupt throttle
timers are based on the link speed of the PF. However, the VF is unable
to get the link speed information from its configuration space, so the
PF must inform it of what scale to use.

Rather than pass this scale via mailbox message, take advantage of
unused bits in the TDLEN register to pass the scale. It is the
responsibility of the PF to program this for the VF while setting up the
VF queues and the responsibility of the VF to get the information
accordingly. This is preferable because it allows the VF to set up the
interrupts properly during initialization and matches how the MAC
address is passed in the TDBAL/TDBAH registers.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h      |  4 ++++
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 17 +++++++++++++----
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 12 ++++++++++--
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 16 +++++++++++++++-
 drivers/net/ethernet/intel/fm10k/fm10k_type.h |  6 ++++++
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   | 11 +++++++++--
 6 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index cc7f442e..feb53c0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -131,6 +131,7 @@ struct fm10k_ring {
 					 * different for DCB and RSS modes
 					 */
 	u8 qos_pc;			/* priority class of queue */
+	u8 itr_scale;			/* throttle scaler based on PCI speed */
 	u16 vid;			/* default vlan ID of queue */
 	u16 count;			/* amount of descriptors */
 
@@ -164,6 +165,9 @@ struct fm10k_ring_container {
 #define FM10K_ITR_10K		100	/* 100us */
 #define FM10K_ITR_20K		50	/* 50us */
 #define FM10K_ITR_ADAPTIVE	0x8000	/* adaptive interrupt moderation flag */
+#define FM10K_ITR_SCALE_SMALL	60	/* Constant factor for small frames */
+#define FM10K_ITR_SCALE_MEDIUM	50	/* Constant factor for medium frames */
+#define FM10K_ITR_SCALE_LARGE	40	/* Constant factor for large frames */
 
 #define FM10K_ITR_ENABLE	(FM10K_ITR_AUTOMASK | FM10K_ITR_MASK_CLEAR)
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 1e08832..cd2e86a 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -1395,11 +1395,20 @@ static void fm10k_update_itr(struct fm10k_ring_container *ring_container)
 	if (avg_wire_size > 3000)
 		avg_wire_size = 3000;
 
-	/* Give a little boost to mid-size frames */
-	if ((avg_wire_size > 300) && (avg_wire_size < 1200))
-		avg_wire_size /= 3;
+	/* Simple throttle rate management based on average wire size,
+	 * providing boosts to small and medium packet loads. Divide the
+	 * average wire size by a constant factor to calculate the minimum time
+	 * until the next interrupt in microseconds.
+	 */
+	if (avg_wire_size < 300)
+		avg_wire_size /= FM10K_ITR_SCALE_SMALL;
+	else if ((avg_wire_size >= 300) && (avg_wire_size < 1200))
+		avg_wire_size /= FM10K_ITR_SCALE_MEDIUM;
 	else
-		avg_wire_size /= 2;
+		avg_wire_size /= FM10K_ITR_SCALE_LARGE;
+
+	/* Scale for various PCIe link speeds */
+	avg_wire_size /= ring_container->ring->itr_scale;
 
 	/* write back value and retain adaptive flag */
 	ring_container->itr = avg_wire_size | FM10K_ITR_ADAPTIVE;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index cc527dd..c7c9832 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -532,6 +532,9 @@ static void fm10k_configure_tx_ring(struct fm10k_intfc *interface,
 	/* store tail pointer */
 	ring->tail = &interface->uc_addr[FM10K_TDT(reg_idx)];
 
+	/* store ITR scale */
+	ring->itr_scale = hw->mac.itr_scale;
+
 	/* reset ntu and ntc to place SW in sync with hardwdare */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
@@ -638,6 +641,9 @@ static void fm10k_configure_rx_ring(struct fm10k_intfc *interface,
 	/* store tail pointer */
 	ring->tail = &interface->uc_addr[FM10K_RDT(reg_idx)];
 
+	/* store ITR scale */
+	ring->itr_scale = hw->mac.itr_scale;
+
 	/* reset ntu and ntc to place SW in sync with hardwdare */
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
@@ -824,7 +830,8 @@ static irqreturn_t fm10k_msix_mbx_vf(int __always_unused irq, void *data)
 
 	/* re-enable mailbox interrupt and indicate 20us delay */
 	fm10k_write_reg(hw, FM10K_VFITR(FM10K_MBX_VECTOR),
-			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
+			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY /
+					    hw->mac.itr_scale));
 
 	/* service upstream mailbox */
 	if (fm10k_mbx_trylock(interface)) {
@@ -1007,7 +1014,8 @@ static irqreturn_t fm10k_msix_mbx_pf(int __always_unused irq, void *data)
 
 	/* re-enable mailbox interrupt and indicate 20us delay */
 	fm10k_write_reg(hw, FM10K_ITR(FM10K_MBX_VECTOR),
-			FM10K_ITR_ENABLE | FM10K_MBX_INT_DELAY);
+			FM10K_ITR_ENABLE | (FM10K_MBX_INT_DELAY /
+					    hw->mac.itr_scale));
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index a92b58d..be80024 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -144,16 +144,21 @@ static s32 fm10k_init_hw_pf(struct fm10k_hw *hw)
 				FM10K_TPH_RXCTRL_HDR_WROEN);
 	}
 
-	/* set max hold interval to align with 1.024 usec in all modes */
+	/* set max hold interval to align with 1.024 usec in all modes and
+	 * store ITR scale
+	 */
 	switch (hw->bus.speed) {
 	case fm10k_bus_speed_2500:
 		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN1;
+		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN1;
 		break;
 	case fm10k_bus_speed_5000:
 		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN2;
+		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN2;
 		break;
 	case fm10k_bus_speed_8000:
 		dma_ctrl = FM10K_DMA_CTRL_MAX_HOLD_1US_GEN3;
+		hw->mac.itr_scale = FM10K_TDLEN_ITR_SCALE_GEN3;
 		break;
 	default:
 		dma_ctrl = 0;
@@ -907,6 +912,12 @@ static s32 fm10k_iov_assign_default_mac_vlan_pf(struct fm10k_hw *hw,
 	fm10k_write_reg(hw, FM10K_TDBAL(vf_q_idx), tdbal);
 	fm10k_write_reg(hw, FM10K_TDBAH(vf_q_idx), tdbah);
 
+	/* Provide the VF the ITR scale, using software-defined fields in TDLEN
+	 * to pass the information during VF initialization
+	 */
+	fm10k_write_reg(hw, FM10K_TDLEN(vf_q_idx), hw->mac.itr_scale <<
+						   FM10K_TDLEN_ITR_SCALE_SHIFT);
+
 err_out:
 	/* configure Queue control register */
 	txqctl = ((u32)vf_vid << FM10K_TXQCTL_VID_SHIFT) &
@@ -1039,6 +1050,9 @@ static s32 fm10k_iov_reset_resources_pf(struct fm10k_hw *hw,
 	for (i = queues_per_pool; i--;) {
 		fm10k_write_reg(hw, FM10K_TDBAL(vf_q_idx + i), tdbal);
 		fm10k_write_reg(hw, FM10K_TDBAH(vf_q_idx + i), tdbah);
+		fm10k_write_reg(hw, FM10K_TDLEN(vf_q_idx + i),
+				hw->mac.itr_scale <<
+				FM10K_TDLEN_ITR_SCALE_SHIFT);
 		fm10k_write_reg(hw, FM10K_TQMAP(qmap_idx + i), vf_q_idx + i);
 		fm10k_write_reg(hw, FM10K_RQMAP(qmap_idx + i), vf_q_idx + i);
 	}
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_type.h b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
index 4af9668..c9a646d 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_type.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_type.h
@@ -271,6 +271,11 @@ struct fm10k_hw;
 #define FM10K_TDBAL(_n)		((0x40 * (_n)) + 0x8000)
 #define FM10K_TDBAH(_n)		((0x40 * (_n)) + 0x8001)
 #define FM10K_TDLEN(_n)		((0x40 * (_n)) + 0x8002)
+#define FM10K_TDLEN_ITR_SCALE_SHIFT		9
+#define FM10K_TDLEN_ITR_SCALE_MASK		0x00000E00
+#define FM10K_TDLEN_ITR_SCALE_GEN1		4
+#define FM10K_TDLEN_ITR_SCALE_GEN2		2
+#define FM10K_TDLEN_ITR_SCALE_GEN3		1
 #define FM10K_TPH_TXCTRL(_n)	((0x40 * (_n)) + 0x8003)
 #define FM10K_TPH_TXCTRL_DESC_TPHEN		0x00000020
 #define FM10K_TPH_TXCTRL_DESC_RROEN		0x00000200
@@ -560,6 +565,7 @@ struct fm10k_mac_info {
 	bool get_host_state;
 	bool tx_ready;
 	u32 dglort_map;
+	u8 itr_scale;
 };
 
 struct fm10k_swapi_table_info {
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
index 94f0f6a..099f190 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_vf.c
@@ -28,7 +28,7 @@
 static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
 {
 	u8 *perm_addr = hw->mac.perm_addr;
-	u32 bal = 0, bah = 0;
+	u32 bal = 0, bah = 0, tdlen;
 	s32 err;
 	u16 i;
 
@@ -48,6 +48,9 @@ static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
 		       ((u32)perm_addr[2]);
 	}
 
+	/* restore default itr_scale for next VF initialization */
+	tdlen = hw->mac.itr_scale << FM10K_TDLEN_ITR_SCALE_SHIFT;
+
 	/* The queues have already been disabled so we just need to
 	 * update their base address registers
 	 */
@@ -56,6 +59,7 @@ static s32 fm10k_stop_hw_vf(struct fm10k_hw *hw)
 		fm10k_write_reg(hw, FM10K_TDBAH(i), bah);
 		fm10k_write_reg(hw, FM10K_RDBAL(i), bal);
 		fm10k_write_reg(hw, FM10K_RDBAH(i), bah);
+		fm10k_write_reg(hw, FM10K_TDLEN(i), tdlen);
 	}
 
 	return 0;
@@ -124,9 +128,12 @@ static s32 fm10k_init_hw_vf(struct fm10k_hw *hw)
 	/* record maximum queue count */
 	hw->mac.max_queues = i;
 
-	/* fetch default VLAN */
+	/* fetch default VLAN and ITR scale */
 	hw->mac.default_vid = (fm10k_read_reg(hw, FM10K_TXQCTL(0)) &
 			       FM10K_TXQCTL_VID_MASK) >> FM10K_TXQCTL_VID_SHIFT;
+	hw->mac.itr_scale = (fm10k_read_reg(hw, FM10K_TDLEN(0)) &
+			     FM10K_TDLEN_ITR_SCALE_MASK) >>
+			    FM10K_TDLEN_ITR_SCALE_SHIFT;
 
 	return 0;
 }
-- 
1.9.3

