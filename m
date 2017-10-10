From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 10 Oct 2017 14:56:58 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: only redistribute MSI-X vectors
	when needed
Message-ID: <1507672618-396715-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Whether or not there are vectors_left, we only need to redistribute
our vectors if we didn't get as many as we requested.  With the current
check, the code will try to redistribute even if we did in fact get all
the vectors we requested - this can happen when we have more CPUs than
we do vectors.  This restores an earlier check to be sure we only
redistribute if we didn't get the full count we requested.

Fixes: 4ce20abc645f (i40e: fix MSI-X vector redistribution if hw limit is reached)
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index bf91958..535e6e7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8176,7 +8176,7 @@ static int i40e_init_msix(struct i40e_pf *pf)
 		pf->num_lan_qps = 1;
 		pf->num_lan_msix = 1;
 
-	} else if (!vectors_left) {
+	} else if (v_actual != v_budget) {
 		/* If we have limited resources, we will start with no vectors
 		 * for the special features and then allocate vectors to some
 		 * of these features based on the policy and at the end disable
@@ -8185,7 +8185,8 @@ static int i40e_init_msix(struct i40e_pf *pf)
 		int vec;
 
 		dev_info(&pf->pdev->dev,
-			 "MSI-X vector limit reached, attempting to redistribute vectors\n");
+			 "MSI-X vector limit reached with %d, wanted %d, attempting to redistribute vectors\n",
+			 v_actual, v_budget);
 		/* reserve the misc vector */
 		vec = v_actual - 1;
 
-- 
1.7.1

