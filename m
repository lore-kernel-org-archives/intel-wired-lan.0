From: Don Skidmore <donald.c.skidmore@intel.com>
Date: Wed, 03 Jun 2015 20:14:03 -0400
Subject: [Intel-wired-lan] [net-next PATCH 09/11] ixgbe: fix issue with sfp
 events with new X550 devices
In-Reply-To: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
References: <20150604001322.18893.48953.stgit@dcs-desk.jf.intel.com>
Message-ID: <20150604001403.18893.91285.stgit@dcs-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add checks for systems that don't have SFP's to avoid incorrectly
acting on interrupts that are falsely interpreted as SFP events.
We do this by updating the ixgbe_is_sfp to be aware of the
new X550 devices.  This also includes a modified check generating
the EICR mask to be more forward-looking.

Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   62 +++++++++++++------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cb80404..cd782b2 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2464,20 +2464,50 @@ static void ixgbe_check_overtemp_event(struct ixgbe_adapter *adapter, u32 eicr)
 	e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
+static inline bool ixgbe_is_sfp(struct ixgbe_hw *hw)
+{
+	switch (hw->mac.type) {
+	case ixgbe_mac_82598EB:
+		if (hw->phy.type == ixgbe_phy_nl)
+			return true;
+		return false;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X550EM_x:
+		switch (hw->mac.ops.get_media_type(hw)) {
+		case ixgbe_media_type_fiber:
+		case ixgbe_media_type_fiber_qsfp:
+			return true;
+		default:
+			return false;
+		}
+	default:
+		return false;
+	}
+}
+
 static void ixgbe_check_sfp_event(struct ixgbe_adapter *adapter, u32 eicr)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 eicr_mask = IXGBE_EICR_GPI_SDP2(hw);
+
+	if (!ixgbe_is_sfp(hw))
+		return;
+
+	/* Later MAC's use different SDP */
+	if (hw->mac.type >= ixgbe_mac_X540)
+		eicr_mask = IXGBE_EICR_GPI_SDP0_X540;
 
-	if (eicr & IXGBE_EICR_GPI_SDP2(hw)) {
+	if (eicr & eicr_mask) {
 		/* Clear the interrupt */
-		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP2(hw));
+		IXGBE_WRITE_REG(hw, IXGBE_EICR, eicr_mask);
 		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
 			adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
 			ixgbe_service_event_schedule(adapter);
 		}
 	}
 
-	if (eicr & IXGBE_EICR_GPI_SDP1(hw)) {
+	if (adapter->hw.mac.type == ixgbe_mac_82599EB &&
+	    (eicr & IXGBE_EICR_GPI_SDP1(hw))) {
 		/* Clear the interrupt */
 		IXGBE_WRITE_REG(hw, IXGBE_EICR, IXGBE_EICR_GPI_SDP1(hw));
 		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
@@ -4738,32 +4768,6 @@ static void ixgbe_configure(struct ixgbe_adapter *adapter)
 	ixgbe_configure_dfwd(adapter);
 }
 
-static inline bool ixgbe_is_sfp(struct ixgbe_hw *hw)
-{
-	switch (hw->phy.type) {
-	case ixgbe_phy_sfp_avago:
-	case ixgbe_phy_sfp_ftl:
-	case ixgbe_phy_sfp_intel:
-	case ixgbe_phy_sfp_unknown:
-	case ixgbe_phy_sfp_passive_tyco:
-	case ixgbe_phy_sfp_passive_unknown:
-	case ixgbe_phy_sfp_active_unknown:
-	case ixgbe_phy_sfp_ftl_active:
-	case ixgbe_phy_qsfp_passive_unknown:
-	case ixgbe_phy_qsfp_active_unknown:
-	case ixgbe_phy_qsfp_intel:
-	case ixgbe_phy_qsfp_unknown:
-	/* ixgbe_phy_none is set when no SFP module is present */
-	case ixgbe_phy_none:
-		return true;
-	case ixgbe_phy_nl:
-		if (hw->mac.type == ixgbe_mac_82598EB)
-			return true;
-	default:
-		return false;
-	}
-}
-
 /**
  * ixgbe_sfp_link_config - set up SFP+ link
  * @adapter: pointer to private adapter struct

