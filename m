From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:03 -0400
Subject: [Intel-wired-lan] [next PATCH S19 02/15] i40e: Change BUG_ON to
	WARN_ON in service event complete
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

There's no need to kill the thread and eventually the kernel in this
case.  In fact, the remainder of the code won't hurt anything anyway,
so just complain that we're here and move along.

Prompted by a recent Linus diatribe.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Iec020d8bcfedffc1cd2553cc6905fd915bb3e670

---
Testing-hints: Internal code change only, check that the patch was
applied and compiled correctly.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 62d58de..d2e4ea8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5758,7 +5758,7 @@ static void i40e_handle_lan_overflow_event(struct i40e_pf *pf,
  **/
 static void i40e_service_event_complete(struct i40e_pf *pf)
 {
-	BUG_ON(!test_bit(__I40E_SERVICE_SCHED, &pf->state));
+	WARN_ON(!test_bit(__I40E_SERVICE_SCHED, &pf->state));
 
 	/* flush memory to make sure state is correct before next watchog */
 	smp_mb__before_atomic();
-- 
1.9.3

