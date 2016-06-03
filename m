From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:21 -0700
Subject: [Intel-wired-lan] [PATCH v1 11/18] fm10k: implement prepare_suspend
	and handle_resume
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Implement fm10k_prepare_suspend and fm10k_handle_resume functions which
abstract around the now existing fm10k_prepare_for_reset and
fm10k_handle_reset. The new functions also handle stopping the service
task, which is something that the original re-init flow does not need.

Every other location that does a suspend/resume type flow is expected to
use these functions, because otherwise they may have conflicts with the
running watchdog routines. This also has the effect of preventing
possible surprise remove events during handling of FLR events and PCIe
errors.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 95a654adca84..ab26bfa0a342 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2107,6 +2107,44 @@ static void fm10k_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static void fm10k_prepare_suspend(struct fm10k_intfc *interface)
+{
+	/* the watchdog task reads from registers, which might appear like
+	 * a surprise remove if the PCIe device is disabled while we're
+	 * stopped. We stop the watchdog task until after we resume software
+	 * activity.
+	 */
+	set_bit(__FM10K_SERVICE_DISABLE, &interface->state);
+	cancel_work_sync(&interface->service_task);
+
+	fm10k_prepare_for_reset(interface);
+}
+
+static int fm10k_handle_resume(struct fm10k_intfc *interface)
+{
+	struct fm10k_hw *hw = &interface->hw;
+	int err;
+
+	/* reset statistics starting values */
+	hw->mac.ops.rebind_hw_stats(hw, &interface->stats);
+
+	err = fm10k_handle_reset(interface);
+	if (err)
+		return err;
+
+	/* assume host is not ready, to prevent race with watchdog in case we
+	 * actually don't have connection to the switch
+	 */
+	interface->host_ready = false;
+	fm10k_watchdog_host_not_ready(interface);
+
+	/* clear the service task disable bit to allow service task to start */
+	clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
+	fm10k_service_event_schedule(interface);
+
+	return err;
+}
+
 #ifdef CONFIG_PM
 /**
  * fm10k_resume - Restore device to pre-sleep state
-- 
2.8.2.820.gd1c5f70

