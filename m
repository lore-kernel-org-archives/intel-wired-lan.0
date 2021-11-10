From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Nov 2021 11:13:50 +0300
Subject: [Intel-wired-lan] [PATCH net] iavf: missing unlocks in
 iavf_watchdog_task()
Message-ID: <20211110081350.GI5176@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This code was re-organized and there some unlocks missing now.

Fixes: 898ef1cb1cb2 ("iavf: Combine init and watchdog state machines")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 847d67e32a54..b97f685a5cf8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2012,6 +2012,7 @@ static void iavf_watchdog_task(struct work_struct *work)
 		}
 		adapter->aq_required = 0;
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
+		mutex_unlock(&adapter->crit_lock);
 		queue_delayed_work(iavf_wq,
 				   &adapter->watchdog_task,
 				   msecs_to_jiffies(10));
@@ -2042,9 +2043,8 @@ static void iavf_watchdog_task(struct work_struct *work)
 			iavf_detect_recover_hung(&adapter->vsi);
 		break;
 	case __IAVF_REMOVE:
-		mutex_unlock(&adapter->crit_lock);
-		return;
 	default:
+		mutex_unlock(&adapter->crit_lock);
 		return;
 	}
 
-- 
2.20.1

