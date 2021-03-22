From: Yongxin Liu <yongxin.liu@windriver.com>
Date: Mon, 22 Mar 2021 15:14:48 +0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix unbalanced device
 enable/disable in suspend/resume
Message-ID: <20210322071448.12023-1-yongxin.liu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

pci_disable_device() called in __ixgbe_shutdown() decreases
dev->enable_cnt by 1. pci_enable_device_mem() which increases
dev->enable_cnt by 1, was removed from ixgbe_resume() in commit
6f82b2558735 ("ixgbe: use generic power management"). This caused
unbalanced increase/decrease. So add pci_enable_device_mem() back.

Fix the following call trace.

  ixgbe 0000:17:00.1: disabling already-disabled device
  Call Trace:
   __ixgbe_shutdown+0x10a/0x1e0 [ixgbe]
   ixgbe_suspend+0x32/0x70 [ixgbe]
   pci_pm_suspend+0x87/0x160
   ? pci_pm_freeze+0xd0/0xd0
   dpm_run_callback+0x42/0x170
   __device_suspend+0x114/0x460
   async_suspend+0x1f/0xa0
   async_run_entry_fn+0x3c/0xf0
   process_one_work+0x1dd/0x410
   worker_thread+0x34/0x3f0
   ? cancel_delayed_work+0x90/0x90
   kthread+0x14c/0x170
   ? kthread_park+0x90/0x90
   ret_from_fork+0x1f/0x30

Fixes: 6f82b2558735 ("ixgbe: use generic power management")
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9f3f12e2ccf2..b0a8f7a43f06 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6891,6 +6891,11 @@ static int __maybe_unused ixgbe_resume(struct device *dev_d)
 
 	adapter->hw.hw_addr = adapter->io_addr;
 
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		e_dev_err("Cannot enable PCI device from suspend\n");
+		return err;
+	}
 	smp_mb__before_atomic();
 	clear_bit(__IXGBE_DISABLED, &adapter->state);
 	pci_set_master(pdev);
-- 
2.14.5

