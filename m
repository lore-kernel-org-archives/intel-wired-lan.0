From: Caleb Sander <csander@purestorage.com>
Date: Fri,  1 Oct 2021 09:50:06 -0600
Subject: [Intel-wired-lan] [PATCH] i40e: avoid spin loop in
 i40e_asq_send_command()
Message-ID: <20211001155006.30732-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously, the kernel could spend up to 250 ms waiting for a command to
be submitted to an admin queue. This function is also called in a loop,
e.g., in i40e_get_module_eeprom() (through i40e_aq_get_phy_register()),
so the time spent in the kernel may be even higher. We observed
scheduling delays of over 2 seconds in production,
with stacktraces pointing to this code as the culprit.

Add a call to cond_resched() so the loop can yield the CPU.
Also compute the total time using the jiffies counter
instead of assuming udelay() waits the precise time interval requested.

Signed-off-by: Caleb Sander <csander@purestorage.com>
Reviewed-by: Joern Engel <joern@purestorage.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 593912b17..f1fcb867a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -902,7 +902,7 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 	 * we need to wait for desc write back
 	 */
 	if (!details->async && !details->postpone) {
-		u32 total_delay = 0;
+		unsigned long timeout_end = jiffies + usecs_to_jiffies(hw->aq.asq_cmd_timeout);
 
 		do {
 			/* AQ designers suggest use of head for better
@@ -910,9 +910,9 @@ i40e_status i40e_asq_send_command(struct i40e_hw *hw,
 			 */
 			if (i40e_asq_done(hw))
 				break;
+			cond_resched();
 			udelay(50);
-			total_delay += 50;
-		} while (total_delay < hw->aq.asq_cmd_timeout);
+		} while (time_before(jiffies, timeout_end));
 	}
 
 	/* if ready, copy the desc back to temp */
-- 
2.17.1

