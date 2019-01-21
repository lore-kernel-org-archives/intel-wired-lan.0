From: Feng Tang <feng.tang@intel.com>
Date: Mon, 21 Jan 2019 16:37:05 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Make driver init async
Message-ID: <1548059825-78171-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When optimizing boot time for a platform with igb module, we found the
igb driver probe will take about 45 ms, make the probe asynchronous
will save quite some time as the init runs in parallel with other
asynchronous drivers.

In theory, this could be applied to some other drivers like igc or
e1000, but we don't have HW to verify that.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 7137e7f..d477253 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -229,6 +229,7 @@ static struct pci_driver igb_driver = {
 	.id_table = igb_pci_tbl,
 	.probe    = igb_probe,
 	.remove   = igb_remove,
+	.driver.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM
 	.driver.pm = &igb_pm_ops,
 #endif
-- 
2.7.4

