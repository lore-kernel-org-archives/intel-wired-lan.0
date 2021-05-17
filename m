From: Karen Sornek <karen.sornek@intel.com>
Date: Mon, 17 May 2021 16:28:18 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add restoration of VF
 MSI-X state during PCI reset
Message-ID: <20210517142818.288238-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability
register will be cleared. This can lead to issues when a VF is
assigned to a VM because in these cases the VF driver receives no
indication of the PF PCI error/reset and additionally it is incapable
of restoring the cleared flag in the hypervisor configuration space
without fully reinitializing the driver interrupt functionality.

Since the VF driver is unable to easily resolve this condition on its own,
restore the VF MSI-X flag during the PF PCI reset handling.

Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 32 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
 3 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c34a4b3f5..c4f0fbb53 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16021,6 +16021,8 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
 	i40e_reset_and_rebuild(pf, false, false);
+
+	i40e_restore_all_vfs_msi_state(pdev);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 139562aaf..409444341 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -152,6 +152,38 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
+/**
+ * i40_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
+ * @pdev: pointer to a pci_dev structure
+ *
+ * Called when recovering from a PF FLR to restore interrupt capability to
+ * the VFs.
+ */
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
+{
+	struct pci_dev *vfdev;
+	u16 vf_id;
+	int pos;
+
+	/* Continue only if this is a PF */
+	if (!pdev->is_physfn)
+		return;
+
+	if (!pci_num_vf(pdev))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
+		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
+		while (vfdev) {
+			if (vfdev->is_virtfn && vfdev->physfn == pdev)
+				pci_restore_msi_state(vfdev);
+			vfdev = pci_get_device(pdev->vendor, vf_id, vfdev);
+		}
+	}
+}
+
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 091e32c1b..87c76bb5b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -136,6 +136,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
-- 
2.27.0

