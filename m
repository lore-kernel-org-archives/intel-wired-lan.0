From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Thu, 17 Aug 2017 03:00:55 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/6] [net-next]net: i40e: Add macro for
	PF reset bit
In-Reply-To: <150296373549.16167.14331445560838257351.stgit@anamdev.jf.intel.com>
References: <150296373549.16167.14331445560838257351.stgit@anamdev.jf.intel.com>
Message-ID: <150296405502.16167.9720405534691757130.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce a macro for the bit setting the PF reset flag and
update its usages. This makes it easier to use this flag
in functions to be introduced in future without encountering
checkpatch issues related to alignment and line over 80
characters.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h             |    2 ++
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    3 +--
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    9 ++++-----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |    5 ++---
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 890508f..0e53838 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -157,6 +157,8 @@ enum i40e_state_t {
 	__I40E_STATE_SIZE__,
 };
 
+#define I40E_PF_RESET_FLAG	BIT_ULL(__I40E_PF_RESET_REQUESTED)
+
 /* VSI state flags */
 enum i40e_vsi_state_t {
 	__I40E_VSI_DOWN,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 8f326f8..b46117e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -798,8 +798,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		 */
 		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
 			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
-			i40e_do_reset_safe(pf,
-					   BIT_ULL(__I40E_PF_RESET_REQUESTED));
+			i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 		}
 
 		vsi = i40e_vsi_setup(pf, I40E_VSI_VMDQ2, vsi_seid, 0);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d2ca98f..9392c5a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5753,7 +5753,7 @@ int i40e_vsi_open(struct i40e_vsi *vsi)
 err_setup_tx:
 	i40e_vsi_free_tx_resources(vsi);
 	if (vsi == pf->vsi[pf->lan_vsi])
-		i40e_do_reset(pf, BIT_ULL(__I40E_PF_RESET_REQUESTED), true);
+		i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 
 	return err;
 }
@@ -5881,7 +5881,7 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
 		wr32(&pf->hw, I40E_GLGEN_RTRIG, val);
 		i40e_flush(&pf->hw);
 
-	} else if (reset_flags & BIT_ULL(__I40E_PF_RESET_REQUESTED)) {
+	} else if (reset_flags & I40E_PF_RESET_FLAG) {
 
 		/* Request a PF Reset
 		 *
@@ -9209,7 +9209,7 @@ static int i40e_set_features(struct net_device *netdev,
 	need_reset = i40e_set_ntuple(pf, features);
 
 	if (need_reset)
-		i40e_do_reset(pf, BIT_ULL(__I40E_PF_RESET_REQUESTED), true);
+		i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 
 	return 0;
 }
@@ -9461,8 +9461,7 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 				pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
 			else
 				pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
-			i40e_do_reset(pf, BIT_ULL(__I40E_PF_RESET_REQUESTED),
-				      true);
+			i40e_do_reset(pf, I40E_PF_RESET_FLAG, true);
 			break;
 		}
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index e156096..92fe06d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1400,8 +1400,7 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	if (num_vfs) {
 		if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
 			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
-			i40e_do_reset_safe(pf,
-					   BIT_ULL(__I40E_PF_RESET_REQUESTED));
+			i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 		}
 		return i40e_pci_sriov_enable(pdev, num_vfs);
 	}
@@ -1409,7 +1408,7 @@ int i40e_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	if (!pci_vfs_assigned(pf->pdev)) {
 		i40e_free_vfs(pf);
 		pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
-		i40e_do_reset_safe(pf, BIT_ULL(__I40E_PF_RESET_REQUESTED));
+		i40e_do_reset_safe(pf, I40E_PF_RESET_FLAG);
 	} else {
 		dev_warn(&pdev->dev, "Unable to free VFs because some are assigned to VMs.\n");
 		return -EINVAL;

