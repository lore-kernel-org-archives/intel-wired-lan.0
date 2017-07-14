From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:04 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 05/10] i40e: don't clear
	suspended state until we finish resuming
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When handling suspend and resume callbacks we want to make sure that (a)
we don't suspend again if we're already suspended and (b) we don't
resume again if we're already resuming. Lets make sure we test_and_set
the __I40E_SUSPENDED bit in i40e_suspend which ensures that a suspend
call when already suspended will exit early. Additionally, if
__I40E_SUSPENDED is not set when we begin resuming, exit early as well.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b47cc14..11c9565 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12045,7 +12045,10 @@ static int i40e_suspend(struct device *dev)
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	struct i40e_hw *hw = &pf->hw;
 
-	set_bit(__I40E_SUSPENDED, pf->state);
+	/* If we're already suspended, then there is nothing to do */
+	if (test_and_set_bit(__I40E_SUSPENDED, pf->state))
+		return 0;
+
 	set_bit(__I40E_DOWN, pf->state);
 
 	if (pf->wol_en && (pf->hw_features & I40E_HW_WOL_MC_MAGIC_PKT_WAKE))
@@ -12070,11 +12073,15 @@ static int i40e_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 
-	/* handling the reset will rebuild the device state */
-	if (test_and_clear_bit(__I40E_SUSPENDED, pf->state)) {
-		clear_bit(__I40E_DOWN, pf->state);
-		i40e_reset_and_rebuild(pf, false, false);
-	}
+	/* If we're not suspended, then there is nothing to do */
+	if (!test_bit(__I40E_SUSPENDED, pf->state))
+		return 0;
+
+	clear_bit(__I40E_DOWN, pf->state);
+	i40e_reset_and_rebuild(pf, false, false);
+
+	/* Clear suspended state last after everything is recovered */
+	clear_bit(__I40E_SUSPENDED, pf->state);
 
 	return 0;
 }
-- 
2.9.3

