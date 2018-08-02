From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:34 -0700
Subject: [Intel-wired-lan] [next PATCH S94 11/13] i40e: Prevent kernel panic
 when rebooting server while NIC is in recovery
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

If user triggers a reboot and the adapter is in recovery
mode, we are not taking this fact into account and we are
not freeing irq that has been specifically allocated for
NVM update/recover purposes, what bothers kernel when we issue
pci_disable_msi when irq still has an interrupt registered.
This patch fixes that and ensures that we free this irq.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3b1740d..ff04dc4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14627,6 +14627,16 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	wr32(hw, I40E_PFPM_WUFC,
 	     (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
+	/* Free MSI/legacy interrupt 0 when in recovery mode.
+	 * This is normally done in i40e_vsi_free_irq on
+	 * VSI close but since recovery mode doesn't allow to up
+	 * an interface and we do not allocate all Rx/Tx resources
+	 * for it we'll just do it here
+	 */
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state) &&
+	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
+		free_irq(pf->pdev->irq, pf);
+
 	i40e_clear_interrupt_scheme(pf);
 
 	if (system_state == SYSTEM_POWER_OFF) {
-- 
2.9.5

