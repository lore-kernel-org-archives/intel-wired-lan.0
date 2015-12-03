From: Aaron Sierra <asierra@xes-inc.com>
Date: Thu, 3 Dec 2015 13:43:41 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH v2] igb: Add I210 cable fault detection to
	self test
In-Reply-To: <494008248.99336.1449171467578.JavaMail.zimbra@xes-inc.com>
Message-ID: <27181503.100057.1449171821628.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Joe Schultz <jschultz@xes-inc.com>

Add an offline diagnostic test for the I210 internal PHY which checks
for cable faults and reports the distance along the cable where the
fault was detected. Fault types detected include open, short, and
cross-pair short.

Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 v2 - account for changes made by this patch in dev-queue:
   drivers/net: get rid of unnecessary initializations in .get_drvinfo()

 drivers/net/ethernet/intel/igb/e1000_defines.h |  13 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c   | 189 ++++++++++++++++++++++++-
 2 files changed, 197 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 240902e..d18a6d0 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -932,6 +932,7 @@
 #define I347AT4_PCDL1                  0x11 /* Pair 1 PHY Cable Diagnostics Length */
 #define I347AT4_PCDL2                  0x12 /* Pair 2 PHY Cable Diagnostics Length */
 #define I347AT4_PCDL3                  0x13 /* Pair 3 PHY Cable Diagnostics Length */
+#define I347AT4_PCDR                   0x14 /* PHY Cable Diagnostics Results */
 #define I347AT4_PCDC                   0x15 /* PHY Cable Diagnostics Control */
 #define I347AT4_PAGE_SELECT            0x16
 
@@ -952,7 +953,17 @@
 #define I347AT4_PSCR_DOWNSHIFT_8X     0x7000
 
 /* i347-AT4 PHY Cable Diagnostics Control */
-#define I347AT4_PCDC_CABLE_LENGTH_UNIT 0x0400 /* 0=cm 1=meters */
+#define I347AT4_PCDC_CABLE_LENGTH_UNIT	0x0400 /* 0=cm 1=meters */
+#define I347AT4_PCDC_CABLE_DIAG_STATUS	0x0800
+#define I347AT4_PCDC_DISABLE_CROSS_PAIR	0x2000
+#define I347AT4_PCDC_RUN_AT_AUTONEG	0x4000
+#define I347AT4_PCDC_RUN_TEST		0x8000
+
+/* i347-AT4 PHY Cable Diagnostics Results */
+#define I347AT4_PCDR_CABLE_OK		0x0001 /* No faults detected on pair */
+#define I347AT4_PCDR_CABLE_OPEN		0x0002 /* Open pair detected */
+#define I347AT4_PCDR_CABLE_SHORT	0x0003 /* Shorted pair detected */
+#define I347AT4_PCDR_CABLE_CROSS_SHORT	0x0004 /* Cross-pair short detected */
 
 /* Marvell 1112 only registers */
 #define M88E1112_VCT_DSP_DISTANCE       0x001A
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 1d329f1..066cc73 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -132,7 +132,28 @@ enum igb_diagnostics_results {
 	TEST_EEP,
 	TEST_IRQ,
 	TEST_LOOP,
-	TEST_LINK
+	TEST_LINK,
+	/* I210 superset */
+	TEST_FAULT_A,
+	TEST_FAULT_B,
+	TEST_FAULT_C,
+	TEST_FAULT_D,
+	TEST_LENGTH_A,
+	TEST_LENGTH_B,
+	TEST_LENGTH_C,
+	TEST_LENGTH_D,
+	TEST_OPEN_A,
+	TEST_OPEN_B,
+	TEST_OPEN_C,
+	TEST_OPEN_D,
+	TEST_SHORT_A,
+	TEST_SHORT_B,
+	TEST_SHORT_C,
+	TEST_SHORT_D,
+	TEST_CROSS_A,
+	TEST_CROSS_B,
+	TEST_CROSS_C,
+	TEST_CROSS_D
 };
 
 static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
@@ -142,7 +163,50 @@ static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
 	[TEST_LOOP] = "Loopback test  (offline)",
 	[TEST_LINK] = "Link test   (on/offline)"
 };
