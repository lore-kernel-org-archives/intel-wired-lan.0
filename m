From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 16:31:05 -0700
Subject: [Intel-wired-lan] [rc2 08/15] fm10k: trivial fixup message style to
	include a colon
In-Reply-To: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
References: <1433374272-6684-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433374272-6684-9-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 445014a49de7..5269b1628ca6 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1773,7 +1773,7 @@ static int fm10k_probe(struct pci_dev *pdev,
 					   fm10k_driver_name);
 	if (err) {
 		dev_err(&pdev->dev,
-			"pci_request_selected_regions failed 0x%x\n", err);
+			"pci_request_selected_regions failed: 0x%x\n", err);
 		goto err_pci_reg;
 	}
 
-- 
2.1.0

