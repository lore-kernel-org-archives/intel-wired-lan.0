From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:30 -0700
Subject: [Intel-wired-lan] [next PATCH S94 07/13] i40e: Check for recovery
 mode before doing PF reset
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mariusz Stachura <mariusz.stachura@intel.com>

This patch moves call to i40e_check_recovery_mode() before we do PF
resets. Previous behavior was proven to be working on A2A scenario,
but was not sufficient for addressing other RecoveryMode cases.

Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d7eeced..5720d40 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13848,12 +13848,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Reset here to make sure all is clean and to define PF 'n' */
 	i40e_clear_hw(hw);
-	err = i40e_pf_reset(hw);
-	if (err) {
-		dev_info(&pdev->dev, "Initial pf_reset failed: %d\n", err);
-		goto err_pf_reset;
+	if (!i40e_check_recovery_mode(pf)) {
+		err = i40e_pf_reset(hw);
+		if (err) {
+			dev_info(&pdev->dev, "Initial pf_reset failed: %d\n",
+				 err);
+			goto err_pf_reset;
+		}
+		pf->pfr_count++;
 	}
-	pf->pfr_count++;
 
 	hw->aq.num_arq_entries = I40E_AQ_LEN;
 	hw->aq.num_asq_entries = I40E_AQ_LEN;
@@ -13919,7 +13922,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_sw_init;
 	}
 
-	if (i40e_check_recovery_mode(pf))
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
 		return i40e_init_recovery_mode(pf, hw);
 
 	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
-- 
2.9.5

