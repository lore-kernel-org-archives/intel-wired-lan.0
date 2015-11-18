From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 18 Nov 2015 15:47:06 -0800
Subject: [Intel-wired-lan] [net PATCH v2] i40e/i40evf: avoid mutex re-init
Message-ID: <1447890426-15471-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the driver were to happen to have a mutex held while
the i40e_init_adminq call was called, the init_adminq might
inadvertently call mutex_init on a lock that was held
which is a violation of the calling semantics.

Fix this by avoiding adminq.c code allocating/freeing this memory, and
then do the same work only once in probe/remove.

Testing Hints (Required if no HSD): for VF, load i40evf in bare metal
and echo 32 > sriov_numvfs; echo 0 > sriov_numvfs in a loop.  Yes this
is a horrible thing to do.

Reported-by: Stefan Assmann <sassmann@redhat.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Ida263c51b34e195252179e7e5e400d73a99be7a2

---

v2: removed old calls to mutex_init that are no longer necessary
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c   |  6 ------
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 11 ++++++++++-
 drivers/net/ethernet/intel/i40evf/i40e_adminq.c |  6 ------
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 ++++++++++
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 0ff8f01..1fd5ea8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -567,10 +567,6 @@ i40e_status i40e_init_adminq(struct i40e_hw *hw)
 		goto init_adminq_exit;
 	}
 
-	/* initialize locks */
-	mutex_init(&hw->aq.asq_mutex);
-	mutex_init(&hw->aq.arq_mutex);
-
 	/* Set up register offsets */
 	i40e_adminq_init_regs(hw);
 
@@ -664,8 +660,6 @@ i40e_status i40e_shutdown_adminq(struct i40e_hw *hw)
 	i40e_shutdown_asq(hw);
 	i40e_shutdown_arq(hw);
 
-	/* destroy the locks */
-
 	if (hw->nvm_buff.va)
 		i40e_free_virt_mem(hw, &hw->nvm_buff);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 36645828..181dc81 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10457,6 +10457,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* set up a default setting for link flow control */
 	pf->hw.fc.requested_mode = I40E_FC_NONE;
 
+	/* set up the locks for the AQ, do this only once in probe
+	 * and destroy them only once in remove
+	 */
+	mutex_init(&hw->aq.asq_mutex);
+	mutex_init(&hw->aq.arq_mutex);
+
 	err = i40e_init_adminq(hw);
 	if (err) {
 		if (err == I40E_ERR_FIRMWARE_API_VERSION)
@@ -10874,7 +10880,6 @@ static void i40e_remove(struct pci_dev *pdev)
 	set_bit(__I40E_DOWN, &pf->state);
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
-	i40e_fdir_teardown(pf);
 
 	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
 		i40e_free_vfs(pf);
@@ -10917,6 +10922,10 @@ static void i40e_remove(struct pci_dev *pdev)
 			 "Failed to destroy the Admin Queue resources: %d\n",
 			 ret_code);
 
+	/* destroy the locks only once, here */
+	mutex_destroy(&hw->aq.arq_mutex);
+	mutex_destroy(&hw->aq.asq_mutex);
+
 	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
 	i40e_clear_interrupt_scheme(pf);
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
index fd123ca..3f65e39 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq.c
@@ -551,10 +551,6 @@ i40e_status i40evf_init_adminq(struct i40e_hw *hw)
 		goto init_adminq_exit;
 	}
 
-	/* initialize locks */
-	mutex_init(&hw->aq.asq_mutex);
-	mutex_init(&hw->aq.arq_mutex);
-
 	/* Set up register offsets */
 	i40e_adminq_init_regs(hw);
 
@@ -596,8 +592,6 @@ i40e_status i40evf_shutdown_adminq(struct i40e_hw *hw)
 	i40e_shutdown_asq(hw);
 	i40e_shutdown_arq(hw);
 
-	/* destroy the locks */
-
 	if (hw->nvm_buff.va)
 		i40e_free_virt_mem(hw, &hw->nvm_buff);
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7e207ed..6da6cd7 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2652,6 +2652,12 @@ static int i40evf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw->bus.device = PCI_SLOT(pdev->devfn);
 	hw->bus.func = PCI_FUNC(pdev->devfn);
 
+	/* set up the locks for the AQ, do this only once in probe
+	 * and destroy them only once in remove
+	 */
+	mutex_init(&hw->aq.asq_mutex);
+	mutex_init(&hw->aq.arq_mutex);
+
 	INIT_LIST_HEAD(&adapter->mac_filter_list);
 	INIT_LIST_HEAD(&adapter->vlan_filter_list);
 
@@ -2808,6 +2814,10 @@ static void i40evf_remove(struct pci_dev *pdev)
 	if (hw->aq.asq.count)
 		i40evf_shutdown_adminq(hw);
 
+	/* destroy the locks only once, here */
+	mutex_destroy(&hw->aq.arq_mutex);
+	mutex_destroy(&hw->aq.asq_mutex);
+
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 
-- 
1.8.3.1

