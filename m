From: Joshua Hay <joshua.a.hay@intel.com>
Date: Wed, 13 Jan 2016 16:51:50 -0800
Subject: [Intel-wired-lan] [v2 next PATCH S27 13/15] i40e/i40evf: use
	logical operators, not bitwise
In-Reply-To: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452732712-12248-14-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Mr. Spock would certainly raise an eyebrow to see us using bitwise
operaters, when we should clearly be relying on logic. Fascinating.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ie338010c016f93e9faa2002c07c90b15134b7477
---
Testing Hints: No functional change, but the code is more correct.
Make sure it compiles and passes traffic properly.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 1ce572e..37104bf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1996,7 +1996,8 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
-		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
+		clean_complete = clean_complete &&
+				 i40e_clean_tx_irq(ring, vsi->work_limit);
 		arm_wb = arm_wb || ring->arm_wb;
 		ring->arm_wb = false;
 	}
@@ -2020,7 +2021,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 
 		work_done += cleaned;
 		/* if we didn't clean as many as budgeted, we must be done */
-		clean_complete &= (budget_per_ring != cleaned);
+		clean_complete = clean_complete && (budget_per_ring > cleaned);
 	}
 
 	/* If work not completed, return budget and polling will return */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index f971018..620cb97 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1432,7 +1432,8 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
-		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
+		clean_complete = clean_complete &&
+				 i40e_clean_tx_irq(ring, vsi->work_limit);
 		arm_wb = arm_wb || ring->arm_wb;
 		ring->arm_wb = false;
 	}
@@ -1456,7 +1457,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 
 		work_done += cleaned;
 		/* if we didn't clean as many as budgeted, we must be done */
-		clean_complete &= (budget_per_ring != cleaned);
+		clean_complete = clean_complete && (budget_per_ring > cleaned);
 	}
 
 	/* If work not completed, return budget and polling will return */
-- 
2.1.0

