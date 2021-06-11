From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Fri, 11 Jun 2021 12:01:41 +0200
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix missing rtnl locking
 when setting up pf switch
Message-ID: <20210611100141.6089-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jan Sokolowski <jan.sokolowski@intel.com>

A recent change that made i40e use new udp_tunnel infrastructure
uses a method that expects to be called under rtnl lock.

However, not all codepaths do the lock prior to calling
i40e_setup_pf_switch.

Fix that by adding additional rtnl locking and unlocking.

Fixes: 40a98cb6f01f ("i40e: convert to new udp_tunnel infrastructure")
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fce05ad..f7977e5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -32,7 +32,7 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi);
 static void i40e_handle_reset_warning(struct i40e_pf *pf, bool lock_acquired);
 static int i40e_add_vsi(struct i40e_vsi *vsi);
 static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi);
-static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit);
+static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acquired);
 static int i40e_setup_misc_vector(struct i40e_pf *pf);
 static void i40e_determine_queue_usage(struct i40e_pf *pf);
 static int i40e_setup_pf_filter_control(struct i40e_pf *pf);
@@ -10652,7 +10652,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 #endif /* CONFIG_I40E_DCB */
 	if (!lock_acquired)
 		rtnl_lock();
-	ret = i40e_setup_pf_switch(pf, reinit);
+	ret = i40e_setup_pf_switch(pf, reinit, true);
 	if (ret)
 		goto end_unlock;
 
@@ -14710,10 +14710,11 @@ int i40e_fetch_switch_configuration(struct i40e_pf *pf, bool printconfig)
  * i40e_setup_pf_switch - Setup the HW switch on startup or after reset
  * @pf: board private structure
  * @reinit: if the Main VSI needs to re-initialized.
+ * @lock_acquired: indicates whether or not the lock has been acquired
  *
  * Returns 0 on success, negative value on failure
  **/
-static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
+static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 {
 	u16 flags = 0;
 	int ret;
@@ -14815,9 +14816,15 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit)
 
 	i40e_ptp_init(pf);
 
+	if (!lock_acquired)
+		rtnl_lock();
+
 	/* repopulate tunnel port filters */
 	udp_tunnel_nic_reset_ntf(pf->vsi[pf->lan_vsi]->netdev);
 
+	if (!lock_acquired)
+		rtnl_unlock();
+
 	return ret;
 }
 
@@ -15628,7 +15635,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
 	}
 #endif
-	err = i40e_setup_pf_switch(pf, false);
+	err = i40e_setup_pf_switch(pf, false, false);
 	if (err) {
 		dev_info(&pdev->dev, "setup_pf_switch failed: %d\n", err);
 		goto err_vsis;
-- 
2.27.0

