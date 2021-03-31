From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 31 Mar 2021 14:17:03 -0700
Subject: [Intel-wired-lan] [PATCH S58 08/13] ice: remove unused struct member
In-Reply-To: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
References: <20210331211708.55205-1-anthony.l.nguyen@intel.com>
Message-ID: <20210331211708.55205-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The only time you can ever have a rq_last_status is if
a firmware event was somehow reporting a status on the receive
queue, which are generally firmware initiated events or
mailbox messages from a VF.  Mostly this struct member was unused.

Fix this problem by still printing the value of the field in a debug
print, but don't store the value forever in a struct, potentially
creating opportunities for callers to use the wrong struct member.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_controlq.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 0f207a42ea77..87b33bdd4960 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1097,6 +1097,7 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 		  struct ice_rq_event_info *e, u16 *pending)
 {
 	u16 ntc = cq->rq.next_to_clean;
+	enum ice_aq_err rq_last_status;
 	enum ice_status ret_code = 0;
 	struct ice_aq_desc *desc;
 	struct ice_dma_mem *bi;
@@ -1130,13 +1131,12 @@ ice_clean_rq_elem(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	desc = ICE_CTL_Q_DESC(cq->rq, ntc);
 	desc_idx = ntc;
 
-	cq->rq_last_status = (enum ice_aq_err)le16_to_cpu(desc->retval);
+	rq_last_status = (enum ice_aq_err)le16_to_cpu(desc->retval);
 	flags = le16_to_cpu(desc->flags);
 	if (flags & ICE_AQ_FLAG_ERR) {
 		ret_code = ICE_ERR_AQ_ERROR;
 		ice_debug(hw, ICE_DBG_AQ_MSG, "Control Receive Queue Event 0x%04X received with error 0x%X\n",
-			  le16_to_cpu(desc->opcode),
-			  cq->rq_last_status);
+			  le16_to_cpu(desc->opcode), rq_last_status);
 	}
 	memcpy(&e->desc, desc, sizeof(e->desc));
 	datalen = le16_to_cpu(desc->datalen);
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 77c2307d4fb8..fe75871e48ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -83,7 +83,6 @@ struct ice_rq_event_info {
 /* Control Queue information */
 struct ice_ctl_q_info {
 	enum ice_ctl_q qtype;
-	enum ice_aq_err rq_last_status;	/* last status on receive queue */
 	struct ice_ctl_q_ring rq;	/* receive queue */
 	struct ice_ctl_q_ring sq;	/* send queue */
 	u32 sq_cmd_timeout;		/* send queue cmd write back timeout */
-- 
2.20.1

