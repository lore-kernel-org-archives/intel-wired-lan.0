From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:37 -0700
Subject: [Intel-wired-lan] [next PATCH S37 07/15] i40e: Clean up MSIX irqs
	before suspend
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

The i40e_suspend() function calls another function that preps the device
for the power save and resume by freeing all the tx/rx resources and
interrupts but that function does not free the "other" causes interrupt
vector and irq. It also fails to call synchronize_irq() before freeing
the irq vectors.  This sometimes may result in some AER errors on those
systems with that PCIe error reporting feature enabled.

Call synchronize_irq() before freeing irq vectors and explicitly free
the other causes interrupt resources and shut down that MSIX interrupt.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: Ib88e4536756518a352446da0232189716618ad81
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3439e9f..d71b6bc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3955,6 +3955,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			/* clear the affinity_mask in the IRQ descriptor */
 			irq_set_affinity_hint(pf->msix_entries[vector].vector,
 					      NULL);
+			synchronize_irq(pf->msix_entries[vector].vector);
 			free_irq(pf->msix_entries[vector].vector,
 				 vsi->q_vectors[i]);
 
@@ -11535,6 +11536,8 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 	wr32(hw, I40E_PFPM_APM, (pf->wol_en ? I40E_PFPM_APM_APME_MASK : 0));
 	wr32(hw, I40E_PFPM_WUFC, (pf->wol_en ? I40E_PFPM_WUFC_MAG_MASK : 0));
 
+	i40e_stop_misc_vector(pf);
+
 	pci_wake_from_d3(pdev, pf->wol_en);
 	pci_set_power_state(pdev, PCI_D3hot);
 
-- 
2.4.11

