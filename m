From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  6 Nov 2019 09:18:23 -0800
Subject: [Intel-wired-lan] [net] igb/igc: use ktime accessors for skb->tstamp
Message-ID: <20191106171823.30554-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When implementing launch time support in the igb and igc drivers, the
skb->tstamp value is assumed to be a s64, but it's declared as a ktime_t
value.

Although ktime_t is typedef'd to s64 it wasn't always, and the kernel
provides accessors for ktime_t values.

Use the ktime_to_timespec64 and ktime_set accessors instead of directly
assuming that the variable is always an s64.

This improves portability if the code is ever moved to another kernel
version, or if the definition of ktime_t ever changes again in the
future.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 9148c62d9ac5..ed7e667d7eb2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5675,8 +5675,8 @@ static void igb_tx_ctxtdesc(struct igb_ring *tx_ring,
 	 * should have been handled by the upper layers.
 	 */
 	if (tx_ring->launchtime_enable) {
-		ts = ns_to_timespec64(first->skb->tstamp);
-		first->skb->tstamp = 0;
+		ts = ktime_to_timespec64(first->skb->tstamp);
+		first->skb->tstamp = ktime_set(0, 0);
 		context_desc->seqnum_seed = cpu_to_le32(ts.tv_nsec / 32);
 	} else {
 		context_desc->seqnum_seed = 0;
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8e424dfab12e..24888676f69b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -824,8 +824,8 @@ static void igc_tx_ctxtdesc(struct igc_ring *tx_ring,
 	 * should have been handled by the upper layers.
 	 */
 	if (tx_ring->launchtime_enable) {
-		ts = ns_to_timespec64(first->skb->tstamp);
-		first->skb->tstamp = 0;
+		ts = ktime_to_timespec64(first->skb->tstamp);
+		first->skb->tstamp = ktime_set(0, 0);
 		context_desc->launch_time = cpu_to_le32(ts.tv_nsec / 32);
 	} else {
 		context_desc->launch_time = 0;
-- 
2.23.0.245.gf157bbb9169d

