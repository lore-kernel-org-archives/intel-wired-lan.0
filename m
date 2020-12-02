From: Mario Limonciello <mario.limonciello@dell.com>
Date: Wed,  2 Dec 2020 10:17:46 -0600
Subject: [Intel-wired-lan] [PATCH v2 3/5] e1000e: Add Dell's Comet Lake
 systems into s0ix heuristics
In-Reply-To: <20201202161748.128938-1-mario.limonciello@dell.com>
References: <20201202161748.128938-1-mario.limonciello@dell.com>
Message-ID: <20201202161748.128938-4-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dell's Comet Lake Latitude and Precision systems containing i219LM are
properly configured and should use the s0ix flows.

Tested-by: Yijun Shen <yijun.shen@dell.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/ethernet/intel/e1000e/s0ix.c | 33 +++++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/s0ix.c b/drivers/net/ethernet/intel/e1000e/s0ix.c
index c3013edbd9e4..74043e80c32f 100644
--- a/drivers/net/ethernet/intel/e1000e/s0ix.c
+++ b/drivers/net/ethernet/intel/e1000e/s0ix.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 1999 - 2018 Intel Corporation. */
+/* Copyright(c) 1999 - 2018 Intel Corporation.
+ * Copyright(c) 2020 Dell Inc.
+ */
 
 #include <linux/netdevice.h>
 
@@ -44,6 +46,26 @@ static bool e1000e_check_me(u16 device_id)
 	return false;
 }
 
+static bool e1000e_check_subsystem_allowlist(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL) {
+		switch (dev->subsystem_device) {
+		case 0x099f: /* Latitude 5310 */
+		case 0x09a0: /* Latitude 5410 */
+		case 0x09c9: /* Latitude 5410 */
+		case 0x09a1: /* Latitude 5510 */
+		case 0x09a2: /* Precision 3550 */
+		case 0x09c0: /* Latitude 5411 */
+		case 0x09c1: /* Latitude 5511 */
+		case 0x09c2: /* Precision 3551 */
+		case 0x09c3: /* Precision 7550 */
+		case 0x09c4: /* Precision 7750 */
+			return true;
+		}
+	}
+	return false;
+}
+
 void e1000e_s0ix_entry_flow(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
@@ -273,8 +295,11 @@ void e1000e_maybe_enable_s0ix(struct e1000_adapter *adapter)
 	/* require cannon point or later */
 	if (hw->mac.type < e1000_pch_cnp)
 		return;
-	/* turn off on ME configurations */
-	if (e1000e_check_me(pdev->device))
-		return;
+	/* check for allowlist of systems */
+	if (!e1000e_check_subsystem_allowlist(pdev)) {
+		/* turn off on ME configurations */
+		if (e1000e_check_me(pdev->device))
+			return;
+	}
 	adapter->flags2 |= FLAG2_ENABLE_S0IX_FLOWS;
 }
-- 
2.25.1

