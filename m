From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:31 -0700
Subject: [Intel-wired-lan] [next PATCH S94 08/13] i40e: Reorder irq and
 adminq deinitialization in i40e_remove
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This is needed to allow changing of deinitialization flow in
order to skip freeing uninitialized irq when in recovery mode.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5720d40..725b2de 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14370,13 +14370,6 @@ static void i40e_remove(struct pci_dev *pdev)
 	}
 
 unmap:
-	/* shutdown the adminq */
-	i40e_shutdown_adminq(hw);
-
-	/* destroy the locks only once, here */
-	mutex_destroy(&hw->aq.arq_mutex);
-	mutex_destroy(&hw->aq.asq_mutex);
-
 	/* Free MSI/legacy interrupt 0 when in recovery mode.
 	 * This is normally done in i40e_vsi_free_irq on
 	 * VSI close but since recovery mode doesn't allow to up
@@ -14398,6 +14391,13 @@ static void i40e_remove(struct pci_dev *pdev)
 		}
 	}
 
+	/* shutdown the adminq */
+	i40e_shutdown_adminq(hw);
+
+	/* destroy the locks only once, here */
+	mutex_destroy(&hw->aq.arq_mutex);
+	mutex_destroy(&hw->aq.asq_mutex);
+
 	for (i = 0; i < I40E_MAX_VEB; i++) {
 		kfree(pf->veb[i]);
 		pf->veb[i] = NULL;
-- 
2.9.5

