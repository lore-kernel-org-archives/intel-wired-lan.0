From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Oct 2018 12:18:28 -0700
Subject: [Intel-wired-lan] [net-next 2/3] fm10k: ensure completer aborts are
 marked as non-fatal after a resume
In-Reply-To: <20181015191829.17115-1-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
Message-ID: <20181015191829.17115-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

VF drivers can trigger PCIe completer aborts any time they read a queue
that they don't own. Even in nominal circumstances, it is not possible
to prevent the VF driver from reading queues it doesn't own. VF drivers
may attempt to read queues it previously owned, but which it no longer
does due to a PF reset.

Normally these completer aborts aren't an issue. However, on some
platforms these trigger machine check errors. This is true even if we
lower their severity from fatal to non-fatal. Indeed, we already have
code for lowering the severity.

We could attempt to mask these errors conditionally around resets, which
is the most common time they would occur. However this would essentially
be a race between the PF and VF drivers, and we may still occasionally
see machine check exceptions on these strictly configured platforms.

Instead, mask the errors entirely any time we resume VFs. By doing so,
we prevent the completer aborts from being sent to the parent PCIe
device, and thus these strict platforms will not upgrade them into
machine check errors.

Addtionally, we don't lose any information by masking these errors,
because we'll still report VFs which attempt to access queues via the
FUM_BAD_VF_QACCESS errors.

Without this change, on platforms where completer aborts cause machine
check exceptions, the VF reading queues it doesn't own could crash the
host system. Masking the completer abort prevents this, so we should
mask it for good, and not just around a PCIe reset. Otherwise malicious
or misconfigured VFs could cause the host system to crash.

Because we are masking the error entirely, there is little reason to
also keep setting the severity bit, so that code is also removed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 48 ++++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 74160c2095ee..5d4f1761dc0c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -303,6 +303,28 @@ void fm10k_iov_suspend(struct pci_dev *pdev)
 	}
 }
 
+static void fm10k_mask_aer_comp_abort(struct pci_dev *pdev)
+{
+	u32 err_mask;
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return;
+
+	/* Mask the completion abort bit in the ERR_UNCOR_MASK register,
+	 * preventing the device from reporting these errors to the upstream
+	 * PCIe root device. This avoids bringing down platforms which upgrade
+	 * non-fatal completer aborts into machine check exceptions. Completer
+	 * aborts can occur whenever a VF reads a queue it doesn't own.
+	 */
+	pci_read_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, &err_mask);
+	err_mask |= PCI_ERR_UNC_COMP_ABORT;
+	pci_write_config_dword(pdev, pos + PCI_ERR_UNCOR_MASK, err_mask);
+
+	mmiowb();
+}
+
 int fm10k_iov_resume(struct pci_dev *pdev)
 {
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
@@ -318,6 +340,12 @@ int fm10k_iov_resume(struct pci_dev *pdev)
 	if (!iov_data)
 		return -ENOMEM;
 
+	/* Lower severity of completer abort error reporting as
+	 * the VFs can trigger this any time they read a queue
+	 * that they don't own.
+	 */
+	fm10k_mask_aer_comp_abort(pdev);
+
 	/* allocate hardware resources for the VFs */
 	hw->iov.ops.assign_resources(hw, num_vfs, num_vfs);
 
@@ -461,20 +489,6 @@ void fm10k_iov_disable(struct pci_dev *pdev)
 	fm10k_iov_free_data(pdev);
 }
 
-static void fm10k_disable_aer_comp_abort(struct pci_dev *pdev)
-{
-	u32 err_sev;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (!pos)
-		return;
-
-	pci_read_config_dword(pdev, pos + PCI_ERR_UNCOR_SEVER, &err_sev);
-	err_sev &= ~PCI_ERR_UNC_COMP_ABORT;
-	pci_write_config_dword(pdev, pos + PCI_ERR_UNCOR_SEVER, err_sev);
-}
-
 int fm10k_iov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	int current_vfs = pci_num_vf(pdev);
@@ -496,12 +510,6 @@ int fm10k_iov_configure(struct pci_dev *pdev, int num_vfs)
 
 	/* allocate VFs if not already allocated */
 	if (num_vfs && num_vfs != current_vfs) {
-		/* Disable completer abort error reporting as
-		 * the VFs can trigger this any time they read a queue
-		 * that they don't own.
-		 */
-		fm10k_disable_aer_comp_abort(pdev);
-
 		err = pci_enable_sriov(pdev, num_vfs);
 		if (err) {
 			dev_err(&pdev->dev,
-- 
2.18.0.219.gaf81d287a9da

