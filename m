From: Mario Limonciello <mario.limonciello@dell.com>
Date: Sun, 27 Sep 2020 23:40:23 -0500
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Dell's Comet Lake systems
 into s0ix heuristics
In-Reply-To: <20200928044024.7595-1-mario.limonciello@dell.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
Message-ID: <20200928044024.7595-3-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dell's Comet Lake Latitude and Precision systems containing i219LM are
properly configured and should use the s0ix flows.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/ethernet/intel/Kconfig        |  1 +
 drivers/net/ethernet/intel/e1000e/param.c | 80 ++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 5aa86318ed3e..280af47d74d2 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -58,6 +58,7 @@ config E1000
 config E1000E
 	tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
 	depends on PCI && (!SPARC32 || BROKEN)
+	depends on DMI
 	select CRC32
 	imply PTP_1588_CLOCK
 	help
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index e66b222c824b..58e6718c4f75 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/dmi.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -201,6 +202,80 @@ static const struct e1000e_me_supported me_supported[] = {
 	{0}
 };
 
+static const struct dmi_system_id s0ix_supported_systems[] = {
+	{
+		/* Dell Latitude 5310 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "099F"),
+		},
+	},
+	{
+		/* Dell Latitude 5410 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A0"),
+		},
+	},
+	{
+		/* Dell Latitude 5410 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C9"),
+		},
+	},
+	{
+		/* Dell Latitude 5510 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A1"),
+		},
+	},
+	{
+		/* Dell Precision 3550 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A2"),
+		},
+	},
+	{
+		/* Dell Latitude 5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C0"),
+		},
+	},
+	{
+		/* Dell Latitude 5511 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C1"),
+		},
+	},
+	{
+		/* Dell Precision 3551 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C2"),
+		},
+	},
+	{
+		/* Dell Precision 7550 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C3"),
+		},
+	},
+	{
+		/* Dell Precision 7750 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C4"),
+		},
+	},
+	{ }
+};
+
 static bool e1000e_check_me(u16 device_id)
 {
 	struct e1000e_me_supported *id;
@@ -599,8 +674,11 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		}
 
 		if (enabled == S0IX_HEURISTICS) {
+			/* check for allowlist of systems */
+			if (dmi_check_system(s0ix_supported_systems))
+				enabled = S0IX_FORCE_ON;
 			/* default to off for ME configurations */
-			if (e1000e_check_me(hw->adapter->pdev->device))
+			else if (e1000e_check_me(hw->adapter->pdev->device))
 				enabled = S0IX_FORCE_OFF;
 		}
 
-- 
2.25.1

