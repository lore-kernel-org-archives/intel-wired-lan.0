From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Tue, 19 Oct 2021 15:59:17 +0200
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix kernel BUG in
 free_msi_irqs
Message-ID: <20211019135917.15621-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>

Fix driver not freeing VF's traffic irqs, prior to calling
pci_disable_msix in iavf_remove.
There were possible 2 erroneous states in which, iavf_close would
not be called.
One erroneous state is fixed by allowing netdev to register, when state
is already running. It was possible for VF adapter to enter state loop
from running to resetting, where iavf_open would subsequently fail.
If user would then unload driver/remove VF pci, iavf_close would not be
called, as the netdev was not registered, leaving traffic pcis still
allocated.
Fixed this by breaking loop, allowing netdev to open device when adapter
state is __IAVF_RUNNING and it is not explicitily downed.
Other possiblity is entering to iavf_remove from __IAVF_RESETTING state,
where iavf_close would not free irqs, but just return 0.
Fixed this by checking for last adapter state and then removing irqs.

Kernel panic:
[ 2773.628585] kernel BUG at drivers/pci/msi.c:375!
...
[ 2773.631567] RIP: 0010:free_msi_irqs+0x180/0x1b0
...
[ 2773.640939] Call Trace:
[ 2773.641572]  pci_disable_msix+0xf7/0x120
[ 2773.642224]  iavf_reset_interrupt_capability.part.41+0x15/0x30 [iavf]
[ 2773.642897]  iavf_remove+0x12e/0x500 [iavf]
[ 2773.643578]  pci_device_remove+0x3b/0xc0
[ 2773.644266]  device_release_driver_internal+0x103/0x1f0
[ 2773.644948]  pci_stop_bus_device+0x69/0x90
[ 2773.645576]  pci_stop_and_remove_bus_device+0xe/0x20
[ 2773.646215]  pci_iov_remove_virtfn+0xba/0x120
[ 2773.646862]  sriov_disable+0x2f/0xe0
[ 2773.647531]  ice_free_vfs+0x2f8/0x350 [ice]
[ 2773.648207]  ice_sriov_configure+0x94/0x960 [ice]
[ 2773.648883]  ? _kstrtoull+0x3b/0x90
[ 2773.649560]  sriov_numvfs_store+0x10a/0x190
[ 2773.650249]  kernfs_fop_write+0x116/0x190
[ 2773.650948]  vfs_write+0xa5/0x1a0
[ 2773.651651]  ksys_write+0x4f/0xb0
[ 2773.652358]  do_syscall_64+0x5b/0x1a0
[ 2773.653075]  entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: 22ead37f8af8 ("i40evf: Add longer wait after remove module")
Signed-off-by: Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Fixed checkpatch errors
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index d384de4..45a5a48 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3329,6 +3329,13 @@ static int iavf_open(struct net_device *netdev)
 		goto err_unlock;
 	}
 
+	if (adapter->state == __IAVF_RUNNING &&
+	    !test_bit(__IAVF_VSI_DOWN, adapter->vsi.state)) {
+		dev_dbg(&adapter->pdev->dev, "VF is already open.\n");
+		err = 0;
+		goto err_unlock;
+	}
+
 	/* allocate transmit descriptors */
 	err = iavf_setup_all_tx_resources(adapter);
 	if (err)
@@ -3977,6 +3984,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	struct iavf_mac_filter *f, *ftmp;
 	struct iavf_cloud_filter *cf, *cftmp;
 	struct iavf_hw *hw = &adapter->hw;
+	enum iavf_state_t last_state;
 	int err;
 	/* Indicate we are in remove and not to run reset_task */
 	mutex_lock(&adapter->remove_lock);
@@ -4009,6 +4017,15 @@ static void iavf_remove(struct pci_dev *pdev)
 	iavf_change_state(adapter, __IAVF_REMOVE);
 	adapter->aq_required = 0;
 	adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
+
+	/* In case we enter iavf_remove from erroneous state, free traffic irqs
+	 * here, so as to not cause a kernel crash, when calling
+	 * iavf_reset_interrupt_capability.
+	 */
+	if (!(netdev->flags & IFF_UP) &&
+	    (last_state == __IAVF_RESETTING ||
+	     last_state == __IAVF_RUNNING))
+		iavf_free_traffic_irqs(adapter);
 	iavf_free_all_tx_resources(adapter);
 	iavf_free_all_rx_resources(adapter);
 	iavf_misc_irq_disable(adapter);
-- 
2.27.0

