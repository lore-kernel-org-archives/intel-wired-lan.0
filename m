From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:08 -0800
Subject: [Intel-wired-lan] [next PATCH S26 08/12] i40e: negate phy int mask
	bits
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-9-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

The phy interrupt mask bits mask out the events we don't want,
so we need to negate the bitmask of events we want.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I273244da5a8d285b6abc84fd68a90f1e6fa0393e
---
Testing Hints:
The software will not be notified that an empty module has been
placed into the cage, and link has not been established.

 drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 37d6979..2939ce8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6816,12 +6816,12 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 	if (ret)
 		goto end_core_reset;
 
-	/* driver is only interested in link up/down and module qualification
-	 * reports from firmware
+	/* The driver only wants link up/down and module qualification
+	 * reports from firmware.  Note the negative logic.
 	 */
 	ret = i40e_aq_set_phy_int_mask(&pf->hw,
-				       I40E_AQ_EVENT_LINK_UPDOWN |
-				       I40E_AQ_EVENT_MODULE_QUAL_FAIL, NULL);
+				       ~(I40E_AQ_EVENT_LINK_UPDOWN |
+					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (ret)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
 			 i40e_stat_str(&pf->hw, ret),
@@ -10959,12 +10959,12 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
-	/* driver is only interested in link up/down and module qualification
-	 * reports from firmware
+	/* The driver only wants link up/down and module qualification
+	 * reports from firmware.  Note the negative logic.
 	 */
 	err = i40e_aq_set_phy_int_mask(&pf->hw,
-				       I40E_AQ_EVENT_LINK_UPDOWN |
-				       I40E_AQ_EVENT_MODULE_QUAL_FAIL, NULL);
+				       ~(I40E_AQ_EVENT_LINK_UPDOWN |
+					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (err)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %s aq_err %s\n",
 			 i40e_stat_str(&pf->hw, err),
-- 
2.1.0

