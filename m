From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:03 -0400
Subject: [Intel-wired-lan] [net-next S4 06/15] i40e/i40evf: Remove unneeded
	TODO
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-7-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

There's no need for a counter so remove the TODO comment.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: I3321dda04934c4f5fda9b279ab666192bda44214
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 268da01..d781a86 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1653,9 +1653,6 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		/* ERR_MASK will only have valid bits if EOP set */
 		if (unlikely(rx_error & (1 << I40E_RX_DESC_ERROR_RXE_SHIFT))) {
 			dev_kfree_skb_any(skb);
-			/* TODO: shouldn't we increment a counter indicating the
-			 * drop?
-			 */
 			continue;
 		}
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 362d6e1..e1a44dd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1128,9 +1128,6 @@ static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, int budget)
 		/* ERR_MASK will only have valid bits if EOP set */
 		if (unlikely(rx_error & (1 << I40E_RX_DESC_ERROR_RXE_SHIFT))) {
 			dev_kfree_skb_any(skb);
-			/* TODO: shouldn't we increment a counter indicating the
-			 * drop?
-			 */
 			continue;
 		}
 
-- 
1.9.3

