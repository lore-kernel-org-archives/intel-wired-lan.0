From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue,  7 Apr 2020 15:11:39 -0700
Subject: [Intel-wired-lan] [next-queue v2] i40e: Add a check to see if MFS
 is set
Message-ID: <20200407221139.2233977-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Todd Fujinaka <todd.fujinaka@intel.com>

A customer was chain-booting to provision his systems and one of the
steps was setting MFS. MFS isn't cleared by normal warm reboots
(clearing requires a GLOBR) and there was no indication of why Jumbo
Frame receives were failing.

Add a warning if MFS is set to anything lower than the default.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: added missing defines

 drivers/net/ethernet/intel/i40e/i40e_main.c     | 9 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_register.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b08dccbe6ef2..75189c16604e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15344,6 +15344,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			i40e_stat_str(&pf->hw, err),
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
+	/* make sure the MFS hasn't been set lower than the default */
+#define MAX_FRAME_SIZE_DEFAULT 0x2600
+	for (i = 0; i < 4; i++) {
+		val = ((rd32(&pf->hw, I40E_PRTGL_SAH) & I40E_PRTGL_SAH_MFS_MASK)
+			>> I40E_PRTGL_SAH_MFS_SHIFT);
+		if (val < MAX_FRAME_SIZE_DEFAULT)
+			dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n", i, val);
+	}
+
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
 	 * PAUSE or PFC frames and potentially controlling traffic for other
diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 0653b3bed2f2..4eeedcdee342 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -349,6 +349,14 @@
 #define I40E_VSILAN_QBASE_VSIQTABLE_ENA_SHIFT 11
 #define I40E_VSILAN_QBASE_VSIQTABLE_ENA_MASK I40E_MASK(0x1, I40E_VSILAN_QBASE_VSIQTABLE_ENA_SHIFT)
 #define I40E_VSILAN_QTABLE(_i, _VSI) (0x00200000 + ((_i) * 2048 + (_VSI) * 4)) /* _i=0...7, _VSI=0...383 */ /* Reset: PFR */
+#define I40E_PRTGL_SAH			0x001E2140 /* Reset: GLOBR */
+#define I40E_PRTGL_SAH_FC_SAH_SHIFT	0
+#define I40E_PRTGL_SAH_FC_SAH_MASK	I40E_MASK(0xFFFF, I40E_PRTGL_SAH_FC_SAH_SHIFT)
+#define I40E_PRTGL_SAH_MFS_SHIFT	16
+#define I40E_PRTGL_SAH_MFS_MASK		I40E_MASK(0xFFFF, I40E_PRTGL_SAH_MFS_SHIFT)
+#define I40E_PRTGL_SAL			0x001E2120 /* Reset: GLOBR */
+#define I40E_PRTGL_SAL_FC_SAL_SHIFT	0
+#define I40E_PRTGL_SAL_FC_SAL_MASK	I40E_MASK(0xFFFFFFFF, I40E_PRTGL_SAL_FC_SAL_SHIFT)
 #define I40E_GLNVM_FLA 0x000B6108 /* Reset: POR */
 #define I40E_GLNVM_FLA_LOCKED_SHIFT 6
 #define I40E_GLNVM_FLA_LOCKED_MASK I40E_MASK(0x1, I40E_GLNVM_FLA_LOCKED_SHIFT)
-- 
2.25.2

