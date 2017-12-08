From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 08 Dec 2017 10:55:04 -0800
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e/i40evf: Account
 for frags split over multiple descriptors in check linearize
Message-ID: <20171208185336.3685.3975.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The original code for __i40e_chk_linearize didn't take into account the
fact that if a fragment is 16K in size or larger it has to be split over 2
descriptors and the smaller of those 2 descriptors will be on the trailing
edge of the transmit. As a result we can get into situations where we didn't
catch requests that could result in a Tx hang.

This patch takes care of that by subtracting the length of all but the
trailing edge of the stale fragment before we test for sum. By doing this
we can guarantee that we have all cases covered, including the case of a
fragment that spans multiple descriptors. We don't need to worry about
checking the inner portions of this since 12K is the maximum aligned DMA
size and that is larger than any MSS will ever be since the MTU limit for
jumbos is something on the order of 9K.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   26 ++++++++++++++++++++++---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   26 ++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4566d66ffc7c..5bc2748ac468 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -3047,10 +3047,30 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale = &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale = &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size = skb_frag_size(stale);
+
 		sum += skb_frag_size(frag++);
 
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad = -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -3058,7 +3078,7 @@ bool __i40e_chk_linearize(struct sk_buff *skb)
 		if (!nr_frags--)
 			break;
 
-		sum -= skb_frag_size(stale++);
+		sum -= stale_size;
 	}
 
 	return false;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 50864f99446d..1ba29bb85b67 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -2012,10 +2012,30 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 	/* Walk through fragments adding latest fragment, testing it, and
 	 * then removing stale fragments from the sum.
 	 */
-	stale = &skb_shinfo(skb)->frags[0];
-	for (;;) {
+	for (stale = &skb_shinfo(skb)->frags[0];; stale++) {
+		int stale_size = skb_frag_size(stale);
+
 		sum += skb_frag_size(frag++);
 
+		/* The stale fragment may present us with a smaller
+		 * descriptor than the actual fragment size. To account
+		 * for that we need to remove all the data on the front and
+		 * figure out what the remainder would be in the last
+		 * descriptor associated with the fragment.
+		 */
+		if (stale_size > I40E_MAX_DATA_PER_TXD) {
+			int align_pad = -(stale->page_offset) &
+					(I40E_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -= I40E_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > I40E_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -2023,7 +2043,7 @@ bool __i40evf_chk_linearize(struct sk_buff *skb)
 		if (!nr_frags--)
 			break;
 
-		sum -= skb_frag_size(stale++);
+		sum -= stale_size;
 	}
 
 	return false;

