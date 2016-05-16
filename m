From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 16 May 2016 10:26:38 -0700
Subject: [Intel-wired-lan] [next PATCH S37 08/15] i40e: Save PCI state
	before suspend
In-Reply-To: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1463419605-30746-9-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

The i40e_suspend() function was failing to save PCI state
and this would result in a kernel stack trace from a WARN_ONCE in the
pci_legacy_suspend() function.

Add a call to pci_save_state() to fix that problem.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: I4736e62bb660966bd208cc8af617a14cb07fc4bd
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d71b6bc..ae4d089 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11525,6 +11525,7 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct i40e_pf *pf = pci_get_drvdata(pdev);
 	struct i40e_hw *hw = &pf->hw;
+	int retval = 0;
 
 	set_bit(__I40E_SUSPENDED, &pf->state);
 	set_bit(__I40E_DOWN, &pf->state);
@@ -11538,10 +11539,14 @@ static int i40e_suspend(struct pci_dev *pdev, pm_message_t state)
 
 	i40e_stop_misc_vector(pf);
 
+	retval = pci_save_state(pdev);
+	if (retval)
+		return retval;
+
 	pci_wake_from_d3(pdev, pf->wol_en);
 	pci_set_power_state(pdev, PCI_D3hot);
 
-	return 0;
+	return retval;
 }
 
 /**
-- 
2.4.11

