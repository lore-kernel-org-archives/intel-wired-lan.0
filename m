From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Jun 2015 15:00:51 -0700
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: disable service task during
	suspend
Message-ID: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The service task reads some registers as part of its normal routine,
even while the interface is down. Normally this is ok. However, during
suspend we have disabled the PCI device. Due to this, registers will
read in the same way as a surprise-remove event. Disable the service
task while we suspend, and re-enable it after we resume. If we don't do
this, the device could be UP when you suspend and come back from resume
as closed (since fm10k closes the device when it gets a surprise
remove).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 0381c8d192aa..c7ffb2635f92 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1983,6 +1983,16 @@ static int fm10k_resume(struct pci_dev *pdev)
 	if (err)
 		return err;
 
+	/* assume host is not ready, to prevent race with watchdog incase we
+	 * actually don't have connection to the switch
+	 */
+	interface->host_ready = false;
+	fm10k_watchdog_host_not_ready(interface);
+
+	/* clear the service task disable bit to allow service task to start */
+	clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
+	fm10k_service_event_schedule(interface);
+
 	/* restore SR-IOV interface */
 	fm10k_iov_resume(pdev);
 
@@ -2010,6 +2020,15 @@ static int fm10k_suspend(struct pci_dev *pdev,
 
 	fm10k_iov_suspend(pdev);
 
+	/* the watchdog tasks may read registers, which will appear like a
+	 * surprise-remove event once the PCI device is disabled. This will
+	 * cause us to close the netdevice, so we don't retain the open/closed
+	 * state post-resume. Prevent this by disabling the service task while
+	 * suspended, until we actually resume.
+	 */
+	set_bit(__FM10K_SERVICE_DISABLE, &interface->state);
+	cancel_work_sync(&interface->service_task);
+
 	rtnl_lock();
 
 	if (netif_running(netdev))
-- 
2.4.2

