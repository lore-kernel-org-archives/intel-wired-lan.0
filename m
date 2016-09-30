From: Dave Ertman <david.m.ertman@intel.com>
Date: Fri, 30 Sep 2016 01:36:21 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix bit logic error in failure case
Message-ID: <1475224581-121904-1-git-send-email-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Patch a036244c0686 "i40e: Fix kernel panic on enable/disable LLDP"
introduced an error in bit logic.

Originally this bit manipulation was meant to clear two bits to indicate
that DCB was not enabled or capable. An "&" was incorrectly used instead
of an "|" bit operator to combine the two bitmasks into one.  This also
created a static checker error since the resultant code was a no-op.

This patch fixes the error by using the correct bit-wise operator.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Found-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8176596..bf68dd7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10955,7 +10955,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = i40e_init_pf_dcb(pf);
 	if (err) {
 		dev_info(&pdev->dev, "DCB init failed %d, disabled\n", err);
-		pf->flags &= ~(I40E_FLAG_DCB_CAPABLE & I40E_FLAG_DCB_ENABLED);
+		pf->flags &= ~(I40E_FLAG_DCB_CAPABLE | I40E_FLAG_DCB_ENABLED);
 		/* Continue without DCB enabled */
 	}
 #endif /* CONFIG_I40E_DCB */
-- 
2.7.4

