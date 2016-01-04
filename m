From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:01 -0800
Subject: [Intel-wired-lan] [next PATCH S26 01/12] i40e: trivial: drop
	duplicate definition
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-2-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The probe routine already had a u32 val declared, no need
to do it again.  Found by W=2 compile.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Id7b65f6d0ef6bb71067d0557f5be0202b6d8741e
---
Testing-Hints:
Try making W=2 and check output for:
 "val" shadow declaration is gone.
 /driver/i40e/i40e_main.c: In function ???i40e_probe???:
 /driver/i40e/i40e_main.c:10752:7: warning: declaration of ???val??? shadows
 a previous local [-Wshadow]
 /driver/i40e/i40e_main.c:10411:6: note: shadowed declaration is here

 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2ac9a00..766a887 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11006,8 +11006,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if ((pf->flags & I40E_FLAG_SRIOV_ENABLED) &&
 	    (pf->flags & I40E_FLAG_MSIX_ENABLED) &&
 	    !test_bit(__I40E_BAD_EEPROM, &pf->state)) {
-		u32 val;
-
 		/* disable link interrupts for VFs */
 		val = rd32(hw, I40E_PFGEN_PORTMDIO_NUM);
 		val &= ~I40E_PFGEN_PORTMDIO_NUM_VFLINK_STAT_ENA_MASK;
-- 
2.1.0

