From: Aaron Sierra <asierra@xes-inc.com>
Date: Tue, 3 Nov 2015 12:37:29 -0600 (CST)
Subject: [Intel-wired-lan] [PATCH 4/5] igb: Explicitly label self-test
	result indices
In-Reply-To: <1888067736.304762.1446575427308.JavaMail.zimbra@xes-inc.com>
Message-ID: <2113406542.305783.1446575849467.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Joe Schultz <jschultz@xes-inc.com>

Previously, the ethtool self-test gstrings/data arrays were accessed via
hardcoded indices, which made the code difficult to follow. This patch
replaces the hardcoded values with enum-based labels.

Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 38 ++++++++++++++++++----------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 7426276..f5da885 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -127,10 +127,20 @@ static const struct igb_stats igb_gstrings_net_stats[] = {
 #define IGB_STATS_LEN \
 	(IGB_GLOBAL_STATS_LEN + IGB_NETDEV_STATS_LEN + IGB_QUEUE_STATS_LEN)
 
+enum igb_diagnostics_results {
+	TEST_REG = 0,
+	TEST_EEP,
+	TEST_IRQ,
+	TEST_LOOP,
+	TEST_LINK
+};
+
 static const char igb_gstrings_test[][ETH_GSTRING_LEN] = {
-	"Register test  (offline)", "Eeprom test    (offline)",
-	"Interrupt test (offline)", "Loopback test  (offline)",
-	"Link test   (on/offline)"
+	[TEST_REG]  = "Register test  (offline)",
+	[TEST_EEP]  = "Eeprom test    (offline)",
+	[TEST_IRQ]  = "Interrupt test (offline)",
+	[TEST_LOOP] = "Loopback test  (offline)",
+	[TEST_LINK] = "Link test   (on/offline)"
 };
 #define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
 
@@ -2006,7 +2016,7 @@ static void igb_diag_test(struct net_device *netdev,
 		/* Link test performed before hardware reset so autoneg doesn't
 		 * interfere with test result
 		 */
-		if (igb_link_test(adapter, &data[4]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		if (if_running)
@@ -2015,21 +2025,21 @@ static void igb_diag_test(struct net_device *netdev,
 		else
 			igb_reset(adapter);
 
-		if (igb_reg_test(adapter, &data[0]))
+		if (igb_reg_test(adapter, &data[TEST_REG]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		igb_reset(adapter);
-		if (igb_eeprom_test(adapter, &data[1]))
+		if (igb_eeprom_test(adapter, &data[TEST_EEP]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		igb_reset(adapter);
-		if (igb_intr_test(adapter, &data[2]))
+		if (igb_intr_test(adapter, &data[TEST_IRQ]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		igb_reset(adapter);
 		/* power up link for loopback test */
 		igb_power_up_link(adapter);
-		if (igb_loopback_test(adapter, &data[3]))
+		if (igb_loopback_test(adapter, &data[TEST_LOOP]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 
 		/* restore speed, duplex, autoneg settings */
@@ -2049,16 +2059,16 @@ static void igb_diag_test(struct net_device *netdev,
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
 		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[4]))
+		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
 		else
-			data[4] = 0;
+			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
-		data[0] = 0;
-		data[1] = 0;
-		data[2] = 0;
-		data[3] = 0;
+		data[TEST_REG] = 0;
+		data[TEST_EEP] = 0;
+		data[TEST_IRQ] = 0;
+		data[TEST_LOOP] = 0;
 
 		clear_bit(__IGB_TESTING, &adapter->state);
 	}
-- 
1.9.1

