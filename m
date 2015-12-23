From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:55 -0800
Subject: [Intel-wired-lan] [next PATCH S25 15/16] i40e: trivial: remove
	unnecessary local var
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-16-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Probe routine already has too many locals, just convert one
used for kzalloc into a kcalloc, eliminating the local.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Singhai, Anjali <anjali.singhai@intel.com>
Change-ID: I349049872b71f858cbeb91ad7836e6767fc7b7d1
---
Testing-Hints: compile test only.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f751a80..eeaa794 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10538,7 +10538,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u16 wol_nvm_bits;
 	u16 link_status;
 	int err;
-	u32 len;
 	u32 val;
 	u32 i;
 	u8 set_fc_aq_fail;
@@ -10791,8 +10790,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		pf->num_alloc_vsi = pf->hw.func_caps.num_vsis;
 
 	/* Set up the *vsi struct and our local tracking of the MAIN PF vsi. */
-	len = sizeof(struct i40e_vsi *) * pf->num_alloc_vsi;
-	pf->vsi = kzalloc(len, GFP_KERNEL);
+	pf->vsi = kcalloc(pf->num_alloc_vsi, sizeof(struct i40e_vsi *),
+			  GFP_KERNEL);
 	if (!pf->vsi) {
 		err = -ENOMEM;
 		goto err_switch_setup;
-- 
2.1.0

