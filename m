From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:44 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 06/13] i40e: Assure that
	adminq is alive in debug mode
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-7-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

When dropping into debug mode in a failed probe, make sure that
the AdminQ is left alive for possible hand debug of driver and
firmware states.

Move the mutex_init calls earlier in probe so that if init fails,
the admin queue interface is still available for debugging purposes.

Testing Hints:
Inject an error into the i40e_probe logic that puts the driver
into debug mode and try some debugfs commands that query the
firmware, such as "dump switch".

Signed-off-by: Nelson, Shannon <shannon.nelson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 260abd8..5d2dba2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10744,6 +10744,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->bus.func = PCI_FUNC(pdev->devfn);
 	pf->instance = pfs_found;
 
+	/* set up the locks for the AQ, do this only once in probe
+	 * and destroy them only once in remove
+	 */
+	mutex_init(&hw->aq.asq_mutex);
+	mutex_init(&hw->aq.arq_mutex);
+
 	if (debug != -1) {
 		pf->msg_enable = pf->hw.debug_mask;
 		pf->msg_enable = debug;
@@ -10789,12 +10795,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* set up a default setting for link flow control */
 	pf->hw.fc.requested_mode = I40E_FC_NONE;
 
-	/* set up the locks for the AQ, do this only once in probe
-	 * and destroy them only once in remove
-	 */
-	mutex_init(&hw->aq.asq_mutex);
-	mutex_init(&hw->aq.arq_mutex);
-
 	err = i40e_init_adminq(hw);
 	if (err) {
 		if (err == I40E_ERR_FIRMWARE_API_VERSION)
@@ -11171,7 +11171,6 @@ err_init_lan_hmc:
 	kfree(pf->qp_pile);
 err_sw_init:
 err_adminq_setup:
-	(void)i40e_shutdown_adminq(hw);
 err_pf_reset:
 	iounmap(hw->hw_addr);
 err_ioremap:
-- 
2.4.3

