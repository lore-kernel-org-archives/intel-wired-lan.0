From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 24 Mar 2020 17:38:20 -0700
Subject: [Intel-wired-lan] [PATCH 06/10] igc: Use netdev log helpers in
 igc_diag.c
In-Reply-To: <20200325003824.5487-1-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
Message-ID: <20200325003824.5487-7-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In igc_diag.c we print log messages using dev_* helpers, generating
inconsistent output with the rest of the driver. Since this is a network
device driver, we should preferably use netdev_* helpers because they
append the interface name to the message, helping making sense out of
the logs.

This patch converts all dev_* calls to netdev_*. It also takes this
opportunity to remove the '\n' character at the end of messages since it
is automatically added by netdev_* log helpers.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_diag.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
index 56acc9b8447e..3532496bae34 100644
--- a/drivers/net/ethernet/intel/igc/igc_diag.c
+++ b/drivers/net/ethernet/intel/igc/igc_diag.c
@@ -46,9 +46,9 @@ static bool reg_pattern_test(struct igc_adapter *adapter, u64 *data, int reg,
 		wr32(reg, test_pattern[pat] & write);
 		val = rd32(reg);
 		if (val != (test_pattern[pat] & write & mask)) {
-			dev_err(&adapter->pdev->dev,
-				"pattern test reg %04X failed: got 0x%08X expected 0x%08X\n",
-				reg, val, test_pattern[pat] & write & mask);
+			netdev_err(adapter->netdev,
+				   "pattern test reg %04X failed: got 0x%08X expected 0x%08X",
+				   reg, val, test_pattern[pat] & write & mask);
 			*data = reg;
 			wr32(reg, before);
 			return true;
@@ -68,9 +68,9 @@ static bool reg_set_and_check(struct igc_adapter *adapter, u64 *data, int reg,
 	wr32(reg, write & mask);
 	val = rd32(reg);
 	if ((write & mask) != (val & mask)) {
-		dev_err(&adapter->pdev->dev,
-			"set/check reg %04X test failed: got 0x%08X expected 0x%08X\n",
-			reg, (val & mask), (write & mask));
+		netdev_err(adapter->netdev,
+			   "set/check reg %04X test failed: got 0x%08X expected 0x%08X",
+			   reg, (val & mask), (write & mask));
 		*data = reg;
 		wr32(reg, before);
 		return true;
@@ -97,9 +97,9 @@ bool igc_reg_test(struct igc_adapter *adapter, u64 *data)
 	wr32(IGC_STATUS, toggle);
 	after = rd32(IGC_STATUS) & toggle;
 	if (value != after) {
-		dev_err(&adapter->pdev->dev,
-			"failed STATUS register test got: 0x%08X expected: 0x%08X\n",
-			after, value);
+		netdev_err(adapter->netdev,
+			   "failed STATUS register test got: 0x%08X expected: 0x%08X",
+			   after, value);
 		*data = 1;
 		return true;
 	}
@@ -207,8 +207,8 @@ int igc_intr_test(struct igc_adapter *adapter, u64 *data)
 		*data = 1;
 		return -1;
 	}
-	dev_info(&adapter->pdev->dev, "testing %s interrupt\n",
-		 (shared_int ? "shared" : "unshared"));
+	netdev_info(adapter->netdev, "testing %s interrupt",
+		    (shared_int ? "shared" : "unshared"));
 
 	/* Disable all the interrupts */
 	wr32(IGC_IMC, ~0);
-- 
2.25.0

