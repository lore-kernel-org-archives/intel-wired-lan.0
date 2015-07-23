From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:37 -0400
Subject: [Intel-wired-lan] [next PATCH S9 08/15] i40e: limit debugfs io ops
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Don't let the debugfs register read and write commands try to access
outside of the ioremapped space.  While we're at it, remove the use of
a misleading constant.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Ifce2893e232c65c7a76c23532c658f298218a81b
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  3 ++-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 12 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 ++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c452527..d821c99 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -71,7 +71,6 @@
 #define I40E_MAX_VEB          16
 
 #define I40E_MAX_NUM_DESCRIPTORS      4096
-#define I40E_MAX_REGISTER     0x800000
 #define I40E_MAX_CSR_SPACE (4 * 1024 * 1024 - 64 * 1024)
 #define I40E_DEFAULT_NUM_DESCRIPTORS  512
 #define I40E_REQ_DESCRIPTOR_MULTIPLE  32
@@ -408,6 +407,8 @@ struct i40e_pf {
 	/* These are only valid in NPAR modes */
 	u32 npar_max_bw;
 	u32 npar_min_bw;
+
+	u32 ioremap_len;
 };
 
 struct i40e_mac_filter {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index d7c15d1..3671611 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1495,9 +1495,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		}
 
 		/* check the range on address */
-		if (address >= I40E_MAX_REGISTER) {
-			dev_info(&pf->pdev->dev, "read reg address 0x%08x too large\n",
-				 address);
+		if (address > (pf->ioremap_len - sizeof(u32))) {
+			dev_info(&pf->pdev->dev, "read reg address 0x%08x too large, max=0x%08lx\n",
+				 address, (pf->ioremap_len - sizeof(u32)));
 			goto command_write_done;
 		}
 
@@ -1514,9 +1514,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		}
 
 		/* check the range on address */
-		if (address >= I40E_MAX_REGISTER) {
-			dev_info(&pf->pdev->dev, "write reg address 0x%08x too large\n",
-				 address);
+		if (address > (pf->ioremap_len - sizeof(u32))) {
+			dev_info(&pf->pdev->dev, "write reg address 0x%08x too large, max=0x%08lx\n",
+				 address, (pf->ioremap_len - sizeof(u32)));
 			goto command_write_done;
 		}
 		wr32(&pf->hw, address, value);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a6a5f45..b267e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9792,7 +9792,6 @@ static void i40e_print_features(struct i40e_pf *pf)
 static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct i40e_aq_get_phy_abilities_resp abilities;
-	unsigned long ioremap_len;
 	struct i40e_pf *pf;
 	struct i40e_hw *hw;
 	static u16 pfs_found;
@@ -9845,15 +9844,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	hw = &pf->hw;
 	hw->back = pf;
 
-	ioremap_len = min_t(unsigned long, pci_resource_len(pdev, 0),
-			    I40E_MAX_CSR_SPACE);
+	pf->ioremap_len = min_t(int, pci_resource_len(pdev, 0),
+				I40E_MAX_CSR_SPACE);
 
-	hw->hw_addr = ioremap(pci_resource_start(pdev, 0), ioremap_len);
+	hw->hw_addr = ioremap(pci_resource_start(pdev, 0), pf->ioremap_len);
 	if (!hw->hw_addr) {
 		err = -EIO;
 		dev_info(&pdev->dev, "ioremap(0x%04x, 0x%04x) failed: 0x%x\n",
 			 (unsigned int)pci_resource_start(pdev, 0),
-			 (unsigned int)pci_resource_len(pdev, 0), err);
+			 pf->ioremap_len, err);
 		goto err_ioremap;
 	}
 	hw->vendor_id = pdev->vendor;
-- 
1.9.3

