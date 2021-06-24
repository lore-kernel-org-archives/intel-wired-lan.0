From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 24 Jun 2021 11:18:27 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/3] e1000e: Add handshake with the
 CSME to support s0ix
Message-ID: <20210624081827.568657-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On the corporate system, the driver will ask from the CSME
(manageability engine) to perform device settings are required
to allow s0ix residency.
This patch provides initial support.

Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.h |   2 +
 drivers/net/ethernet/intel/e1000e/netdev.c  | 328 +++++++++++---------
 2 files changed, 176 insertions(+), 154 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 1502895eb45d..e59456d867db 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -47,6 +47,8 @@
 #define E1000_SHRAH_PCH_LPT(_i)		(0x0540C + ((_i) * 8))
 
 #define E1000_H2ME		0x05B50	/* Host to ME */
+#define E1000_H2ME_START_DPG	0x00000001	/* indicate the ME of DPG */
+#define E1000_H2ME_EXIT_DPG	0x00000002	/* indicate the ME exit DPG */
 #define E1000_H2ME_ULP		0x00000800	/* ULP Indication Bit */
 #define E1000_H2ME_ENFORCE_SETTINGS	0x00001000	/* Enforce Settings */
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 646bfb83a18b..786719890f2b 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6345,42 +6345,104 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 	u32 mac_data;
 	u16 phy_data;
 
-	/* Disable the periodic inband message,
-	 * don't request PCIe clock in K1 page770_17[10:9] = 10b
-	 */
-	e1e_rphy(hw, HV_PM_CTRL, &phy_data);
-	phy_data &= ~HV_PM_CTRL_K1_CLK_REQ;
-	phy_data |= BIT(10);
-	e1e_wphy(hw, HV_PM_CTRL, phy_data);
+	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
+		/* Request ME configure the device for s0ix */
+		mac_data = er32(H2ME);
+		mac_data |= E1000_H2ME_START_DPG;
+		mac_data &= ~E1000_H2ME_EXIT_DPG;
+		ew32(H2ME, mac_data);
+	} else {
+		/* Request driver configure the device to s0ix */
+		/* Disable the periodic inband message,
+		 * don't request PCIe clock in K1 page770_17[10:9] = 10b
+		 */
+		e1e_rphy(hw, HV_PM_CTRL, &phy_data);
+		phy_data &= ~HV_PM_CTRL_K1_CLK_REQ;
+		phy_data |= BIT(10);
+		e1e_wphy(hw, HV_PM_CTRL, phy_data);
 
-	/* Make sure we don't exit K1 every time a new packet arrives
-	 * 772_29[5] = 1 CS_Mode_Stay_In_K1
-	 */
-	e1e_rphy(hw, I217_CGFREG, &phy_data);
-	phy_data |= BIT(5);
-	e1e_wphy(hw, I217_CGFREG, phy_data);
+		/* Make sure we don't exit K1 every time a new packet arrives
+		 * 772_29[5] = 1 CS_Mode_Stay_In_K1
+		 */
+		e1e_rphy(hw, I217_CGFREG, &phy_data);
+		phy_data |= BIT(5);
+		e1e_wphy(hw, I217_CGFREG, phy_data);
 
-	/* Change the MAC/PHY interface to SMBus
-	 * Force the SMBus in PHY page769_23[0] = 1
-	 * Force the SMBus in MAC CTRL_EXT[11] = 1
-	 */
-	e1e_rphy(hw, CV_SMB_CTRL, &phy_data);
-	phy_data |= CV_SMB_CTRL_FORCE_SMBUS;
-	e1e_wphy(hw, CV_SMB_CTRL, phy_data);
-	mac_data = er32(CTRL_EXT);
-	mac_data |= E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_data);
+		/* Change the MAC/PHY interface to SMBus
+		 * Force the SMBus in PHY page769_23[0] = 1
+		 * Force the SMBus in MAC CTRL_EXT[11] = 1
+		 */
+		e1e_rphy(hw, CV_SMB_CTRL, &phy_data);
+		phy_data |= CV_SMB_CTRL_FORCE_SMBUS;
+		e1e_wphy(hw, CV_SMB_CTRL, phy_data);
+		mac_data = er32(CTRL_EXT);
+		mac_data |= E1000_CTRL_EXT_FORCE_SMBUS;
+		ew32(CTRL_EXT, mac_data);
+
+		/* DFT control: PHY bit: page769_20[0] = 1
+		 * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
+		 */
+		e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
+		phy_data |= BIT(0);
+		e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
+
+		mac_data = er32(EXTCNF_CTRL);
+		mac_data |= E1000_EXTCNF_CTRL_GATE_PHY_CFG;
+		ew32(EXTCNF_CTRL, mac_data);
+
+		/* Enable the Dynamic Power Gating in the MAC */
+		mac_data = er32(FEXTNVM7);
+		mac_data |= BIT(22);
+		ew32(FEXTNVM7, mac_data);
+
+		/* Disable disconnected cable conditioning for Power Gating */
+		mac_data = er32(DPGFR);
+		mac_data |= BIT(2);
+		ew32(DPGFR, mac_data);
+
+		/* Don't wake from dynamic Power Gating with clock request */
+		mac_data = er32(FEXTNVM12);
+		mac_data |= BIT(12);
+		ew32(FEXTNVM12, mac_data);
+
+		/* Ungate PGCB clock */
+		mac_data = er32(FEXTNVM9);
+		mac_data &= ~BIT(28);
+		ew32(FEXTNVM9, mac_data);
+
+		/* Enable K1 off to enable mPHY Power Gating */
+		mac_data = er32(FEXTNVM6);
+		mac_data |= BIT(31);
+		ew32(FEXTNVM6, mac_data);
+
+		/* Enable mPHY power gating for any link and speed */
+		mac_data = er32(FEXTNVM8);
+		mac_data |= BIT(9);
+		ew32(FEXTNVM8, mac_data);
+
+		/* Enable the Dynamic Clock Gating in the DMA and MAC */
+		mac_data = er32(CTRL_EXT);
+		mac_data |= E1000_CTRL_EXT_DMA_DYN_CLK_EN;
+		ew32(CTRL_EXT, mac_data);
+
+		/* No MAC DPG gating SLP_S0 in modern standby
+		 * Switch the logic of the lanphypc to use PMC counter
+		 */
+		mac_data = er32(FEXTNVM5);
+		mac_data |= BIT(7);
+		ew32(FEXTNVM5, mac_data);
+	}
 
