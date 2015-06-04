From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:13:58 -0400
Subject: [Intel-wired-lan] [net-next PATCH 08/11] ixgbe: add support for
 interrupts from X550 external PHY
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001358.18893.44752.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Don Skidmore <dcskidmo@dcs-desk.jf.intel.com>

This patch adds support for receiving interrupts from a external copper
PHY for the X550 part.  This includes enabling, detection as well as
re-enablement.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   32 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 5181a4d..99fb91b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -645,6 +645,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_RSS_FIELD_IPV4_UDP		(u32)(1 << 8)
 #define IXGBE_FLAG2_RSS_FIELD_IPV6_UDP		(u32)(1 << 9)
 #define IXGBE_FLAG2_PTP_PPS_ENABLED		(u32)(1 << 10)
+#define IXGBE_FLAG2_PHY_INTERRUPT		(u32)(1 << 11)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 8f8c5d3..cb80404 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2408,6 +2408,8 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 
 		break;
 	default:
+		if (adapter->hw.mac.type >= ixgbe_mac_X540)
+			return;
 		if (!(eicr & IXGBE_EICR_GPI_SDP0(hw)))
 			return;
 		break;
@@ -2592,6 +2594,8 @@ static inline void ixgbe_irq_enable(struct ixgbe_adapter *adapter, bool queues,
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+		if (adapter->hw.phy.type == ixgbe_phy_x550em_ext_t)
+			mask |= IXGBE_EICR_GPI_SDP0_X540;
 		mask |= IXGBE_EIMS_ECC;
 		mask |= IXGBE_EIMS_MAILBOX;
 		break;
@@ -2646,6 +2650,13 @@ static irqreturn_t ixgbe_msix_other(int irq, void *data)
 	case ixgbe_mac_X540:
 	case ixgbe_mac_X550:
 	case ixgbe_mac_X550EM_x:
+		if (hw->phy.type == ixgbe_phy_x550em_ext_t &&
+		    (eicr & IXGBE_EICR_GPI_SDP0_X540)) {
+			adapter->flags2 |= IXGBE_FLAG2_PHY_INTERRUPT;
+			ixgbe_service_event_schedule(adapter);
+			IXGBE_WRITE_REG(hw, IXGBE_EICR,
+					IXGBE_EICR_GPI_SDP0_X540);
+		}
 		if (eicr & IXGBE_EICR_ECC) {
 			e_info(link, "Received ECC Err, initiating reset\n");
 			adapter->flags2 |= IXGBE_FLAG2_RESET_REQUESTED;
@@ -6757,6 +6768,26 @@ static void ixgbe_service_timer(unsigned long data)
 	ixgbe_service_event_schedule(adapter);
 }
 
+static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 status;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
+		return;
+
+	adapter->flags2 &= ~IXGBE_FLAG2_PHY_INTERRUPT;
+
+	if (!hw->phy.ops.handle_lasi)
+		return;
+
+	status = hw->phy.ops.handle_lasi(&adapter->hw);
+	if (status != IXGBE_ERR_OVERTEMP)
+		return;
+
+	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+}
+
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 {
 	if (!(adapter->flags2 & IXGBE_FLAG2_RESET_REQUESTED))
@@ -6798,6 +6829,7 @@ static void ixgbe_service_task(struct work_struct *work)
 		return;
 	}
 	ixgbe_reset_subtask(adapter);
+	ixgbe_phy_interrupt_subtask(adapter);
 	ixgbe_sfp_detection_subtask(adapter);
 	ixgbe_sfp_link_config_subtask(adapter);
 	ixgbe_check_overtemp_subtask(adapter);

