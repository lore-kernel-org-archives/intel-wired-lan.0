From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 27 May 2015 12:06:14 -0400
Subject: [Intel-wired-lan] [net PATCH] i40e: Make sure to be in VEB mode if
	SRIOV is enabled at probe
Message-ID: <1432742774-69564-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

If SRIOV is enabled we need to be in VEB mode not VEPA mode at probe.
This fixes an NPAR bug when SRIOV is enabled in the BIOS.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: Ibf006abafd9a0ca3698ec24848cd771cf345cbbc
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 853eb2f..eead111 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8756,9 +8756,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 					 __func__);
 				return NULL;
 			}
-			/* We come up by default in VEPA mode */
-			veb->bridge_mode = BRIDGE_MODE_VEPA;
-			pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+			/* We come up by default in VEPA mode if sriov is not
+			 * already enabled, in which case we can't force VEPA
+			 * mode.
+			 */
+			if (!(pf->flags & I40E_FLAG_VEB_MODE_ENABLED)) {
+				veb->bridge_mode = BRIDGE_MODE_VEPA;
+				pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
+			}
 			i40e_config_bridge_mode(veb);
 		}
 		for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
@@ -9869,6 +9874,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_switch_setup;
 	}
 
+#ifdef CONFIG_PCI_IOV
+	/* prep for VF support */
+	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
+	    (pf->flags & I40E_FLAG_MSIX_ENABLED) &&
+	    !test_bit(__I40E_BAD_EEPROM, &pf->state)) {
+		if (pci_num_vf(pdev))
+			pf->flags |= I40E_FLAG_VEB_MODE_ENABLED;
+	}
+#endif
 	err = i40e_setup_pf_switch(pf, false);
 	if (err) {
 		dev_info(&pdev->dev, "setup_pf_switch failed: %d\n", err);
-- 
1.9.3

