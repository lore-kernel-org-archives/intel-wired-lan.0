From: Chen Yu <yu.c.chen@intel.com>
Date: Wed, 11 Nov 2020 13:51:49 +0800
Subject: [Intel-wired-lan] [PATCH 3/4][RFC] e1000e: Introduce workqueue to
 disable the power management
In-Reply-To: <cover.1605073208.git.yu.c.chen@intel.com>
References: <cover.1605073208.git.yu.c.chen@intel.com>
Message-ID: <659e3a4977a7d9e1276d06882ea838d27d7c9ff1.1605073208.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce a workqueue to disable the power management of this device.
It is supposed to be triggered when e1000e hardware error is detected
during resume from S3.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
 drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba7a0f8f6937..f50e5716d609 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -309,6 +309,7 @@ struct e1000_adapter {
 	struct work_struct downshift_task;
 	struct work_struct update_phy_task;
 	struct work_struct print_hang_task;
+	struct work_struct pm_remove_task;
 
 	int phy_hang_count;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f7c08426c0d7..45e0b1901440 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6030,6 +6030,16 @@ static void e1000_reset_task(struct work_struct *work)
 	e1000e_reinit_locked(adapter);
 }
 
+static void e1000_pm_remove_task(struct work_struct *work)
+{
+	struct e1000_adapter *adapter;
+	struct device *dev;
+
+	adapter = container_of(work, struct e1000_adapter, pm_remove_task);
+	dev = &adapter->pdev->dev;
+	device_pm_remove(dev);
+}
+
 /**
  * e1000_get_stats64 - Get System Network Statistics
  * @netdev: network interface device structure
@@ -7589,6 +7599,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&adapter->downshift_task, e1000e_downshift_workaround);
 	INIT_WORK(&adapter->update_phy_task, e1000e_update_phy_task);
 	INIT_WORK(&adapter->print_hang_task, e1000_print_hw_hang);
+	INIT_WORK(&adapter->pm_remove_task, e1000_pm_remove_task);
 
 	/* Initialize link parameters. User can change them with ethtool */
 	adapter->hw.mac.autoneg = 1;
@@ -7731,6 +7742,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	cancel_work_sync(&adapter->downshift_task);
 	cancel_work_sync(&adapter->update_phy_task);
 	cancel_work_sync(&adapter->print_hang_task);
+	cancel_work_sync(&adapter->pm_remove_task);
 
 	if (adapter->flags & FLAG_HAS_HW_TIMESTAMP) {
 		cancel_work_sync(&adapter->tx_hwtstamp_work);
-- 
2.17.1

