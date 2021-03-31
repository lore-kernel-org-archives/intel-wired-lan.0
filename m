From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:08 -0700
Subject: [Intel-wired-lan] [PATCH S58 13/13] ice: reduce scope of variable
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

The scope of this variable can be reduced so do that.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index ef2a91fc5472..96a2b319bf21 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -4375,7 +4375,6 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
  */
 void ice_restore_all_vfs_msi_state(struct pci_dev *pdev)
 {
-	struct pci_dev *vfdev;
 	u16 vf_id;
 	int pos;
 
@@ -4384,6 +4383,8 @@ void ice_restore_all_vfs_msi_state(struct pci_dev *pdev)
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos) {
+		struct pci_dev *vfdev;
+
 		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID,
 				     &vf_id);
 		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
-- 
2.20.1

