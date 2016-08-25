From: Dave Ertman <david.m.ertman@intel.com>
Date: Thu, 25 Aug 2016 02:15:59 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e: Fix kernel panic on
	enable/disable lldp
Message-ID: <1472116559-93975-1-git-send-email-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If DCB is configured on the link partner switch with an
unsupported traffic class configuration (e.g. non-contiguous TCs),
the driver is flagging DCB as disabled.  But, for future DCB
LLDPDUs, the driver was checking if the interface was DCB capable
instead of enabled.  This was causing a kernel panic when lldp
was enabled/disabled on the link partner switch.

This patch corrects the situation by having the lldp event handler
check the correct flag in the pf structure.  It also cleans up the
setting and clearing of the enabled flag for other checks.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c6ac7a6..3c21e41 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5113,9 +5113,13 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 				       DCB_CAP_DCBX_VER_IEEE;
 
 			pf->flags |= I40E_FLAG_DCB_CAPABLE;
-			/* Enable DCB tagging only when more than one TC */
+			/* Enable DCB tagging only when more than one TC
+			 * or explicitly disable if only one TC
+			 */
 			if (i40e_dcb_get_num_tc(&hw->local_dcbx_config) > 1)
 				pf->flags |= I40E_FLAG_DCB_ENABLED;
+			else
+				pf->flags &= ~I40E_FLAG_DCB_ENABLED;
 			dev_dbg(&pf->pdev->dev,
 				"DCBX offload is supported for this PF.\n");
 		}
@@ -5717,7 +5721,7 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 	u8 type;
 
 	/* Not DCB capable or capability disabled */
-	if (!(pf->flags & I40E_FLAG_DCB_CAPABLE))
+	if (!(pf->flags & I40E_FLAG_DCB_ENABLED))
 		return ret;
 
 	/* Ignore if event is not for Nearest Bridge */
@@ -7897,6 +7901,7 @@ static int i40e_init_interrupt_scheme(struct i40e_pf *pf)
 #endif
 				       I40E_FLAG_RSS_ENABLED	|
 				       I40E_FLAG_DCB_CAPABLE	|
+				       I40E_FLAG_DCB_ENABLED	|
 				       I40E_FLAG_SRIOV_ENABLED	|
 				       I40E_FLAG_FD_SB_ENABLED	|
 				       I40E_FLAG_FD_ATR_ENABLED	|
@@ -10503,6 +10508,7 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 			       I40E_FLAG_FD_SB_ENABLED	|
 			       I40E_FLAG_FD_ATR_ENABLED	|
 			       I40E_FLAG_DCB_CAPABLE	|
+			       I40E_FLAG_DCB_ENABLED	|
 			       I40E_FLAG_SRIOV_ENABLED	|
 			       I40E_FLAG_VMDQ_ENABLED);
 	} else if (!(pf->flags & (I40E_FLAG_RSS_ENABLED |
@@ -10526,7 +10532,8 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 		/* Not enough queues for all TCs */
 		if ((pf->flags & I40E_FLAG_DCB_CAPABLE) &&
 		    (queues_left < I40E_MAX_TRAFFIC_CLASS)) {
-			pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+			pf->flags &= ~(I40E_FLAG_DCB_CAPABLE |
+					I40E_FLAG_DCB_ENABLED);
 			dev_info(&pf->pdev->dev, "not enough queues for DCB. DCB is disabled.\n");
 		}
 		pf->num_lan_qps = max_t(int, pf->rss_size_max,
@@ -10923,7 +10930,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = i40e_init_pf_dcb(pf);
 	if (err) {
 		dev_info(&pdev->dev, "DCB init failed %d, disabled\n", err);
-		pf->flags &= ~I40E_FLAG_DCB_CAPABLE;
+		pf->flags &= ~(I40E_FLAG_DCB_CAPABLE & I40E_FLAG_DCB_ENABLED);
 		/* Continue without DCB enabled */
 	}
 #endif /* CONFIG_I40E_DCB */
-- 
2.7.4

