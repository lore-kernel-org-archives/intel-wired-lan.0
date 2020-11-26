From: Chen Yu <yu.c.chen@intel.com>
Date: Thu, 26 Nov 2020 14:14:58 +0800
Subject: [Intel-wired-lan] [PATCH 2/2][v2] e1000e: Remove the runtime
 suspend restriction on CNP+
In-Reply-To: <cover.1606370334.git.yu.c.chen@intel.com>
References: <cover.1606370334.git.yu.c.chen@intel.com>
Message-ID: <8d92dd25b45f711708701e11d6cf4e4d41b2bddc.1606370334.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Although there is platform issue of runtime suspend support
on CNP, it would be more flexible to let the user decide whether
to disable runtime or not because:
1. This can be done in userspace via
   echo on > /sys/devices/pci0000\:00/0000\:00\:1f.d/power/control
2. More and more NICs would support runtime suspend, disabling the
   runtime suspend on them by default would impact the validation.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e32d443feb24..2850535db7a1 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7684,7 +7684,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
 				DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME);
 
-	if (pci_dev_run_wake(pdev) && hw->mac.type < e1000_pch_cnp)
+	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
 	return 0;
-- 
2.17.1

