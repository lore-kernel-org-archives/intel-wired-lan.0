From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 18:05:04 -0700
Subject: [Intel-wired-lan] [next PATCH S45 02/10] i40e: Limit TX descriptor
	count in cases where frag size is greater than 16K
In-Reply-To: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473210312-29592-3-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The i40e driver was incorrectly assuming that we would always be pulling
no more than 1 descriptor from each fragment.  It is in fact possible for
us to end up with the case where 2 descriptors worth of data may be pulled
when a frame is larger than one of the pieces generated when aligning the
payload to either 4K or pieces smaller than 16K.

To adjust for this we just need to make certain to test all the way to the
end of the fragments as it is possible for us to span 2 descriptors in the
block before us so we need to guarantee that even the last 6 descriptors
have enough data to fill a full frame.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Ic2ecb4d6b745f447d334e66c14002152f50e2f99
---
Testing Hints:
        This is hard to reproduce.  Patch submitted to customer for
        testing.  Best effort would be to try testing TSO, if possible
        TSO with iSCSI to verify nothing there is broken.

HSD-number: 10021204

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 7 ++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f8d6623..bf7bb7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2621,9 +2621,7 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 		return false;
 
 	/* We need to walk through the list and validate that each group
-	 * of 6 fragments totals at least gso_size.  However we don't need
-	 * to perform such validation on the last 6 since the last 6 cannot
-	 * inherit any data from a descriptor after them.
+	 * of 6 fragments totals at least gso_size.
 	 */
 	nr_frags -= I40E_MAX_BUFFER_TXD - 2;
 	frag = &skb_shinfo(skb)->frags[0];
@@ -2654,8 +2652,7 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 		if (sum < 0)
 			return true;
 
-		/* use pre-decrement to avoid processing last fragment */
-		if (!--nr_frags)
+		if (!nr_frags--)
 			break;
 
 		sum -= skb_frag_size(stale++);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 0130458..e3427eb 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1832,9 +1832,7 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 		return false;
 
 	/* We need to walk through the list and validate that each group
-	 * of 6 fragments totals at least gso_size.  However we don't need
-	 * to perform such validation on the last 6 since the last 6 cannot
-	 * inherit any data from a descriptor after them.
+	 * of 6 fragments totals@least gso_size.
 	 */
 	nr_frags -= I40E_MAX_BUFFER_TXD - 2;
 	frag = &skb_shinfo(skb)->frags[0];
@@ -1865,8 +1863,7 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 		if (sum < 0)
 			return true;
 
-		/* use pre-decrement to avoid processing last fragment */
-		if (!--nr_frags)
+		if (!nr_frags--)
 			break;
 
 		sum -= skb_frag_size(stale++);
-- 
2.4.11

