From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:44 -0700
Subject: [Intel-wired-lan] [next PATCH S91 06/11] i40e: Fix recalculation of
 MSI-X vectors for VMDq
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

This patch adds a recalculation of number of MSI-X
vectors for VMDq in the case where we have less
vectors available than we would want to reserve for
VMDq.

It fixes the issue where we recalculate vectors left
and vectors wanted but we didn't take into account
the reduced number of queue pairs per VSI.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c8659fb..f17867a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10309,21 +10309,28 @@ static int i40e_init_msix(struct i40e_pf *pf)
 
 	/* any vectors left over go for VMDq support */
 	if (pf->flags & I40E_FLAG_VMDQ_ENABLED) {
-		int vmdq_vecs_wanted = pf->num_vmdq_vsis * pf->num_vmdq_qps;
-		int vmdq_vecs = min_t(int, vectors_left, vmdq_vecs_wanted);
-
 		if (!vectors_left) {
 			pf->num_vmdq_msix = 0;
 			pf->num_vmdq_qps = 0;
 		} else {
+			int vmdq_vecs_wanted =
+				pf->num_vmdq_vsis * pf->num_vmdq_qps;
+			int vmdq_vecs =
+				min_t(int, vectors_left, vmdq_vecs_wanted);
+
 			/* if we're short on vectors for what's desired, we limit
 			 * the queues per vmdq.  If this is still more than are
 			 * available, the user will need to change the number of
 			 * queues/vectors used by the PF later with the ethtool
 			 * channels command
 			 */
-			if (vmdq_vecs < vmdq_vecs_wanted)
+			if (vectors_left < vmdq_vecs_wanted) {
 				pf->num_vmdq_qps = 1;
+				vmdq_vecs_wanted = pf->num_vmdq_vsis;
+				vmdq_vecs = min_t(int,
+						  vectors_left,
+						  vmdq_vecs_wanted);
+			}
 			pf->num_vmdq_msix = pf->num_vmdq_qps;
 
 			v_budget += vmdq_vecs;
-- 
2.9.5

