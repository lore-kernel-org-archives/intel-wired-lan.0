From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Wed, 23 Feb 2022 13:36:56 +0100
Subject: [Intel-wired-lan] [PATCH net v1 2/8] iavf: Add waiting so the port
 is initialized in remove
Message-ID: <20220223123656.29846-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: SlawomirX Laba <slawomirx.laba@intel.com>

There exist races when port is being configured and remove is
triggered.

unregister_netdev is not and can't be called under crit_lock
mutex since it is calling ndo_stop -> iavf_close which requires
this lock. Depending on init state the netdev could be still
unregistered so unregister_netdev never cleans up, when shortly
after that the device could become registered.

Make iavf_remove wait until port finishes initialization.
All critical state changes are atomic (under crit_lock).
Crashes that come from iavf_reset_interrupt_capability and
iavf_free_traffic_irqs should now be solved in a graceful
manner.

Fixes: 605ca7c5c6707 ("iavf: Fix kernel BUG in free_msi_irqs")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Phani Burra <phani.r.burra@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 27 ++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 84ae96e..5e71b38e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4558,7 +4558,6 @@ static int __maybe_unused iavf_resume(struct device *dev_d)
 static void iavf_remove(struct pci_dev *pdev)
 {
 	struct iavf_adapter *adapter = iavf_pdev_to_adapter(pdev);
-	enum iavf_state_t prev_state = adapter->last_state;
 	struct net_device *netdev = adapter->netdev;
 	struct iavf_fdir_fltr *fdir, *fdirtmp;
 	struct iavf_vlan_filter *vlf, *vlftmp;
@@ -4568,6 +4567,22 @@ static void iavf_remove(struct pci_dev *pdev)
 	struct iavf_hw *hw = &adapter->hw;
 	int err;
 
+	/* Wait until port initialization is complete.
+	 * There are flows where register/unregister netdev may race.
+	 */
+	while (1) {
+		mutex_lock(&adapter->crit_lock);
+		if (adapter->state == __IAVF_RUNNING ||
+		    adapter->state == __IAVF_DOWN) {
+			mutex_unlock(&adapter->crit_lock);
+			break;
+		}
+
+		mutex_unlock(&adapter->crit_lock);
+		usleep_range(500, 1000);
+	}
+	cancel_delayed_work_sync(&adapter->watchdog_task);
+
 	if (adapter->netdev_registered) {
 		unregister_netdev(netdev);
 		adapter->netdev_registered = false;
@@ -4605,16 +4620,6 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_free_all_rx_resources(adapter);
 	iavf_free_misc_irq(adapter);
 
-	/* In case we enter iavf_remove from erroneous state, free traffic irqs
-	 * here, so as to not cause a kernel crash, when calling
-	 * iavf_reset_interrupt_capability.
-	 */
-	if ((adapter->last_state == __IAVF_RESETTING &&
-	     prev_state != __IAVF_DOWN) ||
-	    (adapter->last_state == __IAVF_RUNNING &&
-	     !(netdev->flags & IFF_UP)))
-		iavf_free_traffic_irqs(adapter);
-
 	iavf_reset_interrupt_capability(adapter);
 	iavf_free_q_vectors(adapter);
 
-- 
2.27.0