-	/* DFT control: PHY bit: page769_20[0] = 1
-	 * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
-	 */
-	e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
-	phy_data |= BIT(0);
-	e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
+	/* Disable the time synchronization clock */
+	mac_data = er32(FEXTNVM7);
+	mac_data |= BIT(31);
+	mac_data &= ~BIT(0);
+	ew32(FEXTNVM7, mac_data);
 
-	mac_data = er32(EXTCNF_CTRL);
-	mac_data |= E1000_EXTCNF_CTRL_GATE_PHY_CFG;
-	ew32(EXTCNF_CTRL, mac_data);
+	/* Dynamic Power Gating Enable */
+	mac_data = er32(CTRL_EXT);
+	mac_data |= BIT(3);
+	ew32(CTRL_EXT, mac_data);
 
 	/* Check MAC Tx/Rx packet buffer pointers.
 	 * Reset MAC Tx/Rx packet buffer pointers to suppress any
@@ -6416,59 +6478,6 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 	mac_data = er32(RDFPC);
 	if (mac_data)
 		ew32(RDFPC, 0);
-
-	/* Enable the Dynamic Power Gating in the MAC */
-	mac_data = er32(FEXTNVM7);
-	mac_data |= BIT(22);
-	ew32(FEXTNVM7, mac_data);
-
-	/* Disable the time synchronization clock */
-	mac_data = er32(FEXTNVM7);
-	mac_data |= BIT(31);
-	mac_data &= ~BIT(0);
-	ew32(FEXTNVM7, mac_data);
-
-	/* Dynamic Power Gating Enable */
-	mac_data = er32(CTRL_EXT);
-	mac_data |= BIT(3);
-	ew32(CTRL_EXT, mac_data);
-
-	/* Disable disconnected cable conditioning for Power Gating */
-	mac_data = er32(DPGFR);
-	mac_data |= BIT(2);
-	ew32(DPGFR, mac_data);
-
-	/* Don't wake from dynamic Power Gating with clock request */
-	mac_data = er32(FEXTNVM12);
-	mac_data |= BIT(12);
-	ew32(FEXTNVM12, mac_data);
-
-	/* Ungate PGCB clock */
-	mac_data = er32(FEXTNVM9);
-	mac_data &= ~BIT(28);
-	ew32(FEXTNVM9, mac_data);
-
-	/* Enable K1 off to enable mPHY Power Gating */
-	mac_data = er32(FEXTNVM6);
-	mac_data |= BIT(31);
-	ew32(FEXTNVM6, mac_data);
-
-	/* Enable mPHY power gating for any link and speed */
-	mac_data = er32(FEXTNVM8);
-	mac_data |= BIT(9);
-	ew32(FEXTNVM8, mac_data);
-
-	/* Enable the Dynamic Clock Gating in the DMA and MAC */
-	mac_data = er32(CTRL_EXT);
-	mac_data |= E1000_CTRL_EXT_DMA_DYN_CLK_EN;
-	ew32(CTRL_EXT, mac_data);
-
-	/* No MAC DPG gating SLP_S0 in modern standby
-	 * Switch the logic of the lanphypc to use PMC counter
-	 */
-	mac_data = er32(FEXTNVM5);
-	mac_data |= BIT(7);
-	ew32(FEXTNVM5, mac_data);
 }
 
 static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
