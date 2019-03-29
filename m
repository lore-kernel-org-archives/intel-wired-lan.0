From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Mar 2019 12:48:50 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: Limiting RSS queues to CPUs
Message-ID: <20190329194850.79377-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Limiting RSS queues number to online CPUs number in order to
avoid issues with creating misconfigured RSS queues.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e64751da0921..357c74bc3265 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -416,7 +416,7 @@ int iavf_request_queues(struct iavf_adapter *adapter, int num)
 		return -EBUSY;
 	}
 
-	vfres.num_queue_pairs = num;
+	vfres.num_queue_pairs = min_t(int, num, num_online_cpus());
 
 	adapter->current_op = VIRTCHNL_OP_REQUEST_QUEUES;
 	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
-- 
2.19.2

