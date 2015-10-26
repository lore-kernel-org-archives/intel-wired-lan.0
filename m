From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 26 Oct 2015 19:44:35 -0400
Subject: [Intel-wired-lan] [next PATCH S20 09/15] i40e: Update error
	messaging
In-Reply-To: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445903081-155893-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes an issue where adminq init failures always provided
a message that NVM was newer than expected.  This is not always the
case for init_adminq failures. Without this patch, if adminq init
fails for any reason, newer nvm message would be given.  This
problem is fixed by adding  a check for that specific error
condition and a different hopefully helpful message otherwise.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Iaeaebee4e398989eae40bb70f943ab66a3a521a5

---
Testing-hints: This was only seen with SOME bricked cards. If you have one
that happens to work, you will see an erroneous error message that the
firmware is too new. If you cannot find a card that will reproduce the
error, a simple compile and check that the code is there is sufficient.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 491c82f..508cf9a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10471,6 +10471,16 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pf->hw.fc.requested_mode = I40E_FC_NONE;
 
 	err = i40e_init_adminq(hw);
+	if (err) {
+		if (err == I40E_ERR_FIRMWARE_API_VERSION)
+			dev_info(&pdev->dev,
+				 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
+		else
+			dev_info(&pdev->dev,
+				 "The driver for the device stopped because the device firmware failed to init. Try updating your NVM image.\n");
+
+		goto err_pf_reset;
+	}
 
 	/* provide nvm, fw, api versions */
 	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s\n",
@@ -10478,12 +10488,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
 		 i40e_nvm_version_str(hw));
 
-	if (err) {
-		dev_info(&pdev->dev,
-			 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
-		goto err_pf_reset;
-	}
-
 	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
 	    hw->aq.api_min_ver > I40E_FW_API_VERSION_MINOR)
 		dev_info(&pdev->dev,
-- 
1.9.3

