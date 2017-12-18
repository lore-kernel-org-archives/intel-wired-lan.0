From: Alice Michael <alice.michael@intel.com>
Date: Mon, 18 Dec 2017 05:16:43 -0500
Subject: [Intel-wired-lan] [next PATCH S83-V5 4/9] i40evf: Don't schedule
 reset_task when device is being removed
Message-ID: <20171218101643.75775-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

When a host disables and enables a PF device, all the associated
VFs are removed and added back in. It also generates a PFR which in turn
resets all the connected VFs. This behaviour is different from that of
Linux guest on Linux host. Hence we end up in a situation where there's
a PFR and device removal at the same time. And watchdog doesn't have a
clue about this and schedules a reset_task. This patch adds code to send
signal to reset_task that the device is currently being removed.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 47040ab..33c0ffc 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -187,6 +187,7 @@ enum i40evf_state_t {
 enum i40evf_critical_section_t {
 	__I40EVF_IN_CRITICAL_TASK,	/* cannot be interrupted */
 	__I40EVF_IN_CLIENT_TASK,
+	__I40EVF_IN_REMOVE_TASK,	/* device being removed */
 };
 
 /* board specific private data structure */
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 6472116..0e5df19 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1803,6 +1803,12 @@ static void i40evf_reset_task(struct work_struct *work)
 	int i = 0, err;
 	bool running;
 
+	/* When device is being removed it doesn't make sense to run the reset
+	 * task, just return in such a case.
+	 */
+	if (test_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section))
+		return;
+
 	while (test_and_set_bit(__I40EVF_IN_CLIENT_TASK,
 				&adapter->crit_section))
 		usleep_range(500, 1000);
@@ -3053,7 +3059,8 @@ static void i40evf_remove(struct pci_dev *pdev)
 	struct i40evf_mac_filter *f, *ftmp;
 	struct i40e_hw *hw = &adapter->hw;
 	int err;
-
+	/* Indicate we are in remove and not to run reset_task */
+	set_bit(__I40EVF_IN_REMOVE_TASK, &adapter->crit_section);
 	cancel_delayed_work_sync(&adapter->init_task);
 	cancel_work_sync(&adapter->reset_task);
 	cancel_delayed_work_sync(&adapter->client_task);
-- 
2.9.5

