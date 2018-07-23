From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 15:05:12 -0700
Subject: [Intel-wired-lan] [PATCH v2 05/13] ice: Clean control queues only
 when they are initialized
In-Reply-To: <20180723220520.16678-1-anirudh.venkataramanan@intel.com>
References: <20180723220520.16678-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723220520.16678-6-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Preethi Banala <preethi.banala@intel.com>

Clean control queues only when they are initialized. One of the ways to
validate if the basic initialization is done is by checking value of
cq->sq.head and cq->rq.head variables that specify the register address.
This patch adds a check to avoid NULL pointer dereference crash when tried
to shutdown uninitialized control queue.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 7c511f144ed6..c064416080e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -597,10 +597,14 @@ static enum ice_status ice_init_check_adminq(struct ice_hw *hw)
 	return 0;
 
 init_ctrlq_free_rq:
-	ice_shutdown_rq(hw, cq);
-	ice_shutdown_sq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
 	return status;
 }
 
@@ -706,10 +710,14 @@ static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type)
 		return;
 	}
 
-	ice_shutdown_sq(hw, cq);
-	ice_shutdown_rq(hw, cq);
-	mutex_destroy(&cq->sq_lock);
-	mutex_destroy(&cq->rq_lock);
+	if (cq->sq.head) {
+		ice_shutdown_sq(hw, cq);
+		mutex_destroy(&cq->sq_lock);
+	}
+	if (cq->rq.head) {
+		ice_shutdown_rq(hw, cq);
+		mutex_destroy(&cq->rq_lock);
+	}
 }
 
 /**
-- 
2.14.3