@@ -6477,87 +6486,98 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	u32 mac_data;
 	u16 phy_data;
 
-	/* Disable the Dynamic Power Gating in the MAC */
-	mac_data = er32(FEXTNVM7);
-	mac_data &= 0xFFBFFFFF;
-	ew32(FEXTNVM7, mac_data);
+	if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID) {
+		/* Request ME un configure the device from s0ix */
+		mac_data = er32(H2ME);
+		mac_data &= ~E1000_H2ME_START_DPG;
+		mac_data |= E1000_H2ME_EXIT_DPG;
+		ew32(H2ME, mac_data);
+	} else {
+		/* Request driver un configure the device from s0ix */
+
+		/* Disable the Dynamic Power Gating in the MAC */
+		mac_data = er32(FEXTNVM7);
+		mac_data &= 0xFFBFFFFF;
+		ew32(FEXTNVM7, mac_data);
+
+		/* Disable mPHY power gating for any link and speed */
+		mac_data = er32(FEXTNVM8);
+		mac_data &= ~BIT(9);
+		ew32(FEXTNVM8, mac_data);
+
+		/* Disable K1 off */
+		mac_data = er32(FEXTNVM6);
+		mac_data &= ~BIT(31);
+		ew32(FEXTNVM6, mac_data);
+
+		/* Disable Ungate PGCB clock */
+		mac_data = er32(FEXTNVM9);
+		mac_data |= BIT(28);
+		ew32(FEXTNVM9, mac_data);
+
+		/* Cancel not waking from dynamic
+		 * Power Gating with clock request
+		 */
+		mac_data = er32(FEXTNVM12);
+		mac_data &= ~BIT(12);
+		ew32(FEXTNVM12, mac_data);
 
-	/* Enable the time synchronization clock */
-	mac_data = er32(FEXTNVM7);
-	mac_data |= BIT(0);
-	ew32(FEXTNVM7, mac_data);
+		/* Cancel disable disconnected cable conditioning
+		 * for Power Gating
+		 */
+		mac_data = er32(DPGFR);
+		mac_data &= ~BIT(2);
+		ew32(DPGFR, mac_data);
 
-	/* Disable mPHY power gating for any link and speed */
-	mac_data = er32(FEXTNVM8);
-	mac_data &= ~BIT(9);
-	ew32(FEXTNVM8, mac_data);
+		/* Disable the Dynamic Clock Gating in the DMA and MAC */
+		mac_data = er32(CTRL_EXT);
+		mac_data &= 0xFFF7FFFF;
+		ew32(CTRL_EXT, mac_data);
 
-	/* Disable K1 off */
-	mac_data = er32(FEXTNVM6);
-	mac_data &= ~BIT(31);
-	ew32(FEXTNVM6, mac_data);
+		/* Revert the lanphypc logic to use the internal Gbe counter
+		 * and not the PMC counter
+		 */
+		mac_data = er32(FEXTNVM5);
+		mac_data &= 0xFFFFFF7F;
+		ew32(FEXTNVM5, mac_data);
 
-	/* Disable Ungate PGCB clock */
-	mac_data = er32(FEXTNVM9);
-	mac_data |= BIT(28);
-	ew32(FEXTNVM9, mac_data);
+		/* Enable the periodic inband message,
+		 * Request PCIe clock in K1 page770_17[10:9] =01b
+		 */
+		e1e_rphy(hw, HV_PM_CTRL, &phy_data);
+		phy_data &= 0xFBFF;
+		phy_data |= HV_PM_CTRL_K1_CLK_REQ;
+		e1e_wphy(hw, HV_PM_CTRL, phy_data);
 
-	/* Cancel not waking from dynamic
-	 * Power Gating with clock request
-	 */
-	mac_data = er32(FEXTNVM12);
-	mac_data &= ~BIT(12);
-	ew32(FEXTNVM12, mac_data);
+		/* Return back configuration
+		 * 772_29[5] = 0 CS_Mode_Stay_In_K1
+		 */
+		e1e_rphy(hw, I217_CGFREG, &phy_data);
+		phy_data &= 0xFFDF;
+		e1e_wphy(hw, I217_CGFREG, phy_data);
 
-	/* Cancel disable disconnected cable conditioning
-	 * for Power Gating
-	 */
-	mac_data = er32(DPGFR);
-	mac_data &= ~BIT(2);
-	ew32(DPGFR, mac_data);
+		/* Change the MAC/PHY interface to Kumeran
+		 * Unforce the SMBus in PHY page769_23[0] = 0
+		 * Unforce the SMBus in MAC CTRL_EXT[11] = 0
+		 */
+		e1e_rphy(hw, CV_SMB_CTRL, &phy_data);
+		phy_data &= ~CV_SMB_CTRL_FORCE_SMBUS;
+		e1e_wphy(hw, CV_SMB_CTRL, phy_data);
+		mac_data = er32(CTRL_EXT);
+		mac_data &= ~E1000_CTRL_EXT_FORCE_SMBUS;
+		ew32(CTRL_EXT, mac_data);
+	}
 
 	/* Disable Dynamic Power Gating */
 	mac_data = er32(CTRL_EXT);
 	mac_data &= 0xFFFFFFF7;
 	ew32(CTRL_EXT, mac_data);
 
