From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:07 -0700
Subject: [Intel-wired-lan] [PATCH S50 04/15] ice: restore VF MSI-X state
 during PCI reset
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nick Nunley <nicholas.d.nunley@intel.com>

During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability
register will be cleared. This can lead to issues when a VF is
assigned to a VM because in these cases the VF driver receives no
indication of the PF PCI error/reset and additionally it is incapable
of restoring the cleared flag in the hypervisor configuration space
without fully reinitializing the driver interrupt functionality.

Since the VF driver is unable to easily resolve this condition on its own,
restore the VF MSI-X flag during the PF PCI reset handling.

Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 30 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5940c16d0747..a7b6502f1b4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4478,6 +4478,8 @@ static void ice_pci_err_resume(struct pci_dev *pdev)
 		return;
 	}
 
+	ice_restore_all_vfs_msi_state(pdev);
+
 	ice_do_reset(pf, ICE_RESET_PFR);
 	ice_service_task_restart(pf);
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 50b11197b3cf..760137710242 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -5084,3 +5084,33 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
 		}
 	}
 }
+
+/**
+ * ice_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
+ * @pdev: pointer to a pci_dev structure
+ *
+ * Called when recovering from a PF FLR to restore interrupt capability to
+ * the VFs.
+ */
+void ice_restore_all_vfs_msi_state(struct pci_dev *pdev)
+{
+	struct pci_dev *vfdev;
+	u16 vf_id;
+	int pos;
+
+	if (!pci_num_vf(pdev))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID,
+				     &vf_id);
+		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
+		while (vfdev) {
+			if (vfdev->is_virtfn && vfdev->physfn == pdev)
+				pci_restore_msi_state(vfdev);
+			vfdev = pci_get_device(pdev->vendor, vf_id,
+					       vfdev);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
index 8cd8d6cb6730..be005d787a6f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
@@ -121,6 +121,7 @@ void ice_vc_notify_link_state(struct ice_pf *pf);
 void ice_vc_notify_reset(struct ice_pf *pf);
 bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr);
 bool ice_reset_vf(struct ice_vf *vf, bool is_vflr);
+void ice_restore_all_vfs_msi_state(struct pci_dev *pdev);
 
 int
 ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
@@ -158,6 +159,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id);
 #define ice_vf_lan_overflow_event(pf, event) do {} while (0)
 #define ice_print_vfs_mdd_events(pf) do {} while (0)
 #define ice_print_vf_rx_mdd_event(vf) do {} while (0)
+#define ice_restore_all_vfs_msi_state(pdev) do {} while (0)
 
 static inline bool
 ice_reset_all_vfs(struct ice_pf __always_unused *pf,
-- 
2.20.1

