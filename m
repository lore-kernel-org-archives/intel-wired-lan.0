From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:50 -0400
Subject: [Intel-wired-lan] [next PATCH S15 03/15] i40e: Change some messages
	from info to debug only
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

There are several error messages that have been printing when there is
no functional issue. These messages should be available at debug message
level only.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Id91e47bf942c483563995f30d8705fa53acd5aa3
---
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  7 +++----
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c   |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 21 +++++++++++++--------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 7c42d13..886e667 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -240,10 +240,9 @@ static void i40e_dcbnl_del_app(struct i40e_pf *pf,
 	for (v = 0; v < pf->num_alloc_vsi; v++) {
 		if (pf->vsi[v] && pf->vsi[v]->netdev) {
 			err = i40e_dcbnl_vsi_del_app(pf->vsi[v], app);
-			if (err)
-				dev_info(&pf->pdev->dev, "Failed deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
-					 pf->vsi[v]->seid, err, app->selector,
-					 app->protocolid, app->priority);
+			dev_dbg(&pf->pdev->dev, "Deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
+				pf->vsi[v]->seid, err, app->selector,
+				app->protocolid, app->priority);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
index eaedc1f..2ec2411 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_fcoe.c
@@ -284,7 +284,7 @@ void i40e_init_pf_fcoe(struct i40e_pf *pf)
 	pf->fcoe_hmc_filt_num = 0;
 
 	if (!pf->hw.func_caps.fcoe) {
-		dev_info(&pf->pdev->dev, "FCoE capability is disabled\n");
+		dev_dbg(&pf->pdev->dev, "FCoE capability is disabled\n");
 		return;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fee2127..23f36be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6518,9 +6518,9 @@ static void i40e_reset_and_rebuild(struct i40e_pf *pf, bool reinit)
 	/* make sure our flow control settings are restored */
 	ret = i40e_set_fc(&pf->hw, &set_fc_aq_fail, true);
 	if (ret)
-		dev_info(&pf->pdev->dev, "set fc fail, err %s aq_err %s\n",
-			 i40e_stat_str(&pf->hw, ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+		dev_dbg(&pf->pdev->dev, "setting flow control: ret = %s last_status = %s\n",
+			i40e_stat_str(&pf->hw, ret),
+			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 
 	/* Rebuild the VSIs and VEBs that existed before reset.
 	 * They are still in our local switch element arrays, so only
@@ -9877,8 +9877,14 @@ static void i40e_determine_queue_usage(struct i40e_pf *pf)
 	}
 
 	pf->queues_left = queues_left;
+	dev_dbg(&pf->pdev->dev,
+		"qs_avail=%d FD SB=%d lan_qs=%d lan_tc0=%d vf=%d*%d vmdq=%d*%d, remaining=%d\n",
+		pf->hw.func_caps.num_tx_qp,
+		!!(pf->flags & I40E_FLAG_FD_SB_ENABLED),
+		pf->num_lan_qps, pf->rss_size, pf->num_req_vfs, pf->num_vf_qps,
+		pf->num_vmdq_vsis, pf->num_vmdq_qps, queues_left);
 #ifdef I40E_FCOE
-	dev_info(&pf->pdev->dev, "fcoe queues = %d\n", pf->num_fcoe_qps);
+	dev_dbg(&pf->pdev->dev, "fcoe queues = %d\n", pf->num_fcoe_qps);
 #endif
 }
 
@@ -10364,10 +10370,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* get the requested speeds from the fw */
 	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
 	if (err)
-		dev_info(&pf->pdev->dev,
-			 "get phy capabilities failed, err %s aq_err %s, advertised speed settings may not be correct\n",
-			 i40e_stat_str(&pf->hw, err),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %s last_status =  %s\n",
+			i40e_stat_str(&pf->hw, err),
+			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
 	/* get the supported phy types from the fw */
-- 
1.9.3

