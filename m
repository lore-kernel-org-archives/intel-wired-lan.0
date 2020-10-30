From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 30 Oct 2020 14:03:48 -0700
Subject: [Intel-wired-lan] [PATCH v3 6/9] igc: Add set/clear large buffer
 helpers
In-Reply-To: <20201030210351.46482-1-andre.guedes@intel.com>
References: <20201030210351.46482-1-andre.guedes@intel.com>
Message-ID: <20201030210351.46482-7-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While commit 13b5b7fd6a4a ("igc: Add support for Tx/Rx rings")
introduced code to handle larger packet buffers, it missed the
set/clear helpers which enable/disable that feature. This patch
introduces the missing helpers which will be use in the next
patch.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index ae91d51073ca..e72f1fc772aa 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -509,6 +509,10 @@ enum igc_ring_flags_t {
 
 #define ring_uses_large_buffer(ring) \
 	test_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define set_ring_uses_large_buffer(ring) \
+	set_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define clear_ring_uses_large_buffer(ring) \
+	clear_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
 
 #define ring_uses_build_skb(ring) \
 	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
-- 
2.28.0

