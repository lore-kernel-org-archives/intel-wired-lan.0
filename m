From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:29 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 11/12] i40e: Request phy media
	event at reset time
In-Reply-To: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
References: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458232890-110933-12-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

As we did at driver startup, be sure to ask for the Media Not Available
flag in the link event mask.

Testing Hints:
	Do some link tests, removing and reinserting the wire, etc.
	after a reset.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
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