-	/* Disable the Dynamic Clock Gating in the DMA and MAC */
-	mac_data = er32(CTRL_EXT);
-	mac_data &= 0xFFF7FFFF;
-	ew32(CTRL_EXT, mac_data);
-
-	/* Revert the lanphypc logic to use the internal Gbe counter
-	 * and not the PMC counter
-	 */
-	mac_data = er32(FEXTNVM5);
-	mac_data &= 0xFFFFFF7F;
-	ew32(FEXTNVM5, mac_data);
-
-	/* Enable the periodic inband message,
-	 * Request PCIe clock in K1 page770_17[10:9] =01b
-	 */
-	e1e_rphy(hw, HV_PM_CTRL, &phy_data);
-	phy_data &= 0xFBFF;
-	phy_data |= HV_PM_CTRL_K1_CLK_REQ;
-	e1e_wphy(hw, HV_PM_CTRL, phy_data);
-
-	/* Return back configuration
-	 * 772_29[5] = 0 CS_Mode_Stay_In_K1
-	 */
-	e1e_rphy(hw, I217_CGFREG, &phy_data);
-	phy_data &= 0xFFDF;
-	e1e_wphy(hw, I217_CGFREG, phy_data);
-
-	/* Change the MAC/PHY interface to Kumeran
-	 * Unforce the SMBus in PHY page769_23[0] = 0
-	 * Unforce the SMBus in MAC CTRL_EXT[11] = 0
-	 */
-	e1e_rphy(hw, CV_SMB_CTRL, &phy_data);
-	phy_data &= ~CV_SMB_CTRL_FORCE_SMBUS;
-	e1e_wphy(hw, CV_SMB_CTRL, phy_data);
-	mac_data = er32(CTRL_EXT);
-	mac_data &= ~E1000_CTRL_EXT_FORCE_SMBUS;
-	ew32(CTRL_EXT, mac_data);
+	/* Enable the time synchronization clock */
+	mac_data = er32(FEXTNVM7);
+	mac_data &= ~BIT(31);
+	mac_data |= BIT(0);
+	ew32(FEXTNVM7, mac_data);
 }
 
 static int e1000e_pm_freeze(struct device *dev)
-- 
2.25.1

