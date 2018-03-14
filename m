From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:13 -0700
Subject: [Intel-wired-lan] [PATCH S88 3/8] i40e: Close client on suspend and
 restore client MSIx on resume
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180314181918.21582-3-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shiraz Saleem <shiraz.saleem@intel.com>

During suspend client MSIx vectors are freed while they are still
in use causing a crash on entering S3.

Fix this calling client close before freeing up its MSIx vectors.
Also update the client MSIx vectors on resume before client
open is called.

Fixes commit b980c0634fe5 ("i40e: shutdown all IRQs and disable MSI-X
when suspended")

Reported-by: Stefan Assmann <sassmann@redhat.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_client.c | 16 +++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 ++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 956299c45d5f..1e1cd5204b4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1042,6 +1042,7 @@ void i40e_notify_client_of_l2_param_changes(struct i40e_vsi *vsi);
 void i40e_notify_client_of_netdev_close(struct i40e_vsi *vsi, bool reset);
 void i40e_notify_client_of_vf_enable(struct i40e_pf *pf, u32 num_vfs);
 void i40e_notify_client_of_vf_reset(struct i40e_pf *pf, u32 vf_id);
+void i40e_client_update_msix_info(struct i40e_pf *pf);
 int i40e_vf_client_capable(struct i40e_pf *pf, u32 vf_id);
 /**
  * i40e_irq_dynamic_enable - Enable default interrupt generation settings
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 0680a627d27b..a04bbfcca266 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -288,6 +288,17 @@ int i40e_vf_client_capable(struct i40e_pf *pf, u32 vf_id)
 	return capable;
 }
 
+void i40e_client_update_msix_info(struct i40e_pf *pf)
+{
+	struct i40e_client_instance *cdev = pf->cinst;
+
+	if (!cdev || !cdev->client)
+		return;
+
+	cdev->lan_info.msix_count = pf->num_iwarp_msix;
+	cdev->lan_info.msix_entries = &pf->msix_entries[pf->iwarp_base_vector];
+}
+
 /**
  * i40e_client_add_instance - add a client instance struct to the instance list
  * @pf: pointer to the board struct
@@ -329,9 +340,6 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 		return;
 	}
 
-	cdev->lan_info.msix_count = pf->num_iwarp_msix;
-	cdev->lan_info.msix_entries = &pf->msix_entries[pf->iwarp_base_vector];
-
 	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
 			       struct netdev_hw_addr, list);
 	if (mac)
@@ -341,6 +349,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
 
 	cdev->client = registered_client;
 	pf->cinst = cdev;
+
+	i40e_client_update_msix_info(pf);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0df21e4f2a0f..5a77dbf972f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10595,6 +10595,9 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
 	if (err)
 		goto err_unwind;
 
+	if (pf->flags & I40E_FLAG_IWARP_ENABLED)
+		i40e_client_update_msix_info(pf);
+
 	return 0;
 
 err_unwind:
@@ -14345,6 +14348,11 @@ static int __maybe_unused i40e_suspend(struct device *dev)
 	del_timer_sync(&pf->service_timer);
 	cancel_work_sync(&pf->service_task);
 
+	/* Client close must be called explicitly here because the timer
+	 * has been stopped.
+	 */
+	i40e_notify_client_of_netdev_close(pf->vsi[pf->lan_vsi], false);
+
 	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
 		i40e_enable_mc_magic_wake(pf);
 
-- 
2.14.3