+
+static const char igb_i210_gstrings_test[][ETH_GSTRING_LEN] = {
+	[TEST_REG]	= "Register test        (offline)",
+	[TEST_EEP]	= "Eeprom test          (offline)",
+	[TEST_IRQ]	= "Interrupt test       (offline)",
+	[TEST_LOOP]	= "Loopback test        (offline)",
+	[TEST_LINK]	= "Link test         (on/offline)",
+	[TEST_FAULT_A]  = "Pair A cable fault   (offline)",
+	[TEST_FAULT_B]  = "Pair B cable fault   (offline)",
+	[TEST_FAULT_C]  = "Pair C cable fault   (offline)",
+	[TEST_FAULT_D]  = "Pair D cable fault   (offline)",
+	[TEST_LENGTH_A] = "Pair A fault distance         ",
+	[TEST_LENGTH_B] = "Pair B fault distance         ",
+	[TEST_LENGTH_C] = "Pair C fault distance         ",
+	[TEST_LENGTH_D] = "Pair D fault distance         ",
+	[TEST_OPEN_A]   = "Pair A fault open             ",
+	[TEST_OPEN_B]   = "Pair B fault open             ",
+	[TEST_OPEN_C]   = "Pair C fault open             ",
+	[TEST_OPEN_D]   = "Pair D fault open             ",
+	[TEST_SHORT_A]  = "Pair A fault intra-pair short ",
+	[TEST_SHORT_B]  = "Pair B fault intra-pair short ",
+	[TEST_SHORT_C]  = "Pair C fault intra-pair short ",
+	[TEST_SHORT_D]  = "Pair D fault intra-pair short ",
+	[TEST_CROSS_A]  = "Pair A fault inter-pair short ",
+	[TEST_CROSS_B]  = "Pair B fault inter-pair short ",
+	[TEST_CROSS_C]  = "Pair C fault inter-pair short ",
+	[TEST_CROSS_D]  = "Pair D fault inter-pair short "
+};
+
 #define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
+#define IGB_I210_TEST_LEN (sizeof(igb_i210_gstrings_test) / ETH_GSTRING_LEN)
+
+static inline bool igb_has_i210_cable_fault_test(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+
+	if (hw->phy.media_type != e1000_media_type_copper)
+		return false;
+
+	if (hw->phy.id == I210_I_PHY_ID)
+		return true;
+
+	return false;
+}
 
 static int igb_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
 {
@@ -1983,6 +2047,104 @@ static int igb_link_test(struct igb_adapter *adapter, u64 *data)
 	return *data;
 }
 
