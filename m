From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:41 -0800
Subject: [Intel-wired-lan] [next PATCH S61 03/10] i40e/i40evf: Fix use after
	free in Rx cleanup path
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

We need to reset skb back to NULL when we have freed it in the Rx cleanup
path.  I found one spot where this wasn't occurring so this patch fixes it.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Iaca68934200732cd4a63eb0bd83b539c95f8c4dd
---
Testing Hints:
        The "Fixes" commit ID will need to be updated before this is pushed
        upstream.  Ideally this patch can be dropped if the patch that
        introduced the bug has not yet made it upstream, and this fix can
        be taken care of there.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f80c76c..558d7da 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2183,6 +2183,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
 			dev_kfree_skb_any(skb);
+			skb = NULL;
 			continue;
 		}
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 39e2e73..9b9314a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1299,6 +1299,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
 		 */
 		if (unlikely(i40e_test_staterr(rx_desc, BIT(I40E_RXD_QW1_ERROR_SHIFT)))) {
 			dev_kfree_skb_any(skb);
+			skb = NULL;
 			continue;
 		}
 
-- 
2.4.11

