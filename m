From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:15 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 11/12] i40e: Request phy media
	event at reset time
In-Reply-To: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458328696-135941-12-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the Media Not Available flag to the link event mask.  It seems
that event comes first if you have a DA cable pulled out, but there's no
followup event for Link Down; if you're not looking for MEDIA_NA you will
get no event, even though there's now no Link.

Testing Hints:
	Do some link tests, removing and reinserting the wire, etc.
	after a reset.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: cb3340a2849805bb881f64f6f2ae810eef46eba7
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 18877f0..ba9d0cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6836,6 +6836,7 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 	 */
 	ret = i40e_aq_set_phy_int_mask(&pf->hw,
 				       ~(I40E_AQ_EVENT_LINK_UPDOWN |
+					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (ret)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
@@ -10992,6 +10993,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	err = i40e_aq_set_phy_int_mask(&pf->hw,
 				       ~(I40E_AQ_EVENT_LINK_UPDOWN |
+					 I40E_AQ_EVENT_MEDIA_NA |
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (err)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
-- 
2.4.3

