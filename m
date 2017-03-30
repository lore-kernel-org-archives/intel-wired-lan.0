From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Mar 2017 00:46:08 -0700
Subject: [Intel-wired-lan] [next S65 3/3 v2] i40e: close client on remove
	and shutdown
In-Reply-To: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
References: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20170330074608.52108-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When the driver is removed or shut down, close any attached clients
(i.e. i40iw). This prevents a panic seen sometimes on forced driver
removal or system shutdown when iWarp is running.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I4f6161e5a73ffbb2fd5883567b007310302bfcb5
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cb087d546a0a..da22850897c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11392,6 +11392,11 @@ static void i40e_remove(struct pci_dev *pdev)
 	if (pf->service_task.func)
 		cancel_work_sync(&pf->service_task);
 
+	/* Client close must be called explicitly here because the timer
+	 * has been stopped.
+	 */
+	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+
 	if (pf->flags & I40E_FLAG_SRIOV_ENABLED) {
 		i40e_free_vfs(pf);
 		pf->flags &= ~I40E_FLAG_SRIOV_ENABLED;
@@ -11632,6 +11637,11 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	cancel_work_sync(&pf->service_task);
 	i40e_fdir_teardown(pf);
 
+	/* Client close must be called explicitly here because the timer
+	 * has been stopped.
+	 */
+	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+
 	if (pf->wol_en && (pf->flags & I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-- 
2.12.0

