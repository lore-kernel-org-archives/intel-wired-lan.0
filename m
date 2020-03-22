From: Tsai, Rex <rex.tsai@intel.com>
Date: Sun, 22 Mar 2020 00:10:15 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1
 Carbon 7th
In-Reply-To: <20200319052629.7282-1-kai.heng.feng@canonical.com>
References: <20200319052629.7282-1-kai.heng.feng@canonical.com>
Message-ID: <D83742F1B1819A43B1E71852F964BF245D763260@PGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Kai-Heng,
I will take over here. When do you have a chance to talk this issue next week?

Rex Tsai | Intel Client LAN Engineer | +1 (503) 264-0517

-----Original Message-----
From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Kai-Heng Feng
Sent: Wednesday, March 18, 2020 10:26 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; Kai-Heng Feng <kai.heng.feng@canonical.com>; moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; David S. Miller <davem@davemloft.net>; open list <linux-kernel@vger.kernel.org>
Subject: [Intel-wired-lan] [PATCH 1/1] e1000e: Disable s0ix flow for X1 Carbon 7th

The s0ix flow makes X1 Carbon 7th can only run S2Idle for only once.

Temporarily disable it until Intel found a solution.

Link:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20200316/0192
22.html
BugLink: https://bugs.launchpad.net/bugs/1865570
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
b/drivers/net/ethernet/intel/e1000e/netdev.c
index db4ea58bac82..3e090aa993ee 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/aer.h>
 #include <linux/prefetch.h>
+#include <linux/dmi.h>
 
 #include "e1000.h"
 
@@ -6843,6 +6844,17 @@ static int __e1000_resume(struct pci_dev *pdev)  }
 
 #ifdef CONFIG_PM_SLEEP
+static const struct dmi_system_id s0ix_blacklist[] = {
+	{
+		.ident = "LENOVO ThinkPad X1 Carbon 7th",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X1 Carbon
7th"),
+		},
+	},
+	{}
+};
+
 static int e1000e_pm_suspend(struct device *dev)  {
 	struct net_device *netdev = pci_get_drvdata(to_pci_dev(dev)); @@ -6860,7 +6872,7 @@ static int e1000e_pm_suspend(struct device *dev)
 		e1000e_pm_thaw(dev);
 
 	/* Introduce S0ix implementation */
-	if (hw->mac.type >= e1000_pch_cnp)
+	if (hw->mac.type >= e1000_pch_cnp &&
!dmi_check_system(s0ix_blacklist))
 		e1000e_s0ix_entry_flow(adapter);
 
 	return rc;
@@ -6875,7 +6887,7 @@ static int e1000e_pm_resume(struct device *dev)
 	int rc;
 
 	/* Introduce S0ix implementation */
-	if (hw->mac.type >= e1000_pch_cnp)
+	if (hw->mac.type >= e1000_pch_cnp &&
!dmi_check_system(s0ix_blacklist))
 		e1000e_s0ix_exit_flow(adapter);
 
 	rc = __e1000_resume(pdev);
--
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
