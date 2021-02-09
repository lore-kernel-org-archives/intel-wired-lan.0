From: Vedang Patel <vedang.patel@intel.com>
Date: Mon,  8 Feb 2021 18:41:38 -0800
Subject: [Intel-wired-lan] [PATCH net-next v5 6/9] igc: Add set/clear large
 buffer helpers
In-Reply-To: <20210209024141.23298-1-vedang.patel@intel.com>
References: <20210209024141.23298-1-vedang.patel@intel.com>
Message-ID: <20210209024141.23298-7-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andre Guedes <andre.guedes@intel.com>

While commit 13b5b7fd6a4a ("igc: Add support for Tx/Rx rings")
introduced code to handle larger packet buffers, it missed the
set/clear helpers which enable/disable that feature. Introduce
the missing helpers which will be use in the next patch.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 05d893029643..3187df9cb7e4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -503,6 +503,10 @@ enum igc_ring_flags_t {
 
 #define ring_uses_large_buffer(ring) \
 	test_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define set_ring_uses_large_buffer(ring) \
+	set_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+#define clear_ring_uses_large_buffer(ring) \
+	clear_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
 
 #define ring_uses_build_skb(ring) \
 	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
-- 
2.17.1

