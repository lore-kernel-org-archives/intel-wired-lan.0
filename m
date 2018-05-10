From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:48 -0700
Subject: [Intel-wired-lan] [next PATCH S91 10/11] i40e: free the skb after
 clearing the bitlock
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In commit bbc4e7d273b5 ("i40e: fix race condition with PTP_TX_IN_PROGRESS
bits") we modified the code which handles Tx timestamps so that we would
clear the progress bit as soon as possible.

A later commit 0bc0706b46cd ("i40e: check for Tx timestamp timeouts during
watchdog") introduced similar code for detecting and handling cleanup of
a blocked Tx timestamp. This code did not use the same pattern for cleaning
up the skb.

Update this code to wait to free the skb until after the bit lock is
free, by first setting the ptp_tx_skb to NULL and clearing the lock.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 8f30cd5..4280018 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -321,6 +321,8 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf)
  **/
 void i40e_ptp_tx_hang(struct i40e_pf *pf)
 {
+	struct sk_buff *skb;
+
 	if (!(pf->flags & I40E_FLAG_PTP) || !pf->ptp_tx)
 		return;
 
@@ -333,9 +335,12 @@ void i40e_ptp_tx_hang(struct i40e_pf *pf)
 	 * within a second it is reasonable to assume that we never will.
 	 */
 	if (time_is_before_jiffies(pf->ptp_tx_start + HZ)) {
-		dev_kfree_skb_any(pf->ptp_tx_skb);
+		skb = pf->ptp_tx_skb;
 		pf->ptp_tx_skb = NULL;
 		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+
+		/* Free the skb after we clear the bitlock */
+		dev_kfree_skb_any(skb);
 		pf->tx_hwtstamp_timeouts++;
 	}
 }
-- 
2.9.5

