From: Karen Sornek <karen.sornek@intel.com>
Date: Mon, 30 Aug 2021 10:38:01 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix static code analysis
 warning
Message-ID: <20210830083801.269798-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Change min() to min_t() to fix static code analysis warning of possible
overflow.

Fixes: 6beb84a73ec5 ("i40e/i40evf: napi_poll must return the work done")
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 3525eab8e..42c9f9dc2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1766,7 +1766,7 @@ tx_only:
 	if (likely(napi_complete_done(napi, work_done)))
 		iavf_update_enable_itr(vsi, q_vector);
 
-	return min(work_done, budget - 1);
+	return min_t(int, work_done, budget - 1);
 }
 
 /**
-- 
2.27.0

