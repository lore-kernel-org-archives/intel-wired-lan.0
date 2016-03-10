From: ajdayana <avinash.dayanand@intel.com>
Date: Thu, 10 Mar 2016 14:59:48 -0800
Subject: [Intel-wired-lan] [next PATCH S30 v3 10/13] i40e: Change unknown
	event error msg to ignore message
In-Reply-To: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1457650791-100229-11-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

There's no real error in an unknown event from the Firmware, we're just
posting a useful FYI notice, so this patch simply removes the "Error" word.

Testing Hints:
	Not really testable live with current FW/SW, so just
	compile and go.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index b42303c..20c03a8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6348,7 +6348,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
 			break;
 		default:
 			dev_info(&pf->pdev->dev,
-				 "ARQ Error: Unknown event 0x%04x received\n",
+				 "ARQ: Unknown event 0x%04x ignored\n",
 				 opcode);
 			break;
 		}
-- 
2.4.3

