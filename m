From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Tue, 23 Jan 2018 00:50:23 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix the number
 of queues available to be mapped for use
Message-ID: <151669742383.55162.13181985807500442895.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the number of queues per enabled TC and report available queues
to the kernel without having to limit them to the max rss limit so
they are available to be mapped for XPS. This allows a queue per
processing thread available for handling traffic for the given
traffic class.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7808659..4da2087 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1778,7 +1778,7 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	struct i40e_pf *pf = vsi->back;
 	u16 sections = 0;
 	u8 netdev_tc = 0;
-	u16 numtc = 0;
+	u16 numtc = 1;
 	u16 qcount;
 	u8 offset;
 	u16 qmap;
@@ -1788,9 +1788,11 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 	sections = I40E_AQ_VSI_PROP_QUEUE_MAP_VALID;
 	offset = 0;
 
+	/* Number of queues per enabled TC */
+	num_tc_qps = vsi->alloc_queue_pairs;
 	if (enabled_tc && (vsi->back->flags & I40E_FLAG_DCB_ENABLED)) {
 		/* Find numtc from enabled TC bitmap */
-		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
+		for (i = 0, numtc = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
 			if (enabled_tc & BIT(i)) /* TC is enabled */
 				numtc++;
 		}
@@ -1798,18 +1800,13 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 			dev_warn(&pf->pdev->dev, "DCB is enabled but no TC enabled, forcing TC0\n");
 			numtc = 1;
 		}
-	} else {
-		/* At least TC0 is enabled in non-DCB, non-MQPRIO case */
-		numtc = 1;
+		num_tc_qps = num_tc_qps / numtc;
+		num_tc_qps = min_t(int, num_tc_qps,
+				   i40e_pf_get_max_q_per_tc(pf));
 	}
 
 	vsi->tc_config.numtc = numtc;
 	vsi->tc_config.enabled_tc = enabled_tc ? enabled_tc : 1;
-	/* Number of queues per enabled TC */
-	qcount = vsi->alloc_queue_pairs;
-
-	num_tc_qps = qcount / numtc;
-	num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
 
 	/* Do not allow use more TC queue pairs than MSI-X vectors exist */
 	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
@@ -1824,9 +1821,13 @@ static void i40e_vsi_setup_queue_map(struct i40e_vsi *vsi,
 
 			switch (vsi->type) {
 			case I40E_VSI_MAIN:
-				qcount = min_t(int, pf->alloc_rss_size,
-					       num_tc_qps);
-				break;
+				if (!(pf->flags & (I40E_FLAG_FD_SB_ENABLED |
+				    I40E_FLAG_FD_ATR_ENABLED)) ||
+				    vsi->tc_config.enabled_tc != 1) {
+					qcount = min_t(int, pf->alloc_rss_size,
+						       num_tc_qps);
+					break;
+				}
 			case I40E_VSI_FDIR:
 			case I40E_VSI_SRIOV:
 			case I40E_VSI_VMDQ2:

