From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 11 Dec 2018 15:59:37 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Exclude device from suspend
 direct complete optimization
Message-ID: <20181211075938.32026-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

e1000e sets different WoL settings in system suspend callback and
runtime suspend callback.

The suspend direct complete optimization leaves e1000e in runtime
suspneded state with wrong WoL setting during system suspend.

To fix this, we need to disable suspend direct complete optimization to
let e1000e always use suspend callback to set correct WoL during system
suspend.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index e434a6a64966..4a22390f9f49 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7351,6 +7351,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	e1000_print_device_info(adapter);
 
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
+
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
 
-- 
2.17.1

