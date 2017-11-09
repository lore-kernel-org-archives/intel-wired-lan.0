From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 08 Nov 2017 16:38:43 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Remove limit of
 64 max queues per channel
Message-ID: <151018792366.14946.6477127974398632743.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It is safe to remove the upper limit of 64 queues on a channel
VSI. The upper bound is determined by the VSI's num_queue_pairs
and gets validated when the queue mapping info through mqprio
interface is subject to bound checking in the driver.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      |    1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c |    8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 5829715..e019baa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -90,7 +90,6 @@
 #define I40E_AQ_LEN			256
 #define I40E_AQ_WORK_LIMIT		66 /* max number of VFs + a little */
 #define I40E_MAX_USER_PRIORITY		8
-#define I40E_MAX_QUEUES_PER_CH		64
 #define I40E_DEFAULT_TRAFFIC_CLASS	BIT(0)
 #define I40E_DEFAULT_MSG_ENABLE		4
 #define I40E_QUEUE_WAIT_RETRY_LIMIT	10
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 02880d8..c3fb545 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5629,14 +5629,6 @@ static int i40e_validate_num_queues(struct i40e_pf *pf, int num_queues,
 		return -EINVAL;
 
 	*reconfig_rss = false;
-
-	if (num_queues > I40E_MAX_QUEUES_PER_CH) {
-		dev_err(&pf->pdev->dev,
-			"Failed to create VMDq VSI. User requested num_queues (%d) > I40E_MAX_QUEUES_PER_VSI (%u)\n",
-			num_queues, I40E_MAX_QUEUES_PER_CH);
-		return -EINVAL;
-	}
-
 	if (vsi->current_rss_size) {
 		if (num_queues > vsi->current_rss_size) {
 			dev_dbg(&pf->pdev->dev,

