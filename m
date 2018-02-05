From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon,  5 Feb 2018 13:03:37 -0800
Subject: [Intel-wired-lan] [S86 v3 8/8] i40evf: Make VF reset warning
 message more clear
In-Reply-To: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
References: <20180205210337.22102-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180205210337.22102-8-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

When the PF resets the VF, the VF puts out a warning message
indicating that the VF received a reset message from the PF.
Make this message more clear so that we do not mistakenly
think that the PF is undergoing a reset.

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index ff3d681fa81a..6134b61e0938 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1244,7 +1244,7 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			i40evf_print_link_message(adapter);
 			break;
 		case VIRTCHNL_EVENT_RESET_IMPENDING:
-			dev_info(&adapter->pdev->dev, "PF reset warning received\n");
+			dev_info(&adapter->pdev->dev, "Reset warning received from the PF\n");
 			if (!(adapter->flags & I40EVF_FLAG_RESET_PENDING)) {
 				adapter->flags |= I40EVF_FLAG_RESET_PENDING;
 				dev_info(&adapter->pdev->dev, "Scheduling reset task\n");
-- 
2.14.3

