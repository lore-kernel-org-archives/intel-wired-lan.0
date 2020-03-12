From: Vitaly Lifshits <vitaly.lifshits@intel.com>
Date: Thu, 12 Mar 2020 13:57:07 +0200
Subject: [Intel-wired-lan] [PATCH v1] e1000e: fix S0ix flows for cable
 connected case
Message-ID: <20200312115707.6534-1-vitaly.lifshits@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Added a fix to S0ix entry and exit flows for TGP and above
MAC types, to the case when the ethernet cable is connected
and the link is up. With that the system is able to reach
SLP_S0 when going to freeze power state.

Change-type: ImplementationChange
Title: e1000e: fix S0ix flows for cable connected case
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 54 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/regs.h   |  3 ++
 2 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 1e1625122596..4b86c14961e8 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6405,6 +6405,31 @@ static void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 	mac_data |= BIT(3);
 	ew32(CTRL_EXT, mac_data);
 
+	/* Disable disconnected cable conditioning for Power Gating */
+	mac_data = er32(DPGFR);
+	mac_data |= BIT(2);
+	ew32(DPGFR, mac_data);
+
+	/* Don't wake from dynamic Power Gating with clock request */
+	mac_data = er32(FEXTNVM12);
+	mac_data |= BIT(12);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Ungate PGCB clock */
+	mac_data = er32(FEXTNVM9);
+	mac_data |= BIT(28);
+	ew32(FEXTNVM9, mac_data);
+
+	/* Enable K1 off to enable mPHY Power Gating */
+	mac_data = er32(FEXTNVM6);
+	mac_data |= BIT(31);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Enable mPHY power gating for any link and speed */
+	mac_data = er32(FEXTNVM8);
+	mac_data |= BIT(9);
+	ew32(FEXTNVM8, mac_data);
+
 	/* Enable the Dynamic Clock Gating in the DMA and MAC */
 	mac_data = er32(CTRL_EXT);
 	mac_data |= E1000_CTRL_EXT_DMA_DYN_CLK_EN;
@@ -6434,6 +6459,35 @@ static void e1000e_s0ix_exit_flow(struct e1000_adapter *adapter)
 	mac_data |= BIT(0);
 	ew32(FEXTNVM7, mac_data);
 
+	/* Disable mPHY power gating for any link and speed */
+	mac_data = er32(FEXTNVM8);
+	mac_data &= ~BIT(9);
+	ew32(FEXTNVM8, mac_data);
+
+	/* Disable K1 off */
+	mac_data = er32(FEXTNVM6);
+	mac_data &= ~BIT(31);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Disable Ungate PGCB clock */
+	mac_data = er32(FEXTNVM9);
+	mac_data &= ~BIT(28);
+	ew32(FEXTNVM9, mac_data);
+
+	/* Cancel not waking from dynamic
+	 * Power Gating with clock request
+	 */
+	mac_data = er32(FEXTNVM12);
+	mac_data &= ~BIT(12);
+	ew32(FEXTNVM12, mac_data);
+
+	/* Cancel disable disconnected cable conditioning
+	 * for Power Gating
+	 */
+	mac_data = er32(DPGFR);
+	mac_data &= ~BIT(2);
+	ew32(DPGFR, mac_data);
+
 	/* Disable Dynamic Power Gating */
 	mac_data = er32(CTRL_EXT);
 	mac_data &= 0xFFFFFFF7;
diff --git a/drivers/net/ethernet/intel/e1000e/regs.h b/drivers/net/ethernet/intel/e1000e/regs.h
index df59fd1d660c..04e030b6c4b2 100644
--- a/drivers/net/ethernet/intel/e1000e/regs.h
+++ b/drivers/net/ethernet/intel/e1000e/regs.h
@@ -21,9 +21,12 @@
 #define E1000_FEXTNVM5	0x00014	/* Future Extended NVM 5 - RW */
 #define E1000_FEXTNVM6	0x00010	/* Future Extended NVM 6 - RW */
 #define E1000_FEXTNVM7	0x000E4	/* Future Extended NVM 7 - RW */
+#define E1000_FEXTNVM8  0x5BB0  /* Future Extended NVM 8 - RW */
 #define E1000_FEXTNVM9	0x5BB4	/* Future Extended NVM 9 - RW */
 #define E1000_FEXTNVM11	0x5BBC	/* Future Extended NVM 11 - RW */
+#define E1000_FEXTNVM12 0x5BC0  /* Future Extended NVM 12 - RW */
 #define E1000_PCIEANACFG	0x00F18	/* PCIE Analog Config */
+#define E1000_DPGFR     0x00FAC /* Dynamic Power Gate Force Control Register */
 #define E1000_FCT	0x00030	/* Flow Control Type - RW */
 #define E1000_VET	0x00038	/* VLAN Ether Type - RW */
 #define E1000_ICR	0x000C0	/* Interrupt Cause Read - R/clr */
-- 
2.11.0

