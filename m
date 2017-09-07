From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:56 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 11/11] i40e: use a local
	variable instead of calculating multiple times
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-11-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

The computed result of I40E_MAX_VSI_QP * I40E_VIRTCHNL_SUPPORTED_QTYPES
is used more than three times in function i40e_config_irq_link_list.
Simply declare a local variable to store it to improve readability.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b2bdf27..341944b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -273,7 +273,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 	struct i40e_hw *hw = &pf->hw;
 	u16 vsi_queue_id, pf_queue_id;
 	enum i40e_queue_type qtype;
-	u16 next_q, vector_id;
+	u16 next_q, vector_id, size;
 	u32 reg, reg_idx;
 	u16 itr_idx = 0;
 
@@ -303,11 +303,9 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 				     vsi_queue_id + 1));
 	}
 
-	next_q = find_first_bit(&linklistmap,
-				(I40E_MAX_VSI_QP *
-				 I40E_VIRTCHNL_SUPPORTED_QTYPES));
-	if (unlikely(next_q == (I40E_MAX_VSI_QP *
-				I40E_VIRTCHNL_SUPPORTED_QTYPES)))
+	size = I40E_MAX_VSI_QP * I40E_VIRTCHNL_SUPPORTED_QTYPES;
+	next_q = find_first_bit(&linklistmap, size);
+	if (unlikely(next_q == size))
 		goto irq_list_done;
 
 	vsi_queue_id = next_q / I40E_VIRTCHNL_SUPPORTED_QTYPES;
@@ -317,7 +315,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 
 	wr32(hw, reg_idx, reg);
 
-	while (next_q < (I40E_MAX_VSI_QP * I40E_VIRTCHNL_SUPPORTED_QTYPES)) {
+	while (next_q < size) {
 		switch (qtype) {
 		case I40E_QUEUE_TYPE_RX:
 			reg_idx = I40E_QINT_RQCTL(pf_queue_id);
@@ -331,12 +329,8 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 			break;
 		}
 
-		next_q = find_next_bit(&linklistmap,
-				       (I40E_MAX_VSI_QP *
-					I40E_VIRTCHNL_SUPPORTED_QTYPES),
-				       next_q + 1);
-		if (next_q <
-		    (I40E_MAX_VSI_QP * I40E_VIRTCHNL_SUPPORTED_QTYPES)) {
+		next_q = find_next_bit(&linklistmap, size, next_q + 1);
+		if (next_q < size) {
 			vsi_queue_id = next_q / I40E_VIRTCHNL_SUPPORTED_QTYPES;
 			qtype = next_q % I40E_VIRTCHNL_SUPPORTED_QTYPES;
 			pf_queue_id = i40e_vc_get_pf_queue_id(vf, vsi_id,
-- 
2.9.4

