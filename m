From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:11 -0800
Subject: [Intel-wired-lan] [next PATCH S28 04/15] i40e: trivial: cleanup use
	of pf->hw
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-5-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

This patch makes use of a pointer called hw consistent
in the i40e_remove function.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Idacc7ff0a09a68289c57457a78618bf5497de077
---
Testing Hints: check remove works via rmmod,
mostly just a compile change.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c46a9a1..8b04769 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11217,8 +11217,8 @@ static void i40e_remove(struct pci_dev *pdev)
 		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
 
 	/* shutdown and destroy the HMC */
-	if (pf->hw.hmc.hmc_obj) {
-		ret_code = i40e_shutdown_lan_hmc(&pf->hw);
+	if (hw->hmc.hmc_obj) {
+		ret_code = i40e_shutdown_lan_hmc(hw);
 		if (ret_code)
 			dev_warn(&pdev->dev,
 				 "Failed to destroy the HMC resources: %d\n",
@@ -11226,7 +11226,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	}
 
 	/* shutdown the adminq */
-	ret_code = i40e_shutdown_adminq(&pf->hw);
+	ret_code = i40e_shutdown_adminq(hw);
 	if (ret_code)
 		dev_warn(&pdev->dev,
 			 "Failed to destroy the Admin Queue resources: %d\n",
@@ -11254,7 +11254,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	kfree(pf->qp_pile);
 	kfree(pf->vsi);
 
-	iounmap(pf->hw.hw_addr);
+	iounmap(hw->hw_addr);
 	kfree(pf);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
-- 
2.1.0

