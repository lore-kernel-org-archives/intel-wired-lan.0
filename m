From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue,  1 Mar 2016 16:02:15 -0800
Subject: [Intel-wired-lan] [PATCH] i40evf: remove dead code
Message-ID: <1456876935-4810-1-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Cox <alan@linux.intel.com>

The only error case is when the malloc fails, in which case the clean up
loop does nothing at all, so remove it

Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 66964eb..c1cb910 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1506,7 +1506,7 @@ static int i40evf_alloc_q_vectors(struct i40evf_adapter *adapter)
 	adapter->q_vectors = kcalloc(num_q_vectors, sizeof(*q_vector),
 				     GFP_KERNEL);
 	if (!adapter->q_vectors)
-		goto err_out;
+		return -ENOMEM;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		q_vector = &adapter->q_vectors[q_idx];
@@ -1518,15 +1518,6 @@ static int i40evf_alloc_q_vectors(struct i40evf_adapter *adapter)
 	}
 
 	return 0;
-
-err_out:
-	while (q_idx) {
-		q_idx--;
-		q_vector = &adapter->q_vectors[q_idx];
-		netif_napi_del(&q_vector->napi);
-	}
-	kfree(adapter->q_vectors);
-	return -ENOMEM;
 }
 
 /**
