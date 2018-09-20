From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Wed, 19 Sep 2018 17:23:04 -0700
Subject: [Intel-wired-lan] [PATCH 1/8] ice: use [sr]q.count when checking if
 queue is initialized
In-Reply-To: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
References: <20180920002311.10891-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180920002311.10891-2-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

When shutting down the controlqs, we check if they are initialized
before we shut them down and destroy the lock. This is important, as it
prevents attempts to access the lock of an already shutdown queue.

Unfortunately, we checked rq.head and sq.head as the value to determine
if the queue was initialized. This doesn't work, because head is not
reset when the queue is shutdown. In some flows, the adminq will have
already been shut down prior to calling ice_shutdown_all_ctrlqs. This
can result in a crash due to attempting to access the already destroyed
mutex.

Fix this by using rq.count and sq.count instead. Indeed, ice_shutdown_sq
and ice_shutdown_rq already indicate that this is the value we should be
using to determine of the queue was initialized.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index 1fe026a65d75..3c736b90a6bf 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -597,11 +597,11 @@ static enum ice_status ice_init_check_adminq(struct ice_hw *hw)
 	return 0;
 
 init_ctrlq_free_rq:
-	if (cq->rq.head) {
+	if (cq->rq.count) {
 		ice_shutdown_rq(hw, cq);
 		mutex_destroy(&cq->rq_lock);
 	}
-	if (cq->sq.head) {
+	if (cq->sq.count) {
 		ice_shutdown_sq(hw, cq);
 		mutex_destroy(&cq->sq_lock);
 	}
@@ -710,11 +710,11 @@ static void ice_shutdown_ctrlq(struct ice_hw *hw, enum ice_ctl_q q_type)
 		return;
 	}
 
-	if (cq->sq.head) {
+	if (cq->sq.count) {
 		ice_shutdown_sq(hw, cq);
 		mutex_destroy(&cq->sq_lock);
 	}
-	if (cq->rq.head) {
+	if (cq->rq.count) {
 		ice_shutdown_rq(hw, cq);
 		mutex_destroy(&cq->rq_lock);
 	}
-- 
2.14.3

