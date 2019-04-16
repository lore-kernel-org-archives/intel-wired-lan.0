From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:21:26 -0700
Subject: [Intel-wired-lan] [PATCH S18 13/15] ice: Use more efficient
 structures
In-Reply-To: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416172128.27184-14-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Move a bunch of members around to make more efficient use of
memory, eliminating holes where possible. None of these members
are hot path so cache line alignment is not very important here.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 0038a4109c99..e0585394d984 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -79,6 +79,7 @@ struct ice_rq_event_info {
 /* Control Queue information */
 struct ice_ctl_q_info {
 	enum ice_ctl_q qtype;
+	enum ice_aq_err rq_last_status;	/* last status on receive queue */
 	struct ice_ctl_q_ring rq;	/* receive queue */
 	struct ice_ctl_q_ring sq;	/* send queue */
 	u32 sq_cmd_timeout;		/* send queue cmd write back timeout */
@@ -86,10 +87,9 @@ struct ice_ctl_q_info {
 	u16 num_sq_entries;		/* send queue depth */
 	u16 rq_buf_size;		/* receive queue buffer size */
 	u16 sq_buf_size;		/* send queue buffer size */
+	enum ice_aq_err sq_last_status;	/* last status on send queue */
 	struct mutex sq_lock;		/* Send queue lock */
 	struct mutex rq_lock;		/* Receive queue lock */
-	enum ice_aq_err sq_last_status;	/* last status on send queue */
-	enum ice_aq_err rq_last_status;	/* last status on receive queue */
 };
 
 #endif /* _ICE_CONTROLQ_H_ */
-- 
2.20.1

