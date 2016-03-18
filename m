From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 11:33:16 -0700
Subject: [Intel-wired-lan] [PATCH V2 6/7] ixgbe: Add support for new 10G MAC
	type
In-Reply-To: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
References: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318183316.40415.17112.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for a new 10G MAC type for the ixgbe driver.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Added a necessary check in ixgbe_main.c for configuring interrupt mask
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c   |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c  |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c     |    6 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |    3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   42 +++++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c     |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c     |    6 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c    |   45 +++++++++++++++++++++-
 10 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 4590fabdedf0..d10ed62993c1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -817,6 +817,7 @@ static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
 		return IXGBE_MAX_RSS_INDICES;
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		return IXGBE_MAX_RSS_INDICES_X550;
 	default:
 		return 0;
@@ -860,6 +861,7 @@ enum ixgbe_boards {
 	board_X540,
 	board_X550,
 	board_X550EM_x,
+	board_x550em_a,
 };
 
 extern const struct ixgbe_info ixgbe_82598_info;
@@ -867,6 +869,7 @@ extern const struct ixgbe_info ixgbe_82599_info;
 extern const struct ixgbe_info ixgbe_X540_info;
 extern const struct ixgbe_info ixgbe_X550_info;
 extern const struct ixgbe_info ixgbe_X550EM_x_info;
