From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 21 Apr 2020 15:17:34 -0700
Subject: [Intel-wired-lan] [net-next v2] i40e: Add a check to see if MFS is
 set
Message-ID: <20200421221734.503494-1-jeffrey.t.kirsher@intel.com>
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
---
v2: fix the math calculation on accessing the SAH register

 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4c414208a22a..61311d1e772c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15347,6 +15347,15 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			i40e_stat_str(&pf->hw, err),
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
+	/* make sure the MFS hasn't been set lower than the default */
+#define MAX_FRAME_SIZE_DEFAULT 0x2600
+	for (i = 0; i < 4; i++) {
+		val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
+		       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
+		if (val < MAX_FRAME_SIZE_DEFAULT)
+			dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n", i, val);
+	}
+
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
 	 * PAUSE or PFC frames and potentially controlling traffic for other
-- 
2.25.3

