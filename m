From: Yanir Lubetkin <yanirx.lubetkin@intel.com>
Date: Fri, 10 Apr 2015 16:08:58 -0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e i219 fix unit hang on reset and
	runtime D3
Message-ID: <979014366-12063-1-git-send-email-yanirx.lubetkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yanir Lubetkin <yanir@galilsoft.com>

unit hang may occur if multiple descriptors are available in the rings during
reset or runtime suspend. This state can be detected by testing the PCI config
space register FEXTNVM7 bit 8 (0x100 mask). if this bit is on, and there are
pending descriptors in one of the rings, we must flush them prior to reset.
same goes for entering runtime suspend.

Signed-off-by: Yanir Lubetkin <yanir@galilsoft.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +
 drivers/net/ethernet/intel/e1000e/netdev.c  | 94 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/regs.h    |  1 +
 3 files changed, 97 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 770a573..68314db 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -101,6 +101,8 @@
 
 #define E1000_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
 
+#define E1000_FEXTNVM11_DISABLE_MULR_FIX       0x00002000
+
 #define K1_ENTRY_LATENCY	0
 #define K1_MIN_TIME		1
 #define NVM_SIZE_MULTIPLIER 4096	/*multiplier for NVMS field */
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 74ec185..9ba0d7e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3788,6 +3788,98 @@ static void e1000_power_down_phy(struct e1000_adapter *adapter)
 }
 
 /**
+ * e1000_flush_tx_ring - remove all descriptors from the tx_ring
+ *
+ * force the hardware to read all the descriptors and discard them
+ * we put a descriptor with the ring itself as its data. reading
+ * the descriptor contents is performing a read on all the ring entries and
+ * causes a ring flush
+ */
+static void e1000_flush_tx_ring(struct e1000_adapter *adapter)
+{
+       struct e1000_hw *hw = &adapter->hw;
+       struct e1000_ring *tx_ring = adapter->tx_ring;
+       struct e1000_tx_desc *tx_desc = NULL;
+       u32 txd_lower = E1000_TXD_CMD_IFCS;
+       u32 tctl, tdbal, tdbah;
+       int next_to_use;
+       u16 size = 512;
+
+       tctl = er32(TCTL);
+       ew32(TCTL, tctl | E1000_TCTL_EN);
+       tdbal = er32(TDBAL(0));
+       tdbah = er32(TDBAH(0));
+       next_to_use = tx_ring->next_to_use;
+       tx_desc = E1000_TX_DESC(*tx_ring, next_to_use);
+       tx_desc->buffer_addr = cpu_to_le64(((u64)tdbah << 32) | tdbal);
+       tx_desc->lower.data = cpu_to_le32(txd_lower | size);
+       tx_desc->upper.data = 0;
+       /* in case other processors access the descriptor ring */
+       dma_wmb();
+       next_to_use++;
+       if (next_to_use == tx_ring->count)
+               next_to_use = 0;
+       ew32(TDT(0), next_to_use);
+       mmiowb();
+       usleep_range(200);
+}
+
+/**
+ * e1000_flush_rx_ring - remove all descriptors from the tx_ring
+ *
+ * Mark all descriptors in the RX ring as consumed and disable the rx ring
+ */
+static void e1000_flush_rx_ring(struct e1000_adapter *adapter)
+{
+       u32 rctl, rxdctl;
+       struct e1000_hw *hw = &adapter->hw;
+
+       rctl = er32(RCTL);
+       ew32(RCTL, rctl & ~E1000_RCTL_EN);
+       usleep_range(100);
+       rxdctl = er32(RXDCTL(0));
+       rxdctl &= 0xffffc000;
+       rxdctl |= (0x1F | (1 << 8) | (1 << 24));
+       ew32(RXDCTL(0), rxdctl);
+       ew32(RCTL, rctl | E1000_RCTL_EN);
+       usleep_range(100);
+       ew32(RCTL, rctl & ~E1000_RCTL_EN);
+}
+
+/**
+ * e1000_flush_desc_rings - remove all descriptors from the descriptor rings
+ *
+ * In i219, the descriptor rings must be emptied before resetting the HW
+ * or before changing the device state to D3 during runtime (runtime PM).
+ *
+ * Failure to do this will cause the HW to enter a unit hang state which can
+ * only be released by PCI reset on the device
+ *
+ */
+
+static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
+{
+       u16 hang_state;
+       u32 fext_nvm11, tdlen;
+       struct e1000_hw *hw = &adapter->hw;
+
+       /* First, disable MULR fix in FEXTNVM11 */
+       fext_nvm11 = er32(FEXTNVM11);
+       fext_nvm11 |= E1000_FEXTNVM11_DISABLE_MULR_FIX;
+       ew32(FEXTNVM11, fext_nvm11);
+       /* do nothing if we're not in faulty state, or if the queue is empty */
+       tdlen = er32(TDLEN(0));
+       pci_read_config_word(adapter->pdev, E1000_FEXTNVM7, &hang_state);
+       if ((hang_state & E1000_FEXTNVM7_MULR_NEED_DESCRING_FLUSH) || tdlen)
+               return;
+       e1000_flush_tx_ring(adapter);
+       /* recheck, maybe the fault is caused by the rx ring */
+       pci_read_config_word(adapter->pdev, E1000_FEXTNVM7, &hang_state);
+       if (hang_state & E1000_FEXTNVM7_MULR_NEED_DESCRING_FLUSH)
+               e1000_flush_rx_ring(adapter);
+}
+
+/**
  * e1000e_reset - bring the hardware into a known good state
  *
  * This function boots the hardware and enables some settings that
@@ -3943,6 +4035,8 @@ void e1000e_reset(struct e1000_adapter *adapter)
 		}
 	}
 
+	if (hw->mac.type == e1000_pch_spt)
+		e1000_flush_desc_rings(adapter);
 	/* Allow time for pending master requests to run */
 	mac->ops.reset_hw(hw);
 
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index 85eefc4..fdaac8e 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -38,6 +38,7 @@
 #define E1000_FEXTNVM4	0x00024	/* Future Extended NVM 4 - RW */
 #define E1000_FEXTNVM6	0x00010	/* Future Extended NVM 6 - RW */
 #define E1000_FEXTNVM7	0x000E4	/* Future Extended NVM 7 - RW */
+#define E1000_FEXTNVM11        0x5BBC  /* Future Extended NVM 11 - RW */
 #define E1000_PCIEANACFG	0x00F18	/* PCIE Analog Config */
 #define E1000_FCT	0x00030	/* Flow Control Type - RW */
 #define E1000_VET	0x00038	/* VLAN Ether Type - RW */
-- 
1.9.3

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