+static int igb_cable_fault_test_prep(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	u16 pcdc;
+	s32 ret_val;
+
+	ret_val = igb_write_phy_reg(hw, I347AT4_PAGE_SELECT, 0x7);
+	if (ret_val)
+		goto done;
+
+	/* Initiate diagnostics at next auto-negotiation */
+	pcdc = I347AT4_PCDC_CABLE_LENGTH_UNIT |
+		I347AT4_PCDC_RUN_AT_AUTONEG;
+
+	ret_val = igb_write_phy_reg(hw, I347AT4_PCDC, pcdc);
+
+done:
+	igb_write_phy_reg(hw, I347AT4_PAGE_SELECT, 0);
+	return ret_val;
+}
+
+static int igb_cable_fault_test(struct igb_adapter *adapter,
+			   struct ethtool_test *eth_test, u64 *data) {
+	struct e1000_hw *hw = &adapter->hw;
+	u16 pcdc, pcdr;
+	u16 error_code = 0;
+	u32 timeout = 0;
+	s32 ret_val;
+	int i;
+
+	ret_val = igb_write_phy_reg(hw, I347AT4_PAGE_SELECT, 0x7);
+	if (ret_val)
+		goto done;
+
+	ret_val = igb_write_phy_reg(hw, I347AT4_PCDC, pcdc);
+	if (ret_val)
+		goto done;
+
+	/* Wait up to 1.5s for the results to be ready */
+	while (pcdc & I347AT4_PCDC_CABLE_DIAG_STATUS) {
+		ret_val = igb_read_phy_reg(hw, I347AT4_PCDC, &pcdc);
+		if (ret_val || timeout == 1500)
+			break;
+		udelay(1000);
+		timeout++;
+	}
+
+	if (timeout >= 1500)
+		dev_warn(&adapter->pdev->dev,
+			"Cable fault test timed out. Results may be invalid");
+
+	ret_val = igb_read_phy_reg(hw, I347AT4_PCDR, &pcdr);
+	if (ret_val)
+		goto done;
+
+	hw->phy.ops.get_cable_length(hw);
+
+	/* Iterate over each cable pair */
+	for (i = 0; i < 4; i++) {
+		data[TEST_LENGTH_A + i] = hw->phy.pair_length[i];
+
+		error_code = (pcdr >> (i * 4)) & 0xf;
+		switch (error_code) {
+		case I347AT4_PCDR_CABLE_OK:
+			data[TEST_FAULT_A + i] = 0;
+			data[TEST_LENGTH_A + i] = -1;
+			/* don't assign ret_val */
+			break;
+		case I347AT4_PCDR_CABLE_OPEN:
+			data[TEST_FAULT_A + i] = 1;
+			data[TEST_OPEN_A + i] = 1;
+			ret_val = -1;
+			break;
+		case I347AT4_PCDR_CABLE_SHORT:
+			data[TEST_FAULT_A + i] = 1;
+			data[TEST_SHORT_A + i] = 1;
+			ret_val = -1;
+			break;
+		case I347AT4_PCDR_CABLE_CROSS_SHORT:
+			data[TEST_FAULT_A + i] = 1;
+			data[TEST_CROSS_A + i] = 1;
+			ret_val = -1;
+			break;
+		default:
+			data[TEST_FAULT_A + i] = -1;
+			data[TEST_LENGTH_A + i] = -1;
+			data[TEST_OPEN_A + i] = -1;
+			data[TEST_SHORT_A + i] = -1;
+			data[TEST_CROSS_A + i] = -1;
+			ret_val = -1;
+		}
+	}
+
+done:
+	igb_write_phy_reg(hw, I347AT4_PAGE_SELECT, 0);
+	return ret_val;
+}
+
 static void igb_diag_test(struct net_device *netdev,
 			  struct ethtool_test *eth_test, u64 *data)
 {
@@ -1993,6 +2155,11 @@ static void igb_diag_test(struct net_device *netdev,
 
 	set_bit(__IGB_TESTING, &adapter->state);
 
+	if (igb_has_i210_cable_fault_test(adapter)) {
+		memset(&data[TEST_FAULT_A], 0x0,
+			sizeof(u64) * (IGB_I210_TEST_LEN - IGB_TEST_LEN));
+	}
+
 	/* can't do offline tests on media switching devices */
 	if (adapter->hw.dev_spec._82575.mas_capable)
 		eth_test->flags &= ~ETH_TEST_FL_OFFLINE;
@@ -2009,12 +2176,21 @@ static void igb_diag_test(struct net_device *netdev,
 		/* power up link for link test */
 		igb_power_up_link(adapter);
 
+		if (igb_has_i210_cable_fault_test(adapter))
+			igb_cable_fault_test_prep(adapter);
+
 		/* Link test performed before hardware reset so autoneg doesn't
 		 * interfere with test result
 		 */
 		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
+		/* Test for cable faults before the PHY gets shut off */
+		if (igb_has_i210_cable_fault_test(adapter)) {
+			if (igb_cable_fault_test(adapter, eth_test, data))
+				eth_test->flags |= ETH_TEST_FL_FAILED;
+		}
+
 		if (if_running)
 			/* indicate we're in test mode */
 			dev_close(netdev);
@@ -2270,7 +2446,8 @@ static int igb_get_sset_count(struct net_device *netdev, int sset)
 	case ETH_SS_STATS:
 		return IGB_STATS_LEN;
 	case ETH_SS_TEST:
-		return IGB_TEST_LEN;
+		return igb_has_i210_cable_fault_test(netdev_priv(netdev)) ?
+			IGB_I210_TEST_LEN : IGB_TEST_LEN;
 	default:
 		return -ENOTSUPP;
 	}
@@ -2340,8 +2517,12 @@ static void igb_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-		memcpy(data, *igb_gstrings_test,
-			IGB_TEST_LEN*ETH_GSTRING_LEN);
+		if (igb_has_i210_cable_fault_test(adapter))
+			memcpy(data, *igb_i210_gstrings_test,
+				IGB_I210_TEST_LEN*ETH_GSTRING_LEN);
+		else
+			memcpy(data, *igb_gstrings_test,
+				IGB_TEST_LEN*ETH_GSTRING_LEN);
 		break;
 	case ETH_SS_STATS:
 		for (i = 0; i < IGB_GLOBAL_STATS_LEN; i++) {
-- 
1.9.1
