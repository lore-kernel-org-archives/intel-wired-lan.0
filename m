From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:03 -0700
Subject: [Intel-wired-lan] [next PATCH S96 3/9] i40e: hold the rtnl lock on
 clearing interrupt scheme
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

Hold the rtnl lock when we're clearing interrupt scheme
in i40e_shutdown and in i40e_remove.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fd0c6c5..79bffaf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14726,6 +14726,7 @@ static void i40e_remove(struct pci_dev *pdev)
 		free_irq(pf->pdev->irq, pf);
 
 	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
+	rtnl_lock();
 	i40e_clear_interrupt_scheme(pf);
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		if (pf->vsi[i]) {
@@ -14735,6 +14736,7 @@ static void i40e_remove(struct pci_dev *pdev)
 			pf->vsi[i] = NULL;
 		}
 	}
+	rtnl_unlock();
 
 	/* shutdown the adminq */
 	i40e_shutdown_adminq(hw);
@@ -14963,7 +14965,13 @@ static void i40e_shutdown(struct pci_dev *pdev)
 	    !(pf->flags & I40E_FLAG_MSIX_ENABLED))
 		free_irq(pf->pdev->irq, pf);
 
+	/* Since we're going to destroy queues during the
+	 * i40e_clear_interrupt_scheme() we should hold the RTNL lock for this
+	 * whole section
+	 */
+	rtnl_lock();
 	i40e_clear_interrupt_scheme(pf);
+	rtnl_unlock();
 
 	if (system_state == SYSTEM_POWER_OFF) {
 		pci_wake_from_d3(pdev, pf->wol_en);
-- 
2.9.5

