From: Karen Sornek <karen.sornek@intel.com>
Date: Mon, 30 Aug 2021 11:02:20 +0200
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix limit of total number of
 queues to active queues of VF
Message-ID: <20210830090220.271120-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the absence of this validation, if the user requests to
configure queues more than the enabled queues, it results in
sending the requested number of queues to the kernel stack
(due to the asynchronous nature of VF response), in which
case the stack might pick a queue to transmit that is not
enabled and result in Tx hang. Fix this bug by
limiting the total number of queues allocated for VF to
active queues of VF.

Fixes: 129cf89e5856 ("iavf: rename functions and structs to new name")
Signed-off-by: Ashwin Vijayavel <ashwin.vijayavel@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 80437ef26..c215ca503 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2647,8 +2647,11 @@ static int iavf_validate_ch_config(struct iavf_adapter *adapter,
 		total_max_rate += tx_rate;
 		num_qps += mqprio_qopt->qopt.count[i];
 	}
-	if (num_qps > IAVF_MAX_REQ_QUEUES)
+	if (num_qps > adapter->num_active_queues) {
+		dev_err(&adapter->pdev->dev,
+			"Cannot support requested number of queues\n");
 		return -EINVAL;
+	}
 
 	ret = iavf_validate_tx_bandwidth(adapter, total_max_rate);
 	return ret;
-- 
2.27.0

