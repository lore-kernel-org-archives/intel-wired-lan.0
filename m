From: Karen Sornek <karen.sornek@intel.com>
Date: Tue, 31 Aug 2021 12:12:02 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor text of
 informational message
Message-ID: <20210831101202.3532-1-karen.sornek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This message is intended to be informational to indicate a reset is about
to happen, but the use of "warning" in the message text can cause concern
with users.  Reword the message to make it less alarming.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Karen Sornek <karen.sornek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 9c128462e..0a2f23f2b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1518,7 +1518,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			iavf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
-			dev_info(&adapter->pdev->dev, "Reset warning received from the PF\n");
+			dev_info(&adapter->pdev->dev, "Reset indication received from the PF\n");
 			if (!(adapter->flags & IAVF_FLAG_RESET_PENDING)) {
 				adapter->flags |= IAVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
-- 
2.27.0

