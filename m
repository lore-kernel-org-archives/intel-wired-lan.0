From: Li RongQing <lirongqing@baidu.com>
Date: Wed,  1 Jul 2020 16:54:53 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: not compute affinity_mask for IRQ
Message-ID: <1593593693-31299-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After commit 759dc4a7e605 ("i40e: initialize our affinity_mask
based on cpu_possible_mask"), NAPI IRQ affinity_mask is bind to
all possible cpus, not a fixed cpu

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5d807c8004f8..a63548cb022d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11156,11 +11156,10 @@ static int i40e_init_msix(struct i40e_pf *pf)
  * i40e_vsi_alloc_q_vector - Allocate memory for a single interrupt vector
  * @vsi: the VSI being configured
  * @v_idx: index of the vector in the vsi struct
- * @cpu: cpu to be used on affinity_mask
  *
  * We allocate one q_vector.  If allocation fails we return -ENOMEM.
  **/
-static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx, int cpu)
+static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 {
 	struct i40e_q_vector *q_vector;
 
@@ -11193,7 +11192,7 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx, int cpu)
 static int i40e_vsi_alloc_q_vectors(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
-	int err, v_idx, num_q_vectors, current_cpu;
+	int err, v_idx, num_q_vectors;
 
 	/* if not MSIX, give the one vector only to the LAN VSI */
 	if (pf->flags & I40E_FLAG_MSIX_ENABLED)
@@ -11203,15 +11202,10 @@ static int i40e_vsi_alloc_q_vectors(struct i40e_vsi *vsi)
 	else
 		return -EINVAL;
 
-	current_cpu = cpumask_first(cpu_online_mask);
-
 	for (v_idx = 0; v_idx < num_q_vectors; v_idx++) {
-		err = i40e_vsi_alloc_q_vector(vsi, v_idx, current_cpu);
+		err = i40e_vsi_alloc_q_vector(vsi, v_idx);
 		if (err)
 			goto err_out;
-		current_cpu = cpumask_next(current_cpu, cpu_online_mask);
-		if (unlikely(current_cpu >= nr_cpu_ids))
-			current_cpu = cpumask_first(cpu_online_mask);
 	}
 
 	return 0;
-- 
2.16.2

