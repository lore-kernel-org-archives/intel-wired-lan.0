From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 24 Jun 2020 09:04:22 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: Fix updating statistics
Message-ID: <20200624160422.58874-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit bac8486116b0 ("iavf: Refactor the watchdog state machine") inverted
the logic for when to update statistics. Statistics should be updated when
no other commands are pending, instead they were only requested when a
command was processed. iavf_request_stats() would see a pending request
and not request statistics to be updated. This caused statistics to never
be updated; fix the logic.

Fixes: bac8486116b0 ("iavf: Refactor the watchdog state machine")
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b90ad1abbabb..48c956d90b90 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1937,7 +1937,10 @@ static void iavf_watchdog_task(struct work_struct *work)
 				iavf_send_api_ver(adapter);
 			}
 		} else {
-			if (!iavf_process_aq_command(adapter) &&
+			/* An error will be returned if no commands were
+			 * processed; use this opportunity to update stats
+			 */
+			if (iavf_process_aq_command(adapter) &&
 			    adapter->state == __IAVF_RUNNING)
 				iavf_request_stats(adapter);
 		}
-- 
2.20.1

