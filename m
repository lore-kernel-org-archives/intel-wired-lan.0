From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Wed, 23 Dec 2015 12:05:47 -0800
Subject: [Intel-wired-lan] [next PATCH S25 07/16] i40e: fix
	write-back-on-itr to work with legacy itr
In-Reply-To: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1450901156-30904-8-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

We were not doing write-back on interrupt throttle for Legacy case in X722.
This patch fixes that, so we do WB_ON_ITR for Legacy as well. Plus the issue
that we should still be setting NO_ITR if we are touching the DYN_CTLN register
since we do not want to change ITR setting here.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Change-ID: I5db8491ee1544118a389db839cecc93e1bbc480e
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 18 +++++++++++++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  3 ++-
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 94dbeb3..b15d0fa 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -789,12 +789,20 @@ void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)
 		if (q_vector->arm_wb_state)
 			return;
 
-		val = I40E_PFINT_DYN_CTLN_WB_ON_ITR_MASK;
+		if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED) {
+			val = I40E_PFINT_DYN_CTLN_WB_ON_ITR_MASK |
+			      I40E_PFINT_DYN_CTLN_ITR_INDX_MASK; /* set noitr */
+
+			wr32(&vsi->back->hw,
+			     I40E_PFINT_DYN_CTLN(q_vector->v_idx +
+						 vsi->base_vector - 1),
+			     val);
+		} else {
+			val = I40E_PFINT_DYN_CTL0_WB_ON_ITR_MASK |
+			      I40E_PFINT_DYN_CTL0_ITR_INDX_MASK; /* set noitr */
 
-		wr32(&vsi->back->hw,
-		     I40E_PFINT_DYN_CTLN(q_vector->v_idx +
-					 vsi->base_vector - 1),
-		     val);
+			wr32(&vsi->back->hw, I40E_PFINT_DYN_CTL0, val);
+		}
 		q_vector->arm_wb_state = true;
 	} else if (vsi->back->flags & I40E_FLAG_MSIX_ENABLED) {
 		u32 val = I40E_PFINT_DYN_CTLN_INTENA_MASK |
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 0e2c627..6a4da0a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -307,7 +307,8 @@ static void i40evf_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector
 		if (q_vector->arm_wb_state)
 			return;
 
-		val = I40E_VFINT_DYN_CTLN1_WB_ON_ITR_MASK;
+		val = I40E_VFINT_DYN_CTLN1_WB_ON_ITR_MASK |
+		      I40E_VFINT_DYN_CTLN1_ITR_INDX_MASK; /* set noitr */
 
 		wr32(&vsi->back->hw,
 		     I40E_VFINT_DYN_CTLN1(q_vector->v_idx +
-- 
2.1.0

