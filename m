From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:39 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 10/13] i40e: implement split
	PCI error reset handler
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

This patch implements the PCI error handler reset_prepare and reset_done.
This allows us to handle function level reset.  Without this patch we
are unable to perform and recover from an FLR correctly and this will cause
VFs to be unable to recover from an FLR on the PF.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2fdd130..eee2e53 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12047,6 +12047,28 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
 }
 
 /**
+ * i40e_pci_error_reset_prepare - prepare device driver for pci reset
+ * @pdev: PCI device information struct
+ */
+static void i40e_pci_error_reset_prepare(struct pci_dev *pdev)
+{
+	struct i40e_pf *pf = pci_get_drvdata(pdev);
+
+	i40e_prep_for_reset(pf, false);
+}
+
+/**
+ * i40e_pci_error_reset_done - pci reset done, device driver reset can begin
+ * @pdev: PCI device information struct
+ */
+static void i40e_pci_error_reset_done(struct pci_dev *pdev)
+{
+	struct i40e_pf *pf = pci_get_drvdata(pdev);
+
+	i40e_reset_and_rebuild(pf, false, false);
+}
+
+/**
  * i40e_pci_error_resume - restart operations after PCI error recovery
  * @pdev: PCI device information struct
  *
@@ -12236,6 +12258,8 @@ static int i40e_resume(struct device *dev)
 static const struct pci_error_handlers i40e_err_handler = {
 	.error_detected = i40e_pci_error_detected,
 	.slot_reset = i40e_pci_error_slot_reset,
+	.reset_prepare = i40e_pci_error_reset_prepare,
+	.reset_done = i40e_pci_error_reset_done,
 	.resume = i40e_pci_error_resume,
 };
 
-- 
2.9.4

