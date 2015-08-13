From: Mitch Williams <mitch.a.williams@intel.com>
Date: Thu, 13 Aug 2015 15:11:32 -0700
Subject: [Intel-wired-lan] [next,PATCH] i40evf: tweak init timing
Message-ID: <1439503892-26218-1-git-send-email-mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch tweaks the init timing of the driver just a little bit to
increase stability on load/unload and SR-IOV enable/disable cycles.

First, run the init_task loop a little quicker in order to reduce
overall init time.

Second, stagger the start of the init task based on the device's
PCIe function ID. This lessens the impact on the firmware when a
whole bunch of VFs are initialized simultaneously, e.g. enabling
SR-IOV without the VF driver blacklisted. For single VFs assigned
to VMs this will have no effect as the function ID will always be 0.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2a6063a..59effa4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2300,8 +2300,7 @@ static void i40evf_init_task(struct work_struct *work)
 	}
 	return;
 restart:
-	schedule_delayed_work(&adapter->init_task,
-			      msecs_to_jiffies(50));
+	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(30));
 	return;
 
 err_register:
@@ -2434,7 +2433,8 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->adminq_task, i40evf_adminq_task);
 	INIT_WORK(&adapter->watchdog_task, i40evf_watchdog_task);
 	INIT_DELAYED_WORK(&adapter->init_task, i40evf_init_task);
-	schedule_delayed_work(&adapter->init_task, 10);
+	schedule_delayed_work(&adapter->init_task,
+			      msecs_to_jiffies(5 * (pdev->devfn & 0x07)));
 
 	return 0;
 
-- 
2.4.3

