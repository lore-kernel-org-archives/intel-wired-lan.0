From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:51 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 06/11] i40e/i40evf: bump tail
	only in multiples of 8
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Hardware only fetches descriptors on cachelines of 8, essentially
ignoring the lower 3 bits of the tail register. Thus, it is pointless to
bump tail by an unaligned access as the hardware will ignore some of the
new descriptors we allocated. Thus, it's ideal if we can ensure tail
writes are always aligned to 8.

At first, it seems like we'd already do this, since we allocate
descriptors in batches which are a multiple of 8. Since we'd always
increment by a multiple of 8, it seems like the value should always be
aligned.

However, this ignores allocation failures. If we fail to allocate
a buffer, our tail register will become unaligned. Once it has become
unaligned it will essentially be stuck unaligned until a buffer
allocation happens to fail at the exact amount necessary to re-align it.

We can do better, by simply rounding down the number of buffers we're
about to allocate (cleaned_count) such that "next_to_clean
+ cleaned_count" is rounded to the nearest multiple of 8.

We do this by calculating how far off that value is and subtracting it
from the cleaned_count. This essentially defers allocation of buffers if
they're going to be ignored by hardware anyways, and re-aligns our
next_to_use and tail values after a failure to allocate a descriptor.

This calculation ensures that we always align the tail writes in a way
the hardware expects and don't unnecessarily allocate buffers which
won't be fetched immediately.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 9 +++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 0e9a910..94311e3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1372,6 +1372,15 @@ bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 	union i40e_rx_desc *rx_desc;
 	struct i40e_rx_buffer *bi;
 
+	/* Hardware only fetches new descriptors in cache lines of 8,
+	 * essentially ignoring the lower 3 bits of the tail register. We want
+	 * to ensure our tail writes are aligned to avoid unnecessary work. We
+	 * can't simply round down the cleaned count, since we might fail to
+	 * allocate some buffers. What we really want is to ensure that
+	 * next_to_used + cleaned_count produces an aligned value.
+	 */
+	cleaned_count -= (ntu + cleaned_count) & 0x7;
+
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
 		return false;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 4ae054d..212fc1f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -711,6 +711,15 @@ bool i40evf_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
 	union i40e_rx_desc *rx_desc;
 	struct i40e_rx_buffer *bi;
 
+	/* Hardware only fetches new descriptors in cache lines of 8,
+	 * essentially ignoring the lower 3 bits of the tail register. We want
+	 * to ensure our tail writes are aligned to avoid unnecessary work. We
+	 * can't simply round down the cleaned count, since we might fail to
+	 * allocate some buffers. What we really want is to ensure that
+	 * next_to_used + cleaned_count produces an aligned value.
+	 */
+	cleaned_count -= (ntu + cleaned_count) & 0x7;
+
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
 		return false;
-- 
2.9.4

