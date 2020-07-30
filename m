From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:17 -0700
Subject: [Intel-wired-lan] [PATCH S51 08/13] ice: port fix for chk_linearlize
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-8-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

This is a port of commit 248de22e638f ("i40e/i40evf: Account for frags
split over multiple descriptors in check linearize")

As part of testing workloads (read/write) using larger IO size (128K)
tx_timeout is observed and whenever it happens, it was due to
tx_linearize.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 26 ++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 53c67eeec2fa..77de8869e7ca 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2292,10 +2292,30 @@ static bool __ice_chk_linearize(struct sk_buff *skb)
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
+		if (stale_size > ICE_MAX_DATA_PER_TXD) {
+			int align_pad = -(skb_frag_off(stale)) &
+					(ICE_MAX_READ_REQ_SIZE - 1);
+
+			sum -= align_pad;
+			stale_size -= align_pad;
+
+			do {
+				sum -= ICE_MAX_DATA_PER_TXD_ALIGNED;
+				stale_size -= ICE_MAX_DATA_PER_TXD_ALIGNED;
+			} while (stale_size > ICE_MAX_DATA_PER_TXD);
+		}
+
 		/* if sum is negative we failed to make sufficient progress */
 		if (sum < 0)
 			return true;
@@ -2303,7 +2323,7 @@ static bool __ice_chk_linearize(struct sk_buff *skb)
 		if (!nr_frags--)
 			break;
 
-		sum -= skb_frag_size(stale++);
+		sum -= stale_size;
 	}
 
 	return false;
-- 
2.20.1

