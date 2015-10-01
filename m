From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:38 -0400
Subject: [Intel-wired-lan] [next PATCH S18 5/8] i40e: fix inconsistent
	statuses after a PF reset
In-Reply-To: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443724661-92168-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

This patch fixes a problem of possibly getting inconsistent flow control
statuses after a PF reset. Requested_mode was being set with a default
value during probing, but the initial HW state could be different from
this mode.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: I772bf07b78616e87086418d4bd87954b66fa17cd

---
Testing-hints: 5644395
 drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a56aefe..a887fd9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10200,6 +10200,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int err;
 	u32 len;
 	u32 i;
+	u8 set_fc_aq_fail;
 
 	err = pci_enable_device_mem(pdev);
 	if (err)
@@ -10464,6 +10465,25 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_info(&pdev->dev, "setup_pf_switch failed: %d\n", err);
 		goto err_vsis;
 	}
+
+	/* Make sure flow control is set according to current settings */
+	err = i40e_set_fc(hw, &set_fc_aq_fail, true);
+	if (set_fc_aq_fail & I40E_SET_FC_AQ_FAIL_GET)
+		dev_dbg(&pf->pdev->dev,
+			"Set fc with err %s aq_err %s on get_phy_cap\n",
+			i40e_stat_str(hw, err),
+			i40e_aq_str(hw, hw->aq.asq_last_status));
+	if (set_fc_aq_fail & I40E_SET_FC_AQ_FAIL_SET)
+		dev_dbg(&pf->pdev->dev,
+			"Set fc with err %s aq_err %s on set_phy_config\n",
+			i40e_stat_str(hw, err),
+			i40e_aq_str(hw, hw->aq.asq_last_status));
+	if (set_fc_aq_fail & I40E_SET_FC_AQ_FAIL_UPDATE)
+		dev_dbg(&pf->pdev->dev,
+			"Set fc with err %s aq_err %s on get_link_info\n",
+			i40e_stat_str(hw, err),
+			i40e_aq_str(hw, hw->aq.asq_last_status));
+
 	/* if FDIR VSI was set up, start it now */
 	for (i = 0; i < pf->num_alloc_vsi; i++) {
 		if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
-- 
1.9.3

