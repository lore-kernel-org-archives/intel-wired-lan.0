From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:53 -0700
Subject: [Intel-wired-lan] [next PATCH S5 08/10] i40e: Check if the BAR size
 is large enough before writing to registers
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

This patch fixes the problem with a kernel panic occurring when trying
to bind the i40e driver to a non-i40e port. The problem is fixed by
checking if the BAR size in the device is large enough by reading the
highest register.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5716f8fe06ed..d640da4a8835 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14696,7 +14696,17 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pf->ioremap_len = min_t(int, pci_resource_len(pdev, 0),
 				I40E_MAX_CSR_SPACE);
-
+	/* We believe that the highest register to read is
+	 * I40E_GLGEN_STAT_CLEAR, so we check if the BAR size
+	 * is not less than that before mapping to prevent a
+	 * kernel panic.
+	 */
+	if (pf->ioremap_len < I40E_GLGEN_STAT_CLEAR) {
+		dev_err(&pdev->dev, "Cannot map registers, bar size 0x%X too small, aborting\n",
+			pf->ioremap_len);
+		err = -ENOMEM;
+		goto err_ioremap;
+	}
 	hw->hw_addr = ioremap(pci_resource_start(pdev, 0), pf->ioremap_len);
 	if (!hw->hw_addr) {
 		err = -EIO;
-- 
2.19.2