+extern const struct ixgbe_info ixgbe_x550em_a_info;
 #ifdef CONFIG_IXGBE_DCB
 extern const struct dcbnl_rtnl_ops dcbnl_ops;
 #endif
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
index 4bb6b685263b..01519787324a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c
@@ -1633,6 +1633,7 @@ s32 ixgbe_fdir_set_input_mask_82599(struct ixgbe_hw *hw,
 	switch (hw->mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		IXGBE_WRITE_REG(hw, IXGBE_FDIRSCTPM, ~fdirtcpm);
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index ee43a383aa0a..76080310fc6b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -2854,6 +2854,7 @@ u16 ixgbe_get_pcie_msix_count_generic(struct ixgbe_hw *hw)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		pcie_offset = IXGBE_PCIE_MSIX_82599_CAPS;
 		max_msix_count = IXGBE_MAX_MSIX_VECTORS_82599;
 		break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
index 02c7333a9c83..f8fb2acc2632 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2016 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -293,6 +293,7 @@ s32 ixgbe_dcb_hw_config(struct ixgbe_hw *hw,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		return ixgbe_dcb_hw_config_82599(hw, pfc_en, refill, max,
 						 bwgid, ptype, prio_tc);
 	default:
@@ -311,6 +312,7 @@ s32 ixgbe_dcb_hw_pfc_config(struct ixgbe_hw *hw, u8 pfc_en, u8 *prio_tc)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		return ixgbe_dcb_config_pfc_82599(hw, pfc_en, prio_tc);
 	default:
 		break;
@@ -368,6 +370,7 @@ s32 ixgbe_dcb_hw_ets_config(struct ixgbe_hw *hw,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		ixgbe_dcb_config_rx_arbiter_82599(hw, refill, max,
 						  bwg_id, prio_type, prio_tc);
 		ixgbe_dcb_config_tx_desc_arbiter_82599(hw, refill, max,
@@ -398,6 +401,7 @@ void ixgbe_dcb_read_rtrup2tc(struct ixgbe_hw *hw, u8 *map)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		ixgbe_dcb_read_rtrup2tc_82599(hw, map);
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index fd130f63b321..8e7c6d4961e6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2014 Intel Corporation.
+  Copyright(c) 1999 - 2016 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -549,6 +549,7 @@ static void ixgbe_get_regs(struct net_device *netdev,
 		case ixgbe_mac_X540:
 		case ixgbe_mac_X550:
 		case ixgbe_mac_X550EM_x:
+		case ixgbe_mac_x550em_a:
 			regs_buff[35 + i] = IXGBE_READ_REG(hw, IXGBE_FCRTL_82599(i));
 			regs_buff[43 + i] = IXGBE_READ_REG(hw, IXGBE_FCRTH_82599(i));
 			break;
@@ -662,6 +663,7 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		regs_buff[830] = IXGBE_READ_REG(hw, IXGBE_RTTDCS);
 		regs_buff[832] = IXGBE_READ_REG(hw, IXGBE_RTRPCS);
 		for (i = 0; i < 8; i++)
@@ -1445,6 +1447,7 @@ static int ixgbe_reg_test(struct ixgbe_adapter *adapter, u64 *data)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		toggle = 0x7FFFF30F;
 		test = reg_test_82599;
 		break;
@@ -1683,6 +1686,7 @@ static void ixgbe_free_desc_rings(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		reg_ctl = IXGBE_READ_REG(hw, IXGBE_DMATXCTL);
 		reg_ctl &= ~IXGBE_DMATXCTL_TE;
 		IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL, reg_ctl);
@@ -1722,6 +1726,7 @@ static int ixgbe_setup_desc_rings(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		reg_data = IXGBE_READ_REG(&adapter->hw, IXGBE_DMATXCTL);
 		reg_data |= IXGBE_DMATXCTL_TE;
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_DMATXCTL, reg_data);
@@ -1782,6 +1787,7 @@ static int ixgbe_setup_loopback_test(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		reg_data = IXGBE_READ_REG(hw, IXGBE_MACC);
 		reg_data |= IXGBE_MACC_FLU;
 		IXGBE_WRITE_REG(hw, IXGBE_MACC, reg_data);
@@ -2993,6 +2999,7 @@ static int ixgbe_get_ts_info(struct net_device *dev,
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X540:
 	case ixgbe_mac_82599EB:
 		info->so_timestamping =
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index e771e764daa3..bcdc88444ceb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2013 Intel Corporation.
+  Copyright(c) 1999 - 2016 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -128,6 +128,7 @@ static void ixgbe_get_first_reg_idx(struct ixgbe_adapter *adapter, u8 tc,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		if (num_tcs > 4) {
 			/*
 			 * TCs    : TC0/1 TC2/3 TC4-7
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 59b43ce200be..dbd6fade5529 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -73,7 +73,7 @@ static char ixgbe_default_device_descr[] =
 #define DRV_VERSION "4.2.1-k"
 const char ixgbe_driver_version[] = DRV_VERSION;
 static const char ixgbe_copyright[] =
-				"Copyright (c) 1999-2015 Intel Corporation.";
+				"Copyright (c) 1999-2016 Intel Corporation.";
 
 static const char ixgbe_overheat_msg[] = "Network adapter has been stopped because it has over heated. Restart the computer. If the problem persists, power off the system and replace the adapter";
 
@@ -83,6 +83,7 @@ static const struct ixgbe_info *ixgbe_info_tbl[] = {
 	[board_X540]		= &ixgbe_X540_info,
 	[board_X550]		= &ixgbe_X550_info,
 	[board_X550EM_x]	= &ixgbe_X550EM_x_info,
+	[board_x550em_a]	= &ixgbe_x550em_a_info,
 };
 
 /* ixgbe_pci_tbl - PCI Device ID Table
@@ -860,6 +861,7 @@ static void ixgbe_set_ivar(struct ixgbe_adapter *adapter, s8 direction,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		if (direction == -1) {
 			/* other causes */
 			msix_vector |= IXGBE_IVAR_ALLOC_VAL;
@@ -898,6 +900,7 @@ static inline void ixgbe_irq_rearm_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		mask = (qmask & 0xFFFFFFFF);
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EICS_EX(0), mask);
 		mask = (qmask >> 32);
@@ -2244,6 +2247,7 @@ static void ixgbe_configure_msix(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		ixgbe_set_ivar(adapter, -1, 1, v_idx);
 		break;
 	default:
@@ -2355,6 +2359,7 @@ void ixgbe_write_eitr(struct ixgbe_q_vector *q_vector)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		/*
 		 * set the WDIS bit to not clear the timer bits and cause an
 		 * immediate assertion of the interrupt
@@ -2516,6 +2521,7 @@ static inline bool ixgbe_is_sfp(struct ixgbe_hw *hw)
 		return false;
 	case ixgbe_mac_82599EB:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		switch (hw->mac.ops.get_media_type(hw)) {
 		case ixgbe_media_type_fiber:
 		case ixgbe_media_type_fiber_qsfp:
@@ -2590,6 +2596,7 @@ static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		mask = (qmask & 0xFFFFFFFF);
 		if (mask)
 			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
@@ -2618,6 +2625,7 @@ static inline void ixgbe_irq_disable_queues(struct ixgbe_adapter *adapter,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		mask = (qmask & 0xFFFFFFFF);
 		if (mask)
 			IXGBE_WRITE_REG(hw, IXGBE_EIMC_EX(0), mask);
@@ -2653,6 +2661,7 @@ static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
 		case ixgbe_mac_X540:
 		case ixgbe_mac_X550:
 		case ixgbe_mac_X550EM_x:
+		case ixgbe_mac_x550em_a:
 			mask |= IXGBE_EIMS_TS;
 			break;
 		default:
@@ -2668,7 +2677,9 @@ static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
-		if (adapter->hw.device_id == IXGBE_DEV_ID_X550EM_X_SFP)
+	case ixgbe_mac_x550em_a:
+		if (adapter->hw.device_id == IXGBE_DEV_ID_X550EM_X_SFP ||
+		    adapter->hw.device_id == IXGBE_DEV_ID_X550EM_A_SFP_N)
 			mask |= IXGBE_EIMS_GPI_SDP0(&adapter->hw);
 		if (adapter->hw.phy.type == ixgbe_phy_x550em_ext_t)
 			mask |= IXGBE_EICR_GPI_SDP0_X540;
@@ -2726,6 +2737,7 @@ static irqreturn_t ixgbe_msix_other(int irq, void *data)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		if (hw->phy.type == ixgbe_phy_x550em_ext_t &&
 		    (eicr & IXGBE_EICR_GPI_SDP0_X540)) {
 			adapter->flags2 |= IXGBE_FLAG2_PHY_INTERRUPT;
@@ -2962,6 +2974,7 @@ static irqreturn_t ixgbe_intr(int irq, void *data)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		if (eicr & IXGBE_EICR_ECC) {
 			e_info(link, "Received ECC Err, initiating reset\n");
 			adapter->flags2 |= IXGBE_FLAG2_RESET_REQUESTED;
@@ -3058,6 +3071,7 @@ static inline void ixgbe_irq_disable(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, 0xFFFF0000);
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC_EX(0), ~0);
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC_EX(1), ~0);
@@ -3857,6 +3871,7 @@ static void ixgbe_setup_rdrxctl(struct ixgbe_adapter *adapter)
 		break;
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		if (adapter->num_vfs)
 			rdrxctl |= IXGBE_RDRXCTL_PSP;
 		/* fall through for older HW */
@@ -4020,6 +4035,7 @@ static void ixgbe_vlan_strip_disable(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct ixgbe_ring *ring = adapter->rx_ring[i];
 
@@ -4056,6 +4072,7 @@ static void ixgbe_vlan_strip_enable(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct ixgbe_ring *ring = adapter->rx_ring[i];
 
@@ -4082,6 +4099,7 @@ static void ixgbe_vlan_promisc_enable(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 	default:
 		if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED)
 			break;
@@ -4172,6 +4190,7 @@ static void ixgbe_vlan_promisc_disable(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 	default:
 		if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED)
 			break;
@@ -4560,6 +4579,7 @@ static void ixgbe_clear_vxlan_port(struct ixgbe_adapter *adapter)
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_VXLANCTRL, 0);
 		adapter->vxlan_port = 0;
 		break;
@@ -4660,6 +4680,7 @@ static int ixgbe_hpbthresh(struct ixgbe_adapter *adapter, int pb)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		dv_id = IXGBE_DV_X540(link, tc);
 		break;
 	default:
@@ -4720,6 +4741,7 @@ static int ixgbe_lpbthresh(struct ixgbe_adapter *adapter, int pb)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		dv_id = IXGBE_LOW_DV_X540(tc);
 		break;
 	default:
@@ -5136,6 +5158,7 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
 		case ixgbe_mac_X540:
 		case ixgbe_mac_X550:
 		case ixgbe_mac_X550EM_x:
+		case ixgbe_mac_x550em_a:
 		default:
 			IXGBE_WRITE_REG(hw, IXGBE_EIAM_EX(0), 0xFFFFFFFF);
 			IXGBE_WRITE_REG(hw, IXGBE_EIAM_EX(1), 0xFFFFFFFF);
@@ -5186,6 +5209,7 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
 		gpie |= IXGBE_SDP1_GPIEN_8259X | IXGBE_SDP2_GPIEN_8259X;
 		break;
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		gpie |= IXGBE_SDP0_GPIEN_X540;
 		break;
 	default:
@@ -5497,6 +5521,7 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL,
 				(IXGBE_READ_REG(hw, IXGBE_DMATXCTL) &
 				 ~IXGBE_DMATXCTL_TE));
@@ -5615,6 +5640,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 			adapter->flags2 |= IXGBE_FLAG2_TEMP_SENSOR_CAPABLE;
 		break;
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
 #ifdef CONFIG_IXGBE_DCA
 		adapter->flags &= ~IXGBE_FLAG_DCA_CAPABLE;
@@ -5640,6 +5666,7 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		adapter->dcb_cfg.num_tcs.pg_tcs = X540_TRAFFIC_CLASS;
 		adapter->dcb_cfg.num_tcs.pfc_tcs = X540_TRAFFIC_CLASS;
 		break;
@@ -6247,6 +6274,7 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		pci_wake_from_d3(pdev, !!wufc);
 		break;
 	default:
@@ -6382,6 +6410,7 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 		case ixgbe_mac_X540:
 		case ixgbe_mac_X550:
 		case ixgbe_mac_X550EM_x:
+		case ixgbe_mac_x550em_a:
 			hwstats->pxonrxc[i] +=
 				IXGBE_READ_REG(hw, IXGBE_PXONRXCNT(i));
 			break;
@@ -6397,7 +6426,8 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 		if ((hw->mac.type == ixgbe_mac_82599EB) ||
 		    (hw->mac.type == ixgbe_mac_X540) ||
 		    (hw->mac.type == ixgbe_mac_X550) ||
-		    (hw->mac.type == ixgbe_mac_X550EM_x)) {
+		    (hw->mac.type == ixgbe_mac_X550EM_x) ||
+		    (hw->mac.type == ixgbe_mac_x550em_a)) {
 			hwstats->qbtc[i] += IXGBE_READ_REG(hw, IXGBE_QBTC_L(i));
 			IXGBE_READ_REG(hw, IXGBE_QBTC_H(i)); /* to clear */
 			hwstats->qbrc[i] += IXGBE_READ_REG(hw, IXGBE_QBRC_L(i));
@@ -6422,6 +6452,7 @@ void ixgbe_update_stats(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		/* OS2BMC stats are X540 and later */
 		hwstats->o2bgptc += IXGBE_READ_REG(hw, IXGBE_O2BGPTC);
 		hwstats->o2bspc += IXGBE_READ_REG(hw, IXGBE_O2BSPC);
@@ -6692,6 +6723,7 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_82599EB: {
 		u32 mflcn = IXGBE_READ_REG(hw, IXGBE_MFLCN);
 		u32 fccfg = IXGBE_READ_REG(hw, IXGBE_FCCFG);
@@ -9144,6 +9176,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		IXGBE_WRITE_REG(&adapter->hw, IXGBE_WUS, ~0);
 		break;
 	default:
@@ -9576,6 +9609,9 @@ static pci_ers_result_t ixgbe_io_error_detected(struct pci_dev *pdev,
 		case ixgbe_mac_X550EM_x:
 			device_id = IXGBE_DEV_ID_X550EM_X_VF;
 			break;
+		case ixgbe_mac_x550em_a:
+			device_id = IXGBE_DEV_ID_X550EM_A_VF;
+			break;
 		default:
 			device_id = 0;
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
index 2837c94d6e35..b2125e358f7b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c
@@ -307,6 +307,7 @@ static s32 ixgbe_check_for_rst_pf(struct ixgbe_hw *hw, u16 vf_number)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		vflre = IXGBE_READ_REG(hw, IXGBE_VFLREC(reg_offset));
 		break;
 	default:
@@ -430,6 +431,7 @@ void ixgbe_init_mbx_params_pf(struct ixgbe_hw *hw)
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 	    hw->mac.type != ixgbe_mac_X550 &&
 	    hw->mac.type != ixgbe_mac_X550EM_x &&
+	    hw->mac.type != ixgbe_mac_x550em_a &&
 	    hw->mac.type != ixgbe_mac_X540)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index ef1504d41890..bdc8fdcc07a5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1,7 +1,7 @@
 /*******************************************************************************
 
   Intel 10 Gigabit PCI Express Linux driver
-  Copyright(c) 1999 - 2015 Intel Corporation.
+  Copyright(c) 1999 - 2016 Intel Corporation.
 
   This program is free software; you can redistribute it and/or modify it
   under the terms and conditions of the GNU General Public License,
@@ -333,6 +333,7 @@ static void ixgbe_ptp_convert_to_hwtstamp(struct ixgbe_adapter *adapter,
 	 */
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		/* Upper 32 bits represent billions of cycles, lower 32 bits
 		 * represent cycles. However, we use timespec64_to_ns for the
 		 * correct math even though the units haven't been corrected
@@ -921,6 +922,7 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 	switch (hw->mac.type) {
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		/* enable timestamping all packets only if at least some
 		 * packets were requested. Otherwise, play nice and disable
 		 * timestamping
@@ -1083,6 +1085,7 @@ void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter)
 			cc.shift = 2;
 		}
 		/* fallthrough */
+	case ixgbe_mac_x550em_a:
 	case ixgbe_mac_X550:
 		cc.read = ixgbe_ptp_read_X550;
 
@@ -1223,6 +1226,7 @@ static long ixgbe_ptp_create_clock(struct ixgbe_adapter *adapter)
 		break;
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
 		snprintf(adapter->ptp_caps.name, 16, "%s", netdev->name);
 		adapter->ptp_caps.owner = THIS_MODULE;
 		adapter->ptp_caps.max_adj = 30000000;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 3f5d1802c61e..0dadf2b95c0d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -278,6 +278,8 @@ static s32 ixgbe_identify_phy_x550em(struct ixgbe_hw *hw)
 		hw->phy.phy_semaphore_mask = IXGBE_GSSR_SHARED_I2C_SM;
 		ixgbe_setup_mux_ctl(hw);
 		ixgbe_check_cs4227(hw);
+		/* Fallthrough */
+	case IXGBE_DEV_ID_X550EM_A_SFP_N:
 		return ixgbe_identify_module_generic(hw);
 	case IXGBE_DEV_ID_X550EM_X_KX4:
 		hw->phy.type = ixgbe_phy_x550em_kx4;
@@ -1455,7 +1457,6 @@ static void ixgbe_init_mac_link_ops_X550em(struct ixgbe_hw *hw)
 		mac->ops.enable_tx_laser = NULL;
 		mac->ops.flap_tx_laser = NULL;
 		mac->ops.setup_link = ixgbe_setup_mac_link_multispeed_fiber;
-		mac->ops.setup_fc = ixgbe_setup_fc_x550em;
 		mac->ops.setup_mac_link = ixgbe_setup_mac_link_sfp_x550em;
 		mac->ops.set_rate_select_speed =
 					ixgbe_set_soft_rate_select_speed;
@@ -1464,11 +1465,17 @@ static void ixgbe_init_mac_link_ops_X550em(struct ixgbe_hw *hw)
 		mac->ops.setup_link = ixgbe_setup_mac_link_t_X550em;
 		mac->ops.setup_fc = ixgbe_setup_fc_generic;
 		mac->ops.check_link = ixgbe_check_link_t_X550em;
+		return;
+	case ixgbe_media_type_backplane:
 		break;
 	default:
-		mac->ops.setup_fc = ixgbe_setup_fc_x550em;
 		break;
 	}
+
+	if (mac->type >= ixgbe_mac_x550em_a)
+		mac->ops.setup_fc = ixgbe_setup_fc_generic;
+	else
+		mac->ops.setup_fc = ixgbe_setup_fc_x550em;
 }
 
 /** ixgbe_setup_sfp_modules_X550em - Setup SFP module
@@ -2222,11 +2229,12 @@ static enum ixgbe_media_type ixgbe_get_media_type_X550em(struct ixgbe_hw *hw)
 		media_type = ixgbe_media_type_backplane;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_SFP:
+	case IXGBE_DEV_ID_X550EM_A_SFP_N:
 		media_type = ixgbe_media_type_fiber;
 		break;
 	case IXGBE_DEV_ID_X550EM_X_1G_T:
 	case IXGBE_DEV_ID_X550EM_X_10G_T:
-		 media_type = ixgbe_media_type_copper;
+		media_type = ixgbe_media_type_copper;
 		break;
 	default:
 		media_type = ixgbe_media_type_unknown;
@@ -2623,6 +2631,23 @@ static const struct ixgbe_mac_operations mac_ops_X550EM_x = {
 	.write_iosf_sb_reg	= ixgbe_write_iosf_sb_reg_x550,
 };
 
+static struct ixgbe_mac_operations mac_ops_x550em_a = {
+	X550_COMMON_MAC
+	.reset_hw		= ixgbe_reset_hw_X550em,
+	.get_media_type		= ixgbe_get_media_type_X550em,
+	.get_san_mac_addr	= NULL,
+	.get_wwn_prefix		= NULL,
+	.setup_link		= NULL, /* defined later */
+	.get_link_capabilities	= ixgbe_get_link_capabilities_X550em,
+	.get_bus_info		= ixgbe_get_bus_info_X550em,
+	.setup_sfp		= ixgbe_setup_sfp_modules_X550em,
+	.acquire_swfw_sync	= ixgbe_acquire_swfw_sync_x550em_a,
+	.release_swfw_sync	= ixgbe_release_swfw_sync_x550em_a,
+	.setup_fc		= ixgbe_setup_fc_generic,
+	.read_iosf_sb_reg	= ixgbe_read_iosf_sb_reg_x550a,
+	.write_iosf_sb_reg	= ixgbe_write_iosf_sb_reg_x550a,
+};
+
 #define X550_COMMON_EEP \
 	.read			= &ixgbe_read_ee_hostif_X550, \
 	.read_buffer		= &ixgbe_read_ee_hostif_buffer_X550, \
@@ -2683,6 +2708,10 @@ static const u32 ixgbe_mvals_X550EM_x[IXGBE_MVALS_IDX_LIMIT] = {
 	IXGBE_MVALS_INIT(X550EM_x)
 };
 
+static const u32 ixgbe_mvals_x550em_a[IXGBE_MVALS_IDX_LIMIT] = {
+	IXGBE_MVALS_INIT(X550EM_a)
+};
+
 const struct ixgbe_info ixgbe_X550_info = {
 	.mac			= ixgbe_mac_X550,
 	.get_invariants		= &ixgbe_get_invariants_X540,
@@ -2702,3 +2731,13 @@ const struct ixgbe_info ixgbe_X550EM_x_info = {
 	.mbx_ops		= &mbx_ops_generic,
 	.mvals			= ixgbe_mvals_X550EM_x,
 };
+
+const struct ixgbe_info ixgbe_x550em_a_info = {
+	.mac			= ixgbe_mac_x550em_a,
+	.get_invariants		= &ixgbe_get_invariants_X550_x,
+	.mac_ops		= &mac_ops_x550em_a,
+	.eeprom_ops		= &eeprom_ops_X550EM_x,
+	.phy_ops		= &phy_ops_X550EM_x,
+	.mbx_ops		= &mbx_ops_generic,
+	.mvals			= ixgbe_mvals_x550em_a,
+};

