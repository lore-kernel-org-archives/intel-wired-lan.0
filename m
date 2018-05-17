From: Alice Michael <alice.michael@intel.com>
Date: Thu, 17 May 2018 01:08:32 -0700
Subject: [Intel-wired-lan] [next PATCH S92 1/9] i40e: free skb after
 clearing lock in ptp_stop
Message-ID: <20180517080840.30192-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Use the same logic to free the skb after clearing the Tx timestamp bit
lock in i40e_ptp_stop as we use in the other locations. It is not as
important here since we are not racing against a future Tx timestamp
request (as we are disabling PTP at this point). However it is good to
be consistent in how we approach the bit lock so that future callers
don't copy the old anti-pattern.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index d50d849..35f2866 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -799,9 +799,11 @@ void i40e_ptp_stop(struct i40e_pf *pf)
 	pf->ptp_rx = false;
 
 	if (pf->ptp_tx_skb) {
-		dev_kfree_skb_any(pf->ptp_tx_skb);
+		struct sk_buff *skb = pf->ptp_tx_skb;
+
 		pf->ptp_tx_skb = NULL;
 		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
+		dev_kfree_skb_any(skb);
 	}
 
 	if (pf->ptp_clock) {
-- 
2.9.5

