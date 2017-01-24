From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 24 Jan 2017 10:24:01 -0800
Subject: [Intel-wired-lan] [next PATCH S58-V3 4/4] i40e: don't add more
	vectors to num_lan_msix than number of CPUs
In-Reply-To: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
References: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485282241-3579-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This is a solution to avoid adding too many queues to num_lan_msix.
A recent refactor of queue pairs accidentally added all remaining
vectors to the num_lan_msix which can have adverse performance issues,
due to enabling more queues than the number of CPU cores.

This patch removes the old calculation, and replaces it with a simple
algorithm.

1) add queue pairs up to num_online_cpus(), but capped at half of total
   vectors
2) then add alternative features such as flow directory and similar
3) finally, add the remaining vectors back to queue pairs, but capped
   such that the total number of queue pairs does not exceed
   num_online_cpus().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I668abf67d5011a1248866daba8885f4ff00cb8d9
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 30 ++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index ad7b9ba..357f7df 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8027,6 +8027,7 @@ static int i40e_reserve_msix_vectors(struct i40e_pf *pf, int vectors)
 static int i40e_init_msix(struct i40e_pf *pf)
 {
 	struct i40e_hw *hw = &pf->hw;
+	int cpus, extra_vectors;
 	int vectors_left;
 	int v_budget, i;
 	int v_actual;
@@ -8062,10 +8063,16 @@ static int i40e_init_msix(struct i40e_pf *pf)
 		vectors_left--;
 	}
 
-	/* reserve vectors for the main PF traffic queues */
-	pf->num_lan_msix = min_t(int, num_online_cpus(), vectors_left);
+	/* reserve some vectors for the main PF traffic queues. Initially we
+	 * only reserve at most 50% of the available vectors, in the case that
+	 * the number of online CPUs is large. This ensures that we can enable
+	 * extra features as well. Once we've enabled the other features, we
+	 * will use any remaining vectors to reach as close as we can to the
+	 * number of online CPUs.
+	 */
+	cpus = num_online_cpus();
+	pf->num_lan_msix = min_t(int, cpus, vectors_left / 2);
 	vectors_left -= pf->num_lan_msix;
-	v_budget += pf->num_lan_msix;
 
 	/* reserve one vector for sideband flow director */
 	if (pf->flags & I40E_FLAG_FD_SB_ENABLED) {
@@ -8128,6 +8135,23 @@ static int i40e_init_msix(struct i40e_pf *pf)
 		}
 	}
 
+	/* On systems with a large number of SMP cores, we previously limited
+	 * the number of vectors for num_lan_msix to be at most 50% of the
+	 * available vectors, to allow for other features. Now, we add back
+	 * the remaining vectors. However, we ensure that the total
+	 * num_lan_msix will not exceed num_online_cpus(). To do this, we
+	 * calculate the number of vectors we can add without going over the
+	 * cap of CPUs. For systems with a small number of CPUs this will be
+	 * zero.
+	 */
+	extra_vectors = min_t(int, cpus - pf->num_lan_msix, vectors_left);
+	pf->num_lan_msix += extra_vectors;
+	vectors_left -= extra_vectors;
+
+	WARN(vectors_left < 0,
+	     "Calculation of remaining vectors underflowed. This is an accounting bug when determining total MSI-X vectors.\n");
+
+	v_budget += pf->num_lan_msix;
 	pf->msix_entries = kcalloc(v_budget, sizeof(struct msix_entry),
 				   GFP_KERNEL);
 	if (!pf->msix_entries)
-- 
2.4.11

